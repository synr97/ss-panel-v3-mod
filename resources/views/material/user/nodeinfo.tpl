


{include file='user/header_info.tpl'}


{$ssr_prefer = URL::SSRCanConnect($user, $mu)}
  
          <div class="nav-wrapper">
        <ul class="nav nav-pills nav-fill  flex-md-row" id="tabs-text" role="tablist">
          <li class="nav-item">
            <a class="nav-link mb-sm-3 mb-md-0 active" id="1-tab" data-toggle="tab" href="#1" role="tab" aria-controls="3" aria-selected="true">个人端口</a>
          </li>
          <li class="nav-item">
            <a class="nav-link mb-sm-3 mb-md-0" id="2-tab" data-toggle="tab" href="#2" role="tab" aria-controls="2" aria-selected="false">公共端口 - SSR</a>
          </li>
          <li class="nav-item">
            <a class="nav-link mb-sm-3 mb-md-0" id="3-tab" data-toggle="tab" href="#3" role="tab" aria-controls="3" aria-selected="false">公共端口 - SS</a>
          </li>
        </ul>
          </div>
        
          <div class="card shadow">
        <div class="card-body">
          <div class="tab-content" id="myTabContent">
          
          
          <div class="tab-pane fade show active" id="1" role="tabpanel" aria-labelledby="1-tab">
            <div class="text-center">
          {$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
          {$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
              <p style="color:red">{$node->name}</p>
              <p id="ssrtitle">配置信息</p>
          {if URL::SSRCanConnect($user)}
	                        <p>地址：{$ssr_item['address']}<br>
	                          	端口：{$user->port}<br>
	                          	密码：{$ssr_item['passwd']}<br>
	                            加密方式：{$ssr_item['method']}<br>
	                            协议：{$ssr_item['protocol']}<br>
	                            混淆：{$ssr_item['obfs']}<br>
          {elseif URL::SSCanConnect($user)}
                            <p>地址：{$ss_item['address']}<br>
                          		端口：{$user->port}<br>
                          		密码：{$ss_item['passwd']}<br>
                            	加密方式：{$ss_item['method']}<br>
                            	协议：{$ss_item['protocol']}<br>
                            	混淆：{$ss_item['obfs']}<br>
          {/if}
            </div>
          </div>


          <div class="tab-pane fade show " id="2" role="tabpanel" aria-labelledby="2-tab">
            <div class="text-center">
              {$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
                <p style="color:red">{$node->name}</p>
                <p id="ssrtitle">配置信息</p>
                        <p>地址：{$ssr_item['address']}<br>
                          端口：152<br>
                          密码：{$ssr_item['passwd']}<br>
                          加密方式：{$ssr_item['method']}<br>
                          协议：{$ssr_item['protocol']}<br>
                          协议参数：{$ssr_item['protocol_param']}<br>
                          混淆：{$ssr_item['obfs']}<br>
            </div>
          </div>


          <div class="tab-pane fade show " id="3" role="tabpanel" aria-labelledby="3-tab">
            <div class="text-center">
              {$ss_item = URL::getItem($user, $node, $mu, $relay_rule_id, 1)}
                <p style="color:red">{$node->name}</p>
                <p id="ssrtitle">配置信息</p>
                        <p>地址：{$ss_item['address']}<br>
                          端口：153<br>
                          密码：{$ss_item['passwd']}<br>
                          加密方式：{$ss_item['method']}<br>
                          混淆：{$ss_item['obfs']}<br>
                          混淆参数：{$ss_item['obfs_param']}<br></p>
            </div>
          </div>
          </div>
         </div>








{include file='user/footer_info.tpl'}


<script src="https://cdn.godann.com/kitui/js/jquery.qrcode.min.js"></script>
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