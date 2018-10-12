





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
						<div class="col-lg-12">
							<div class="card card-lift shadow border-0">
								<div class="card-body">
								<p>系统中您所有的中转规则。</p>
								<p>在这里，您可以设置您的中转规则，从而将数据从一个服务器重定向到另外一个服务器。</p>
								<p>优先级越大，代表其在多个符合条件的规则并存时会被优先采用，当优先级一致时，先添加的规则会被采用。</p>
								<p>对某个节点不设置中转时，这个节点就可以当作一个普通的节点来做代理使用。</p>
								</div>
							</div>
						</div>		
					</div>

			  <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-9">
                    <a  class="btn btn-primary mt-4"  href="/user/relay/create">添加中转规则</a>
                </div>
              </div>
            </div>
            <div class="mt-5 py-5 text-center">
              <div class="row justify-content-center">
                <div class="col-lg-12">
              <div class="mb-3">
                <small class="text-uppercase font-weight-bold">配置中心</small>
              </div>
					{if $is_relay_able}
              <div class="nav-wrapper">
                <ul class="nav nav-pills nav-fill flex-column flex-md-row" id="tabs-text" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0 active" id="rule_table-tab" data-toggle="tab" href="#rule_table" role="tab" aria-controls="rule_table" aria-selected="true">规则列表</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0" id="link_table-tab" data-toggle="tab" href="#link_table" role="tab" aria-controls="link_table" aria-selected="false">线路列表</a>
                  </li>
                </ul>
              </div>
              <div class="card shadow">
                <div class="card-body">
                  <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="rule_table" role="tabpanel" aria-labelledby="rule_table-tab">
											<div class="table-responsive">
												{$rules->render()}
												<table class="table">
											    <tr>
													<th>操作</th>
													<th>ID</th>
													<th>起源节点</th>
													<th>目标节点</th>
													<th>端口</th>
													<th>优先级</th>

													</tr>
													{foreach $rules as $rule}
														<tr>
														<td>
															<button class="btn btn-primary" {if $rule->user_id == 0}disabled{else}href="/{$rule->id}/edit"{/if}>编辑</button>
															<button class="btn btn-primary" id="delete" value="{$rule->id}" {if $rule->user_id == 0}disabled="disabled"{else}href="javascript:void(0);" onClick="delete_modal_show('{$rule->id}')"{/if}>删除</button>
														</td>
														<td>#{$rule->id}</td>
														{if $rule->source_node_id == 0}
															<td>所有节点</td>
														{else}
															<td>{$rule->Source_Node()->name}</td>
														{/if}
														{if $rule->Dist_Node() == null}
															<td>不进行中转</td>
														{else}
															<td>{$rule->Dist_Node()->name}</td>
														{/if}
														<td>{if $rule->port == 0}所有端口{else}{$rule->port}{/if}</td>
														<td>{$rule->priority}</td>
												        </tr>
												    {/foreach}
												</table>
												{$rules->render()}
											</div>
                 </div>
                    <div class="tab-pane fade" id="link_table" role="tabpanel" aria-labelledby="link_table-tab">
											<div class="table-responsive">
												<table class="table">
											    <tr>
													<th>端口</th>
													<th>始发节点</th>
													<th>终点节点</th>
													<th>途径节点</th>
													<th>状态</th>
													</tr>

													{foreach $pathset as $path}
													<tr>
													<td>{$path->port}</td>
													<td>{$path->begin_node->name}</td>
													<td>{$path->end_node->name}</td>
													<td>{$path->path}</td>
													<td>{$path->status}</td>
									        </tr>
											    {/foreach}
												</table>
											</div>
                      </div>
                  </div>
                </div>
              </div>
			  {/if}
                </div>
              </div>
            </div>
			
			
			
			
			
          </div>
        </div>
      </div>
      
    </section>
    

	
	<div class="modal fade" id="delete_modal" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
    <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="modal-title-default">确认要删除？</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <p>请您确认。</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="delete_input" >确定</button>
            </div>
        </div>
    </div>
    </div>

{include file='user/newui_footer.tpl'}
{include file='newui_dialog.tpl'}

<script>
function delete_modal_show(id) {
	deleteid=id;
	$("#delete_modal").modal();
}


$(document).ready(function(){

	{if !$is_relay_able}
	$("#result").modal();
	$("#msg").html("为了中转的稳定，您需要在<a href='/user/edit'>资料编辑</a>处设置协议为以下协议之一： <br>{foreach $relay_able_protocol_list as $single_text}{$single_text}<br>{/foreach}后方可设置中转规则！");
	{/if}

	function delete_id(){
		$.ajax({
			type:"DELETE",
			url:"/user/relay",
			dataType:"json",
			data:{
				id: deleteid
			},
			success:function(data){
				if(data.ret){
					$("#result").modal();
					$("#msg").html(data.msg);
					window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
				}else{
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error:function(jqXHR){
				$("#result").modal();
				$("#msg").html(data.msg+"  发生错误了。");
			}
		});
	}
	$("#delete_input").click(function(){
		delete_id();
	});
})

</script>
