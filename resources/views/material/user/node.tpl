





{include file='user/newui_header.tpl'}



  <main class="profile-page">
    <section class="section-profile-cover section-shaped my-0">
      <div class="shape shape-style-1 shape-default shape-skew alpha-4">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
      </div>
    </section>
    <section class="section section-skew">
      <div class="container">
        <div class="card card-profile shadow mt--300">
          <div class="px-4">
			   <div class="row justify-content-center">
              <div class="col-lg-3 order-lg-2" >
                <div class="card-profile-image">
                  <a data-container="body" data-original-title="Popover on Top" data-toggle="popover" data-placement="top" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus.">
                    <img src="{$user->gravatar}" alt="user-image" class="rounded-circle" >
                  </a>
                </div>
              </div>
              <div class="col-lg-4 order-lg-3 text-lg-right align-self-lg-center">
                <div class="card-profile-actions py-4 mt-lg-0">
                  <a href="/user/code" class="btn btn-sm btn-default">在线充值</a>
                  <a href="/user/shop" class="btn btn-sm btn-default">购买套餐</a>
                  <a href="/user" class="btn btn-sm btn-primary float-right">用户中心</a>
                </div>
              </div>
              <div class="col-lg-4 order-lg-1">
                <div class="card-profile-stats d-flex justify-content-center">
                  <div>
                    <span class="heading">{$user->money}</span>
                    <span class="description">余额</span>
                  </div>
                  <div>
                    <span class="heading">L{$user->class}</span>
                    <span class="description">等级</span>
                  </div>
                  <div>
                    <span class="heading">{$user->online_ip_count()}</span>
                    <span class="description">在线 IP 数</span>
                  </div>
                </div>
              </div>
            </div>
			
			
			        <div class="row row-grid justify-content-between align-items-center mt-lg">
						<div class="col-lg-12">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<h4>注意！请勿在任何地方公开节点信息！</h4><br>
									<p>Media 系列节点已解锁部分流媒体，如：Netflix、hbo、bbc、hulu 等</p>
									<p>Relay 系列节点一般用于流量中转或国外用户回国使用（默认中转模式，如需回国模式请到“中转规则”设置）</p>
								</div>
							</div>
						</div>		
					</div>	
			
			
			
				{$id=0}
				{foreach $node_classes as $single_classes}
			        <div class="row justify-content-between align-items-center mt-4">
					<div class="col-lg-12 mt-4 border-top">
						<div class="card card-lift border-0">
							<div class="card-body">
								<h3 class="card-heading">{$single_classes['desc']}</h3>
							</div>
						</div>    
					</div>  
					</div>
			        <div class="row row-grid border-top justify-content-between align-items-center mt-lg">
					
						
						{foreach $single_classes['nodes'] as $prefix => $nodes}
		               		{$id=$id+1}
							{foreach $nodes as $node}

								{$relay_rule = null}
								{if $node->sort == 10}
 									{$relay_rule = $tools->pick_out_relay_rule($node->id, $user->port, $relay_rules)}
								{/if}

						           <div class="col-lg-6" style=" margin-top: 3rem;">
                                    <div class="card card-lift shadow border-0">
                                     <div class="card-body {$node_order->$prefix}">
							          <div class="card-main">
								       <div class="card-inner">
									    <p class="card-heading" >
										 {$node->name}{if $relay_rule != null} - {$relay_rule->dist_node()->name}{/if}
									    </p>
										{if $node->node_class > $user->class}
											<a class="btn btn-flat pull-right" >等级不足</a>
											{else}
											
											<a class="btn btn-sm btn-primary pull-right" href="javascript:void(0);" onClick="urlChange('{$node->id}',0,{if $relay_rule != null}{$relay_rule->id}{else}0{/if})">配置信息</a>
										{/if}
									   <p>
										节点状态：
										{if $node_heartbeat[$prefix]=="在线"}
										<span class="badge badge-pill badge-success text-uppercase">正常</span>
										{else}{if $node_heartbeat[$prefix]=='暂无数据'}
										<span class="badge badge-pill badge-info text-uppercase">暂无数据</span>
										{else}
										<span class="badge badge-pill badge-danger text-uppercase">离线</span>
										{/if}{/if}
									  </p>
									 {if $node->sort == 0||$node->sort==7||$node->sort==8||$node->sort==10}
										<p>流量比例：
										<span class="label label-red">
										{$node->traffic_rate}
										</span></p>
									  {/if}
										<p>流量限速：
										{if $node->node_speedlimit != 0}{$node->node_speedlimit}&nbsp;Mbps{else}∞{/if}</p>
										<p>在线人数：
									   {$node_alive[$prefix]}
										</p>
										<p>流量情况：
									   {if isset($node_bandwidth[$prefix])==true}{$node_bandwidth[$prefix]}{else}N/A{/if}
									</p>
								</div>
							</div>
                  </div>
            </div>
          </div>
						{/foreach}
						{/foreach}		  
        </div>
		
						{/foreach}
       </div>
     </div>
   </div>
    </section>
<div aria-hidden="true" class="modal modal-va-middle fade" id="nodeinfo" role="dialog" tabindex="-1" >
	<div class="modal-dialog modal-xs">
		<div class="modal-content">
			<div class="modal-inner" style="height:720px">
				<iframe class="iframe-seamless" frameborder="0" scrolling="no" title="Modal with iFrame" id="infoifram"></iframe>
			</div>
		</div>
	</div>
</div>
	
{include file='newui_dialog.tpl'}


{include file='user/newui_footer.tpl'}


<script>


function urlChange(id,is_mu,rule_id) {
	var site = './node/'+id+'?ismu='+is_mu+'&relay_rule='+rule_id;
	if(id == 'guide')
	{
		var doc = document.getElementById('infoifram').contentWindow.document;
		doc.open();
		doc.write('<img src="../images/node.gif" style="width: 100%;height: 100%; border: none;"/>');
		doc.close();
	}
	else
	{
		document.getElementById('infoifram').src = site;
	}
	$("#nodeinfo").modal();
}
</script>