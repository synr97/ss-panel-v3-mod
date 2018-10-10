





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
                  <a href="/user" class="btn btn-sm btn-primary">用户中心</a>
                  <a href="/user/shop" class="btn btn-sm btn-default float-right">商店</a>
                </div>
              </div>
              <div class="col-lg-4 order-lg-1">
                <div class="card-profile-stats d-flex justify-content-center">
                  <div>
                    <span class="heading">{$user->money}</span>
                    <span class="description">剩余金币</span>
                  </div>
                  <div>
                    <span class="heading">L{$user->class}</span>
                    <span class="description">等级</span>
                  </div>
                  <div>
                    <span class="heading">{$user->online_ip_count()}</span>
                    <span class="description">在线设备数</span>
                  </div>
                </div>
              </div>
            </div>
			
						
						
	<div class="row row-grid justify-content-between align-items-center mt-lg">			
			<div class="col-lg">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">										
				  <p><font color="#FF0000" >帐号删除后，您的所有数据都会被<b>真实地</b>删除。</font></p>

										<p><font color="#FF0000" >如果想重新使用本网站提供的服务，您需要重新注册。</font></p>
										
										<p class="card-heading">输入当前密码以验证身份</p>
										<div class="form-group form-group-label">
											<label class="floating-label" for="passwd">当前密码（必填）</label>
											<input class="form-control" id="passwd" type="password">
										</div>
						<button class="btn btn-primary mt-4" id="kill" >&nbsp;删除我的帐号</button>
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
    $(document).ready(function () {
        $("#kill").click(function () {
            $.ajax({
                type: "POST",
                url: "kill",
                dataType: "json",
                data: {
                    passwd: $("#passwd").val(),
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
						$("#msg").html(data.msg);
                        window.setTimeout("location.href='/'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
						$("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
					$("#result").modal();
                    $("#msg").html("发生错误：" + jqXHR.status + data.msg);
                }
            })
        })
    })
</script>

