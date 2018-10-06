


{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading"> 工单</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-sm-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>仅处理账户问题</p>
								<p>不提供任何技术帮助与指导，请自行观看使用 <a href="https://docs.lhie1.com/black-hole" target="_blank">使用教程</a>（<a href="https://github.com/lhie1/Document/blob/master/SUMMARY.md" target="_blank">备用</a>） </p>
								<p>工作日通常 6 小时内回复或处理</p>
								<p>休息日通常 48 小时内回复或处理</p>
							</div>
						</div>
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
										<a class="btn btn-brand" href="/user/ticket/{$ticket->id}/view">查看</a>
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
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/user/ticket/create">+</a>
							
						</div>
					</div>

							
			</div>
			
			
			
		</div>
	</main>






{include file='user/footer.tpl'}










