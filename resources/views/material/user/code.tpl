





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
                  <a href="/user/node" class="btn btn-sm btn-primary">节点列表</a>
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
					{if $pmw!=''}
						<div class="col-lg-6">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
										{$pmw}
                  </div>
                </div>
            </div>			
					{/if}
			<div class="col-lg-6">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
						<h6 class="category">充值码充值</h6>
										<div class="form-group form-group-label">
											<label class="floating-label" for="code">充值码</label>
											<input class="form-control" id="code" type="text">
										</div>
											<button class="btn btn-primary mt-4" id="code-update" >&nbsp;充值</button>
                  </div>
                </div>
            </div>
        </div>
			
			
						
            <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
              <div class="mb-3">
                <small class="text-uppercase font-weight-bold">充值记录</small>
              </div>
									{$codes->render()}
												<table class="table table-hover">
													<tr>
														<th>ID</th>
														<th>代码</th>
														<th>类型</th>
														<th>金额</th>
														<th>充值时间</th>
														
													</tr>
													{foreach $codes as $code}
														{if $code->type!=-2}
															<tr>
																<td>#{$code->id}</td>
																<td>{$code->code}</td>
																{if $code->type==-1}
																<td>金额充值</td>
																{/if}
																{if $code->type==10001}
																<td>流量充值</td>
																{/if}
																{if $code->type==10002}
																<td>用户续期</td>
																{/if}
																{if $code->type>=1&&$code->type<=10000}
																<td>等级续期 - 等级{$code->type}</td>
																{/if}
																{if $code->type==-1}
																<td>充值 {$code->number} 元</td>
																{/if}
																{if $code->type==10001}
																<td>充值 {$code->number} GB 流量</td>
																{/if}
																{if $code->type==10002}
																<td>延长账户有效期 {$code->number} 天</td>
																{/if}
																{if $code->type>=1&&$code->type<=10000}
																<td>延长等级有效期 {$code->number} 天</td>
																{/if}
																<td>{$code->usedatetime}</td>
															</tr>
														{/if}
													{/foreach}
												</table>
												{$codes->render()}
			  
                </div>
              </div>
            </div>
			
          </div>
        </div>
      </div>
      
    </section>
    

					<div aria-hidden="true" class="modal modal-va-middle fade" id="readytopay" role="dialog" tabindex="-1">
						<div class="modal-dialog modal-xs">
							<div class="modal-content">
								<div class="modal-heading">
									<a class="modal-close" data-dismiss="modal">×</a>
									<h2 class="modal-title">正在连接支付宝</h2>
								</div>
								<div class="modal-inner">
									<p id="title">正在处理...</p>
								</div>
							</div>
						</div>
					</div>
					
					<div aria-hidden="true" class="modal modal-va-middle fade" id="alipay" role="dialog" tabindex="-1">
						<div class="modal-dialog modal-xs">
							<div class="modal-content">
							<div class="modal-heading">
									<a class="modal-close" data-dismiss="modal">×</a>
                              <h2 class="modal-title">请使用支付宝App扫码充值：</h2>
								</div>
								<div class="modal-inner">
                                   <div class="text-center">
                                    <p id="divide">-------------------------------------------------------------</p>
									<p id="title">手机端请点击二维码转跳app</p>
									<p id="divide">-------------------------------------------------------------</p>
									<p id="qrcode"></p>
									<p id="info"></p>
								</div>
                                  </div>

								<div class="modal-footer">
									<p class="text-right"><button class="btn btn-flat btn-brand waves-attach" data-dismiss="modal" id="alipay_cancel" type="button">取消</button></p>
								</div>
							</div>
						</div>
					</div>
	
	
	
{include file='newui_dialog.tpl'}


{include file='user/newui_footer.tpl'}

<script>

  $("#buy_code").click(function () {
	$("#result").modal();
	$("#msg").html("暂不开放充值码购买");
});
	$(document).ready(function () {
		$("#code-update").click(function () {
			$.ajax({
				type: "POST",
				url: "code",
				dataType: "json",
				data: {
					code: $("#code").val()
				},
				success: function (data) {
					if (data.ret) {
						$("#result").modal();
						$("#msg").html(data.msg);
						window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
					} else {
						$("#result").modal();
						$("#msg").html(data.msg);
						window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
					}
				},
				error: function (jqXHR) {
					$("#result").modal();
					$("#msg").html("发生错误：" + jqXHR.status);
				}
			})
		})
		
	$("#urlChange").click(function () {
			$.ajax({
				type: "GET",
				url: "code/f2fpay",
				dataType: "json",
				data: {
					time: timestamp
				},
				success: function (data) {
					if (data.ret) {
						$("#readytopay").modal();
					}
				}
				
			})
		});
		
		$("#readytopay").on('shown.bs.modal', function () {
			$.ajax({
				type: "POST",
				url: "code/f2fpay",
				dataType: "json",
				data: {
							amount: $("input:text").val()
					},
				success: function (data) {
					$("#readytopay").modal('hide');
					if (data.ret) {
						$("#qrcode").html(data.qrcode);
						$("#info").html("您的订单金额为："+data.amount+"元。");
						$("#alipay").modal();
					} else {
						$("#result").modal();
						$("#msg").html(data.msg);
					}
				},
				error: function (jqXHR) {
					$("#readytopay").modal('hide');
					$("#result").modal();
					$("#msg").html(data.msg+"  发生了错误。");
				}
			})
		});	
	timestamp = {time()}; 
		
		
	function f(){
		$.ajax({
			type: "GET",
			url: "code_check",
			dataType: "json",
			data: {
				time: timestamp
			},
			success: function (data) {
				if (data.ret) {
					clearTimeout(tid);
					$("#alipay").modal('hide');
					$("#result").modal();
					$("#msg").html("充值成功！");
					window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
				}
			}
		});
		tid = setTimeout(f, 1000); //循环调用触发setTimeout
	}
	setTimeout(f, 1000);
})
</script>

