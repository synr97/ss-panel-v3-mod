





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
			
<div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
															<div class="table-responsive">
												<table class="table">
													<tr>
														<th>节点</th>
														<th>电信延迟</th>
														<th>电信下载速度</th>
														<th>电信上传速度</th>
														<th>联通延迟</th>
														<th>联通下载速度</th>
														<th>联通上传速度</th>
														<th>移动延迟</th>
														<th>移动下载速度</th>
														<th>移动上传速度</th>
													</tr>
													{foreach $speedtest as $single}
														<tr>
															<td>{$single->node()->name}</td>
															<td>{$single->telecomping}</td>
															<td>{$single->telecomeupload}</td>
															<td>{$single->telecomedownload}</td>
															<td>{$single->unicomping}</td>
															<td>{$single->unicomupload}</td>
															<td>{$single->unicomdownload}</td>
															<td>{$single->cmccping}</td>
															<td>{$single->cmccupload}</td>
															<td>{$single->cmccdownload}</td>
														</tr>
													{/foreach}
												</table>
											</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
    </section>
    

	


{include file='user/newui_footer.tpl'}
