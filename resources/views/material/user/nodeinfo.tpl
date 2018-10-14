


{include file='user/header_info.tpl'}


{$ssr_prefer = URL::SSRCanConnect($user, $mu)}
  
              <div class="nav-wrapper">
                <ul class="nav nav-pills nav-fill  flex-md-row" id="tabs-text" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link mb-sm-3 mb-md-0 active" id="1-tab" data-toggle="tab" href="#1" role="tab" aria-controls="3" aria-selected="true">个人端口</a>
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
              {if URL::SSRCanConnect($user, $mu)}
                                        <p>地址：{$ssr_item['address']}<br>
                                          端口：{$ssr_item['port']}<br>
                                          密码：{$ssr_item['passwd']}<br>
                                          加密方式：{$ssr_item['method']}<br>
                                          协议：{$ssr_item['protocol']}<br>
                                          混淆：{$ssr_item['obfs']}<br></p>
              {if URL::SSCanConnect($user, $mu)}
                                        <p>地址：{$ss_item['address']}<br>
                                           端口：{$ss_item['port']}<br>
                                           密码：{$ss_item['passwd']}<br>
                                           加密方式：{$ss_item['method']}<br>
                                           混淆：{$ss_item['obfs']}<br></p>
              {else}
                                        <p>当前设置的加密方式/协议/混淆不可用</p>
              {/if}
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