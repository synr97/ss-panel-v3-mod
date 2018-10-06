


{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">账户信息</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">账户信息</p>
										<dl class="dl-horizontal">
											<dt>邮箱</dt>
											<dd>{$user->email}</dd>
										</dl>
									</div>
									<div class="card-action">
										<div class="card-action-btn pull-left">
											<a class="btn btn-flat waves-attach" href="kill"><span class="icon">check</span>&nbsp;删除我的账户</a>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="card">
							<div class="card-main">
								<div class="card-inner margin-bottom-no">
									<p class="card-heading">最近在线 IP</p>
									<p>如有异常请及时修改连接密码</p>
									<div class="card-table">
										<div class="table-responsive">
											<table class="table">
												<tr>

													<th>IP</th>
													<th>归属地</th>
												</tr>
												{foreach $userip as $single=>$location}
													<tr>

														<td>{$single}</td>
														<td>{$location}</td>
													</tr>
												{/foreach}
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>


						<div class="card">
							<div class="card-main">
								<div class="card-inner margin-bottom-no">
									<p class="card-heading">最近登录 IP</p>
									<p>如有异常请及时修改登录密码</p>
									<div class="card-table">
										<div class="table-responsive">
											<table class="table">
												<tr>

													<th>IP</th>
													<th>归属地</th>
												</tr>
												{foreach $userloginip as $single=>$location}
													<tr>

														<td>{$single}</td>
														<td>{$location}</td>
													</tr>
												{/foreach}
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>



						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
										<p class="card-heading">返利列表</p>
										<div class="card-table">
											<div class="table-responsive">
											{$paybacks->render()}
												<table class="table">
													<thead>
													<tr>
														<th>###</th>
														<th>邀请用户</th>
														<th>返利金额</th>
													</tr>
													</thead>
													<tbody>
													{foreach $paybacks as $payback}
														<tr>
															<td><b>{$payback->id}</b></td>
															{if $payback->user()!=null}
																<td>{$payback->user()->user_name}
																</td>
																{else}
																<td>已注销
																</td>
															{/if}
															</td>
															<td><span class="payback-num">{$payback->ref_get}</span> <span>元</span></td>
														</tr>
													{/foreach}
													</tbody>
												</table>
											{$paybacks->render()}
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>

				</div>
			</section>
		</div>
	</main>



	<script>
	function countPayBack() {
    	var b = 0;
    	for (var i=0;i<document.getElementsByClassName('payback-num').length;i+=1){
        	var a = parseFloat(document.getElementsByClassName('payback-num')[i].innerHTML);
        	if (a > 0) {
            	var b = a + b;
        	} else {
            	var b = b;
        	}
    	}
    	document.getElementById('payback-num-all').innerHTML = b.toFixed(2);
	}
	window.onload = function() {
    	countPayBack();
	};
	</script>




{include file='user/footer.tpl'}
