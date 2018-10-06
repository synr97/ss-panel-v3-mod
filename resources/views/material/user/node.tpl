







{include file='user/main.tpl'}


<script src="//cdn.jsdelivr.net/gh/YihanH/canvasjs.js@v2.2/canvasjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.3.1"></script>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<style>
.node-header-title {
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	color: #363636;
	display: -webkit-box;
	display: -ms-flexbox;
	display: block;
	-webkit-box-flex: 1;
	-ms-flex-positive: 1;
	flex-grow: 1;
	font-weight: 600;
	padding: 0.2rem;
	text-overflow: ellipsis;
}

.tag:not(body).is-success {
	background-color: #23d160;
	color: #fff;
}
.tag:not(body) {
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	background-color: whitesmoke;
	border-radius: 3px;
	color: #4a4a4a;
	display: -webkit-inline-box;
	display: -ms-inline-flexbox;
	display: inline-flex;
	font-size: 0.75rem;
	height: 2em;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	justify-content: center;
	line-height: 1.5;
	padding-left: 0.75em;
	padding-right: 0.75em;
	white-space: nowrap;
}

card-heading {
	display: block;
	font-size: 20px;
	line-height: 6px;
	margin-top: 24px;
	margin-bottom: 24px;
	box-shadow: 0 10px 30px -12px rgba(0, 0, 0, 0.42), 0 4px 25px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
	margin: -20px 15px 0;
	border-radius: 12px;
	padding: 15px;
}
</style>

	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">节点列表</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<h4>注意！请勿在任何地方公开节点信息！</h4>
									<p>Free 节点不提供任何速度以及可用性的保障</p>
									<p>Media 系列节点已解锁部分流媒体，如：Netflix、hbo、bbc、hulu 等</p>
									<p>Relay 系列节点一般用于流量中转或国外用户回国使用（默认中转模式，如需回国模式请到“中转规则”设置）</p>
									<p>Gamer 系列节点默认限速 3Mbps / 5倍流量计费</p>
									<a href="javascript:void(0);" onClick="urlChange('guide',0,0,0)">如何查看节点的详细信息和二维码方法？请点我</a>
								</div>
							</div>
						</div>
					</div>
				</div>

				{$id=0}
				{foreach $node_classes as $single_classes}
						<div class="ui-card-wrap">
							<div class="row">
								<div class="col-lg-12 col-sm-12">
									<div class="card">
										<div class="card-main">
											<div class="card-inner margin-bottom-no">
											<div class="card-heading {$single_classes['style']}">{$single_classes['desc']}</div>
												<div class="tile-wrap">
													{foreach $single_classes['nodes'] as $prefix => $nodes}
														{$id=$id+1}
															<div class="tile tile-collapse">
																<div data-toggle="tile" data-target="#heading{$node_order->$prefix}">
																	<div class="tile-side pull-left" data-ignore="tile">
																		<p class="node-header-title">
																			<span class="tag {if $node_heartbeat[$prefix]=='在线'}is-success{else}is-danger{/if}">{if $node_heartbeat[$prefix]=='在线'}在线{else}维护{/if}</span>
																		</p>
																			<!--
																			<span class="icon {if $node_heartbeat[$prefix]=='在线'}text-green{else}{if $node_heartbeat[$prefix]=='暂无数据'}text-orange{else}text-red{/if}{/if}">{if $node_heartbeat[$prefix]=="在线"}backup{else}{if $node_heartbeat[$prefix]=='暂无数据'}report{else}warning{/if}{/if}</span>
																			-->
																	</div>
																	<div class="tile-inner">

																	 <div class="node-header-title">{$prefix} | <i class="icon icon-lg">person</i> {$node_alive[$prefix]} | <i class="icon icon-lg">cloud_download</i> {$node_method[$prefix]} | <i class="icon icon-lg">data_usage</i> {if isset($node_bandwidth[$prefix])==true}{$node_bandwidth[$prefix]}{else}N/A{/if}</div>
																	</div>
																</div>
																<div class="collapsible-region collapse" id="heading{$node_order->$prefix}">
																	<div class="tile-sub">

																		<br>

																		{foreach $nodes as $node}

																			{$relay_rule = null}
																			{if $node->sort == 10}
																				{$relay_rule = $tools->pick_out_relay_rule($node->id, $user->port, $relay_rules)}
																			{/if}

																			{if $node->mu_only != 1 && $node->sort != 11}
																			<div class="card">
																				<div class="card-main">
																					<div class="card-inner">

																					{if $single_classes['access'] == 1}
																						<p class="node-info-access" >
																							<a href="javascript:void(0);" onClick="urlChange('{$node->id}',0,{if $relay_rule != null}{$relay_rule->id}{else}0{/if})">{$node->name}{if $relay_rule != null} - {$relay_rule->dist_node()->name}{/if}</a>
																							<span class="label label-brand-accent">{$node->status}</span>
																						</p>

																						<div class="card-content">

																						{if $node->sort > 2 && $node->sort != 5 && $node->sort != 10}
																							<p>地址：<span class="label" >
																							<a href="javascript:void(0);" onClick="urlChange('{$node->id}',0,0)">请点这里进入查看详细信息</a>
																						{else}
																							<p>地址：<span class="label label-brand-accent">
																							{$node->server}
																						{/if}
																							</span></p>

																						{if $node->sort == 0||$node->sort==7||$node->sort==8||$node->sort==10}


																							<p>流量比例：<span class="label label-red">
																								{$node->traffic_rate}
																							</span></p>



																							{if ($node->sort==0||$node->sort==7||$node->sort==8||$node->sort==10)&&($node->node_speedlimit!=0||$user->node_speedlimit!=0)}

																									{if $node->node_class == 0}
																									 <p>用户限速：<span class="label label-green">{$user->bandwidth}Mbps
																									{elseif $node->node_speedlimit > 0}
																									 <p>节点限速：<span class="label label-green">{$node->node_speedlimit}Mbps
																									{else}
																									 <p>用户限速：<span class="label label-green">{$user->bandwidth}Mbps
																									{/if}
																								</span></p>
																							{/if}
																						{/if}

																						<p>{$node->info}</p>
																						</div>
																					{else}
																						<div class="node-info-access" >
																						 <p>您当前无法使用 {$single_classes['desc']} 节点，请到 <a href="/user/shop">商店</a> 购买相应套餐</p>
																						 </div>
																					{/if}
																					</div>

																				</div>
																			</div>
																			{/if}

																			{if ($single_classes['access'] == 1 && ($node->sort == 0 || $node->sort == 10))}
																				{$point_node=$node}
																			{/if}



																			{if $node->sort == 11 && $single_classes['access'] == 1}
																				{assign var=server_explode value=";"|explode:$node->server}
																				<div class="card">
																					<div class="card-main">
																						<div class="card-inner">
																							<p class="node-info-access" >
																								<a href="javascript:void(0);" >{$node->name}</a>
																							</p>

																							<p>地址：<span class="label label-brand-accent">
																							{$server_explode[0]}
																							</span></p>

																							<p>端口：<span class="label label-brand-red">
																							{$server_explode[1]}
																							</span></p>

																							<p>协议：<span class="label label-brand-accent">
																							{$server_explode[2]}
																							</span></p>

																							<p>协议参数：<span class="label label-green">
																							{$server_explode[0]}
																							</span></p>

																							<p>用户 UUID：<span class="label label-brand">
																							{$user->getUuid()}
																							</span></p>

																							<p>流量比例：<span class="label label-red">
																							{$node->traffic_rate}
																							</span></p>

																							<p>AlterId：<span class="label label-green">
																							{$server_explode[3]}
																							</span></p>

																							<p>Level：<span class="label label-brand">
																							{$server_explode[4]}
																							</span></p>

																							<p>VMess 链接：
																							<a class="copy-text" data-clipboard-text="{URL::getV2Url($user, $node)}">点击拷贝</a>
																							</p>

																							<p>{$node->info}</p>
																						</div>
																					</div>
																				</div>
																			{/if}

																			{if ($node->sort == 0 || $node->sort == 10) && $node->custom_rss == 1 && $node->mu_only != -1 && $single_classes['access'] == 1}
																				{foreach $node_muport as $single_muport}

																					{if !($single_muport['server']->node_class <= $user->class && ($single_muport['server']->node_group == 0 || $single_muport['server']->node_group == $user->node_group))}
																						{continue}
																					{/if}

																					{if !($single_muport['user']->class >= $node->node_class && ($node->node_group == 0 || $single_muport['user']->node_group == $node->node_group))}
																						{continue}
																					{/if}

																					{$relay_rule = null}
																					{if $node->sort == 10 && $single_muport['user']['is_multi_user'] != 2}
																						{$relay_rule = $tools->pick_out_relay_rule($node->id, $single_muport['server']->server, $relay_rules)}
																					{/if}

																					<div class="card">
																						<div class="card-main">
																							<div class="card-inner">
																							<p	class="node-info-access"	>
																								<a href="javascript:void(0);" onClick="urlChange('{$node->id}',{$single_muport['server']->server},{if $relay_rule != null}{$relay_rule->id}{else}0{/if})">{$prefix} {if $relay_rule != null} - {$relay_rule->dist_node()->name}{/if} - {$single_muport['server']->server} 端口</a>
																							 	<span class="label label-brand-accent">{$node->status}</span>
																							</p>


																							<p>地址：<span class="label label-brand-accent">
																							{$node->server}
																							</span></p>

																							<p>端口：<span class="label label-brand-red">
																							{$single_muport['user']['port']}
																							</span></p>

																							<p>加密方式：<span class="label label-brand">
																							{$single_muport['user']['method']}
																							</span></p>

																							<p>协议：<span class="label label-brand-accent">
																							{$single_muport['user']['protocol']}
																							</span></p>

																							{if $single_muport['user']['is_multi_user'] != 0}
																							<p>协议参数：<span class="label label-green">
																							{$user->id}:{$user->passwd}
																							</span></p>
																							{/if}

																							<p>混淆方式：<span class="label label-brand">
																							{$single_muport['user']['obfs']}
																							</span></p>

																							{if $single_muport['user']['is_multi_user'] == 1}
																							<p>混淆参数：<span class="label label-green">
																								{$single_muport['user']['obfs_param']}
																							</span></p>
																							{/if}

																							<p>流量比例：<span class="label label-red">
																								{$node->traffic_rate}
																							</span></p>

																							<p>{$node->info}</p>

																							 </div>
																						</div>
																					</div>
																				{/foreach}
																			{/if}
																		{/foreach}

																		{if isset($point_node)}
																			{if $point_node!=null}

																				<div class="card">
																					<div class="card-main">
																						<div class="card-inner" id="info{$id}">

																						</div>
																					</div>
																				</div>

																				<script>
																				$().ready(function(){
																					$('#heading{$node_order->$prefix}').on("shown.bs.tile", function() {

																						$("#info{$id}").load("/user/node/{$point_node->id}/ajax");

																					});
																				});
																				</script>
																			{/if}
																		{/if}
																		{$point_node=null}
																	</div>
																</div>
														</div>
													{/foreach}
												</div>
											</div>
										</div>
									</div>
								</div>

						</div>
						</div>
						{/foreach}


							<div aria-hidden="true" class="modal modal-va-middle fade" id="nodeinfo" role="dialog" tabindex="-1">
								<div class="modal-dialog modal-full">
									<div class="modal-content">
										<iframe class="iframe-seamless" title="Modal with iFrame" id="infoifram"></iframe>
									</div>
								</div>
							</div>
		</section>
		</div>
	</main>







{include file='user/footer.tpl'}


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