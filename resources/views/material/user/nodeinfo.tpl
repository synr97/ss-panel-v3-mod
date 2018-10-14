


{include file='user/header_info.tpl'}


{$ssr_prefer = URL::SSRCanConnect($user, $mu)}
	
              <div class="nav-wrapper">
                <ul class="nav nav-pills nav-fill  flex-md-row" id="tabs-text" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0 active" id="ssr_card-tab" data-toggle="tab" href="#ssr_card" role="tab" aria-controls="ssr_card" aria-selected="true">SSR</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0" id="ss_card-tab" data-toggle="tab" href="#ss_card" role="tab" aria-controls="ss_card" aria-selected="false">SS</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0" id="v2ray_card-tab" data-toggle="tab" href="#v2ray_card" role="tab" aria-controls="v2ray_card" aria-selected="false">V2ray</a>
                  </li>
                </ul>
              </div>
			  
              <div class="card shadow">
                <div class="card-body">
                  <div class="tab-content" id="myTabContent">
				  
				  
					<div class="tab-pane fade show active" id="ssr_card" role="tabpanel" aria-labelledby="ssr_card-tab">
						<div class="text-center">
							{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
							<p style="color:red">{$node->name} - {$ssr_item['port']} 端口</p>
							<p id="ssrtitle">二维码</p>
							<div id="ssrdiv" class="text-center">
								<a href="{URL::getItemUrl($ssr_item, 0)}"><div id="ss-qr-n"></div></a>
							</div>
							<p>手机点击二维码即可跳转APP导入</p>
						</div>
					</div>


					<div class="tab-pane fade show " id="ss_card" role="tabpanel" aria-labelledby="ss_card-tab">
						<div class="text-center">
							{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
								<p style="color:red">{$node->name} - {$ssr_item['port']} 端口</p>
								<p id="ssrtitle">二维码</p>
							<div class="text-center">
								<a href="{URL::getItemUrl($ss_item, 1)}"><div id="ss-qr"></div></a>
							</div>	
								<p>手机点击二维码即可跳转APP导入</p>
						</div>
					</div>



					<div class="tab-pane fade show" id="v2ray_card" role="tabpanel" aria-labelledby="v2ray_card-tab">
						<div class="text-center">
						{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
						{$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
							<p style="color:red">{$node->name} - {$ssr_item['port']} 端口</p>
							<p id="ssrtitle">二维码</p>
						<div class="text-center">
							<a href="{URL::getItemUrl($ss_item, 1)}"><div id="ss-qr"></div></a>
						</div>	
							<p>手机点击二维码即可跳转APP导入</p>
						</div>
					</div>
					</div>
                 </div>








{include file='user/footer_info.tpl'}


<script src="/assets/public/js/jquery.qrcode.min.js"></script>
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
