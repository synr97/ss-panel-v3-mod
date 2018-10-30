





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
			<div class="col-lg">
                <div class="card card-lift shadow border-0">
                  <div class="card-body">
					<p class="card-heading">我的帐号</p>
						<dl class="dl-horizontal">
							<dt>用户名</dt>
							<dd>{$user->user_name}</dd>
							<dt>邮箱</dt>
							<dd>{$user->email}</dd>
						</dl>
                    <a class="btn btn-primary mt-4" href="kill">&nbsp;删除我的账户</a>
                  </div>
                </div>
            </div>
        </div>
            <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-12">
              <div class="mb-3">
                <small class="text-uppercase font-weight-bold">最近五分钟使用IP</small>
              </div>
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
			       <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-12">
              <div class="mb-3">
                <small class="text-uppercase font-weight-bold">最近十次登录IP</small>
              </div>
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
			
            <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-12">
						{$paybacks->render()}
						<table class="table ">
							<tr>

                             <!--   <th>ID</th> -->
								<th>邀请用户ID</th>
								<th>获得返利</th>
                            </tr>
                            {foreach $paybacks as $payback}
                            <tr>

                          <!--       <td>#{$payback->id}</td> -->
								<td>{$payback->userid}</td>
								<td>{$payback->ref_get} 元</td>

                            </tr>
                            {/foreach}
                        </table>
						{$paybacks->render()}
                </div>
              </div>
            </div>
			
          </div>
        </div>
      </div>
      
    </section>
    

	
	
{include file='newui_dialog.tpl'}


{include file='user/newui_footer.tpl'}

