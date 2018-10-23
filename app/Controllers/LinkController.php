<?php

//Thanks to http://blog.csdn.net/jollyjumper/article/details/9823047

namespace App\Controllers;

use App\Models\Link;
use App\Models\User;
use App\Models\Node;
use App\Models\Relay;
use App\Models\Smartline;
use App\Utils\Tools;
use App\Utils\URL;
use App\Services\Config;

/**
 *  HomeController
 */
class LinkController extends BaseController
{
    public function __construct()
    {
    }

    public static function GenerateRandomLink()
    {
        $i =0;
        for ($i = 0; $i < 10; $i++) {
            $token = Tools::genRandomChar(16);
            $Elink = Link::where("token", "=", $token)->first();
            if ($Elink == null) {
                return $token;
            }
        }

        return "couldn't alloc token";
    }

    public static function GenerateCode($type, $address, $port, $ios, $userid)
    {
        $Elink = Link::where("type", "=", $type)->where("address", "=", $address)->where("port", "=", $port)->where("ios", "=", $ios)->where("userid", "=", $userid)->first();
        if ($Elink != null) {
            return $Elink->token;
        }
        $NLink = new Link();
        $NLink->type = $type;
        $NLink->address = $address;
        $NLink->port = $port;
        $NLink->ios = $ios;
        $NLink->userid = $userid;
        $NLink->token = LinkController::GenerateRandomLink();
        $NLink->save();

        return $NLink->token;
    }





    public static function GenerateApnCode($isp, $address, $port, $userid)
    {
        $Elink = Link::where("type", "=", 6)->where("address", "=", $address)->where("port", "=", $port)->where("userid", "=", $userid)->where("isp", "=", $isp)->first();
        if ($Elink != null) {
            return $Elink->token;
        }
        $NLink = new Link();
        $NLink->type = 6;
        $NLink->address = $address;
        $NLink->port = $port;
        $NLink->ios = 1;
        $NLink->isp = $isp;
        $NLink->userid = $userid;
        $NLink->token = LinkController::GenerateRandomLink();
        $NLink->save();

        return $NLink->token;
    }


    public static function GenerateSurgeCode($address, $port, $userid, $geo, $method)
    {
        $Elink = Link::where("type", "=", 0)->where("address", "=", $address)->where("port", "=", $port)->where("userid", "=", $userid)->where("geo", "=", $geo)->where("method", "=", $method)->first();
        if ($Elink != null) {
            return $Elink->token;
        }
        $NLink = new Link();
        $NLink->type = 0;
        $NLink->address = $address;
        $NLink->port = $port;
        $NLink->ios = 1;
        $NLink->geo = $geo;
        $NLink->method = $method;
        $NLink->userid = $userid;
        $NLink->token = LinkController::GenerateRandomLink();
        $NLink->save();

        return $NLink->token;
    }

    public static function GenerateIosCode($address, $port, $userid, $geo, $method)
    {
        $Elink = Link::where("type", "=", -1)->where("address", "=", $address)->where("port", "=", $port)->where("userid", "=", $userid)->where("geo", "=", $geo)->where("method", "=", $method)->first();
        if ($Elink != null) {
            return $Elink->token;
        }
        $NLink = new Link();
        $NLink->type = -1;
        $NLink->address = $address;
        $NLink->port = $port;
        $NLink->ios = 1;
        $NLink->geo = $geo;
        $NLink->method = $method;
        $NLink->userid = $userid;
        $NLink->token = LinkController::GenerateRandomLink();
        $NLink->save();

        return $NLink->token;
    }

    public static function GenerateAclCode($address, $port, $userid, $geo, $method)
    {
        $Elink = Link::where("type", "=", 9)->where("address", "=", $address)->where("port", "=", $port)->where("userid", "=", $userid)->where("geo", "=", $geo)->where("method", "=", $method)->first();
        if ($Elink != null) {
            return $Elink->token;
        }
        $NLink = new Link();
        $NLink->type = 9;
        $NLink->address = $address;
        $NLink->port = $port;
        $NLink->ios = 0;
        $NLink->geo = $geo;
        $NLink->method = $method;
        $NLink->userid = $userid;
        $NLink->token = LinkController::GenerateRandomLink();
        $NLink->save();

        return $NLink->token;
    }

    public static function GenerateRouterCode($userid, $without_mu)
    {
        $Elink = Link::where("type", "=", 10)->where("userid", "=", $userid)->where("geo", $without_mu)->first();
        if ($Elink != null) {
            return $Elink->token;
        }
        $NLink = new Link();
        $NLink->type = 10;
        $NLink->address = "";
        $NLink->port = 0;
        $NLink->ios = 0;
        $NLink->geo = $without_mu;
        $NLink->method = "";
        $NLink->userid = $userid;
        $NLink->token = LinkController::GenerateRandomLink();
        $NLink->save();

        return $NLink->token;
    }

    public static function GenerateSSRSubCode($userid, $without_mu)
    {
        $Elink = Link::where("type", "=", 11)->where("userid", "=", $userid)->where("geo", $without_mu)->first();
        if ($Elink != null) {
            return $Elink->token;
        }
        $NLink = new Link();
        $NLink->type = 11;
        $NLink->address = "";
        $NLink->port = 0;
        $NLink->ios = 0;
        $NLink->geo = $without_mu;
        $NLink->method = "";
        $NLink->userid = $userid;
        $NLink->token = LinkController::GenerateRandomLink();
        $NLink->save();

        return $NLink->token;
    }

    public static function GetContent($request, $response, $args)
    {
        $token = $args['token'];

        //$builder->getPhrase();
        $Elink = Link::where("token", "=", $token)->first();
        if ($Elink == null) {
            return null;
        }

        switch ($Elink->type) {
            case -1:
                $user = User::where("id", $Elink->userid)->first();
                if ($user == null) {
                    return null;
                }

                $is_ss = 1;
                if (isset($request->getQueryParams()["is_ss"])) {
                    $is_ss = $request->getQueryParams()["is_ss"];
                }

                $is_mu = 0;
                if (isset($request->getQueryParams()["is_mu"])) {
                    $is_mu = $request->getQueryParams()["is_mu"];
                }

                $mitm = 0;
                if (isset($request->getQueryParams()["mitm"])) {
                    $mitm = $request->getQueryParams()["mitm"];
                }

                $new = 0;
                if (isset($request->getQueryParams()["new"])) {
                    $new = $request->getQueryParams()["new"];
                }

                $clash = 0;
                if (isset($request->getQueryParams()["clash"])) {
                    $clash = $request->getQueryParams()["clash"];
                }

                $list = 0;
                if (isset($request->getQueryParams()["list"])) {
                    $list = $request->getQueryParams()["list"];
                }

                $list_auto = 0;
                if (isset($request->getQueryParams()["list_auto"])) {
                    $list_auto = $request->getQueryParams()["list_auto"];
                }

                $list_media = 0;
                if (isset($request->getQueryParams()["list_media"])) {
                    $list_media = $request->getQueryParams()["list_media"];
                }

                $list_back = 0;
                if (isset($request->getQueryParams()["list_back"])) {
                    $list_back = $request->getQueryParams()["list_back"];
                }

                $cn_list = 0;
                if (isset($request->getQueryParams()["cn_list"])) {
                    $cn_list = $request->getQueryParams()["cn_list"];
                }

                $hk_list = 0;
                if (isset($request->getQueryParams()["hk_list"])) {
                    $hk_list = $request->getQueryParams()["hk_list"];
                }

                $jp_list = 0;
                if (isset($request->getQueryParams()["jp_list"])) {
                    $jp_list = $request->getQueryParams()["jp_list"];
                }

                $tw_list = 0;
                if (isset($request->getQueryParams()["tw_list"])) {
                    $tw_list = $request->getQueryParams()["tw_list"];
                }

                $kr_list = 0;
                if (isset($request->getQueryParams()["kr_list"])) {
                    $kr_list = $request->getQueryParams()["kr_list"];
                }

                $sg_list = 0;
                if (isset($request->getQueryParams()["sg_list"])) {
                    $sg_list = $request->getQueryParams()["sg_list"];
                }

                $ru_list = 0;
                if (isset($request->getQueryParams()["ru_list"])) {
                    $ru_list = $request->getQueryParams()["ru_list"];
                }

                $us_list = 0;
                if (isset($request->getQueryParams()["us_list"])) {
                    $us_list = $request->getQueryParams()["us_list"];
                }

                $userinfo = "upload=".$user->u."; download=".$user->d.";total=".$user->transfer_enable;

                if ($list_auto == 1) {
                    $filename = 'auto.list';
                } elseif ($list_media == 1) {
                    $filename = 'media.list';
                } elseif ($list_back == 1) {
                    $filename = 'back.list';
                } elseif ($cn_list == 1) {
                    $filename = 'cn_proxy.list';
                } elseif ($hk_list == 1) {
                    $filename = 'hk_proxy.list';
                } elseif ($jp_list == 1) {
                    $filename = 'jp_proxy.list';
                } elseif ($tw_list == 1) {
                    $filename = 'tw_proxy.list';
                } elseif ($kr_list == 1) {
                    $filename = 'kr_proxy.list';
                } elseif ($sg_list == 1) {
                    $filename = 'sg_proxy.list';
                } elseif ($ru_list == 1) {
                    $filename = 'ru_proxy.list';
                } elseif ($us_list == 1) {
                    $filename = 'us_proxy.list';
                } elseif ($list == 1) {
                    $filename = 'all.list';
                } elseif ($clash == 1) {
                    $filename = 'Dler Cloud.yml';
                } elseif ($is_mu == 1) {
                    $filename = 'Dler Cloud - Public.conf';
                } elseif ($new == 1) {
                    $filename = 'Dler Cloud - New.conf';
                } else {
                    $filename = 'Dler Cloud.conf';
                }
                $newResponse = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')->withHeader('Subscription-userinfo',$userinfo)->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename='.$filename);
                $newResponse->getBody()->write(LinkController::GetIosConf($user, $is_mu, $is_ss, $mitm, $new, $clash, $list, $list_auto, $list_media, $list_back, $cn_list, $hk_list, $jp_list, $tw_list, $kr_list, $sg_list, $ru_list, $us_list));
                return $newResponse;
            case 3:
                $type = "PROXY";
                break;
            case 7:
                $type = "PROXY";
                break;
            case 6:
                $newResponse = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename='.$token.'.mobileconfig');//->getBody()->write($builder->output());
                $newResponse->getBody()->write(LinkController::GetApn($Elink->isp, $Elink->address, $Elink->port, User::where("id", "=", $Elink->userid)->first()->pac));
                return $newResponse;
            case 0:
                if ($Elink->geo == 0) {
                    $newResponse = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename='.$token.'.conf');//->getBody()->write($builder->output());
                    $newResponse->getBody()->write(LinkController::GetSurge(User::where("id", "=", $Elink->userid)->first()->passwd, $Elink->method, $Elink->address, $Elink->port, User::where("id", "=", $Elink->userid)->first()->pac));
                    return $newResponse;
                } else {
                    $newResponse = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename='.$token.'.conf');//->getBody()->write($builder->output());
                    $newResponse->getBody()->write(LinkController::GetSurgeGeo(User::where("id", "=", $Elink->userid)->first()->passwd, $Elink->method, $Elink->address, $Elink->port));
                    return $newResponse;
                }
            case 8:
                if ($Elink->ios == 0) {
                    $type = "SOCKS5";
                } else {
                    $type = "SOCKS";
                }
                break;
            case 9:
                $newResponse = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename='.$token.'.acl');//->getBody()->write($builder->output());
                $newResponse->getBody()->write(LinkController::GetAcl(User::where("id", "=", $Elink->userid)->first()));
                return $newResponse;
            case 10:
                $user = User::where("id", $Elink->userid)->first();
                if ($user == null) {
                    return null;
                }

                $is_ss = 0;
                if (isset($request->getQueryParams()["is_ss"])) {
                    $is_ss = $request->getQueryParams()["is_ss"];
                }

                $newResponse = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename='.$token.'.sh');//->getBody()->write($builder->output());
                $newResponse->getBody()->write(LinkController::GetRouter(User::where("id", "=", $Elink->userid)->first(), $Elink->geo, $is_ss));
                return $newResponse;
            case 11:
                $user = User::where("id", $Elink->userid)->first();
                if ($user == null) {
                    return null;
                }

                $max = 0;
                if (isset($request->getQueryParams()["max"])) {
                    $max = (int)$request->getQueryParams()["max"];
                }

                $mu = 0;
                if (isset($request->getQueryParams()["mu"])) {
                    $mu = (int)$request->getQueryParams()["mu"];
                }

                $userinfo = "upload=".$user->u."; download=".$user->d.";total=".$user->transfer_enable;
                $newResponse = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')->withHeader('Subscription-userinfo',$userinfo)->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename='.$token.'.txt');
                $newResponse->getBody()->write(LinkController::GetSSRSub(User::where("id", "=", $Elink->userid)->first(), $mu, $max));
                return $newResponse;
            default:
                break;
        }
        $newResponse = $response->withHeader('Content-type', ' application/x-ns-proxy-autoconfig; charset=utf-8')->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate');//->getBody()->write($builder->output());
        $newResponse->getBody()->write(LinkController::GetPac($type, $Elink->address, $Elink->port, User::where("id", "=", $Elink->userid)->first()->pac));
        return $newResponse;
    }


    public static function GetGfwlistJs($request, $response, $args)
    {
        $newResponse = $response->withHeader('Content-type', ' application/x-ns-proxy-autoconfig; charset=utf-8')->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')->withHeader('Content-Disposition', ' attachment; filename=gfwlist.js');
        ;//->getBody()->write($builder->output());
        $newResponse->getBody()->write(LinkController::GetMacPac());
        return $newResponse;
    }

    public static function GetPcConf($user, $is_mu = 0, $is_ss = 0)
    {
    if ($is_ss == 0) {
        $string = '
            {
                "index" : 0,
                "random" : false,
                "sysProxyMode" : 0,
                "shareOverLan" : false,
                "bypassWhiteList" : false,
                "localPort" : 1080,
                "localAuthPassword" : "'.Tools::genRandomChar(26).'",
                "dns_server" : "",
                "reconnectTimes" : 4,
                "randomAlgorithm" : 0,
                "TTL" : 60,
                "connect_timeout" : 5,
                "proxyRuleMode" : 1,
                "proxyEnable" : false,
                "pacDirectGoProxy" : false,
                "proxyType" : 0,
                "proxyHost" : "",
                "proxyPort" : 0,
                "proxyAuthUser" : "",
                "proxyAuthPass" : "",
                "proxyUserAgent" : "",
                "authUser" : "",
                "authPass" : "",
                "autoBan" : false,
                "sameHostForSameTarget" : true,
                "keepVisitTime" : 180,
                "isHideTips" : true,
                "token" : {

                },
                "portMap" : {

                }
            }
        ';
    } else {
        $string = '
            {
                "strategy": null,
                "index": 6,
                "global": false,
                "enabled": false,
                "shareOverLan": false,
                "isDefault": false,
                "localPort": 1080,
                "pacUrl": null,
                "useOnlinePac": false,
                "secureLocalPac": true,
                "availabilityStatistics": false,
                "autoCheckUpdate": false,
                "checkPreRelease": false,
                "isVerboseLogging": true,
                "logViewer": {
                "topMost": false,
                "wrapText": false,
                "toolbarShown": false,
                "Font": "Consolas, 8pt",
                "BackgroundColor": "Black",
                "TextColor": "White"
                },
                "proxy": {
                "useProxy": false,
                "proxyType": 0,
                "proxyServer": "",
                "proxyPort": 0,
                "proxyTimeout": 3
                },
                "hotkey": {
                "SwitchSystemProxy": "",
                "SwitchSystemProxyMode": "",
                "SwitchAllowLan": "",
                "ShowLogs": "",
                "ServerMoveUp": "",
                "ServerMoveDown": ""
                }
            }
        ';
    }




        $json = json_decode($string, true);
        $temparray = array();

        $items = URL::getAllItems($user, $is_mu, $is_ss);
        foreach($items as $item) {
            if ($is_ss == 0) {
                array_push($temparray, array("remarks"=>$item['remark'],
                                            "server"=>$item['address'],
                                            "server_port"=>$item['port'],
                                            "method"=>$item['method'],
                                            "obfs"=>$item['obfs'],
                                            "obfsparam"=>$item['obfs_param'],
                                            "remarks_base64"=>base64_encode($item['remark']),
                                            "password"=>$item['passwd'],
                                            "tcp_over_udp"=>false,
                                            "udp_over_tcp"=>false,
                                            "group"=>$item['group'],
                                            "protocol"=>$item['protocol'],
                                            "protoparam"=>$item['protocol_param'],
                                            "protocolparam"=>$item['protocol_param'],
                                            "obfs_udp"=>false,
                                            "enable"=>true));
            } else {
                array_push($temparray, array("server"=>$item['address'],
                                            "server_port"=>$item['port'],
                                            "password"=>$item['passwd'],
                                            "method"=>$item['method'],
                                            "plugin"=>"obfs-local",
                                            "plugin_opts"=>str_replace(',',';',URL::getSurgeObfs($item)),
                                            "remarks"=>$item['remark'],
                                            "timeout"=>5));
            }
        }

        $json["configs"] = $temparray;
        return json_encode($json, JSON_PRETTY_PRINT);
    }


    public static function GetIosConf($user, $is_mu = 0, $is_ss = 1, $mitm = 0, $new = 0, $clash = 0, $list = 0, $list_auto = 0, $list_media = 0, $list_back = 0, $cn_list = 0, $hk_list = 0, $jp_list = 0, $tw_list = 0, $kr_list = 0, $sg_list = 0, $ru_list = 0, $us_list = 0) {
        $proxy_name = "";
        $domestic_name = "";
        $auto_name = "";
        $proxy_list = "";
        $clash_array = array();

        if ($clash == 1) {
            $general = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/ClashGeneral.yml");
            $rules = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/ClashRule.yml");

            $clash_array = $clash_array + yaml_parse($general);
            $clash_array["Proxy"] = array();
            $clash_array["Proxy Group"] = array();
            if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("游戏")) == "") {
                    if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("中国")) == "") {
                        $auto_clash = array('name' => "auto", 'type' => "url-test", 'proxies' => array(), 'url' => "http://captive.apple.com", 'interval' => 1200);
                        if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("香港")) != "") {
                        	if (strpos('"'.$item['remark'].'"',"AZURE") == "") {
                        		if (strpos('"'.$item['remark'].'"',"CN2") == "") {
                        			$fallback_auto_clash = array('name' => "fallback-auto", 'type' => "fallback", 'proxies' => array(), 'url' => "http://captive.apple.com", 'interval' => 1200);
                        		}
                        	}
                        }
                    }
                }
            $proxy_clash = array('name' => "Proxy", 'type' => "select", 'proxies' => array());
        } else {
          if ($new == 0) {
              if ($mitm == 0) {
                  $general = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/OldGeneral.conf");
                  $rules = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/Rule.conf");
              } else {
                  $general = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/OldGeneral.conf");
                  $rule = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/Rule.conf");
                  $mitm = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/MitM.conf");
                  $rules = $rule."\n\n".$mitm;
              }
          } elseif ($new == 1) {
              $general = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/General.conf");
              $rule = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/NewRule.conf");
              $url_rewrite = file_get_contents("https://raw.githubusercontent.com/lhie1/Rules/master/Auto/URL%20Rewrite.conf");
              $url_reject = file_get_contents("https://raw.githubusercontent.com/lhie1/Rules/master/Auto/URL%20REJECT.conf");
              $header = file_get_contents("https://raw.githubusercontent.com/lhie1/Rules/master/Auto/Header%20Rewrite.conf");
              $mitm = file_get_contents("https://raw.githubusercontent.com/lhie1/black-hole/master/MitM.conf");
              $rules = $rule."\n\n".$url_rewrite."\n".$url_reject."\n\n".$header."\n\n".$mitm;
          }
        }

        $items = URL::getAllItems($user, $is_mu, $is_ss);
        foreach($items as $item) {
            if ($clash == 1) {
                $em["name"] = $item['remark'];
                $em["type"] = "ss";
                $em["server"] = $item['address'];
                $em["port"]  = $item['port'];
                $em["cipher"] = $item['method'];
                $em["password"] = $item['passwd'];

                if (array_key_exists('obfs', $item) && $item['obfs'] != '') {
                    if (strpos($item['obfs'], 'http') != false) {
                       $em["obfs"] = 'http';
                    }
                    else if (strpos($item['obfs'], 'tls') != false) {
                       $em["obfs"] = 'tls';
                    }
                }

                if (array_key_exists('obfs_param', $item) && $item['obfs_param'] != '') {
                    $em["obfs-host"] = $item['obfs_param'];
                } else {
                    $em["obfs-host"] = "wns.windows.com";
                }

                  array_push($clash_array["Proxy"], $em);
                  array_push($auto_clash["proxies"], $em["name"]);
                  array_push($fallback_auto_clash["proxies"], $em["name"]);
                  array_push($proxy_clash["proxies"], $em["name"]);
            } elseif ($list == 0) {
                if (URL::getSurgeObfs($item) != "") {
                    $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module,'.URL::getSurgeObfs($item).', udp-relay=true, tfo=true'."\n";
                } else {
                    $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module, udp-relay=true, tfo=true'."\n";
                }

                $proxy_name .= ", ".$item['remark'];

                if (substr($item['remark'],-4,4) == "Back") {
                    $domestic_name .= ", ".$item['remark'];
                }

                if (substr($item['remark'],-5,5) == "Media") {
                    $media_name .= ", ".$item['remark'];
                }

                if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("游戏")) == "") {
                    if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("中国")) == "") {
                        $auto_name .= ", ".$item['remark'];
                        if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("香港")) != "") {
                        	if (strpos('"'.$item['remark'].'"',"AZURE") == "") {
                        		if (strpos('"'.$item['remark'].'"',"CN2") == "") {
                        			$fallback_name .= ", ".$item['remark'];
                        		}
                        	}
                        }
                    }
                }
            } elseif ($list == 1) {
                if ($cn_list == 1) {
                    $area = "中国";
                } elseif ($hk_list == 1) {
                    $area = "香港";
                } elseif ($jp_list == 1) {
                    $area = "日本";
                } elseif ($tw_list == 1) {
                    $area = "台湾";
                } elseif ($kr_list == 1) {
                    $area = "韩国";
                } elseif ($sg_list == 1) {
                    $area = "新加坡";
                } elseif ($ru_list == 1) {
                    $area = "俄罗斯";
                } elseif ($us_list == 1) {
                    $area = "美国";
                } else {
                    $area = "";
                }
                if ($area == "") {
                    if ($list_auto == 1) {
                        if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("游戏")) == "") {
                            if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("中国")) == "") {
                                if (URL::getSurgeObfs($item) != "") {
                                    $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module,'.URL::getSurgeObfs($item).', udp-relay=true, tfo=true'."\n";
                                } else {
                                    $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module, udp-relay=true, tfo=true'."\n";
                                }
                            }
                        }
                    } elseif ($list_media == 1) {
                        if (substr($item['remark'],-5,5) == "Media") {
                            if (URL::getSurgeObfs($item) != "") {
                                $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module,'.URL::getSurgeObfs($item).', udp-relay=true, tfo=true'."\n";
                            } else {
                                $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module, udp-relay=true, tfo=true'."\n";
                            }
                        }
                    } elseif ($list_back == 1) {
                        if (substr($item['remark'],-4,4) == "Back") {
                            if (URL::getSurgeObfs($item) != "") {
                                $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module,'.URL::getSurgeObfs($item).', udp-relay=true, tfo=true'."\n";
                            } else {
                                $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module, udp-relay=true, tfo=true'."\n";
                            }
                        }
                    } else {
                        if (URL::getSurgeObfs($item) != "") {
                            $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module,'.URL::getSurgeObfs($item).', udp-relay=true, tfo=true'."\n";
                        } else {
                            $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module, udp-relay=true, tfo=true'."\n";
                        }
                    }
                } elseif ($area != "") {
                    if ($area == "中国") {
                        if (substr($item['remark'],-5,5) != "Gamer") {
                            if (strpos(urlencode('"'.$item['remark'].'"'),urlencode($area)) != "") {
                                if (URL::getSurgeObfs($item) != "") {
                                    $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module,'.URL::getSurgeObfs($item).', udp-relay=true, tfo=true'."\n";
                                } else {
                                    $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module, udp-relay=true, tfo=true'."\n";
                                }
                            }
                        }
                    } elseif ($area != "中国") {
                        if (substr($item['remark'],-5,5) != "Gamer") {
                            if (substr($item['remark'],-4,4) != "Back") {
                                if (strpos(urlencode('"'.$item['remark'].'"'),urlencode("中国")) == "") {
                                    if (strpos(urlencode('"'.$item['remark'].'"'),urlencode($area)) != "") {
                                        if (URL::getSurgeObfs($item) != "") {
                                            $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module,'.URL::getSurgeObfs($item).', udp-relay=true, tfo=true'."\n";
                                        } else {
                                            $proxy_list .= $item['remark'].' = custom, '.$item['address'].', '.$item['port'].', '.$item['method'].', '.$item['passwd'].', https://dlercloud.com/SSEncrypt.module, udp-relay=true, tfo=true'."\n";
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        if ($clash == 1) {
          array_push($clash_array["Proxy Group"], $auto_clash);
          array_push($clash_array["Proxy Group"], $fallback_auto_clash);
          array_push($clash_array["Proxy Group"], $proxy_clash);
          $clash_array = $clash_array + yaml_parse($rules);
          return yaml_emit($clash_array);
        }

        if ($list == 1) {
            if ($area != "" || $list_auto == 1 || $list_media == 1 || $list_back == 1) {
                return ''.$proxy_list.'';
            } else {
                return 'DIRECT = direct
'.$proxy_list.'';
            }
        } elseif ($new == 0) {
			return '#!MANAGED-CONFIG '.Config::get('apiUrl').''.$_SERVER['REQUEST_URI'].'

'.$general.'

[Proxy]
DIRECT = direct
'.$proxy_list.'

[Proxy Group]
PROXY = select, Auto, DIRECT'.$proxy_name.'
Domestic = select, DIRECT, PROXY'.$domestic_name.'
Others = select, PROXY, DIRECT
Apple = select, DIRECT, PROXY, Auto
Media = select, PROXY, DIRECT'.$media_name.'
Auto = url-test'.$auto_name.', url = http://captive.apple.com, interval = 1200, tolerance = 200

'.$rules.'';
        } elseif ($new == 1) {
        	        return '#!MANAGED-CONFIG '.Config::get('apiUrl').''.$_SERVER['REQUEST_URI'].'

'.$general.'

[Proxy]
DIRECT = direct
'.$proxy_list.'

[Proxy Group]
PROXY = select, Auto, fallback, DIRECT'.$proxy_name.'
Domestic = select, DIRECT, PROXY'.$domestic_name.'
Others = select, PROXY, DIRECT
Apple = select, DIRECT, PROXY, Auto
Media = select, PROXY, DIRECT'.$media_name.'
Auto = url-test'.$auto_name.', url = http://captive.apple.com, interval = 1200, tolerance = 200
fallback = fallback'.$fallback_name.', url = http://captive.apple.com, interval = 1200


'.$rules.'';
        }
    }

    private static function GetSurge($passwd, $method, $server, $port, $defined)
    {
        $rulelist = base64_decode(file_get_contents("https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"))."\n".$defined;
        $gfwlist = explode("\n", $rulelist);

        $count = 0;
        $pac_content = '';
        $find_function_content = '
[General]
skip-proxy = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, localhost, *.local
bypass-tun = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12
dns-server = 119.29.29.29, 223.5.5.5, 114.114.114.114
loglevel = notify

[Proxy]
Proxy = custom,'.$server.','.$port.','.$method.','.$passwd.','.Config::get('apiUrl').'/downloads/SSEncrypt.module

[Rule]
DOMAIN-KEYWORD,adsmogo,REJECT
DOMAIN-SUFFIX,acs86.com,REJECT
DOMAIN-SUFFIX,adcome.cn,REJECT
DOMAIN-SUFFIX,adinfuse.com,REJECT
DOMAIN-SUFFIX,admaster.com.cn,REJECT
DOMAIN-SUFFIX,admob.com,REJECT
DOMAIN-SUFFIX,adsage.cn,REJECT
DOMAIN-SUFFIX,adsage.com,REJECT
DOMAIN-SUFFIX,adsmogo.org,REJECT
DOMAIN-SUFFIX,ads.mobclix.com,REJECT
DOMAIN-SUFFIX,adview.cn,REJECT
DOMAIN-SUFFIX,adwhirl.com,REJECT
DOMAIN-SUFFIX,adwo.com,REJECT
DOMAIN-SUFFIX,appads.com,REJECT
DOMAIN-SUFFIX,domob.cn,REJECT
DOMAIN-SUFFIX,domob.com.cn,REJECT
DOMAIN-SUFFIX,domob.org,REJECT
DOMAIN-SUFFIX,doubleclick.net,REJECT
DOMAIN-SUFFIX,duomeng.cn,REJECT
DOMAIN-SUFFIX,duomeng.net,REJECT
DOMAIN-SUFFIX,duomeng.org,REJECT
DOMAIN-SUFFIX,googeadsserving.cn,REJECT
DOMAIN-SUFFIX,guomob.com,REJECT
DOMAIN-SUFFIX,immob.cn,REJECT
DOMAIN-SUFFIX,inmobi.com,REJECT
DOMAIN-SUFFIX,mobads.baidu.com,REJECT
DOMAIN-SUFFIX,mobads-logs.baidu.com,REJECT
DOMAIN-SUFFIX,smartadserver.com,REJECT
DOMAIN-SUFFIX,tapjoyads.com,REJECT
DOMAIN-SUFFIX,umeng.co,REJECT
DOMAIN-SUFFIX,umeng.com,REJECT
DOMAIN-SUFFIX,umtrack.com,REJECT
DOMAIN-SUFFIX,uyunad.com,REJECT
DOMAIN-SUFFIX,youmi.net,REJECT'."\n";
        $isget=array();
        foreach ($gfwlist as $index => $rule) {
            if (empty($rule)) {
                continue;
            } elseif (substr($rule, 0, 1) == '!' || substr($rule, 0, 1) == '[') {
                continue;
            }

            if (substr($rule, 0, 2) == '@@') {
                // ||开头表示前面还有路径
                if (substr($rule, 2, 2) =='||') {
                    //$rule_reg = preg_match("/^((http|https):\/\/)?([^\/]+)/i",substr($rule, 2), $matches);
                    $host = substr($rule, 4);
                    //preg_match("/[^\.\/]+\.[^\.\/]+$/", $host, $matches);
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;
                    $find_function_content.="DOMAIN,".$host.",DIRECT,force-remote-dns\n";
                    continue;
                // !开头相当于正则表达式^
                } elseif (substr($rule, 2, 1) == '|') {
                    preg_match("/(\d{1,3}\.){3}\d{1,3}/", substr($rule, 3), $matches);
                    if (!isset($matches[0])) {
                        continue;
                    }

                    $host = $matches[0];
                    if ($host != "") {
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        $find_function_content.="IP-CIDR,".$host."/32,DIRECT,no-resolve \n";
                        continue;
                    } else {
                        preg_match_all("~^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?~i", substr($rule, 3), $matches);

                        if (!isset($matches[4][0])) {
                            continue;
                        }

                        $host = $matches[4][0];
                        if ($host != "") {
                            if (isset($isget[$host])) {
                                continue;
                            }
                            $isget[$host]=1;
                            $find_function_content.="DOMAIN-SUFFIX,".$host.",DIRECT,force-remote-dns\n";
                            continue;
                        }
                    }
                } elseif (substr($rule, 2, 1) == '.') {
                    $host = substr($rule, 3);
                    if ($host != "") {
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        $find_function_content.="DOMAIN-SUFFIX,".$host.",DIRECT,force-remote-dns \n";
                        continue;
                    }
                }
            }

            // ||开头表示前面还有路径
            if (substr($rule, 0, 2) =='||') {
                //$rule_reg = preg_match("/^((http|https):\/\/)?([^\/]+)/i",substr($rule, 2), $matches);
                $host = substr($rule, 2);
                //preg_match("/[^\.\/]+\.[^\.\/]+$/", $host, $matches);

                if (strpos($host, "*")!==false) {
                    $host = substr($host, strpos($host, "*")+1);
                    if (strpos($host, ".")!==false) {
                        $host = substr($host, strpos($host, ".")+1);
                    }
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;
                    $find_function_content.="DOMAIN-KEYWORD,".$host.",Proxy,force-remote-dns\n";
                    continue;
                }

                if (isset($isget[$host])) {
                    continue;
                }
                $isget[$host]=1;
                $find_function_content.="DOMAIN,".$host.",Proxy,force-remote-dns\n";
            // !开头相当于正则表达式^
            } elseif (substr($rule, 0, 1) == '|') {
                preg_match("/(\d{1,3}\.){3}\d{1,3}/", substr($rule, 1), $matches);

                if (!isset($matches[0])) {
                    continue;
                }

                $host = $matches[0];
                if ($host != "") {
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;
                    $find_function_content.="IP-CIDR,".$host."/32,Proxy,no-resolve \n";
                    continue;
                } else {
                    preg_match_all("~^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?~i", substr($rule, 1), $matches);

                    if (!isset($matches[4][0])) {
                        continue;
                    }

                    $host = $matches[4][0];
                    if (strpos($host, "*")!==false) {
                        $host = substr($host, strpos($host, "*")+1);
                        if (strpos($host, ".")!==false) {
                            $host = substr($host, strpos($host, ".")+1);
                        }
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        $find_function_content.="DOMAIN-KEYWORD,".$host.",Proxy,force-remote-dns\n";
                        continue;
                    }

                    if ($host != "") {
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        $find_function_content.="DOMAIN-SUFFIX,".$host.",Proxy,force-remote-dns\n";
                        continue;
                    }
                }
            } else {
                $host = substr($rule, 0);
                if (strpos($host, "/")!==false) {
                    $host = substr($host, 0, strpos($host, "/"));
                }

                if ($host != "") {
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;
                    $find_function_content.="DOMAIN-KEYWORD,".$host.",PROXY,force-remote-dns \n";
                    continue;
                }
            }


            $count = $count + 1;
        }
        $find_function_content.='
DOMAIN-KEYWORD,google,Proxy,force-remote-dns
IP-CIDR,91.108.4.0/22,Proxy,no-resolve
IP-CIDR,91.108.56.0/22,Proxy,no-resolve
IP-CIDR,109.239.140.0/24,Proxy,no-resolve
IP-CIDR,149.154.160.0/20,Proxy,no-resolve
IP-CIDR,10.0.0.0/8,DIRECT
IP-CIDR,127.0.0.0/8,DIRECT
IP-CIDR,172.16.0.0/12,DIRECT
IP-CIDR,192.168.0.0/16,DIRECT
GEOIP,CN,DIRECT
FINAL,DIRECT
      ';
        $pac_content.=$find_function_content;
        return $pac_content;
    }


    private static function GetSurgeGeo($passwd, $method, $server, $port)
    {
        return '
[General]

skip-proxy = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, localhost, *.local

bypass-tun = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12

dns-server = 119.29.29.29, 223.5.5.5, 114.114.114.114
loglevel = notify



[Proxy]

Proxy = custom,'.$server.','.$port.','.$method.','.$passwd.','.Config::get('baseUrl').'/downloads/SSEncrypt.module



[Rule]

DOMAIN-KEYWORD,adsmogo,REJECT

DOMAIN-SUFFIX,acs86.com,REJECT

DOMAIN-SUFFIX,adcome.cn,REJECT

DOMAIN-SUFFIX,adinfuse.com,REJECT

DOMAIN-SUFFIX,admaster.com.cn,REJECT

DOMAIN-SUFFIX,admob.com,REJECT

DOMAIN-SUFFIX,adsage.cn,REJECT

DOMAIN-SUFFIX,adsage.com,REJECT

DOMAIN-SUFFIX,adsmogo.org,REJECT

DOMAIN-SUFFIX,ads.mobclix.com,REJECT

DOMAIN-SUFFIX,adview.cn,REJECT

DOMAIN-SUFFIX,adwhirl.com,REJECT

DOMAIN-SUFFIX,adwo.com,REJECT

DOMAIN-SUFFIX,appads.com,REJECT

DOMAIN-SUFFIX,domob.cn,REJECT

DOMAIN-SUFFIX,domob.com.cn,REJECT

DOMAIN-SUFFIX,domob.org,REJECT

DOMAIN-SUFFIX,doubleclick.net,REJECT

DOMAIN-SUFFIX,duomeng.cn,REJECT

DOMAIN-SUFFIX,duomeng.net,REJECT

DOMAIN-SUFFIX,duomeng.org,REJECT

DOMAIN-SUFFIX,googeadsserving.cn,REJECT

DOMAIN-SUFFIX,guomob.com,REJECT

DOMAIN-SUFFIX,immob.cn,REJECT

DOMAIN-SUFFIX,inmobi.com,REJECT

DOMAIN-SUFFIX,mobads.baidu.com,REJECT

DOMAIN-SUFFIX,mobads-logs.baidu.com,REJECT

DOMAIN-SUFFIX,smartadserver.com,REJECT

DOMAIN-SUFFIX,tapjoyads.com,REJECT

DOMAIN-SUFFIX,umeng.co,REJECT

DOMAIN-SUFFIX,umeng.com,REJECT

DOMAIN-SUFFIX,umtrack.com,REJECT

DOMAIN-SUFFIX,uyunad.com,REJECT

DOMAIN-SUFFIX,youmi.net,REJECT

GEOIP,AD,Proxy
GEOIP,AE,Proxy
GEOIP,AF,Proxy
GEOIP,AG,Proxy
GEOIP,AI,Proxy
GEOIP,AL,Proxy
GEOIP,AM,Proxy
GEOIP,AO,Proxy
GEOIP,AQ,Proxy
GEOIP,AR,Proxy
GEOIP,AS,Proxy
GEOIP,AS,Proxy
GEOIP,AS,Proxy
GEOIP,AS,Proxy
GEOIP,AT,Proxy
GEOIP,AU,Proxy
GEOIP,AW,Proxy
GEOIP,AX,Proxy
GEOIP,AZ,Proxy
GEOIP,BA,Proxy
GEOIP,BD,Proxy
GEOIP,BE,Proxy
GEOIP,BF,Proxy
GEOIP,BG,Proxy
GEOIP,BH,Proxy
GEOIP,BI,Proxy
GEOIP,BJ,Proxy
GEOIP,BL,Proxy
GEOIP,BM,Proxy
GEOIP,BN,Proxy
GEOIP,BO,Proxy
GEOIP,BQ,Proxy
GEOIP,BR,Proxy
GEOIP,BS,Proxy
GEOIP,BT,Proxy
GEOIP,BW,Proxy
GEOIP,BY,Proxy
GEOIP,BZ,Proxy
GEOIP,CA,Proxy
GEOIP,CC,Proxy
GEOIP,CD,Proxy
GEOIP,CF,Proxy
GEOIP,CG,Proxy
GEOIP,CH,Proxy
GEOIP,CI,Proxy
GEOIP,CK,Proxy
GEOIP,CL,Proxy
GEOIP,CM,Proxy
GEOIP,CO,Proxy
GEOIP,CR,Proxy
GEOIP,CU,Proxy
GEOIP,CV,Proxy
GEOIP,CW,Proxy
GEOIP,CX,Proxy
GEOIP,CY,Proxy
GEOIP,CZ,Proxy
GEOIP,DE,Proxy
GEOIP,DJ,Proxy
GEOIP,DK,Proxy
GEOIP,DM,Proxy
GEOIP,DO,Proxy
GEOIP,DZ,Proxy
GEOIP,EC,Proxy
GEOIP,EE,Proxy
GEOIP,EG,Proxy
GEOIP,EG,Proxy
GEOIP,EH,Proxy
GEOIP,ER,Proxy
GEOIP,ES,Proxy
GEOIP,ET,Proxy
GEOIP,FI,Proxy
GEOIP,FJ,Proxy
GEOIP,FK,Proxy
GEOIP,FM,Proxy
GEOIP,FO,Proxy
GEOIP,FR,Proxy
GEOIP,GA,Proxy
GEOIP,GB,Proxy
GEOIP,GD,Proxy
GEOIP,GE,Proxy
GEOIP,GF,Proxy
GEOIP,GG,Proxy
GEOIP,GH,Proxy
GEOIP,GI,Proxy
GEOIP,GL,Proxy
GEOIP,GM,Proxy
GEOIP,GN,Proxy
GEOIP,GP,Proxy
GEOIP,GQ,Proxy
GEOIP,GR,Proxy
GEOIP,GS,Proxy
GEOIP,GT,Proxy
GEOIP,GU,Proxy
GEOIP,GW,Proxy
GEOIP,GY,Proxy
GEOIP,HK,Proxy
GEOIP,HM,Proxy
GEOIP,HN,Proxy
GEOIP,HR,Proxy
GEOIP,HT,Proxy
GEOIP,HU,Proxy
GEOIP,ID,Proxy
GEOIP,IE,Proxy
GEOIP,IL,Proxy
GEOIP,IM,Proxy
GEOIP,IN,Proxy
GEOIP,IO,Proxy
GEOIP,IQ,Proxy
GEOIP,IR,Proxy
GEOIP,IS,Proxy
GEOIP,IT,Proxy
GEOIP,JE,Proxy
GEOIP,JM,Proxy
GEOIP,JO,Proxy
GEOIP,JP,Proxy
GEOIP,KE,Proxy
GEOIP,KG,Proxy
GEOIP,KH,Proxy
GEOIP,KI,Proxy
GEOIP,KM,Proxy
GEOIP,KN,Proxy
GEOIP,KP,Proxy
GEOIP,KR,Proxy
GEOIP,KW,Proxy
GEOIP,KY,Proxy
GEOIP,KZ,Proxy
GEOIP,LA,Proxy
GEOIP,LB,Proxy
GEOIP,LC,Proxy
GEOIP,LI,Proxy
GEOIP,LK,Proxy
GEOIP,LR,Proxy
GEOIP,LS,Proxy
GEOIP,LT,Proxy
GEOIP,LU,Proxy
GEOIP,LV,Proxy
GEOIP,LY,Proxy
GEOIP,MA,Proxy
GEOIP,MC,Proxy
GEOIP,MD,Proxy
GEOIP,ME,Proxy
GEOIP,MF,Proxy
GEOIP,MG,Proxy
GEOIP,MH,Proxy
GEOIP,MK,Proxy
GEOIP,ML,Proxy
GEOIP,MM,Proxy
GEOIP,MN,Proxy
GEOIP,MO,Proxy
GEOIP,MP,Proxy
GEOIP,MQ,Proxy
GEOIP,MR,Proxy
GEOIP,MS,Proxy
GEOIP,MT,Proxy
GEOIP,MU,Proxy
GEOIP,MV,Proxy
GEOIP,MW,Proxy
GEOIP,MX,Proxy
GEOIP,MY,Proxy
GEOIP,MZ,Proxy
GEOIP,NA,Proxy
GEOIP,NC,Proxy
GEOIP,NE,Proxy
GEOIP,NF,Proxy
GEOIP,NG,Proxy
GEOIP,NI,Proxy
GEOIP,NL,Proxy
GEOIP,NO,Proxy
GEOIP,NP,Proxy
GEOIP,NR,Proxy
GEOIP,NU,Proxy
GEOIP,NZ,Proxy
GEOIP,OM,Proxy
GEOIP,PA,Proxy
GEOIP,PE,Proxy
GEOIP,PF,Proxy
GEOIP,PG,Proxy
GEOIP,PH,Proxy
GEOIP,PK,Proxy
GEOIP,PL,Proxy
GEOIP,PM,Proxy
GEOIP,PN,Proxy
GEOIP,PR,Proxy
GEOIP,PS,Proxy
GEOIP,PT,Proxy
GEOIP,PW,Proxy
GEOIP,PY,Proxy
GEOIP,QA,Proxy
GEOIP,RE,Proxy
GEOIP,RO,Proxy
GEOIP,RS,Proxy
GEOIP,RU,Proxy
GEOIP,RW,Proxy
GEOIP,SA,Proxy
GEOIP,SB,Proxy
GEOIP,SC,Proxy
GEOIP,SD,Proxy
GEOIP,SE,Proxy
GEOIP,SG,Proxy
GEOIP,SH,Proxy
GEOIP,SI,Proxy
GEOIP,SJ,Proxy
GEOIP,SK,Proxy
GEOIP,SL,Proxy
GEOIP,SM,Proxy
GEOIP,SN,Proxy
GEOIP,SO,Proxy
GEOIP,SR,Proxy
GEOIP,SS,Proxy
GEOIP,ST,Proxy
GEOIP,SV,Proxy
GEOIP,SX,Proxy
GEOIP,SY,Proxy
GEOIP,SZ,Proxy
GEOIP,TC,Proxy
GEOIP,TD,Proxy
GEOIP,TF,Proxy
GEOIP,TG,Proxy
GEOIP,TH,Proxy
GEOIP,TJ,Proxy
GEOIP,TK,Proxy
GEOIP,TL,Proxy
GEOIP,TM,Proxy
GEOIP,TN,Proxy
GEOIP,TO,Proxy
GEOIP,TR,Proxy
GEOIP,TT,Proxy
GEOIP,TV,Proxy
GEOIP,TW,Proxy
GEOIP,TZ,Proxy
GEOIP,UA,Proxy
GEOIP,UG,Proxy
GEOIP,UM,Proxy
GEOIP,US,Proxy
GEOIP,UY,Proxy
GEOIP,UZ,Proxy
GEOIP,VA,Proxy
GEOIP,VC,Proxy
GEOIP,VE,Proxy
GEOIP,VG,Proxy
GEOIP,VI,Proxy
GEOIP,VN,Proxy
GEOIP,VU,Proxy
GEOIP,WF,Proxy
GEOIP,WS,Proxy
GEOIP,YE,Proxy
GEOIP,YT,Proxy
GEOIP,ZA,Proxy
GEOIP,ZM,Proxy
GEOIP,ZW,Proxy
IP-CIDR,91.108.4.0/22,Proxy,no-resolve

IP-CIDR,91.108.56.0/22,Proxy,no-resolve

IP-CIDR,109.239.140.0/24,Proxy,no-resolve

IP-CIDR,149.154.160.0/20,Proxy,no-resolve

IP-CIDR,10.0.0.0/8,DIRECT

IP-CIDR,127.0.0.0/8,DIRECT

IP-CIDR,172.16.0.0/12,DIRECT

IP-CIDR,192.168.0.0/16,DIRECT

GEOIP,CN,DIRECT

FINAL,Proxy';
    }

    private static function GetApn($apn, $server, $port)
    {
        return '
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>PayloadContent</key>
            <array>
                <dict>
                    <key>PayloadContent</key>
                    <array>
                        <dict>
                            <key>DefaultsData</key>
                            <dict>
                                <key>apns</key>
                                <array>
                                    <dict>
                                        <key>apn</key>
                                        <string>'.$apn.'</string>
                                        <key>proxy</key>
                                        <string>'.$server.'</string>
                                        <key>proxyPort</key>
                                        <integer>'.$port.'</integer>
                                    </dict>
                                </array>
                            </dict>
                            <key>DefaultsDomainName</key>
                            <string>com.apple.managedCarrier</string>
                        </dict>
                    </array>
                    <key>PayloadDescription</key>
                    <string>提供对营运商“接入点名称”的自定义。</string>
                    <key>PayloadDisplayName</key>
                    <string>APN</string>
                    <key>PayloadIdentifier</key>
                    <string>com.tony.APNUNI'.$server.'.</string>
                    <key>PayloadOrganization</key>
                    <string>Tony</string>
                    <key>PayloadType</key>
                    <string>com.apple.apn.managed</string>
                    <key>PayloadUUID</key>
                    <string>7AC1FC00-7670-41CA-9EE1-4A5882DBD'.rand(100, 999).'D</string>
                    <key>PayloadVersion</key>
                    <integer>1</integer>
                </dict>
            </array>
            <key>PayloadDescription</key>
            <string>APN配置文件</string>
            <key>PayloadDisplayName</key>
            <string>APN快速配置 - '.$server.' ('.$apn.')</string>
            <key>PayloadIdentifier</key>
            <string>com.tony.APNUNI'.$server.'</string>
            <key>PayloadOrganization</key>
            <string>Tony</string>
            <key>PayloadRemovalDisallowed</key>
            <false/>
            <key>PayloadType</key>
            <string>Configuration</string>
            <key>PayloadUUID</key>
            <string>4C355D66-E72E-4DC8-864F-62C416015'.rand(100, 999).'D</string>
            <key>PayloadVersion</key>
            <integer>1</integer>
        </dict>
        </plist>
        ';
    }


    private static function GetPac($type, $address, $port, $defined)
    {
        header('Content-type: application/x-ns-proxy-autoconfig; charset=utf-8');
        return LinkController::get_pac($type, $address, $port, true, $defined);
    }

    private static function GetMacPac()
    {
        header('Content-type: application/x-ns-proxy-autoconfig; charset=utf-8');
        return LinkController::get_mac_pac();
    }


    private static function GetAcl($user)
    {
        $rulelist = base64_decode(file_get_contents("https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"))."\n".$user->pac;
        $gfwlist = explode("\n", $rulelist);

        $count = 0;
        $acl_content = '';
        $find_function_content = '
#Generated by sspanel-glzjin-mod v3
#Time:'.date('Y-m-d H:i:s').'

[bypass_all]

';

        $proxy_list = '[proxy_list]

';
        $bypass_list = '[bypass_list]

';
        $outbound_block_list = '[outbound_block_list]

';

        $isget=array();
        foreach ($gfwlist as $index=>$rule) {
            if (empty($rule)) {
                continue;
            } elseif (substr($rule, 0, 1) == '!' || substr($rule, 0, 1) == '[') {
                continue;
            }

            if (substr($rule, 0, 2) == '@@') {
                // ||开头表示前面还有路径
                if (substr($rule, 2, 2) =='||') {
                    //$rule_reg = preg_match("/^((http|https):\/\/)?([^\/]+)/i",substr($rule, 2), $matches);
                    $host = substr($rule, 4);
                    //preg_match("/[^\.\/]+\.[^\.\/]+$/", $host, $matches);
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;
                    //$find_function_content.="DOMAIN,".$host.",DIRECT,force-remote-dns\n";
                    $bypass_list .= $host."\n";
                    continue;
                // !开头相当于正则表达式^
                } elseif (substr($rule, 2, 1) == '|') {
                    preg_match("/(\d{1,3}\.){3}\d{1,3}/", substr($rule, 3), $matches);
                    if (!isset($matches[0])) {
                        continue;
                    }

                    $host = $matches[0];
                    if ($host != "") {
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        //$find_function_content.="IP-CIDR,".$host."/32,DIRECT,no-resolve \n";
                        $bypass_list .= $host."/32\n";
                        continue;
                    } else {
                        preg_match_all("~^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?~i", substr($rule, 3), $matches);

                        if (!isset($matches[4][0])) {
                            continue;
                        }

                        $host = $matches[4][0];
                        if ($host != "") {
                            if (isset($isget[$host])) {
                                continue;
                            }
                            $isget[$host]=1;
                            //$find_function_content.="DOMAIN-SUFFIX,".$host.",DIRECT,force-remote-dns\n";
                            $bypass_list .= $host."\n";
                            continue;
                        }
                    }
                } elseif (substr($rule, 2, 1) == '.') {
                    $host = substr($rule, 3);
                    if ($host != "") {
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        //$find_function_content.="DOMAIN-SUFFIX,".$host.",DIRECT,force-remote-dns \n";
                        $bypass_list .= $host."\n";
                        continue;
                    }
                }
            }

            // ||开头表示前面还有路径
            if (substr($rule, 0, 2) =='||') {
                //$rule_reg = preg_match("/^((http|https):\/\/)?([^\/]+)/i",substr($rule, 2), $matches);
                $host = substr($rule, 2);
                //preg_match("/[^\.\/]+\.[^\.\/]+$/", $host, $matches);

                if (strpos($host, "*")!==false) {
                    $host = substr($host, strpos($host, "*")+1);
                    if (strpos($host, ".")!==false) {
                        $host = substr($host, strpos($host, ".")+1);
                    }
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;
                    //$find_function_content.="DOMAIN-KEYWORD,".$host.",Proxy,force-remote-dns\n";
                    $proxy_list .= $host."\n";
                    continue;
                }

                if (isset($isget[$host])) {
                    continue;
                }
                $isget[$host]=1;
                //$find_function_content.="DOMAIN,".$host.",Proxy,force-remote-dns\n";
                $proxy_list .= $host."\n";
            // !开头相当于正则表达式^
            } elseif (substr($rule, 0, 1) == '|') {
                preg_match("/(\d{1,3}\.){3}\d{1,3}/", substr($rule, 1), $matches);

                if (!isset($matches[0])) {
                    continue;
                }

                $host = $matches[0];
                if ($host != "") {
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;

                    preg_match("/(\d{1,3}\.){3}\d{1,3}\/\d{1,2}/", substr($rule, 1), $matches_ips);

                    if (!isset($matches_ips[0])) {
                        $proxy_list .= $host."/32\n";
                    } else {
                        $host = $matches_ips[0];
                        $proxy_list .= $host."\n";
                    }

                    //$find_function_content.="IP-CIDR,".$host."/32,Proxy,no-resolve \n";

                    continue;
                } else {
                    preg_match_all("~^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?~i", substr($rule, 1), $matches);

                    if (!isset($matches[4][0])) {
                        continue;
                    }

                    $host = $matches[4][0];
                    if (strpos($host, "*")!==false) {
                        $host = substr($host, strpos($host, "*")+1);
                        if (strpos($host, ".")!==false) {
                            $host = substr($host, strpos($host, ".")+1);
                        }
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        //$find_function_content.="DOMAIN-KEYWORD,".$host.",Proxy,force-remote-dns\n";
                        $proxy_list .= $host."\n";
                        continue;
                    }

                    if ($host != "") {
                        if (isset($isget[$host])) {
                            continue;
                        }
                        $isget[$host]=1;
                        //$find_function_content.="DOMAIN-SUFFIX,".$host.",Proxy,force-remote-dns\n";
                        $proxy_list .= $host."\n";
                        continue;
                    }
                }
            } else {
                $host = substr($rule, 0);
                if (strpos($host, "/")!==false) {
                    $host = substr($host, 0, strpos($host, "/"));
                }

                if ($host != "") {
                    if (isset($isget[$host])) {
                        continue;
                    }
                    $isget[$host]=1;
                    //$find_function_content.="DOMAIN-KEYWORD,".$host.",PROXY,force-remote-dns \n";
                    $proxy_list .= $host."\n";
                    continue;
                }
            }


            $count = $count + 1;
        }

        $acl_content .= $find_function_content."\n".$proxy_list."\n".$bypass_list."\n".$outbound_block_list;
        return $acl_content;
    }



    /**
     * This is a php implementation of autoproxy2pac
     */
    private static function reg_encode($str)
    {
        $tmp_str = $str;
        $tmp_str = str_replace('/', "\\/", $tmp_str);
        $tmp_str = str_replace('.', "\\.", $tmp_str);
        $tmp_str = str_replace(':', "\\:", $tmp_str);
        $tmp_str = str_replace('%', "\\%", $tmp_str);
        $tmp_str = str_replace('*', ".*", $tmp_str);
        $tmp_str = str_replace('-', "\\-", $tmp_str);
        $tmp_str = str_replace('&', "\\&", $tmp_str);
        $tmp_str = str_replace('?', "\\?", $tmp_str);
        $tmp_str = str_replace('+', "\\+", $tmp_str);

        return $tmp_str;
    }

    private static function get_pac($proxy_type, $proxy_host, $proxy_port, $proxy_google, $defined)
    {
        $rulelist = base64_decode(file_get_contents("https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"))."\n".$defined;
        $gfwlist = explode("\n", $rulelist);
        if ($proxy_google == "true") {
            $gfwlist[] = ".google.com";
        }

        $count = 0;
        $pac_content = '';
        $find_function_content = 'function FindProxyForURL(url, host) { var PROXY = "'.$proxy_type.' '.$proxy_host.':'.$proxy_port.'; DIRECT"; var DEFAULT = "DIRECT";'."\n";
        foreach ($gfwlist as $index=>$rule) {
            if (empty($rule)) {
                continue;
            } elseif (substr($rule, 0, 1) == '!' || substr($rule, 0, 1) == '[') {
                continue;
            }
            $return_proxy = 'PROXY';
        // @@开头表示默认是直接访问
        if (substr($rule, 0, 2) == '@@') {
            $rule = substr($rule, 2);
            $return_proxy = "DEFAULT";
        }

        // ||开头表示前面还有路径
        if (substr($rule, 0, 2) =='||') {
            $rule_reg = "^[\\w\\-]+:\\/+(?!\\/)(?:[^\\/]+\\.)?".LinkController::reg_encode(substr($rule, 2));
        // !开头相当于正则表达式^
        } elseif (substr($rule, 0, 1) == '|') {
            $rule_reg = "^" . LinkController::reg_encode(substr($rule, 1));
        // 前后匹配的/表示精确匹配
        } elseif (substr($rule, 0, 1) == '/' && substr($rule, -1) == '/') {
            $rule_reg = substr($rule, 1, strlen($rule) - 2);
        } else {
            $rule_reg = LinkController::reg_encode($rule);
        }
        // 以|结尾，替换为$结尾
        if (preg_match("/\|$/i", $rule_reg)) {
            $rule_reg = substr($rule_reg, 0, strlen($rule_reg) - 1)."$";
        }
            $find_function_content.='if (/' . $rule_reg . '/i.test(url)) return '.$return_proxy.';'."\n";
            $count = $count + 1;
        }
        $find_function_content.='return DEFAULT;'."}";
        $pac_content.=$find_function_content;
        return $pac_content;
    }


    private static function get_mac_pac()
    {
        $rulelist = base64_decode(file_get_contents("https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"));
        $gfwlist = explode("\n", $rulelist);
        $gfwlist[] = ".google.com";

        $count = 0;
        $pac_content = '';
        $find_function_content = 'function FindProxyForURL(url, host) { var PROXY = "SOCKS5 127.0.0.1:1080; SOCKS 127.0.0.1:1080; DIRECT;"; var DEFAULT = "DIRECT";'."\n";
        foreach ($gfwlist as $index=>$rule) {
            if (empty($rule)) {
                continue;
            } elseif (substr($rule, 0, 1) == '!' || substr($rule, 0, 1) == '[') {
                continue;
            }
            $return_proxy = 'PROXY';
        // @@开头表示默认是直接访问
        if (substr($rule, 0, 2) == '@@') {
            $rule = substr($rule, 2);
            $return_proxy = "DEFAULT";
        }

        // ||开头表示前面还有路径
        if (substr($rule, 0, 2) =='||') {
            $rule_reg = "^[\\w\\-]+:\\/+(?!\\/)(?:[^\\/]+\\.)?".LinkController::reg_encode(substr($rule, 2));
        // !开头相当于正则表达式^
        } elseif (substr($rule, 0, 1) == '|') {
            $rule_reg = "^" . LinkController::reg_encode(substr($rule, 1));
        // 前后匹配的/表示精确匹配
        } elseif (substr($rule, 0, 1) == '/' && substr($rule, -1) == '/') {
            $rule_reg = substr($rule, 1, strlen($rule) - 2);
        } else {
            $rule_reg = LinkController::reg_encode($rule);
        }
        // 以|结尾，替换为$结尾
        if (preg_match("/\|$/i", $rule_reg)) {
            $rule_reg = substr($rule_reg, 0, strlen($rule_reg) - 1)."$";
        }
            $find_function_content.='if (/' . $rule_reg . '/i.test(url)) return '.$return_proxy.';'."\n";
            $count = $count + 1;
        }
        $find_function_content.='return DEFAULT;'."}";
        $pac_content.=$find_function_content;
        return $pac_content;
    }

    public static function GetRouter($user, $is_mu = 0, $is_ss = 0)
    {
        $bash = '#!/bin/sh'."\n";
        $bash .= 'export PATH=\'/opt/usr/sbin:/opt/usr/bin:/opt/sbin:/opt/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin\''."\n";
        $bash .= 'export LD_LIBRARY_PATH=/lib:/opt/lib'."\n";
        $bash .= 'nvram set ss_type='.($is_ss == 1 ? '0' : '1')."\n";

        $count = 0;

        $items = URL::getAllItems($user, $is_mu, $is_ss);
        foreach($items as $item) {
            if($is_ss == 0) {
                $bash .= 'nvram set rt_ss_name_x'.$count.'="'.$item['remark']."\"\n";
                $bash .= 'nvram set rt_ss_port_x'.$count.'='.$item['port']."\n";
                $bash .= 'nvram set rt_ss_password_x'.$count.'="'.$item['passwd']."\"\n";
                $bash .= 'nvram set rt_ss_server_x'.$count.'='.$item['address']."\n";
                $bash .= 'nvram set rt_ss_usage_x'.$count.'="'."-o ".$item['obfs']." -g ".$item['obfs_param']." -O ".$item['protocol']." -G ".$item['protocol_param']."\"\n";
                $bash .= 'nvram set rt_ss_method_x'.$count.'='.$item['method']."\n";
                $count += 1;
            } else {
                $bash .= 'nvram set rt_ss_name_x'.$count.'="'.$item['remark']."\"\n";
                $bash .= 'nvram set rt_ss_port_x'.$count.'='.$item['port']."\n";
                $bash .= 'nvram set rt_ss_password_x'.$count.'="'.$item['passwd']."\"\n";
                $bash .= 'nvram set rt_ss_server_x'.$count.'='.$item['address']."\n";
                $bash .= 'nvram set rt_ss_usage_x'.$count.'=""'."\n";
                $bash .= 'nvram set rt_ss_method_x'.$count.'='.$item['method']."\n";
                $count += 1;
            }
        }

        $bash .= "nvram set rt_ssnum_x=".$count."\n";

        return $bash;
    }

    public static function GetSSRSub($user, $mu = 0, $max = 0)
    {
        if ($mu == 0 || $mu == 1) {
            return Tools::base64_url_encode(URL::getAllUrl($user, $mu, 0, 1));
        } 
        elseif ($mu == 2){
            return Tools::base64_url_encode(URL::getAllVMessUrl($user));
        }
        elseif ($mu == 3) {
            return Tools::base64_url_encode(URL::getAllSSDUrl($user));
        }
        elseif ($mu == 4) {
            return base64_encode(URL::getAllUrl($user, 0, 1, 1));
        }
    }
}