





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
			<div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
								<p>仅处理账户问题</p>
								<p>不提供任何技术帮助与指导，请自行观看使用 <a href="https://docs.lhie1.com/black-hole" target="_blank">使用教程</a>（<a href="https://github.com/lhie1/Document/blob/master/SUMMARY.md" target="_blank">备用</a>） </p>
								<p>工作日通常 6 小时内回复或处理</p>
								<p>休息日通常 48 小时内回复或处理</p>
                    <a  class="btn btn-primary mt-4"  href="/user/ticket/create">创建新工单</a>
                </div>
              </div>
            </div>
						
            <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
              <div class="mb-3">
                <small class="text-uppercase font-weight-bold">您创建的工单</small>
              </div>
					<div class="table-responsive">
						{$tickets->render()}
                        <table class="table">
                            <tr>
								<th>操作</th>
                                <th>ID</th>
                                <th>日期</th>
                                <th>标题</th>
								<th>状态</th>
                            </tr>
                            {foreach $tickets as $ticket}
                                <tr>
									<td>
										<a class="btn btn-primary mt-4" href="/user/ticket/{$ticket->id}/view">查看</a>
									</td>
                                    <td>#{$ticket->id}</td>
                                    <td>{$ticket->datetime()}</td>
                                    <td>{$ticket->title}</td>
									{if $ticket->status==1}
									<td>开启</td>
									{else}
									<td>关闭</td>
									{/if}
                                </tr>
                            {/foreach}
                        </table>
                        {$tickets->render()}
					</div>
                </div>
              </div>
            </div>

			
          </div>
        </div>
      </div>
      
    </section>
    

	


{include file='user/newui_footer.tpl'}

