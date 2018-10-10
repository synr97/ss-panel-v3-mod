
{include file='admin/main.tpl'}







    <main class="content">
        <div class="content-header ui-content-header">
            <div class="container">
                <h1 class="content-heading">添加节点</h1>
            </div>
        </div>
        <div class="container">
            <div class="col-lg-12 col-sm-12">
                <section class="content-inner margin-top-no">
                    <form id="main_form">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner">
                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="name">节点名称</label>
                                        <input class="form-control" id="name" type="text" name="name">
                                    </div>


                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="server">节点地址</label>
                                        <input class="form-control" id="server" type="text" name="server">
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="server">节点 IP（可自动获取）</label>
                                        <input class="form-control" id="node_ip" name="node_ip" type="text">
                                    </div>

                                    <div class="form-group form-group-label" hidden="hidden">
                                        <label class="floating-label" for="method">加密方式</label>
                                        <input class="form-control" id="method" type="text" name="method" value="aes-256-cfb">
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="rate">流量比例</label>
                                        <input class="form-control" id="rate" type="text" value="1" name="rate">
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label for="dns_type">
                                            <label class="floating-label" for="dns_type">DNS 类型</label>
                                            <select id="dns_type" class="form-control" name="dns_type">
                                                <option value="0">非使用节点</option>
                                                <option value="1" selected="selected">静态 A 记录</option>
                                                <option value="2">动态 CNAME 记录</option>
                                                <option value="3">动态 A 记录</option>
                                            </select>
                                        </label>
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="dns_value">DNS 记录</label>
                                        <input class="form-control" id="dns_value" name="dns_value" type="text" value="{$node->dns_value}">
                                    </div>

                                    <div class="form-group form-group-label" hidden="hidden">
                                        <div class="checkbox switch">
                                            <label for="custom_method">
                                                <input  class="access-hide" id="custom_method" type="checkbox" name="custom_method" checked="checked" disabled><span class="switch-toggle"></span>自定义加密
                                            </label>
                                        </div>
                                    </div>

                                    <div class="form-group form-group-label" hidden="hidden">
                                        <div class="checkbox switch">
                                            <label for="custom_rss">
                                                <input  class="access-hide" id="custom_rss" type="checkbox" name="custom_rss" checked="checked" disabled><span class="switch-toggle"></span>自定义协议&混淆
                                            </label>
                                        </div>
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label for="mu_only">
                                            <label class="floating-label" for="sort">端口启用</label>
                                            <select id="mu_only" class="form-control" name="is_multi_user">
                                                    <option value="0">个人端口与公共端口并存</option>
                                                    <option value="-1">个人端口</option>
                                                    <option value="1">公共端口</option>
                                            </select>
                                        </label>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner">
                                    <div class="form-group form-group-label">
                                        <div class="checkbox switch">
                                            <label for="type">
                                                <input checked class="access-hide" id="type" type="checkbox" name="type"><span class="switch-toggle"></span>是否显示
                                            </label>
                                        </div>
                                    </div>


                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="status">节点状态</label>
                                        <input class="form-control" id="status" type="text" value="可用" name="status">
                                    </div>

                                    <div class="form-group form-group-label">
                                        <div class="form-group form-group-label">
                                                <label class="floating-label" for="sort">节点类型</label>
                                                <select id="sort" class="form-control" name="sort">
                                                    <option value="0">Shadowsocks</option>
                                                    <option value="1">VPN/Radius基础</option>
                                                    <option value="2">SSH</option>
                                                    <option value="3">PAC</option>
                                                    <option value="4">APN文件外链</option>
                                                    <option value="5">Anyconnect</option>
                                                    <option value="6">APN</option>
                                                    <option value="7">PAC PLUS(Socks 代理生成 PAC文件)</option>
                                                    <option value="8">PAC PLUS PLUS(HTTPS 代理生成 PAC文件)</option>
                                                    <option value="9">Shadowsocks 公共端口</option>
                                                    <option value="10" selected="selected">Shadowsocks 中转</option>
                                                    <option value="11">V2Ray</option>
                                                </select>
                                            </div>
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="info">节点描述</label>
                                        <input class="form-control" id="info" type="text" name="info">
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="class">节点等级（不分级请填0，分级为数字）</label>
                                        <input class="form-control" id="class" type="text" value="0" name="class">
                                    </div>


                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="group">节点群组（分组为数字，不分组请填0）</label>
                                        <input class="form-control" id="group" type="text" value="0" name="group">
                                    </div>


                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="node_bandwidth_limit">节点流量上限（不使用的话请填0）（GB）</label>
                                        <input class="form-control" id="node_bandwidth_limit" type="text" value="0" name="node_bandwidth_limit">
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="bandwidthlimit_resetday">节点流量上限清空日</label>
                                        <input class="form-control" id="bandwidthlimit_resetday" type="text" value="0" name="bandwidthlimit_resetday">
                                    </div>

                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="node_speedlimit">节点限速(对于每个用户端口)（Mbps）</label>
                                        <input class="form-control" id="node_speedlimit" type="text" value="0" name="node_speedlimit">
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
                                                <button id="submit" type="submit" class="btn btn-block btn-brand waves-attach waves-light">添加</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                    {include file='dialog.tpl'}




            </div>



        </div>
    </main>











{include file='admin/footer.tpl'}


{literal}
<script>

    $('#main_form').validate({
        rules: {
          name: {required: true},
          server: {required: true},
          method: {required: true},
          rate: {required: true},
          info: {required: true},
          group: {required: true},
          status: {required: true},
          node_speedlimit: {required: true},
          sort: {required: true},
          dns_type: {required: true},
          node_bandwidth_limit: {required: true},
          bandwidthlimit_resetday: {required: true}
        },

        submitHandler: function() {
            if(document.getElementById('custom_method').checked)
            {
                var custom_method=1;
            }
            else
            {
                var custom_method=0;
            }

            if(document.getElementById('type').checked)
            {
                var type=1;
            }
            else
            {
                var type=0;
            }
            {/literal}
            if(document.getElementById('custom_rss').checked)
            {
                var custom_rss=1;
            }
            else
            {
                var custom_rss=0;
            }


            $.ajax({
                type: "POST",
                url: "/admin/node",
                dataType: "json",
                data: {
                    name: $("#name").val(),
                    server: $("#server").val(),
                    node_ip: $("#node_ip").val(),
                    method: $("#method").val(),
                    custom_method: custom_method,
                    rate: $("#rate").val(),
                    info: $("#info").val(),
                    dns_type: $("#dns_type").val(),
                    dns_value: $("#dns_value").val(),
                    type: type,
                    group: $("#group").val(),
                    status: $("#status").val(),
                    node_speedlimit: $("#node_speedlimit").val(),
                    sort: $("#sort").val(),
                    class: $("#class").val(),
                    node_bandwidth_limit: $("#node_bandwidth_limit").val(),
                    bandwidthlimit_resetday: $("#bandwidthlimit_resetday").val(),
                    custom_rss: custom_rss,
                    mu_only: $("#mu_only").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
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
    });

</script>
