





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
                  <a href="/user/node" class="btn btn-sm btn-default">节点列表</a>
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
								<p>注意：购买同级别套餐将叠加到期时间</p>
								<p>注意：购买不同级别套餐将立即中断老套餐并重新计算到期时间</p>
								<p>注意：Try-out 体验套餐、Bronze 套餐不包含 SS/SSR - Advanced 节点</p>
								</div>
							</div>
						</div>	
					</div>
			
			        <div class="row row-grid justify-content-between align-items-center mt-lg">
					
					
					
					
					 {foreach $shops as $shop}
						<div class="col-lg-6" style=" margin-top: 3rem;">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
							<div class="card-main">
								<div class="card-inner">
									<p class="card-heading" >
										{$shop->name} - <code>{$shop->price}</code>元
									</p>
                                   <button class="btn btn-sm btn-primary pull-right"
                   					{if !$shop->canBuy($user)}disabled{else} href="javascript:void(0);" onClick="buy('{$shop->id}',{$shop->auto_renew},{$shop->auto_reset_bandwidth},{$shop->traffic_package()})"{/if}>立即购买</button>
									<p>
										套餐详情<br>
																											<p><ul>
																	{if $shop->group_limit() != ''}
																	<li>仅限 {$shop->group_limit()} 群组购买</li>
																	{/if}
																	{if $shop->class_limit_operator() != 'none'}
																	<li>仅限等级{if $shop->class_limit_operator() == 'equal'}等于
																			{elseif $shop->class_limit_operator() == 'greater'}大于
																			{elseif $shop->class_limit_operator() == 'greater_equal'}大于等于
																			{elseif $shop->class_limit_operator() == 'less'}小于
																			{elseif $shop->class_limit_operator() == 'less_equal'}小于等于
																			{elseif $shop->class_limit_operator() == 'not'}非{/if}
																			{$shop->class_limit_content()} 的用户购买</li>
																	{/if}
																	{if $shop->traffic_package() != 0}
																	<li>当前套餐节点</li>
																	{/if}
																	{if $shop->traffic_package() != 0}
																	<li>当前套餐速率</li>
																	{/if}
																	{if $shop->traffic_package() != 0}
																	<li>套餐流量重置时流量包将重置</li>
																	{/if}
																	{if $shop->traffic_package() != 0}
																	<li>套餐到期时流量包将清空</li>
																	{/if}
																	{if $shop->bandwidth() != 0}
																	<li>{if $shop->traffic_package() != 0}在下次流量重置前额外增加 {$shop->bandwidth()}G 流量{else}每月流量： {$shop->bandwidth()}G{/if}</li>
																	{/if}
																	{if $shop->node_speedlimit() != 0}
																	<li>最高速率：{$shop->node_speedlimit()}Mbps</li>
																	{/if}
																	{if $shop->node_connector() != 0}
																	<li>同时在线 IP：{$shop->node_connector()}</li>
																	{/if}
																	{if $shop->user_class() != 0}
																	<li>有效期：{$shop->class_expire()} 天</li>
																	{/if}
																	{if $shop->traffic_package() == 0}
																	{if $shop->node_group() != 0}
																	<li>解锁：SS/SSR/V2Ray 节点</li>
																	{else if $shop->node_group() == 0}
																	<li>解锁：SS/SSR 节点</li>
																	{/if}
																	{/if}
																	{if $shop->reset() != 0}
																	<li>每月重置一次流量</li>
																	{/if}
																	</ul></p>
								</div>
							</div>
                  </div>
            </div>				
          </div>
		  
					{/foreach}
        </div>
       </div>
     </div>
   </div>
    </section>
	
<div class="modal fade"  id="coupon_modal" tabindex="-1" role="dialog" aria-labelledby="modal-default float-right" aria-hidden="true">
    <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="modal-title-default float-right">您有优惠码吗？</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
									<div class="form-group form-group-label">
										<label class="floating-label" for="coupon">有的话，请在这里输入。没有的话，直接确定吧</label>
										<input class="form-control" id="coupon" type="text">
									</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary"  data-dismiss="modal" id="coupon_input" type="button">确定</button>
            </div>
        </div>
    </div>
    </div>
					
					
	<div class="modal fade"  id="order_modal"  tabindex="-1" role="dialog" aria-labelledby="modal-default float-right" aria-hidden="true">
    <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="modal-title-default float-right">订单确认</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
             					<p><font color="red">如更换套餐，剩余流量和有效期将会立即重置</font></p>					   
									<p id="name">商品名称：</p>
									<p id="credit">优惠额度：</p>
									<p id="total">总金额：</p>
									
								
									<div class="checkbox switch custom-control custom-checkbox mb-3" id="disableo">
              							<input class="custom-control-input" checked id="disableothers" type="checkbox">
              								<label class="custom-control-label" for="disableothers">
                									<span>关闭旧套餐自动续费</span>
              								</label>
									</div>
									<div class="checkbox switch custom-control custom-checkbox mb-3" id="autor">
              							<input class="custom-control-input" checked id="autorenew" type="checkbox">
              								<label class="custom-control-label" for="autorenew">
                									<span>到期时自动续费</span>
              								</label>
									</div>

              
									
									
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="order_input" type="button">确定</button>
            </div>
        </div>
    </div>
    </div>
					
	<div class="modal fade"  id="tx_modal" tabindex="-1" role="dialog" aria-labelledby="modal-default float-right" aria-hidden="true">
    <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="modal-title-default float-right">确认取消自动续费？</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <p>是否取消自动续费</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="delete_input">确定</button>
            </div>
        </div>
    </div>
    </div>
{include file='newui_dialog.tpl'}


{include file='user/newui_footer.tpl'}


<script>
function buy(id,auto,auto_reset,package) {
	auto_renew = auto;
    if (package == 1)
    {
      document.getElementById('autor').style.display = "none";
      document.getElementById('disableo').style.display = "none";
    }
    else
    {
      document.getElementById('autor').style.display = "";
      document.getElementById('disableo').style.display = "";
    }

	if(auto == 0)
	{
		document.getElementById('autor').style.display = "none";
	} else {
		document.getElementById('autor').style.display = "";
	}


	shop = id;
	$("#coupon_modal").modal();
}

$("#coupon_input").click(function () {
		$.ajax({
			type: "POST",
			url: "coupon_check",
			dataType: "json",
			data: {
				coupon: $("#coupon").val(),
				shop: shop
			},
			success: function (data) {
				if (data.ret) {
					$("#name").html("商品名称：" + data.name);
					$("#credit").html("优惠额度：" + data.credit);
					$("#total").html("总金额：" + data.total);
					$("#order_modal").modal();
				} else {
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error: function (jqXHR) {
				$("#result").modal();
                $("#msg").html(data.msg + "  发生了错误。");
			}
		})
	});
	
$("#order_input").click(function () {

		if(document.getElementById('autorenew').checked)
		{
			var autorenew = 1;
		} else {
			var autorenew = 0;
		}

		if(document.getElementById('disableothers').checked){
			var disableothers = 1;
		} else {
			var disableothers = 0;
		}
			
		$.ajax({
			type: "POST",
			url: "buy",
			dataType: "json",
			data: {
				coupon: $("#coupon").val(),
				shop: shop,
				autorenew: autorenew,
				disableothers:disableothers
			},
			success: function (data) {
				if (data.ret) {
					$("#result").modal();
					$("#msg").html(data.msg);
					window.setTimeout("location.href='/user/shop'", {$config['jump_delay']});
				} else {
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error: function (jqXHR) {
				$("#result").modal();
                $("#msg").html(data.msg + "  发生了错误。");
			}
		})
	});

</script>