





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
			
			<!--<div class="col-lg">
								<p>添加中转规则</p>
            </div>-->
			

            <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
													<div class="form-group form-group-label">
										<label class="floating-label" for="source_node">起源节点</label>
										<select id="source_node" class="form-control" name="source_node">
											<option value="0">请选择起源节点</option>
											{foreach $source_nodes as $source_node}
												<option value="{$source_node->id}">{$source_node->name}</option>
											{/foreach}
										</select>
									</div>


									<div class="form-group form-group-label">
										<label class="floating-label" for="dist_node">目标节点</label>
										<select id="dist_node" class="form-control" name="dist_node">
											<option value="-1">不进行中转</option>
											{foreach $dist_nodes as $dist_node}
												<option value="{$dist_node->id}">{$dist_node->name}</option>
											{/foreach}
										</select>
									</div>

									<div class="form-group form-group-label">
										<label class="floating-label" for="port">端口</label>
										<select id="port" class="form-control" name="port">
											<option value="0">所有端口</option>
											{foreach $ports as $port}
												<option value="{$port}">{$port}</option>
											{/foreach}
										</select>
									</div>



									<div class="form-group form-group-label">
										<label class="floating-label" for="priority">优先级</label>
										<input class="form-control" id="priority" name="priority" type="text" value="0">
									</div>

                </div>
              </div>
            </div>
			
			  <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
					<button id="submit" type="submit" class="btn btn-primary mt-4">添加</button>
                </div>
              </div>
            </div>
			
			
			
			
          </div>
        </div>
      </div>
      
    </section>
    

	

{include file='user/newui_footer.tpl'}
{include file='newui_dialog.tpl'}

{literal}
<script>

	$('#main_form').validate({
		rules: {
		  priority: {required: true}
		},


		submitHandler: function() {



		$.ajax({

				type: "POST",
				url: "/user/relay",
				dataType: "json",
				{/literal}
				data: {
						source_node: $("#source_node").val(),
						dist_node: $("#dist_node").val(),
						port: $("#port").val(),
						priority: $("#priority").val()
				{literal}
					},
					success: function (data) {
						if (data.ret) {
						$("#result").modal();
						$("#msg").html(data.msg);
									{/literal}
						window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
									{literal}
						} else {
						$("#result").modal();
						$("#msg").html(data.msg);
						}
					},
					error: function (jqXHR) {
						$("#result").modal();
						$("#msg").html(data.msg+"  发生错误了。");
					}
					});
				}
		});

</script>

{/literal}
