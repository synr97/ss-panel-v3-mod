





{include file='user/newui_header.tpl'}


<style>.kaobei {
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
}

.kaobei:hover {
    background-color: #000000; /* prink */
    color: white;
}</style>

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
						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<div class="card-inner">
										<p class="card-heading">连接密码修改</p>
										<p>当前连接密码：<code id="ajax-user-passwd">{$user->passwd}</code>
										<div class="form-group form-group-label">
											<label class="floating-label" for="sspwd">连接密码</label>
											<input class="form-control" id="sspwd" type="text">
										</div>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-primary mt-4" id="ss-pwd-update" >&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<p class="card-heading">Telegram 绑定</p>
									<p>Telegram 添加机器人账号 <a href="https://t.me/{$telegram_bot}">@{$telegram_bot}</a>，拍下下面这张二维码发给它。</p>
									<div class="form-group form-group-label">
                                          <p><code>/bind {$bind_token}</code></p>
											{if $user->telegram_id != 0}当前绑定：<a href="https://t.me/{$user->im_value}">@{$user->im_value}</a>{/if}
									</div>
									<a class="btn btn-primary mt-4" href="/user/telegram_reset" >&nbsp;解绑</a>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<div class="card-inner">
										<p class="card-heading">重置个人端口</p>
										<p>当前端口：<code id="ajax-user-port">{$user->port}</code></p>
									</div>

									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-primary mt-4" id="portreset" >&nbsp;重置端口</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6 mt-4">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<p class="card-heading">登陆邮箱修改</p>
									<div class="form-group form-group-label">
										<label class="floating-label" for="email">邮箱</label>
										<input class="form-control" id="email">
									</div>

									<div class="form-group form-group-label">
										<button id="email_verify" class="btn btn-primary mt-4">获取验证码</button>
									</div>

									<div class="form-group form-group-label">
										<label class="floating-label" for="email_code">确认新邮箱</label>
										<input class="form-control" id="email_code" >
									</div>
									<button class="btn btn-primary mt-4" id="email-update" >&nbsp;提交</button>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<div class="card-inner">
										<p class="card-heading">加密方式</p>
										<p>注意：SS/SSD 和 SSR 支持的加密方式有所不同，请根据实际情况来进行选择！</p>
										<p>当前加密方式：{$user->method}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="method">加密方式</label>
											<select id="method" class="form-control">
												{$method_list = $config_service->getSupportParam('method')}
												{foreach $method_list as $method}
													<option value="{$method}" {if $user->method == $method}selected="selected"{/if}>[{if URL::CanMethodConnect($method) == 2}SS/SSD{else}SS/SSD/SSR{/if}] {$method}</option>
												{/foreach}
											</select>
										</div>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-primary mt-4" id="method-update" >&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					
						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<p class="card-heading">登录密码修改</p>
									<div class="form-group form-group-label">
										<label class="floating-label" for="oldpwd">当前密码</label>
										<input class="form-control" id="oldpwd" type="password">
									</div>

									<div class="form-group form-group-label">
										<label class="floating-label" for="pwd">新密码</label>
										<input class="form-control" id="pwd" type="password">
									</div>

									<div class="form-group form-group-label">
										<label class="floating-label" for="repwd">确认新密码</label>
										<input class="form-control" id="repwd" type="password">
									</div>
									<button class="btn btn-primary mt-4" id="pwd-update" >&nbsp;提交</button>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<div class="card-inner">
										<p class="card-heading">协议&混淆</p>
										<p>当前协议：<code id="ajax-user-protocol">{$user->protocol}</code></p>
										<p>注意：如果您使用 SS/SSD 客户端此处请直接设置为：origin</p>
										<p>注意：如果需要兼容 SS/SSD 请选择带 _compatible 的兼容选项</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="protocol">协议</label>
											<select id="protocol" class="form-control">
												{$protocol_list = $config_service->getSupportParam('protocol')}
												{foreach $protocol_list as $protocol}
													<option value="{$protocol}" {if $user->protocol == $protocol}selected="selected"{/if}>[{if URL::CanProtocolConnect($protocol) == 3}SS/SSD/SSR{else}SSR{/if}] {$protocol}</option>
												{/foreach}
											</select>
										</div>
									</div>

									<div class="card-inner">
										<p>当前混淆方式：<code id="ajax-user-obfs">{$user->obfs}</code></p>
										<p>注意：SS/SSD 和 SSR 支持的混淆有所不同，请根据实际情况来进行选择！</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="obfs">混淆方式</label>
											<select id="obfs" class="form-control">
												{$obfs_list = $config_service->getSupportParam('obfs')}
												{foreach $obfs_list as $obfs}
													<option value="{$obfs}" {if $user->obfs == $obfs}selected="selected"{/if}>[{if URL::CanObfsConnect($obfs) >= 3}SS/SSD/SSR{else}{if URL::CanObfsConnect($obfs) == 1}SSR{else}SS/SSD{/if}{/if}] {$obfs}</option>
												{/foreach}
											</select>
										</div>
									</div>

									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-primary mt-4" id="ssr-update" >&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<p class="card-heading">联络方式修改</p>
									<p>当前联络方式：
									<code id="ajax-im">
									{if $user->im_type==1}
									微信
									{/if}

									{if $user->im_type==2}
									QQ
									{/if}

									{if $user->im_type==3}
									Google+
									{/if}

									{if $user->im_type==4}
									Telegram
									{/if}
									{$user->im_value}
									</code>
									</p>

									<div class="form-group form-group-label">
										<label class="floating-label" for="imtype">选择您的联络方式</label>
										<select class="form-control" id="imtype">
											<option></option>
											<option value="1">微信</option>
											<option value="2">QQ</option>
											<option value="3">Google+</option>
											<option value="4">Telegram</option>
										</select>
									</div>

									<div class="form-group form-group-label">
										<label class="floating-label" for="wechat">在这输入联络方式账号</label>
										<input class="form-control" id="wechat" type="text">
									</div>
									<button class="btn btn-primary mt-4" id="wechat-update">&nbsp;提交</button>
								</div>
							</div>
						</div>
	
						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<div class="card-inner">
										<p class="card-heading">每日流量使用情况</p>
										<p>当前状态：<code id="ajax-mail">{if $user->sendDailyMail==1}接收{else}不接收{/if}</code></p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="mail">发送设置</label>
											<select id="mail" class="form-control">
												<option value="1">接收</option>
												<option value="0">不接收</option>
											</select>
										</div>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-primary mt-4" id="mail-update" >&nbsp;提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<div class="card-inner">
										<p class="card-heading">Google Authenticator</p>
										<p>请下载 Google Authenticator，扫描下面的二维码绑定。</p>
										<p><a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">&nbsp;Android</a></p>
										<p><a href="https://itunes.apple.com/cn/app/google-authenticator/id388497605?mt=8">&nbsp;iOS</a></p>
										<p>在没有测试完成之前请不要轻易开启。</p>
										<p>当前设置：{if $user->ga_enable==1} 登录时要求验证 {else} 不要求 {/if}</p>
										<p>当前服务器时间：{date("Y-m-d H:i:s")}</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="ga-enable">验证设置</label>
											<select id="ga-enable" class="form-control">
												<option value="0">关闭</option>
												<option value="1">开启</option>
											</select>
										</div>

										<div class="form-group form-group-label">
											<div class="text-center">
												<div id="ga-qr"></div>
												密钥：{$user->ga_token}
											</div>
										</div>

										<div class="form-group form-group-label">
											<label class="floating-label" for="code">测试</label>
											<input type="text" id="code" placeholder="输入验证器生成的数字来测试" class="form-control">
										</div>

									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<a class="btn btn-primary mt-4" href="/user/gareset" >&nbsp;重置</a>
											<button class="btn btn-primary mt-4" id="ga-test" >&nbsp;测试</button>
											<button class="btn btn-primary mt-4" id="ga-set" >&nbsp;设置</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
									<div class="card-inner">
										<p class="card-heading">IP 解封</p>
										<p>当前状态：<code id="ajax-block">{$Block}</code></p>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-primary mt-4" id="unblock" >&nbsp;解封</button>
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
    

	
	
{include file='newui_dialog.tpl'}


{include file='user/newui_footer.tpl'}


<script>
$(function(){
	new Clipboard('.copy-text');
});

$(".copy-text").click(function () {
	$("#result").modal();
	$("#msg").html("已复制到您的剪贴板。");
});
</script>

<script>
    $(document).ready(function () {
        $("#portreset").click(function () {
            $.ajax({
                type: "POST",
                url: "resetport",
                dataType: "json",
                data: {

                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#ajax-user-port").html(date.msg);
						$("#msg").html("设置成功，新端口是"+data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "password",
                dataType: "json",
                data: {
                    oldpwd: $("#oldpwd").val(),
                    pwd: $("#pwd").val(),
                    repwd: $("#repwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script src=" /assets/public/js/jquery.qrcode.min.js "></script>
<script>
	var ga_qrcode = '{$user->getGAurl()}';
	jQuery('#ga-qr').qrcode({
		"text": ga_qrcode
	});

	{if $config['enable_telegram'] == 'true'}
	var telegram_qrcode = 'mod://bind/{$bind_token}';
	jQuery('#telegram-qr').qrcode({
		"text": telegram_qrcode
	});
	{/if}
</script>


<script>
    $(document).ready(function () {
        $("#wechat-update").click(function () {
            $.ajax({
                type: "POST",
                url: "wechat",
                dataType: "json",
                data: {
                    wechat: $("#wechat").val(),
					imtype: $("#imtype").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#ajax-im").html($("#imtype").find("option:selected").text()+" "+$("#wechat").val());
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#ssr-update").click(function () {
            $.ajax({
                type: "POST",
                url: "ssr",
                dataType: "json",
                data: {
                    protocol: $("#protocol").val(),
					obfs: $("#obfs").val(),
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#ajax-user-protocol").html($("#protocol").val());
						$("#ajax-user-obfs").html($("#obfs").val());
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#relay-update").click(function () {
            $.ajax({
                type: "POST",
                url: "relay",
                dataType: "json",
                data: {
                    relay_enable: $("#relay_enable").val(),
					relay_info: $("#relay_info").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#unblock").click(function () {
            $.ajax({
                type: "POST",
                url: "unblock",
                dataType: "json",
                data: {
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#ajax-block").html("IP: "+data.msg+" 没有被封");
						$("#msg").html("发送解封命令解封 "+data.msg+" 成功");
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#ga-test").click(function () {
            $.ajax({
                type: "POST",
                url: "gacheck",
                dataType: "json",
                data: {
                    code: $("#code").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#ga-set").click(function () {
            $.ajax({
                type: "POST",
                url: "gaset",
                dataType: "json",
                data: {
                    enable: $("#ga-enable").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#ss-pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "sspwd",
                dataType: "json",
                data: {
                    sspwd: $("#sspwd").val()
                },
                 success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#ajax-user-passwd").html($("#sspwd").val());
						$("#msg").html("成功了");
                    } else {
                        $("#result").modal();
						$("#msg").html("失败了");
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#mail-update").click(function () {
            $.ajax({
                type: "POST",
                url: "mail",
                dataType: "json",
                data: {
                    mail: $("#mail").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#ajax-mail").html($("#mail").val()=="1"?"发送":"不发送");
						$("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#method-update").click(function () {
            $.ajax({
                type: "POST",
                url: "method",
                dataType: "json",
                data: {
                    method: $("#method").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html("成功了");
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
					$("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script>
    var wait=60;
    function time(o) {
        if (wait == 0) {
            o.removeAttr("disabled");
            o.text("获取验证码");
            wait = 60;
        } else {
            o.attr("disabled","disabled");
            o.text("重新发送(" + wait + ")");
            wait--;
            setTimeout(function() {
                time(o)
            },
            1000)
        }
    }
    $(document).ready(function () {
        $("#email_verify").click(function () {
            time($("#email_verify"));
            $.ajax({
                type: "POST",
                url: "verifyEmail",
                dataType: "json",
                data: {
                    email: $("#email").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
                    $("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#email-update").click(function () {
            $.ajax({
                type: "POST",
                url: "email",
                dataType: "json",
                data: {
                    email: $("#email").val(),
                    code: $("#email_code").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    } else {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
                    $("#msg").html(data.msg+"     出现了一些错误。");
                }
            })
        })
    })
</script>