


{include file='user/header_info.tpl'}


{$ssr_prefer = URL::SSRCanConnect($user, $mu)}
	
              <div class="nav-wrapper">
                <ul class="nav nav-pills nav-fill  flex-md-row" id="tabs-text" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0 active" id="qr_card-tab" data-toggle="tab" href="#qr_card" role="tab" aria-controls="qr_card" aria-selected="true">二维码扫描</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0" id="detail_card-tab" data-toggle="tab" href="#detail_card" role="tab" aria-controls="detail_card" aria-selected="false">手动配置</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0" id="json_card-tab" data-toggle="tab" href="#json_card" role="tab" aria-controls="json_card" aria-selected="false">JSON文件</a>
                  </li>
                </ul>
              </div>
			  
              <div class="card shadow">
                <div class="card-body">
                  <div class="tab-content" id="myTabContent">
<div class="tab-pane fade show active" id="qr_card" role="tabpanel" aria-labelledby="qr_card-tab">
<div class="text-center">
{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
<p style="color:red">{$node->name} - {$ssr_item['port']} 端口</p>
<p id="ssrtitle">{if URL::SSRCanConnect($user, $mu)}SSR 二维码{else}SS 二维码{/if}</p>
{if URL::SSRCanConnect($user, $mu)}
	<div id="ssrdiv" class="text-center">
		<a href="{URL::getItemUrl($ssr_item, 0)}"><div id="ss-qr-n"></div></a>
	</div>
	{if URL::SSCanConnect($user, $mu)}
	<div id="ssdiv" style="display: none;" class="text-center">
		<a href="{URL::getItemUrl($ss_item, 1)}"><div id="ss-qr"></div></a>
	</div>	
<!--<label for="ssrswitch">
	<input class="access-hide" id="ssrswitch" type="checkbox" name="ssrswitch"><span class="switch-toggle"></span><label id="switch_title">切换到SS</label>
</label>-->
<div class="custom-control custom-checkbox mb-3">
  <input id="ssrswitch" type="checkbox" class="custom-control-input">
  <label for="ssrswitch" class="custom-control-label">
    切换到SS
  </label>
</div>
  
	{else}
	{/if}
{else}
	<div class="text-center">
		<a href="{URL::getItemUrl($ss_item, 1)}"><div id="ss-qr"></div></a>
	</div>	
{/if}
<p>手机点击二维码即可跳转APP导入</p>
</div>
</div>


                    <div class="tab-pane fade show " id="detail_card" role="tabpanel" aria-labelledby="detail_card-tab">
				<div class="text-center">
{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
<p style="color:red">{$node->name} - {$ssr_item['port']} 端口</p>
<p id="detailtitle">{if URL::SSRCanConnect($user, $mu)}SSR配置信息{else}SS配置信息{/if}</p>
	{if URL::SSRCanConnect($user, $mu)}
	<div id="detailssrdiv" class="text-center">
													{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
													<p>服务器地址：{$ssr_item['address']}<br>
													服务器端口：{$ssr_item['port']}<br>
													加密方式：{$ssr_item['method']}<br>
													密码：{$ssr_item['passwd']}<br>
													协议：{$ssr_item['protocol']}<br>
													协议参数：{$ssr_item['protocol_param']}<br>
													混淆：{$ssr_item['obfs']}<br>
													混淆参数：{$ssr_item['obfs_param']}<br></p>
													</div>
{if URL::SSCanConnect($user, $mu)}
<div id="detailssdiv" style="display: none;" class="text-center">
													{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
													<p>服务器地址：{$ss_item['address']}<br>
													服务器端口：{$ss_item['port']}<br>
													加密方式：{$ss_item['method']}<br>
													密码：{$ss_item['passwd']}<br>
													混淆：{$ss_item['obfs']}<br>
													混淆参数：wns.windows.com<br></p>
													</div>
													<!--<label for="detailssrswitch">
	<input class="access-hide" id="detailssrswitch" type="checkbox" name="detailssrswitch"><span class="switch-toggle"></span><label id="detailswitch_title">切换到SS</label>
</label>-->

<div class="custom-control custom-checkbox mb-3">
  <input id="detailssrswitch" type="checkbox" class="custom-control-input">
  <label for="detailssrswitch" class="custom-control-label">
    切换到SS
  </label>
</div>     
                  
	{else}
	{/if}
{else}
<div class="text-center">
													{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
													<p>服务器地址：{$ss_item['address']}<br>
													服务器端口：{$ss_item['port']}<br>
													加密方式：{$ss_item['method']}<br>
													密码：{$ss_item['passwd']}<br>
													混淆：{$ss_item['obfs']}<br>
													混淆参数：wns.windows.com<br></p>
													</div>
{/if}

</div>
                 </div>



                    <div class="tab-pane fade show" id="json_card" role="tabpanel" aria-labelledby="json_card-tab">
				<div class="text-center">
{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
<p style="color:red">{$node->name} - {$ssr_item['port']} 端口</p>
<p id="jsontitle">{if URL::SSRCanConnect($user, $mu)}SSR 配置信息{else}SS 配置信息{/if}</p>
	{if URL::SSRCanConnect($user, $mu)}
	<div id="jsonssrdiv" class="text-center">
{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
	<textarea class="form-control" rows="6" style="height:200px">
{
    "server": "{$ssr_item['address']}",
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "timeout": 300,
    "workers": 1,
    "server_port": {$ssr_item['port']},
    "password": "{$ssr_item['passwd']}",
    "method": "{$ssr_item['method']}",
    "obfs": "{$ssr_item['obfs']}",
    "obfs_param": "{$ssr_item['obfs_param']}",
    "protocol": "{$ssr_item['protocol']}",
    "protocol_param": "{$ssr_item['protocol_param']}"
}
</textarea>
	</div>
{if URL::SSCanConnect($user, $mu)}
<div id="jsonssdiv" style="display: none;" class="text-center">
	{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
	<textarea class="form-control" rows="6" style="height:200px">
{
	"server": "{$ss_item['address']}",
	"local_address": "127.0.0.1",
	"local_port": 1080,
	"timeout": 300,
	"workers": 1,
	"server_port": {$ss_item['port']},
	"password": "{$ss_item['passwd']}",
	"method": "{$ss_item['method']}",
	"plugin": "{URL::getJsonObfs($ss_item)}"
}
</textarea>
</div>
<!--<label for="jsonssrswitch">
	<input class="access-hide" id="jsonssrswitch" type="checkbox" name="jsonssrswitch"><span class="switch-toggle"></span><label id="jsonswitch_title">切换到SS</label>
</label>-->

             <div class="custom-control custom-checkbox mb-3">
  <input id="jsonssrswitch" type="checkbox" class="custom-control-input">
  <label for="jsonssrswitch" class="custom-control-label">
    切换到SS
  </label>
</div>            
                  
	{else}
	{/if}
{else}
<div class="text-center">
	{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
	<textarea class="form-control" rows="6" style="height:200px">
{
	"server": "{$ss_item['address']}",
	"local_address": "127.0.0.1",
	"local_port": 1080,
	"timeout": 300,
	"workers": 1,
	"server_port": {$ss_item['port']},
	"password": "{$ss_item['passwd']}",
	"method": "{$ss_item['method']}",
	"plugin": "{URL::getJsonObfs($ss_item)}"
}
</textarea>
</div>
{/if}

</div>
                 </div>
                 </div>
                 </div>
                 </div>

{include file='user/footer_info.tpl'}


<script src="https://dlercloud.com/newjs/jquery.qrcode.min.js"></script>
<script>
	{if URL::SSCanConnect($user, $mu)}
	var text_qrcode = '{URL::getItemUrl($ss_item, 1)}';
	jQuery('#ss-qr').qrcode({
      	correctLevel :0,
    	width: 200,
    	height: 200,
		text: text_qrcode
	});

	var text_qrcode_win = '{URL::getItemUrl($ss_item, 2)}';
	jQuery('#ss-qr-win').qrcode({
      	correctLevel :0,
    	width: 200,
    	height: 200,
		text: text_qrcode_win
	});
	{/if}

	{if URL::SSRCanConnect($user, $mu)}
	var text_qrcode2 = '{URL::getItemUrl($ssr_item, 0)}';
	jQuery('#ss-qr-n').qrcode({
      	correctLevel :0,
    	width: 200,
    	height: 200,
		text: text_qrcode2
	});
	{/if}


</script>
<script src="https://cdn.godann.com/kitui/js/switch.js"></script>
