





{include file='user/newui_header.tpl'}

	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/mdui/0.4.1/css/mdui.min.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/mdui/0.4.1/js/mdui.min.js"></script>

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
                  <a href="/user/code" class="btn btn-sm btn-default">在线充值</a>
                  <a href="/user/shop" class="btn btn-sm btn-default float-right">购买套餐</a>
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
			<div class="col-lg">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
								<div class="form-group form-group-label">
									<label class="floating-label" for="content">内容</label>
									<link rel="stylesheet" href="/theme/material/editor/css/editormd.min.css" />
									<div id="editormd">
										<textarea style="display:none;" id="content"></textarea>
									</div>
								</div>
                  </div>
                </div>
            </div>				
            </div>	
			
			<div class="mdui-typo">
						<h3 style="color: #3f51b5">操作</h3>
					</div>
					
					<div class="mdui-card">
						<div class="mdui-card-actions">
							<div class="mdui-row-xs-2">
								<div class="mdui-col">
									<button id="submit" type="submit" class="mdui-btn mdui-btn-block mdui-color-pink-a200 mdui-ripple mdui-btn-raised">提交</button>
								</div>
								<div class="mdui-col">
									<button id="close" type="submit" class="mdui-btn mdui-btn-block mdui-color-indigo mdui-ripple mdui-btn-raised">提交并关闭</button>
								</div>
							</div>
						</div>
					</div>
								<div class="mdui-typo">
						<h3 style="color: #3f51b5">内容</h3>
					</div>
					
					{$ticketset->render()}
					{foreach $ticketset as $ticket}
					<div class="mdui-chip">
					{if $ticket->User()->isAdmin()}
						<!-- <img class="mdui-chip-icon" src="https://i.loli.net/2018/06/17/5b2633c2d45da.png"/> -->
						<span class="mdui-chip-icon mdui-color-red"><i class="mdui-icon material-icons">person</i></span>
						<span class="mdui-chip-title">管理员</span>
					{else}
						<!-- <img class="mdui-chip-icon" src="https://i.loli.net/2018/06/04/5b150945bc54d.png"/> -->
						<span class="mdui-chip-icon mdui-color-green"><i class="mdui-icon material-icons">person</i></span>
						<span class="mdui-chip-title">{$ticket->User()->user_name}</span>
					{/if}
					</div>
					<div class="mdui-chip">
						<span class="mdui-chip-icon mdui-color-blue"><i class="mdui-icon material-icons">access_time</i></span>
						<span class="mdui-chip-title">{$ticket->datetime()}</span>
					</div>
					</br></br>
					<div class="mdui-card">
						<div class="mdui-card-content">
							{$ticket->content}
						</div>
					</div></br>
					{/foreach}
					{$ticketset->render()}
					{include file='dialog.tpl'}
			
        </div>
          </div>
        </div>
      </div>
      
    </section>
    

	
{include file='newui_dialog.tpl'}


{include file='user/newui_footer.tpl'}

<script src="/theme/material/editor/editormd.min.js"></script>
<script>
    $(document).ready(function () {
        function submit() {
			$("#result").modal();
            $("#msg").html("正在提交...");
            $.ajax({
                type: "PUT",
                url: "/user/ticket/{$id}",
                dataType: "json",
                data: {
                    content: editor.getHTML(),
					title: $("#title").val(),
					status:status
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href='/user/ticket'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误：" + jqXHR.status);
                }
            });
        }
		
        $("#submit").click(function () {
			status=1;
            submit();
        });
		
		$("#close").click(function () {
			status=0;
            submit();
        });
    });
	
    $(function() {
        editor = editormd("editormd", {
            path : "/theme/material/editor/lib/", // Autoload modules mode, codemirror, marked... dependents libs path
			height: 450,
			saveHTMLToTextarea : true
        });

        /*
        // or
        var editor = editormd({
            id   : "editormd",
            path : "../lib/"
        });
        */
    });
</script>