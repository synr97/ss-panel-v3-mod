

{include file='user/main.tpl'}

{$ssr_prefer = URL::SSRCanConnect($user, 0)}


	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">用户中心</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">

						<div class="col-lg-6 col-md-6">

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">Dler Cloud</p>
										{if $user->class != 0}
										<p><a href="https://t.me/dlercloud_talk" target="_blank">官方交流群组</a> | <a href="https://t.me/dlercloud_news" target="_blank">官方公告面板</a> | <a href="https://t.me/Licensess" target="_blank">流媒体合租</a> | <a href="/client.html" target="_blank">软件中心</a> | <a href="https://docs.lhie1.com/black-hole" target="_blank">文档中心</a></p>
										{/if}
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">All-in-One</p>
										<p>为您提供订阅地址和托管地址，包含了所有节点信息，方便您在诸多的服务器中快速添加，快速切换！</p>
										<p>请前往<a href="/client.html" target="_blank">「软件中心」</a>获取客户端</p> 
										<p>请前往<a href="https://docs.lhie1.com/black-hole" target="_blank">「使用教程」</a>（<a href="https://github.com/lhie1/Document/blob/master/SUMMARY.md" target="_blank">备用地址</a>）观看使用教程</p> 
										<p>请前往<a href="https://docs.lhie1.com/black-hole/tong-yong" target="_blank">「通用」</a>获得帮助与指导</p> 
										{if $user->class != 0}
										<div class="card-action">
											<p class="card-heading">订阅地址</p>
											{if URL::SSRCanConnect($user)}
											<p>SSR 个人端口订阅地址</p>
											<p><code>{$apiUrl}/link/{$ssr_sub_token}?mu=0</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=0">点击拷贝</button>
											<p><a href="Shadowrocket://add/sub://{$ssr_url_0}?remarks=Dler%20Cloud" target="_blank"><span class="icon">check</span>&nbsp;Shadwrocket：一键导入订阅</a></p>
											<p><a href="quantumult://configuration?server={$ssr_url_0}&filter={$filterUrl}&rejection={$rejectUrl}" target="_blank"><span class="icon">check</span>&nbsp;Quantumult：一键导入订阅&规则</a></p>
											<br>
											{/if}
											<p>SSR 公共端口订阅地址</p>
											<p><code>{$apiUrl}/link/{$ssr_sub_token}?mu=1</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=1">点击拷贝</button>
											<p><a href="Shadowrocket://add/sub://{$ssr_url_1}?remarks=Dler%20Cloud" target="_blank"><span class="icon">check</span>&nbsp;Shadwrocket：一键导入订阅</a></p>
											<p><a href="quantumult://configuration?server={$ssr_url_1}&filter={$filterUrl}&rejection={$rejectUrl}" target="_blank"><span class="icon">check</span>&nbsp;Quantumult：一键导入订阅&规则</a></p>
											<br>
											<br>
											{if URL::SSCanConnect($user)}
											<p>SSD 订阅地址</p>
											<p><code>{$apiUrl}/link/{$ssr_sub_token}?mu=3</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=3">点击拷贝</button>
											{/if}
											<br>
											<br>
											<p>V2Ray 订阅地址</p>
											<p><code>{$apiUrl}/link/{$ssr_sub_token}?mu=2</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ssr_sub_token}?mu=2">点击拷贝</button>
											<p><a class="copy-text" data-clipboard-text="{URL::getAllVMessUrl($user)}">复制所有 VMess 链接</a></p>
											<p><a href="Shadowrocket://add/sub://{$v2_url}?remarks=Dler%20Cloud%20-%20[V2Ray]" target="_blank"><span class="icon">check</span>&nbsp;Shadwrocket：一键导入订阅</a></p>
											<p><a href="quantumult://configuration?server={$v2_url_x}&filter={$filterUrl}&rejection={$rejectUrl}" target="_blank"><span class="icon">check</span>&nbsp;Quantumult：一键导入订阅&规则</a></p>
										</div>

										<div class="card-action">
											<p class="card-heading">托管地址</p>
											{if URL::SSCanConnect($user)}
											<p>Surge 2&3 / Surfboard 个人端口托管地址</p>
											<p><code>{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=0</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=0">点击拷贝</button>
											<p><a href="surge:///install-config?url={$ss_url_0}" target="_blank"><span class="icon">check</span>&nbsp;Surge / Surfboard：一键托管&规则</a></p>
											<br>
											{/if}
											<p>Surge 2&3 / Surfboard 公共端口托管地址</p>
											<p><code>{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=1</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=1">点击拷贝</button>
											<p><a href="surge:///install-config?url={$ss_url_1}" target="_blank"><span class="icon">check</span>&nbsp;Surge / Surfboard：一键托管&规则</a></p>
											<br>
											<br>
											{if URL::SSCanConnect($user)}
											<p>Surge 2&3 个人端口托管地址（MitM）</p>
											<p><code>{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=0&mitm=1</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=0&mitm=1">点击拷贝</button>
											<p><a href="surge:///install-config?url={$ss_url_0_mitm}" target="_blank"><span class="icon">check</span>&nbsp;Surge：一键托管&规则</a></p>
											<br>
											{/if}
											<p>Surge 2&3 公共端口托管地址（MitM）</p>
											<p><code>{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=1&mitm=1</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=1&mitm=1&new=1">点击拷贝</button>
											<p><a href="surge:///install-config?url={$ss_url_1_mitm}" target="_blank"><span class="icon">check</span>&nbsp;Surge：一键托管&规则</a></p>
											<br>
											<br>
											{if URL::SSCanConnect($user)}
											<p>Surge 3 个人端口托管地址（MitM）</p>
											<p><code>{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=0&mitm=1&new=1</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=0&mitm=1">点击拷贝</button>
											<p><a href="surge:///install-config?url={$ss_url_0_mitm_new}" target="_blank"><span class="icon">check</span>&nbsp;Surge：一键托管&规则</a></p>
											<br>
											{/if}
											<p>Surge 3 公共端口托管地址（MitM）</p>
											<p><code>{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=1&mitm=1&new=1</code></p>
											<button class="copy-text btn btn-subscription" type="button" data-clipboard-text="{$apiUrl}/link/{$ios_token}?is_ss=1&is_mu=1&mitm=1&new=1">点击拷贝</button>
											<p><a href="surge:///install-config?url={$ss_url_1_mitm_new}" target="_blank"><span class="icon">check</span>&nbsp;Surge：一键托管&规则</a></p>
										</div>
										
										<div class="card-action">
											<div class="card-action-btn pull-left">
												<p><a class="reset-link btn btn-brand btn-flat waves-attach" ><span class="icon">autorenew</span>&nbsp;重置订阅 / 托管地址</a></p>
											</div>
										</div>
										{else}
										<div class="card-action">
											<div class="card-action-btn pull-left">
												<a href="/user/shop">
													<i class="icon icon-lg">info</i>&nbsp;已到期或未购买（点此购买）
												</a>
											</div>
										</div>
										{/if}
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6 col-md-6">

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">公告（<a href="/user/announcement"/>更多</a>）</p>
										{if $ann != null}
										<p>{$ann->content}</p>
										{/if}
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">账户信息</p>
										<dl class="dl-horizontal">
											<p><dt>用户名</dt>
											<dd>{$user->user_name}</dd></p>

											<p><dt>账号等级</dt>
											<dd>{$user->class}</dd></p>

											<p><dt>到期时间</dt>
											<dd>{$user->class_expire}</dd></p>

											<p><dt>余额</dt>
											<dd>{$user->money} 元</p></p>

											<p><dt>速度限制</dt>
											{if $user->node_speedlimit!=0}
											<dd>{$user->node_speedlimit} Mbps</dd>
											{else}
											<dd>∞</dd>
											{/if}</p>

											<p><dt>在线 IP</dt>
											<dd>{$user->online_ip_count()} / {if $user->node_connector!=0}{$user->node_connector}{else}∞{/if}</dd></p>

											<p><dt>最近使用时间</dt>
											<dd>{$user->lastSsTime()}</dd></p>
										</dl>
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">连接信息</p>
											<dl class="dl-horizontal">
												<p><dt>端口</dt>
												<dd>{$user->port}</dd></p>

												<p><dt>密码</dt>
												<dd>{$user->passwd}</dd></p>

												<p><dt>加密</dt>
												<dd>{$user->method}</dd></p>

												<p><dt>协议</dt>
												<dd>{$user->protocol}</dd></p>

												<p><dt>混淆</dt>
												<dd>{$user->obfs}</dd></p>
											</dl>
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">

										<div id="traffic_chart" style="height: 300px; width: 100%;"></div>

										<script src="//cdn.staticfile.org/canvasjs/1.7.0/canvasjs.js"></script>
										<script type="text/javascript">
											var chart = new CanvasJS.Chart("traffic_chart",
											{
												title:{
													text: "流量使用情况",
													fontFamily: "Impact",
													fontWeight: "normal"
												},

												legend:{
													verticalAlign: "bottom",
													horizontalAlign: "center"
												},
												data: [
												{
													//startAngle: 45,
													indexLabelFontSize: 20,
													indexLabelFontFamily: "Garamond",
													indexLabelFontColor: "darkgrey",
													indexLabelLineColor: "darkgrey",
													indexLabelPlacement: "outside",
													type: "doughnut",
													showInLegend: true,
													dataPoints: [
														{if $user->transfer_enable != 0}
														{
															y: {$user->last_day_t/$user->transfer_enable*100},label: "过去已用", legendText:"过去已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}", indexLabel: "过去已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}"
														},
														{
															y: {($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100},label: "今日已用", legendText:"今日已用 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}", indexLabel: "今日已用 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}"
														},
														{
															y: {($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100},label: "剩余可用", legendText:"剩余可用 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}", indexLabel: "剩余可用 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}"
														}
														{/if}
													]
												}
												]
											});

											chart.render();
										</script>

									</div>

								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">签到</p>
											<p>每次签到可能减少/增加流量（{$config['checkinMin']} ~ {$config['checkinMax']}MB）。</p>

											<p>您可以点击按钮或者摇动手机来签到。</p>

											<p>上次签到时间：<code>{$user->lastCheckInTime()}</code></p>

											<p id="checkin-msg"></p>

											{if $geetest_html != null}
												<div id="popup-captcha"></div>
											{/if}
									</div>

									<div class="card-action">
										<div class="card-action-btn pull-left">
											{if $user->isAbleToCheckin() }
											{if $user->class !=0}
												<p id="checkin-btn">
													<button id="checkin" class="btn btn-brand btn-flat waves-attach"><span class="icon">check</span>&nbsp;签到</button>
												</p>
											{else}
												<p><a class="btn btn-brand disabled btn-flat waves-attach" href="#"><span class="icon">close</span>&nbsp;未购买不能签到</a></p>
											{/if}
											{else}
												<p><a class="btn btn-brand disabled btn-flat waves-attach" href="#"><span class="icon">close</span>&nbsp;今天已经签到过了</a></p>
											{/if}
										</div>
									</div>

								</div>
							</div>

						{include file='dialog.tpl'}

				</div>


				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}

<script src="https://cdn.jsdelivr.net/npm/shake.js@1.2.2/shake.min.js"></script>

<script>

$(function(){
	new Clipboard('.copy-text');
});

$(".copy-text").click(function () {
	$("#result").modal();
	$("#msg").html("已拷贝到您的剪贴板，请您继续接下来的操作。");
});

$(".reset-link").click(function () {
	$("#result").modal();
	$("#msg").html("已重置订阅链接，请您继续接下来的操作。");
	window.setTimeout("location.href='/user/url_reset'", {$config['jump_delay']});
});

{if $user->transfer_enable-($user->u+$user->d) == 0}	
window.onload = function() {	
    $("#result").modal();	
    $("#msg").html("您的流量已经用完或套餐已经过期");	
};
{/if}

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