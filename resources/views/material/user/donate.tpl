





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
        <div class="row row-grid justify-content-between align-items-center mt-lg">					
			<div class="col-lg-6">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
						<h6 class="category">支出统计</h6>
						<h6 class="category"></h6>
						<p class="card-title">您可以在<a href="/user/code">充值界面</a>进行充值，这样就等同于捐赠了。</p>									
								<div class="form-group form-group-label">
						<p>总收入：{$total_in} 元</p>
						<p>总支出：{$total_out} 元</p>
										</div>
                  </div>
                </div>
            </div>	
			<div class="col-lg-6">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
						<h6 class="category">匿名捐赠</h6>
						<p class="card-title">当前设置：{if $user->is_hide==1} 匿名 {else} 不匿名 {/if}</p>
									<div class="form-group form-group-label">
											<label class="floating-label" for="hide">匿名设置</label>
											<select id="hide" class="form-control">
												<option value="1">匿名</option>
												<option value="0">不匿名</option>
											</select>
										</div>
											<button class="btn btn-primary mt-4" id="hide-update" >&nbsp;提交</button>
                  </div>
                </div>
            </div>
        </div>
			
			<div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
											<div class="table-responsive">
												{$codes->render()}
												<table class="table table-hover">
													<tr>
														<th>ID</th>
														<th>用户名</th>
														<th>类型</th>
														<th>操作</th>
														<th>备注</th>
														<th>时间</th>
														
													</tr>
													{foreach $codes as $code}
														<tr>
															<td>#{$code->id}</td>
															{if $code->user() != null && $code->user()->is_hide == 0}
															<td>{$code->user()->user_name}</td>
															{else}
															<td>已注销或用户要求匿名</td>
															{/if}
															{if $code->type == -1}
															<td>充值捐赠</td>
															{/if}
															{if $code->type == -2}
															<td>财务支出</td>
															{/if}
															{if $code->type == -1}
															<td>捐赠 {$code->number} 元</td>
															{/if}
															{if $code->type == -2}
															<td>支出 {$code->number} 元</td>
															{/if}
															<td>{$code->code}</td>
															<td>{$code->usedatetime}</td>
														</tr>
													{/foreach}
												</table>
												{$codes->render()}
											</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
    </section>
    

	


{include file='user/newui_footer.tpl'}


<script>
    $(document).ready(function () {
        $("#hide-update").click(function () {
            $.ajax({
                type: "POST",
                url: "hide",
                dataType: "json",
                data: {
                    hide: $("#hide").val()
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
