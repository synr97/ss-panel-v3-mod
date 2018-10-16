


{include file='user/header_info.tpl'}


{if $node->sort == 11}
       <div class="nav-wrapper">
        <ul class="nav nav-pills nav-fill  flex-md-row" id="tabs-text" role="tablist">
          <li class="nav-item">
            <a class="nav-link mb-sm-3 mb-md-0 active" id="1-tab" data-toggle="tab" href="#1" role="tab" aria-controls="3" aria-selected="true">V2Ray</a>
          </li>
        </ul>
          </div>

 <div class="card shadow">
        <div class="card-body">
          <div class="tab-content" id="myTabContent">
          <div class="tab-pane fade show active" id="1" role="tabpanel" aria-labelledby="1-tab">
            <div class="text-center">
              <p style="color:red">{$node->name}</p>
              <p id="ssrtitle">配置信息</p>
              {assign var=server_explode value=";"|explode:$node->server}
              <p>地址：{$server_explode[0]}</br>
              端口：{$server_explode[1]}</br>
              协议：{$server_explode[3]}</br>
              附加协议：{$server_explode[4]}</br>
              用户UUID：{$user->getUuid()}</br>
              AlterId：{$server_explode[2]}</br>
			  VMess链接：
              <code>{URL::getV2Url($user, $node)}</code></p></br>
            </div>
          </div>
    </div>
   </div>



{else}
{$ssr_prefer = URL::SSRCanConnect($user, $mu)}
  
          <div class="nav-wrapper">
            <ul class="nav nav-pills nav-fill  flex-md-row" id="tabs-text" role="tablist">
            {if $node->mu_only != 1}
              <li class="nav-item">
                <a class="nav-link mb-sm-3 mb-md-0 active" id="1-tab" data-toggle="tab" href="#1" role="tab" aria-controls="3" aria-selected="true">个人端口</a>
              </li>
             {/if}
              <li class="nav-item">
                <a class="nav-link mb-sm-3 mb-md-0 {if $node->mu_only == 1}active{/if}" id="2-tab" data-toggle="tab" href="#2" role="tab" aria-controls="2" aria-selected="false">公共端口 - SSR</a>
              </li>
              <li class="nav-item">
                <a class="nav-link mb-sm-3 mb-md-0" id="3-tab" data-toggle="tab" href="#3" role="tab" aria-controls="3" aria-selected="false">公共端口 - SS</a>
              </li>
            </ul>
          </div>
        
          <div class="card shadow">
        <div class="card-body">
          <div class="tab-content" id="myTabContent">
          


        {if $node->mu_only != 1}
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
	                            混淆：{$ssr_item['obfs']}<br></p>
               <div id="ss-qr-n"></div>
          {elseif URL::SSCanConnect($user)}
                            <p>地址：{$ss_item['address']}<br>
                          		端口：{$user->port}<br>
                          		密码：{$ss_item['passwd']}<br>
                            	加密方式：{$ss_item['method']}<br>
                            	协议：{$ss_item['protocol']}<br>
                            	混淆：{$ss_item['obfs']}<br></p>
          {/if}
              <div id="ss-qr"></div>
            </div>
          </div>

          {/if}


          <div class="tab-pane fade show {if $node->mu_only == 1}active{/if}" id="2" role="tabpanel" aria-labelledby="2-tab">
            <div class="text-center">
              {$ssr_item_s = URL::getItem($user, $node, 152, $relay_rule_id, 0)}
                <p style="color:red">{$node->name}</p>
                <p id="ssrtitle">配置信息</p>
                        <p>地址：{$ssr_item_s['address']}<br>
                          端口：{$ssr_item_s['port']}<br>
                          密码：{$ssr_item_s['passwd']}<br>
                          加密方式：{$ssr_item_s['method']}<br>
                          协议：{$ssr_item_s['protocol']}<br>
                          协议参数：{$ssr_item_s['protocol_param']}<br>
                          混淆：{$ssr_item_s['obfs']}<br></p>
                 <div id="ssr-qr-s"></div>
            </div>
          </div>


          <div class="tab-pane fade show " id="3" role="tabpanel" aria-labelledby="3-tab">
            <div class="text-center">
              {$ss_item_s = URL::getItem($user, $node, 153, $relay_rule_id, 1)}
                <p style="color:red">{$node->name}</p>
                <p id="ssrtitle">配置信息</p>
                        <p>地址：{$ss_item_s['address']}<br>
                          端口：{$ss_item_s['port']}<br>
                          密码：{$ss_item_s['passwd']}<br>
                          加密方式：{$ss_item_s['method']}<br>
                          协议：{$ss_item['protocol']}<br>
                          混淆：{$ss_item_s['obfs']}<br>
                          混淆参数：{$ss_item_s['obfs_param']}<br></p>
                 <div id="ss-qr-s"></div>
            </div>
          </div>

          </div>
         </div>


{/if}

{include file='user/footer_info.tpl'}


<script src="/assets/public/js/jquery.qrcode.min.js"></script>

<script>

{if $node->sort != 11}

  var text_qrcode_s = '{URL::getItemUrl($ss_item_s, 1)}';
  jQuery('#ss-qr-s').qrcode({
        correctLevel :0,
      width: 200,
      height: 200,
    text: text_qrcode_s
  });
{/if}


{if URL::SSCanConnect($user, $mu) && $node->sort != 11}
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

  {if $node->sort != 11}

  var text_qrcode2_s = '{URL::getItemUrl($ssr_item_s, 0)}';
  jQuery('#ssr-qr-s').qrcode({
        correctLevel :0,
      width: 200,
      height: 200,
    text: text_qrcode2_s
  });
  {/if}


{if URL::SSRCanConnect($user, $mu) && $node->sort != 11}
  var text_qrcode2 = '{URL::getItemUrl($ssr_item, 0)}';
  jQuery('#ss-qr-n').qrcode({
        correctLevel :0,
      width: 200,
      height: 200,
    text: text_qrcode2
  });
{/if}

$(function(){
	new Clipboard('.copy-text');
});
$(".copy-text").click(function () {
	$("#result").modal();
	$("#msg").html("已复制到您的剪贴板，请您继续接下来的操作。");
});

</script>