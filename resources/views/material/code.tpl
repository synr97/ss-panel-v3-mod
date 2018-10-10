<div class="card-table">
									<div class="table-responsive">
										<table class="table">
											<thead>
											<tr>
												<th>邀请码 (点击自动填写)</th>
											</tr>
											</thead>
											<tbody>
											{foreach $codes as $code}
											<tr>
												<td><a class="copy-text" data-clipboard-text="{$code->code}">{$code->code}</a></td>
											</tr>
                                              <hr>
											{/foreach}
											</tbody>
										</table>										
									</div>
</div>
<script>
$(".copy-text").click(function () {
$("#code_label").text("");
$("#code").val($(this).parent().parent().find("td:eq(0)").text());
$("#reg_code").modal('hide')
});
</script>
