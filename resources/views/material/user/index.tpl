





{include file='user/newui_header.tpl'}

{$ssr_prefer = URL::SSRCanConnect($user, 0)}


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
									<a href="/user/node" class="btn btn-sm btn-primary float-right">节点列表</a>
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
			<div class="col-lg-8">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
                  <div class="progress-label">
                    <span>剩余流量</span>
                  </div>
              <div class="progress-wrapper">
                <div class="progress-info">
                  <div class="progress-percentage">
                    <span>{number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}%</span>
                  </div>
                </div>
                <div class="progress">
                  <div class="progress-bar bg-success" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}%;"></div>
                </div>
              </div>
                    <div class="row">
                    {if $user->isAbleToCheckin() == 1  && $user->class > 0}
                    <button id="checkin" class="btn btn-primary mt-4" style="margin-left: 1rem;">签到<br>（-500M ～ 1000M）</button>
                    {else}
                    <button disabled="disabled" class="btn btn-primary mt-4" style="margin-left: 1rem;">签到<br>（-500M ～ 1000M）</button>
                    {/if}
					   <p class="col mt-4" style="text-align: right;">
                     <span style="color:#B5B5B5;font-size: 18px" title="{number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% 剩余">已用：{$user->LastusedTraffic()}</span>
                         <span style="font-size: 18px;"> / </span><span style="font-weight: 550;color: #8898aa;font-size: 18px;" title="{number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% 剩余">可用：{$user->unusedTraffic()}</span>
                   </p>	
                  </div>
                  </div>
                </div>
            </div>	
			<div class="col-lg-4">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
                  <div class="progress-label">
                    <span>到期时间</span>
                  </div>
						<h2 class="card-title">
						<p class="mt-4" style="font-weight: 700;">{$user->class_expire}</p>
						</h2>
                    <a  class="btn btn-primary mt-4" href="/user/shop">续费</a>
                  </div>
                </div>
            </div>	
            </div>					
					<div class="mt-5 py-5 border-top text-center">
						<div class="row justify-content-center">
							<div class="col-lg-9">
								<div class="mb-3">
									<small class="text-uppercase font-weight-bold">{if $user->lastSsTime()=='从未使用喵'}不知道如何使用？{else}公告 - {$ann->date}{/if}</small>
								</div>
								{if $user->lastSsTime()=='从未使用喵'}
									<p style="color:#DC143C">第一次使用？<a href="https://docs.lhie1.com/black-hole"/>查看教程</a></p>
									<hr>
								{/if}
									<p>{$ann->content}</p>		 
									</div>
								</div>
							</div>

					<div class="mt-5 py-5 border-top text-center">
						<div class="row justify-content-center">
							<div class="col-lg-9">
						<div class="mb-3">
							<small class="text-uppercase font-weight-bold">All-in-One</small>
						</div>
							<div class="nav-wrapper">
								<ul class="nav nav-pills nav-fill flex-column flex-md-row" id="tabs-text" role="tablist">
									<li class="nav-item">
										<a class="nav-link mb-sm-3 mb-md-0 active" id="all_info-tab" data-toggle="tab" href="#all_info" role="tab" aria-controls="all_info" aria-selected="true">连接信息</a>
									</li>
									<li class="nav-item">
										<a class="nav-link mb-sm-3 mb-md-0" id="all_ssr-tab" data-toggle="tab" href="#all_ssr" role="tab" aria-controls="all_ssr" aria-selected="false">SSR</a>
									</li>
									<li class="nav-item">
										<a class="nav-link mb-sm-3 mb-md-0" id="all_ss-tab" data-toggle="tab" href="#all_ss" role="tab" aria-controls="all_ss" aria-selected="false">SS</a>
									</li>
									<li class="nav-item">
										<a class="nav-link mb-sm-3 mb-md-0" id="all_v2-tab" data-toggle="tab" href="#all_v2" role="tab" aria-controls="all_v2" aria-selected="false">V2Ray</a>
									</li>
								</ul>
							</div>

							<div class="card shadow">
								<div class="card-body">
									<div class="tab-content" id="myTabContent">
										<div class="tab-pane fade show active" id="all_info" role="tabpanel" aria-labelledby="all_info-tab">
																		<p>{$agent}</p>
											<dl class="dl-horizontal">
												<p><dt>端口</dt>
												<dd><code>{$user->port}</code></dd></p>

												<p><dt>密码</dt>
												<dd><code>{$user->passwd}</code></dd></p>

												<p><dt>加密</dt>
												<dd><code>{$user->method}</code></dd></p>

												<p><dt>协议</dt>
												<dd><code>{$user->protocol}</code></dd></p>

												<p><dt>混淆</dt>
												<dd><code>{$user->obfs}</code></dd></p>
											</dl>
											<button id="reset-link" class="btn btn-primary mt-4 reset-link">重置订阅/托管地址</button>
										</div>
										<div class="tab-pane fade" id="all_ssr" role="tabpanel" aria-labelledby="all_ssr-tab">
											<div style="padding:18px">
												{if URL::SSRCanConnect($user)}
													<p>SSR 个人端口订阅地址</p>
													<p>
													<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=0">{$apiUrl}/link/{$ssr_sub_token}?mu=0</a></code>
													</p>
													<p><a href="Shadowrocket://add/sub://{$ssr_url_0}?remarks=Dler%20Cloud%20-%20%%5bSSR%5d" target="_blank" class="btn btn-primary mt-4">&nbsp;Shadwrocket<br>一键导入订阅</a></p>
													<p><a href="quantumult://configuration?server={$ssr_url_0}&filter={$filterUrl}&rejection={$rejectUrl}" target="_blank" class="btn btn-primary mt-4">&nbsp;Quantumult<br>一键导入订阅&规则</a></p>
												{else}
													<p>SSR 公共端口订阅地址</p>
													<p>
													<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=1">{$apiUrl}/link/{$ssr_sub_token}?mu=1</a></code>
													</p>
													<p>
													<a href="Shadowrocket://add/sub://{$ssr_url_1}?remarks=Dler%20Cloud%20-%20%%5bSSR%5d" target="_blank" class="btn btn-primary mt-4">&nbsp;Shadwrocket<br>一键导入订阅</a>
													</p>
													<p>
													<a href="quantumult://configuration?server={$ssr_url_1}&filter={$filterUrl}&rejection={$rejectUrl}" target="_blank" class="btn btn-primary mt-4">&nbsp;Quantumult<br>一键导入订阅&规则</a>
													</p>
												{/if}
											</div>
										</div>
										<div class="tab-pane fade" id="all_ss" role="tabpanel" aria-labelledby="all_ss-tab">
											{if URL::SSCanConnect($user)}
												<p>SSD 订阅地址</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=3">{$apiUrl}/link/{$ssr_sub_token}?mu=3</a></code>
												</p>
												<hr>
											{/if}
											{if URL::SSCanConnect($user)}
												<p>SS 订阅地址</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=4">{$apiUrl}/link/{$ssr_sub_token}?mu=4</a></code>
												</p>
												<p>
												<a href="Shadowrocket://add/sub://{$apiUrl}/link/{$ssr_sub_token}?mu=4?remarks=Dler%20Cloud%20-%20%5bSS%5d" target="_blank" class="btn btn-primary mt-4">&nbsp;Shadwrocket<br>一键导入订阅</a>
												</p>
												<p>
												<a href="quantumult://configuration?server={$apiUrl}/link/{$ssr_sub_token}?mu=4&filter={$filterUrl}&rejection={$rejectUrl}" target="_blank" class="btn btn-primary mt-4">&nbsp;Quantumult<br>一键导入订阅&规则</a>
												</p>
												<hr>
											{/if}
											{if URL::SSCanConnect($user)}
												<p>Surge 2&3 / Surfboard 个人端口托管地址</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_mu=0">{$apiUrl}/link/{$ios_token}?is_mu=0</a></code>
												</p>
												<p>
												<a href="surge:///install-config?url={$ss_url_0}" target="_blank" class="btn btn-primary mt-4">&nbsp;Surge / Surfboard<br>一键托管&规则</a>
												</p>
											{else}
												<p>Surge 2&3 / Surfboard 公共端口托管地址</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_mu=1">{$apiUrl}/link/{$ios_token}?is_mu=1</a></code>
												</p>
												<p>
												<a href="surge:///install-config?url={$ss_url_1}" target="_blank" class="btn btn-primary mt-4">&nbsp;Surge / Surfboard<br>一键托管&规则</a>
												</p>
											{/if}
											{if URL::SSCanConnect($user)}
												<p>Surge 2&3 / Surfboard 个人端口托管地址（MitM）</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_mu=0&mitm=1">{$apiUrl}/link/{$ios_token}?is_mu=0&mitm=1</a></code>
												</p>
												<p>
												<a href="surge:///install-config?url={$ss_url_0_mitm}" target="_blank" class="btn btn-primary mt-4">&nbsp;Surge<br>一键托管&规则</a>
												</p>
											{else}
												<p>Surge 2&3 / Surfboard 公共端口托管地址（MitM）</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_mu=1&mitm=1">{$apiUrl}/link/{$ios_token}?is_mu=1&mitm=1</a></code>
												</p>
												<p>
												<a href="surge:///install-config?url={$ss_url_1_mitm}" target="_blank" class="btn btn-primary mt-4">&nbsp;Surge<br>一键托管&规则</a>
												</p>
											{/if}
											{if URL::SSCanConnect($user)}
												<p>Surge 3 个人端口托管地址（MitM）</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_mu=0&mitm=1&new=1">{$apiUrl}/link/{$ios_token}?is_mu=0&mitm=1&new=1</a></code>
												</p>
												<p>
												<a href="surge3:///install-config?url={$ss_url_0_mitm_new}" target="_blank" class="btn btn-primary mt-4">&nbsp;Surge<br>一键托管&规则</a>
												</p>
											{else}
												<p>Surge 3 公共端口托管地址（MitM）</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_mu=1&mitm=1&new=1">{$apiUrl}/link/{$ios_token}?is_mu=1&mitm=1&new=1</a></code>
												</p>
												<p>
												<a href="surge3:///install-config?url={$ss_url_1_mitm_new}" target="_blank" class="btn btn-primary mt-4">&nbsp;Surge<br>一键托管&规则</a>
												</p>
											{/if}
										</div>
											<div class="tab-pane fade" id="all_v2" role="tabpanel" aria-labelledby="all_v2-tab">
												<p>V2Ray 订阅地址</p>
												<p>
												<code><a class="copy-text" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=2">{$apiUrl}/link/{$ssr_sub_token}?mu=2</a></code>
												</p>
												<a class="btn btn-brand copy-text" data-clipboard-text="{URL::getAllVMessUrl($user)}">复制所有 VMess 链接</a>
												<p>
												<a href="Shadowrocket://add/sub://{$v2_url}?remarks=Dler%20Cloud%20-%20%5bV2Ray%5d" target="_blank" class="btn btn-primary mt-4">&nbsp;Shadwrocket<br>一键导入订阅</a>
												</p>
												<p>
												<a href="quantumult://configuration?server={$v2_url_x}&filter={$filterUrl}&rejection={$rejectUrl}" target="_blank" class="btn btn-primary mt-4">&nbsp;Quantumult<br>一键导入订阅&规则</a>
												</p>
												</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</section>
		
	
	<div class="modal fade" id="delete_modal" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
		<div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
				<div class="modal-content">
						<div class="modal-header">
								<h6 class="modal-title" id="modal-title-default">确定取消自动续费？</h6>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">×</span>
								</button>
						</div>
						<div class="modal-body">
								<p>是否取消自动续费</p>
						</div>
						<div class="modal-footer">
								<button type="button" class="btn btn-link	ml-auto" data-dismiss="modal">取消</button>
								<button type="button" class="btn btn-primary" id="delete_input">确定</button>
						</div>
				</div>
		</div>
		</div>
	
	
	
		<div class="modal fade" id="info_form" tabindex="-1" role="dialog" aria-labelledby="modal-form" aria-hidden="true">
							<div class="modal-dialog modal- modal-dialog-centered modal-sm" role="document">
								<div class="modal-content">
									<div class="modal-body p-0">
										<div class="card bg-secondary shadow border-0">
											<div class="card-body px-lg-5 py-lg-5">
												<div class="text-center text-muted mb-4">
													<small>账户信息</small>
												</div>
													<div class="text-center">
													</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
{include file='newui_dialog.tpl'}


{include file='user/newui_footer.tpl'}

<script src="/theme/material/js/shake.js/shake.js"></script>


<script>

$(function(){
	new Clipboard('.copy-text');
});

$(".copy-text").click(function () {
	$("#result").modal();
	$("#msg").html("已复制到您的剪贴板，请您继续接下来的操作。");
});

$(".reset-link").click(function () {
	$("#result").modal();
	$("#msg").html("已重置订阅链接，请您继续接下来的操作。");
	window.setTimeout("location.href='/user/url_reset'", {$config['jump_delay']});
});
  
{if $geetest_html == null}
window.onload = function() {
    var myShakeEvent = new Shake({
        threshold: 15
    });
    myShakeEvent.start();
    window.addEventListener('shake', shakeEventDidOccur, false);
    function shakeEventDidOccur () {
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}
        $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
					$("#result").modal();
                    $("#msg").html(data.msg);
                  	window.setTimeout("location.href='/user'", {$config['jump_delay']});
                },
                error: function (jqXHR) {
					$("#result").modal();
                    $("#msg").html("发生错误：" + jqXHR.status);
                }
            });
    }
};

$(document).ready(function () {
	$("#checkin").click(function () {
		$.ajax({
			type: "POST",
			url: "/user/checkin",
			dataType: "json",
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
                  	window.setTimeout("location.href='/user'", {$config['jump_delay']})
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		})
	})
})

{else}

window.onload = function() {
    var myShakeEvent = new Shake({
        threshold: 15
    });
    myShakeEvent.start();
    window.addEventListener('shake', shakeEventDidOccur, false);
    function shakeEventDidOccur () {
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}
        c.show();
    }
};

var handlerPopup = function (captchaObj) {
	c = captchaObj;
	captchaObj.onSuccess(function () {
		var validate = captchaObj.getValidate();
		$.ajax({
			url: "/user/checkin", // 进行二次验证
			type: "post",
			dataType: "json",
			data: {
				// 二次验证所需的三个值
				geetest_challenge: validate.geetest_challenge,
				geetest_validate: validate.geetest_validate,
				geetest_seccode: validate.geetest_seccode
			},
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		});
	});
	// 弹出式需要绑定触发验证码弹出按钮
	captchaObj.bindOn("#checkin");
	// 将验证码加到id为captcha的元素里
	captchaObj.appendTo("#popup-captcha");
	// 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};
initGeetest({
	gt: "{$geetest_html->gt}",
	challenge: "{$geetest_html->challenge}",
	product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
	offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
}, handlerPopup);

{/if}

</script>
