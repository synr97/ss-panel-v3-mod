
{include file='header.tpl'}

<main class="content">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-lg-push-4 col-sm-6 col-sm-push-3">
					<section class="content-inner">
						<div class="card">
							<div class="card-main">
								<div class="card-header">
									<div class="card-inner">
									<!-- 这里可以取消掉注释换logo图。
									<h1 class="card-heading"><img src="/images/register.jpg" height=100% width=100% /></h1>
									-->
									<h1 class="card-heading">
										<div class="text" style=" text-align:center;">
											欢迎来到
										</div>
										<div class="text" style=" text-align:center;font-weight: bold;">
											{$config["appName"]}
										</div>
									</h1>
									</div>
								</div>
								{if $config['enable_register']!='false'}
								<div class="card-inner">
									
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="name">昵称（必填）</label>
													<input class="form-control" id="name" type="text">
												</div>
											</div>
										</div>
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="email">邮箱（必填）</label>
													<input class="form-control" id="email" type="text"><br>
													{if $enable_email_verify == 'true'}
													<button id="email_verify" class="btn btn-block btn-brand-accent waves-attach waves-light">获取验证码</button>
													{/if}
												</div>
											</div>
										</div>
										
										{if $enable_email_verify == 'true'}
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="email_code">验证码（必填）</label>
													<input class="form-control" id="email_code" type="text">
												</div>
											</div>
										</div>
										{/if}
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="passwd">密码（必填）</label>
													<input class="form-control" id="passwd" type="password">
												</div>
											</div>
										</div>
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="repasswd">重复密码（必填）</label>
													<input class="form-control" id="repasswd" type="password">
												</div>

											</div>
										</div>
										
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="imtype">选择您的联络方式</label>
													<select class="form-control" id="imtype">
														<option value="1">微信</option>
														<option value="2">QQ</option>
														<option value="3">Google+</option>
														<option value="4" selected="selected">Telegram</option>
													</select>
												</div>
											</div>
										</div>
										
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<label class="floating-label" for="wechat">在这输入联络方式账号（必填）</label>
													<input class="form-control" id="wechat" type="text">
												</div>
											</div>
										</div>
										
										
										
										{if $enable_invite_code == 'true'}
											<div class="form-group form-group-label">
												<div class="row">
													<div class="col-md-10 col-md-push-1">
														<label class="floating-label" for="code">邀请码（选填）</label>
														<input class="form-control" id="code" type="text" value="{$code}">
													</div>
												</div>
											</div>
										{/if}
										
										<div class="form-group form-group-label">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<div class="checkbox switch">
														<label for="surge_user">
															<input class="access-hide" id="surge_user" name="surge_user" type="checkbox"><span class="switch-toggle"></span>Surge / Surfboard 用户（SS 模式）
														</label>
													</div>
												</div>
											</div>
										</div>
										
										{if $geetest_html != null}
											<div class="form-group form-group-label">
												<div class="row">
													<div class="col-md-10 col-md-push-1">
														<div id="embed-captcha"></div>
													</div>
												</div>
											</div>
										{/if}
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<button id="tos" type="submit" class="btn btn-block btn-brand waves-attach waves-light">注册</button>
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<p>注册即代表同意<a href="/tos.html">服务条款</a>，以及保证所录入信息的真实性，如有不实信息会导致账号被删除。</p>
												</div>
											</div>
										</div>
										{else}
										<div class="form-group">
											<div class="row">
												<div class="col-md-10 col-md-push-1">
													<p>{$config["appName"]} 已停止新用户注册，请联系网站管理员</p>
												</div>
											</div>
										</div>
									{/if}
								</div>
							</div>
						</div>
						<div class="clearfix">
							<p class="margin-no-top pull-left"><a class="btn btn-flat btn-brand waves-attach" href="/auth/login">已注册？请登录</a></p>
						</div>
						
						
						
								
						{include file='dialog.tpl'}
						
						
						<div aria-hidden="true" class="modal modal-va-middle fade" id="tos_modal" role="dialog" tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-heading">
										<h2 class="modal-title">注册 TOS</h2>
									</div>
									<div class="modal-inner">
										{include file='reg_tos.tpl'}
									</div>
									<div class="modal-footer">
										<p class="text-right"><button class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" type="button" id="cancel">不同意</button><button class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" id="reg" type="button">同意</button></p>
										
									</div>
								</div>
							</div>
						</div>
						
					</section>
				</div>
			</div>
		</div>
	</main>
	
{include file='footer.tpl'}


{if $config['enable_register']!='false'}
<script>
    $(document).ready(function(){
         var affid = {$aff};

          function register(){
            
          if(!(typeof affid === 'number' && affid%1 === 0)) {
              $("#result").modal();
              $("#msg").html("aff不合法");

            return false;
          }

		 document.getElementById("tos").disabled = true; 
		 
		 	if(document.getElementById('surge_user').checked)
			{
				var surge_user=1;
			}
			else
			{
				var surge_user=0;
			}
			
            $.ajax({
                type:"POST",
                url:"/auth/register",
                dataType:"json",
                data:{
                    aff: affid,
                    email: $("#email").val(),
                    name: $("#name").val(),
                    passwd: $("#passwd").val(),
                    repasswd: $("#repasswd").val(),
					wechat: $("#wechat").val(),
					surge_user: surge_user,
					imtype: $("#imtype").val(){if $enable_invite_code == 'true'},
					code: $("#code").val(){/if}{if $enable_email_verify == 'true'},
					emailcode: $("#email_code").val(){/if}{if $geetest_html != null},
					geetest_challenge: validate.geetest_challenge,
                    geetest_validate: validate.geetest_validate,
                    geetest_seccode: validate.geetest_seccode
					{/if}
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href='/auth/login'", {$config['jump_delay']});
                    }else{
                        $("#result").modal();
                        $("#msg").html(data.msg);
			document.getElementById("tos").disabled = false; 

			{if $geetest_html != null}
			captcha.refresh();
			{/if}
                    }
                },
                error:function(jqXHR){
			$("#msg-error").hide(10);
			$("#msg-error").show(100);
			$("#msg-error-p").html("发生错误："+jqXHR.status);
			document.getElementById("tos").disabled = false; 
			{if $geetest_html != null}
			captcha.refresh();
			{/if}
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                $("#tos_modal").modal();
            }
        });
		
		{if $geetest_html != null}
		$('div.modal').on('shown.bs.modal', function() {
			$("div.gt_slider_knob").hide();
		});
		
		
		$('div.modal').on('hidden.bs.modal', function() {
			$("div.gt_slider_knob").show();
		});
		
        
		{/if}
		
		$("#reg").click(function(){
            register();
        });
		
		$("#tos").click(function(){
			{if $geetest_html != null}
			if(typeof validate == 'undefined')
			{
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
            $("#tos_modal").modal();
        });
    })
</script>
{/if}

{if $enable_email_verify == 'true'}
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
                url: "send",
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