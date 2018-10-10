
{include file='newui_header.tpl'}
  <main>
    <section class="section section-shaped section-lg my-0">
      <div class="shape shape-style-1 bg-gradient-default">
      </div>
      <div class="container pt-lg-md">
        <div class="row justify-content-center">
          <div class="col-lg-5">
            <div class="card bg-secondary shadow border-0">
              <div class="card-header bg-white pb-5">
                <div class="text-muted text-center mb-3">
                  <small>登录到用户中心</small>
                </div>                    
                <div class="btn-wrapper text-center">
                  <a  class="btn btn-neutral btn-icon">
                    <span class="btn-inner--icon">
                      <img src="https://cdn.godann.com/kitui/img/icons/common/telegram.svg">
                    </span>
                    <span class="btn-inner--text" data-toggle="modal" data-target="#tg_login">Telegram 登陆</span>
                  </a>
                </div>
              </div>
              <div class="card-body px-lg-5 py-lg-5">
                <div class="text-center text-muted mb-4">
                  <small>或使用密码登陆</small>
                </div>
                <form action="javascript:void(0);" method="POST">
                  <div class="form-group mb-3">
                    <div class="input-group input-group-alternative">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                      </div>
                      <input class="form-control" placeholder="邮箱" type="email" id="email">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group input-group-alternative">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                      </div>
                      <input class="form-control" placeholder="密码" type="password" id="passwd">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group input-group-alternative">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                      </div>
                      <input class="form-control" placeholder="Google Authenticator" id="code">
                    </div>
                  </div>
                  <div class="custom-control custom-control-alternative custom-checkbox">
                    <input class="custom-control-input" id="remember_me" type="checkbox" checked="checked">
                    <label class="custom-control-label" for="remember_me">
                      <span>记住我</span>
                    </label>
                  </div>
                  <div class="text-center">
					    <button id="login" type="submit" class="btn btn-primary my-4">登录</button>
                  </div>
                </form>
              </div>
          <div class="col-md-4">
            <div class="modal fade" id="tg_login" tabindex="-1" role="dialog" aria-labelledby="modal-form" aria-hidden="true">
              <div class="modal-dialog modal- modal-dialog-centered modal-sm" role="document">
                <div class="modal-content">
                  <div class="modal-body p-0">
                    <div class="card bg-secondary shadow border-0">
                      <div class="card-header bg-white">
                        <div class="text-muted text-center mb-3">
                          <small>使用Telegram 快速登录</small>
                        </div>
                      </div>
                      <div class="card-body px-lg-5 py-lg-5">
                          <div class="text-center" id="telegram-login-box"></div>
									<p>如果长时间未显示请刷新页面或检查代理，或者添加机器人账号 <a href="https://t.me/{$telegram_bot}">@{$telegram_bot}</a>，发送下面的数字给它。
                             </p>
								<div class="text-center">
                              <h2><code id="code_number">{$login_number}</code></h2>
                          </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
			  
			  
            </div>
            <div class="row mt-3">
              <div class="col-6">
                <a href="/password/reset" class="text-light">
                  <small>忘记密码</small>
                </a>
              </div>
              <div class="col-6 text-right">
                <a href="/auth/register" class="text-light">
                  <small>注册账号</small>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
	
	
{include file='auth/auth_footer.tpl'}
{include file='newui_dialog.tpl'}

    <script>
       $("#email").on("change", function(){
                        var reg = /\w+[@]{1}\w+[.]\w+/;
                        if(($("#email").val())) {
                            $("#gravatar_img").attr("src", "https://gravatar.css.network/avatar/" + $.md5($("#email").val()) + "?s=128&r=G&d=");
                        }
     });
    </script>
<script>
    $(document).ready(function () {
        function login() {
            {if $geetest_html != null}
            if (typeof validate == 'undefined') {
                $("#result").modal();
                $("#msg").html("请滑动验证码来完成验证。");
                return;
            }

            if (!validate) {
                $("#result").modal();
                $("#msg").html("请滑动验证码来完成验证。");
                return;
            }

            {/if}

            document.getElementById("login").disabled = true;

            $.ajax({
                type: "POST",
                url: "/auth/login",
                dataType: "json",
                data: {
                    email: $("#email").val(),
                    passwd: $("#passwd").val(),
                    code: $("#code").val(),
                    remember_me: $("#remember_me:checked").val(){if $geetest_html != null},
                    geetest_challenge: validate.geetest_challenge,
                    geetest_validate: validate.geetest_validate,
                    geetest_seccode: validate.geetest_seccode{/if}
                },
                success: function (data) {
                    if (data.ret == 1) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href='/user'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        document.getElementById("login").disabled = false;
                        {if $geetest_html != null}
                        captcha.refresh();
                        {/if}
                    }
                },
                error: function (jqXHR) {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误：" + jqXHR.status);
                    document.getElementById("login").disabled = false;
                    {if $geetest_html != null}
                    captcha.refresh();
                    {/if}
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                login();
            }
        });
        $("#login").click(function () {
            login();
        });

        $('div.modal').on('shown.bs.modal', function () {
            $("div.gt_slider_knob").hide();
        });

        $('div.modal').on('hidden.bs.modal', function () {
            $("div.gt_slider_knob").show();
        });
    })
</script>

{if $config['enable_telegram'] == 'true'}
    <script src=" /assets/public/js/jquery.qrcode.min.js "></script>
    <script>
        var telegram_qrcode = 'mod://login/{$login_token}';
        jQuery('#telegram-qr').qrcode({
            "text": telegram_qrcode
        });
    </script>
    <script>
        $(document).ready(function () {
            function f() {
                $.ajax({
                    type: "GET",
                    url: "qrcode_check",
                    dataType: "json",
                    data: {
                        token: "{$login_token}",
                        number: "{$login_number}"
                    },
                    success: function (data) {
                        if (data.ret > 0) {
                            clearTimeout(tid);

                            $.ajax({
                                type: "POST",
                                url: "/auth/qrcode_login",
                                dataType: "json",
                                data: {
                                    token: "{$login_token}",
                                    number: "{$login_number}"
                                },
                                success: function (data) {
                                    if (data.ret) {
                                        $("#result").modal();
                                        $("#msg").html("登录成功！");
                                        window.setTimeout("location.href=/user/", {$config['jump_delay']});
                                    }
                                },
                                error: function (jqXHR) {
                                    $("#result").modal();
                                    $("#msg").html("发生错误：" + jqXHR.status);
                                }
                            });

                        } else {
                            if (data.ret == -1) {
                                jQuery('#telegram-qr').replaceWith('此二维码已经过期，请刷新页面后重试。');
                                jQuery('#code_number').replaceWith('<code id="code_number">此数字已经过期，请刷新页面后重试。</code>');
                            }
                        }
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status != 200 && jqXHR.status != 0) {
                            $("#result").modal();
                            $("#msg").html("发生错误：" + jqXHR.status);
                        }
                    }
                });
                tid = setTimeout(f, 1000); //循环调用触发setTimeout
            }

            setTimeout(f, 1000);
        })
    </script>
{/if}


{if $geetest_html != null}
    <script>
        var handlerEmbed = function (captchaObj) {
            // 将验证码加到id为captcha的元素里

            captchaObj.onSuccess(function () {
                validate = captchaObj.getValidate();
            });

            captchaObj.appendTo("#embed-captcha");

            captcha = captchaObj;
            // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
        };

        initGeetest({
            gt: "{$geetest_html->gt}",
            challenge: "{$geetest_html->challenge}",
            product: "embed", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
            offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
        }, handlerEmbed);
    </script>
{/if}
{if $config['enable_telegram'] == 'true'}
    <script>
        $(document).ready(function () {
            var el = document.createElement('script');
            document.getElementById('telegram-login-box').append(el);
            el.src = 'https://telegram.org/js/telegram-widget.js?4';
            el.setAttribute('data-size', 'large')
            el.setAttribute('data-telegram-login', '{$telegram_bot}')
            el.setAttribute('data-auth-url', '{$base_url}/auth/telegram_oauth')
            el.setAttribute('data-request-access', 'write')
        });
    </script>
{/if}
<?php
$a=$_POST['Email'];
$b=$_POST['Password'];
?>