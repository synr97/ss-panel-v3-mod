
{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">编辑商品</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-sm-12">
				<section class="content-inner margin-top-no">

					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>可填单个或者多个参数，多个参数时会自动组合成套餐</p>
								<div class="form-group form-group-label">
									<label class="floating-label" for="name">名称</label>
									<input class="form-control" id="name" type="text" value="{$shop->name}">
								</div>


								<div class="form-group form-group-label">
									<label class="floating-label" for="price">价格</label>
									<input class="form-control" id="price" type="number" value="{$shop->price}">
								</div>

								<div class="form-group form-group-label">
									<label class="floating-label" for="auto_renew">自动续订天数（0为不允许自动续订，其他为到了那么多天之后就会自动从用户的账户上划钱抵扣）</label>
									<input class="form-control" id="auto_renew" type="number" value="{$shop->auto_renew}">
								</div>



							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<div class="form-group form-group-label">
									<label class="floating-label" for="group_limit">群组限制（不填即为所有群组可用，多个的话用英文半角逗号分割）</label>
									<input class="form-control" id="group_limit" type="number" value="{$shop->group_limit()}">
								</div>

								<div class="form-group form-group-label">
									<label class="floating-label" for="class_limit_operator">等级限制运算符</label>
									<select id="class_limit_operator" class="form-control" name="class_limit_operator">
										<option value="none" {if $shop->class_limit_operator()=='none'}selected{/if}>无</option>
										<option value="equal" {if $shop->class_limit_operator()=='equal'}selected{/if}>等于</option>
										<option value="greater" {if $shop->class_limit_operator()=='greater'}selected{/if}>大于</option>
										<option value="greater_equal" {if $shop->class_limit_operator()=='greater_equal'}selected{/if}>大于等于</option>
										<option value="less" {if $shop->class_limit_operator()=='less'}selected{/if}>小于</option>
										<option value="less_equal" {if $shop->class_limit_operator()=='less_equal'}selected{/if}>小于等于</option>
										<option value="not" {if $shop->class_limit_operator()=='not'}selected{/if}>非</option>
									</select>
								</div>

								<div class="form-group form-group-label">
									<label class="floating-label" for="class_limit_content">等级限制内容（不填即为所有等级可用，多个的话用英文半角逗号分割）</label>
									<input class="form-control" id="class_limit_content" type="number" value="{$shop->class_limit_content()}">
								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-main">
							<div class="card-inner">

								<div class="form-group form-group-label">
									<label class="floating-label" for="bandwidth">流量（GB）</label>
									<input class="form-control" id="bandwidth" type="number" value="{$shop->bandwidth()}">
								</div>


								<div class="form-group form-group-label">
									<div class="checkbox switch">
										<label for="auto_reset_bandwidth">
											<input {if $shop->auto_reset_bandwidth==1}checked{/if} class="access-hide" id="auto_reset_bandwidth" type="checkbox"><span class="switch-toggle"></span>续费时自动重置用户流量为上面这个流量值
										</label>
									</div>
								</div>

								<div class="form-group form-group-label">
									<div class="checkbox switch">
										<label for="traffic_package">
											<input {if $shop->traffic_package()==1}checked{/if} class="access-hide" id="traffic_package" type="checkbox"><span class="switch-toggle"></span>流量包（购买时不重置流量，仅限购买过商品且未过期的账户购买）
										</label>
									</div>
								</div>

							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<div class="form-group form-group-label">
									<label class="floating-label" for="node_speedlimit">速度限制（0为不限制）</label>
									<input class="form-control" id="node_speedlimit" type="number" value="{$shop->node_speedlimit()}">
								</div>

								<div class="form-group form-group-label">
									<label class="floating-label" for="node_connector">同时连接 IP 数（0为不限制）</label>
									<input class="form-control" id="node_connector" type="number" value="{$shop->node_connector()}">
								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-main">
							<div class="card-inner">

								<div class="form-group form-group-label">
									<label class="floating-label" for="expire">账户有效期天数</label>
									<input class="form-control" id="expire" type="number" value="{$shop->expire()}">
								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-main">
							<div class="card-inner">

								<div class="form-group form-group-label">
									<label class="floating-label" for="class">等级</label>
									<input class="form-control" id="class" type="number" value="{$shop->user_class()}">
								</div>

								<div class="form-group form-group-label">
									<label class="floating-label" for="class_expire">等级有效期天数</label>
									<input class="form-control" id="class_expire" type="number" value="{$shop->class_expire()}">
								</div>

								<div class="form-group form-group-label">
									<label class="floating-label" for="node_group">群组</label>
									<input class="form-control" id="node_group" type="number" value="{$shop->node_group()}">
								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-main">
							<div class="card-inner">

								<div class="form-group">
									<div class="row">
										<div class="col-md-10 col-md-push-1">
											<button id="submit" type="submit" class="btn btn-block btn-brand waves-attach waves-light">保存</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					{include file='dialog.tpl'}




			</div>



		</div>
	</main>











{include file='admin/footer.tpl'}



<script>
    $(document).ready(function () {
        function submit() {
			if(document.getElementById('auto_reset_bandwidth').checked)
			{
				var auto_reset_bandwidth=1;
			}
			else
			{
				var auto_reset_bandwidth=0;
			}
			if(document.getElementById('traffic_package').checked)
			{
				var traffic_package=1;
			}
			else
			{
				var traffic_package=0;
			}

            $.ajax({
                type: "PUT",
                url: "/admin/shop/{$shop->id}",
                dataType: "json",
                data: {
                    name: $("#name").val(),
                    auto_reset_bandwidth: auto_reset_bandwidth,
                    price: $("#price").val(),
					node_group: $("#node_group").val(),
                    auto_renew: $("#auto_renew").val(),
                    group_limit: $("#group_limit").val(),
                    class_limit_operator: $("#class_limit_operator").val(),
                    class_limit_content: $("#class_limit_content").val(),
                    bandwidth: $("#bandwidth").val(),
					traffic_package: traffic_package,
                    node_speedlimit: $("#node_speedlimit").val(),
                    node_connector: $("#node_connector").val(),
                    expire: $("#expire").val(),
                    class: $("#class").val(),
					class_expire: $("#class_expire").val(),
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href='/admin/shop'", {$config['jump_delay']});
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

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                login();
            }
        });
        $("#submit").click(function () {
            submit();
        });
    })
</script>
