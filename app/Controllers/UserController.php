<?php

namespace App\Controllers;

use App\Services\Auth;
use App\Models\Node;
use App\Models\TrafficLog;
use App\Models\InviteCode;
use App\Models\CheckInLog;
use App\Models\Ann;
use App\Models\Speedtest;
use App\Models\Shop;
use App\Models\Coupon;
use App\Models\Bought;
use App\Models\Ticket;
use App\Models\EmailVerify;
use App\Services\Config;
use App\Utils\Hash;
use App\Utils\Tools;
use App\Utils\Radius;
use App\Utils\Wecenter;
use App\Utils\Check;
use App\Models\RadiusBan;
use App\Models\DetectLog;
use App\Models\DetectRule;

use voku\helper\AntiXSS;

use App\Models\User;
use App\Models\Code;
use App\Models\Ip;
use App\Models\Paylist;
use App\Models\LoginIp;
use App\Models\BlockIp;
use App\Models\UnblockIp;
use App\Models\Payback;
use App\Models\Relay;
use App\Utils\QQWry;
use App\Utils\GA;
use App\Utils\Geetest;
use App\Utils\Telegram;
use App\Utils\TelegramSessionManager;
use App\Utils\Pay;
use App\Utils\URL;
use App\Services\Mail;

/**
 *  HomeController
 */
class UserController extends BaseController
{
    private $user;

    public function __construct()
    {
        $this->user = Auth::getUser();
    }

    public function index($request, $response, $args)
    {

        $user = $this->user;

        $ios_token = LinkController::GenerateIosCode("smart", 0, $this->user->id, 0, "smart");

        $acl_token = LinkController::GenerateAclCode("smart", 0, $this->user->id, 0, "smart");

        $router_token = LinkController::GenerateRouterCode($this->user->id, 0);
        $router_token_without_mu = LinkController::GenerateRouterCode($this->user->id, 1);

        $ssr_sub_token = LinkController::GenerateSSRSubCode($this->user->id, 0);

        $ss_url_0 = urlencode(Config::get('apiUrl').'/link/'.$ios_token.'?is_ss=1&is_mu=0');
        $ss_url_1 = urlencode(Config::get('apiUrl').'/link/'.$ios_token.'?is_ss=1&is_mu=1');
        $ss_url_0_mitm = urlencode(Config::get('apiUrl').'/link/'.$ios_token.'?is_ss=1&is_mu=0&mitm=1');
        $ss_url_1_mitm = urlencode(Config::get('apiUrl').'/link/'.$ios_token.'?is_ss=1&is_mu=1&mitm=1');
        $ss_url_0_mitm_new = urlencode(Config::get('apiUrl').'/link/'.$ios_token.'?is_ss=1&is_mu=0&mitm=1&new=1');
        $ss_url_1_mitm_new = urlencode(Config::get('apiUrl').'/link/'.$ios_token.'?is_ss=1&is_mu=1&mitm=1&new=1');

        $ssr_url_0 = Tools::base64_url_encode(Config::get('apiUrl').'/link/'.$ssr_sub_token.'?mu=0');
        $ssr_url_1 = Tools::base64_url_encode(Config::get('apiUrl').'/link/'.$ssr_sub_token.'?mu=1');

        $v2_url = Tools::base64_url_encode(Config::get('apiUrl').'/link/'.$ssr_sub_token.'?mu=2');
        $v2_url_x = Tools::base64_url_encode('https://tgbot.lbyczf.com/v2rayN2quan?group=Dler%20Cloud%20-%20[V2Ray]&url='.Config::get('apiUrl').'/link/'.$ssr_sub_token.'?mu=2');

        $filterUrl = Tools::base64_url_encode('https://raw.githubusercontent.com/lhie1/Rules/master/Quantumult/Quantumult.conf');
        $rejectUrl = Tools::base64_url_encode('https://raw.githubusercontent.com/lhie1/Rules/master/Quantumult/Quantumult_URL.conf');


        $uid = time() . rand(1, 10000);
        if (Config::get('enable_geetest_checkin') == 'true') {
            $GtSdk = Geetest::get($uid);
        } else {
            $GtSdk = null;
        }

        $Ann = Ann::orderBy('date', 'desc')->first();



        return $this->view()
        ->assign("ss_url_0", $ss_url_0)
        ->assign("ss_url_1", $ss_url_1)
        ->assign("ss_url_0_mitm", $ss_url_0_mitm)
        ->assign("ss_url_1_mitm", $ss_url_1_mitm)
        ->assign("ss_url_0_mitm_new", $ss_url_0_mitm_new)
        ->assign("ss_url_1_mitm_new", $ss_url_1_mitm_new)
        ->assign("ssr_url_0", $ssr_url_0)
        ->assign("ssr_url_1", $ssr_url_1)
        ->assign("v2_url", $v2_url)
        ->assign("v2_url_x", $v2_url_x)
        ->assign("filterUrl", $filterUrl)
        ->assign("rejectUrl", $rejectUrl)
        
        ->assign("ssr_sub_token", $ssr_sub_token)

        ->assign("router_token", $router_token)
        ->assign("router_token_without_mu", $router_token_without_mu)
        ->assign("acl_token", $acl_token)
        ->assign('ann', $Ann)
        ->assign('geetest_html', $GtSdk)
        ->assign("ios_token", $ios_token)
        ->assign('enable_duoshuo', Config::get('enable_duoshuo'))
        ->assign('duoshuo_shortname', Config::get('duoshuo_shortname'))
        ->assign("user", $this->user)->registerClass("URL", "App\Utils\URL")
        ->assign('apiUrl', Config::get('apiUrl'))->display('user/index.tpl');
    }



    public function lookingglass($request, $response, $args)
    {
        $Speedtest = Speedtest::where("datetime", ">", time()-Config::get('Speedtest_duration') * 3600)->orderBy('datetime', 'desc')->get();

        return $this->view()->assign('speedtest', $Speedtest)->assign('hour', Config::get('Speedtest_duration'))->display('user/lookingglass.tpl');
    }


    public function code($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $codes = Code::where('type', '<>', '-2')->where('userid', '=', $this->user->id)->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $codes->setPath('/user/code');
        return $this->view()->assign('codes', $codes)->assign('pmw', Pay::getHTML($this->user))->display('user/code.tpl');
    }


    public function donate($request, $response, $args)
    {
        if (Config::get('enable_donate') != 'true') {
            exit(0);
        }

        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $codes = Code::where(
            function ($query) {
                $query->where("type", "=", -1)
                    ->orWhere("type", "=", -2);
            }
        )->where("isused", 1)->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $codes->setPath('/user/donate');
        return $this->view()->assign('codes', $codes)->assign('total_in', Code::where('isused', 1)->where('type', -1)->sum('number'))->assign('total_out', Code::where('isused', 1)->where('type', -2)->sum('number'))->display('user/donate.tpl');
    }


    public function code_check($request, $response, $args)
    {
        $time = $request->getQueryParams()["time"];
        $codes = Code::where('userid', '=', $this->user->id)->where('usedatetime', '>', date('Y-m-d H:i:s', $time))->first();
        if ($codes!=null && strpos($codes->code, "充值") !== false) {
            $res['ret'] = 1;
            return $response->getBody()->write(json_encode($res));
        } else {
            $res['ret'] = 0;
            return $response->getBody()->write(json_encode($res));
        }
    }


    public function alipay($request, $response, $args)
    {
        $amount = $request->getQueryParams()["amount"];
        Pay::getGen($this->user, $amount);
    }


    public function codepost($request, $response, $args)
    {
        $code = $request->getParam('code');
        $code = trim($code);
        $user = $this->user;



        if ($code == "") {
            $res['ret'] = 0;
            $res['msg'] = "请填好充值码";
            return $response->getBody()->write(json_encode($res));
        }

        $codeq=Code::where("code", "=", $code)->where("isused", "=", 0)->first();
        if ($codeq == null) {
            $res['ret'] = 0;
            $res['msg'] = "此充值码错误";
            return $response->getBody()->write(json_encode($res));
        }

        $codeq->isused=1;
        $codeq->usedatetime=date("Y-m-d H:i:s");
        $codeq->userid=$user->id;
        $codeq->save();

        if ($codeq->type==-1) {
            $user->money=($user->money+$codeq->number);
            $user->save();

            if ($user->ref_by!=""&&$user->ref_by!=0&&$user->ref_by!=null) {
                $gift_user=User::where("id", "=", $user->ref_by)->first();
                $gift_user->money=($gift_user->money+($codeq->number*(Config::get('code_payback')/100)));
                $gift_user->save();

                $Payback=new Payback();
                $Payback->total=$codeq->number;
                $Payback->userid=$this->user->id;
                $Payback->ref_by=$this->user->ref_by;
                $Payback->ref_get=$codeq->number*(Config::get('code_payback')/100);
                $Payback->datetime=time();
                $Payback->save();
            }

            $res['ret'] = 1;
            $res['msg'] = "充值成功，充值的金额为".$codeq->number."元。";

            if (Config::get('enable_donate') == 'true') {
                if ($this->user->is_hide == 1) {
                    Telegram::Send("姐姐姐姐，一位不愿透露姓名的大老爷给我们捐了 ".$codeq->number." 元呢~");
                } else {
                    Telegram::Send("姐姐姐姐，".$this->user->user_name." 大老爷给我们捐了 ".$codeq->number." 元呢~");
                }
            }

            return $response->getBody()->write(json_encode($res));
        }

        if ($codeq->type==10001) {
            $user->transfer_enable=$user->transfer_enable+$codeq->number*1024*1024*1024;
            $user->save();
        }

        if ($codeq->type==10002) {
            if (time()>strtotime($user->expire_in)) {
                $user->expire_in=date("Y-m-d H:i:s", time()+$codeq->number*86400);
            } else {
                $user->expire_in=date("Y-m-d H:i:s", strtotime($user->expire_in)+$codeq->number*86400);
            }
            $user->save();
        }

        if ($codeq->type>=1&&$codeq->type<=10000) {
            if ($user->class==0||$user->class!=$codeq->type) {
                $user->class_expire=date("Y-m-d H:i:s", time());
                $user->save();
            }
            $user->class_expire=date("Y-m-d H:i:s", strtotime($user->class_expire)+$codeq->number*86400);
            $user->class=$codeq->type;
            $user->save();
        }
    }




    public function GaCheck($request, $response, $args)
    {
        $code = $request->getParam('code');
        $user = $this->user;



        if ($code == "") {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        $ga = new GA();
        $rcode = $ga->verifyCode($user->ga_token, $code);
        if (!$rcode) {
            $res['ret'] = 0;
            $res['msg'] = "测试错误";
            return $response->getBody()->write(json_encode($res));
        }


        $res['ret'] = 1;
        $res['msg'] = "测试成功";
        return $response->getBody()->write(json_encode($res));
    }


    public function GaSet($request, $response, $args)
    {
        $enable = $request->getParam('enable');
        $user = $this->user;



        if ($enable == "") {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        $user->ga_enable=$enable;
        $user->save();


        $res['ret'] = 1;
        $res['msg'] = "设置成功";
        return $response->getBody()->write(json_encode($res));
    }

    public function ResetPort($request, $response, $args)
    {
        $user = $this->user;

        $origin_port = $user->port;

        $user->port = Tools::getAvPort();
        $user->save();

        $relay_rules = Relay::where('user_id', $user->id)->where('port', $origin_port)->get();
        foreach ($relay_rules as $rule) {
            $rule->port = $user->port;
            $rule->save();
        }


        $res['ret'] = 1;
        $res['msg'] = $user->port;
        return $response->getBody()->write(json_encode($res));
    }

    public function GaReset($request, $response, $args)
    {
        $user = $this->user;
        $ga = new GA();
        $secret = $ga->createSecret();

        $user->ga_token = $secret;
        $user->save();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/user/edit');
        return $newResponse;
    }


    public function nodeAjax($request, $response, $args)
    {
        $id = $args['id'];
        $point_node = Node::find($id);
        $prefix = explode(" - ", $point_node->name);
        return $this->view()
        ->assign('point_node', $point_node)
        ->assign('prefix', $prefix[0])
        ->assign('id', $id)
        ->display('user/nodeajax.tpl');
    }


    public function node($request, $response, $args)
    {
        $user = Auth::getUser();
        if ($user->is_admin) {
            $nodes = Node::where('type', 1)->orderBy('name')->get();
        } else {
            $nodes = Node::where(
                function ($query) {
                    $query->Where("node_group", "=", $this->user->node_group)
                        ->orWhere("node_group", "=", 0);
                }
            )->where('type', 1)->orderBy('name')->get();
        }

        $relay_rules = Relay::where('user_id', $this->user->id)->orwhere('user_id', 0)->orderBy('id', 'asc')->get();

        if (!Tools::is_protocol_relay($user)) {
            $relay_rules = array();
        }

        $node_method = array();
        $a = 0;
        $node_order = array();
        $node_alive = array();
        $node_prealive = array();
        $node_heartbeat = array();
        $node_bandwidth = array();
        $node_muport = array();
        $node_classes = array();
        $node_latestload = array();

        array_push($node_classes, array('level' => 1, "isV2Ray" => 0, 'desc' => "SS/SSR - Basis", 'nodes' => array(), 'style' => "card-heading-Basis_node", 'access' => 0));
        array_push($node_classes, array('level' => 2, "isV2Ray" => 0, 'desc' => "SS/SSR - Advanced", 'nodes' => array(), 'style' => "card-heading-Advanced_node", 'access' => 0));
        array_push($node_classes, array('level' => 1, "isV2Ray" => 1, 'desc' => "V2Ray - Beta", 'nodes' => array(), 'style' => "card-heading-Basis_node", 'access' => 0));

        if ($user->is_admin) {
            $ports_count = Node::where('type', 1)->where('sort', 9)->orderBy('name')->count();
        } else {
            $ports_count = Node::where(
                function ($query) use ($user) {
                    $query->Where("node_group", "=", $user->node_group)
                        ->orWhere("node_group", "=", 0);
                }
            )->where('type', 1)->where('sort', 9)->where("node_class", "<=", $user->class)->orderBy('name')->count();
        }

        $ports_count += 1;

        foreach ($node_classes as &$single_classes) {
            if ($user->class >= $single_classes["level"]) {
                $single_classes["access"]=1;
            }


          $node_prefix = array();
          foreach ($nodes as $node) {
              if (($node->node_class == $single_classes['level']) && ((($user->node_group == $node->node_group || $node->node_group == 0)) || $user->is_admin) && (!$node->isNodeTrafficOut())) {
				  
				  if ($node->sort == 11 && $single_classes['isV2Ray'] == 0)
					  continue;
				  
				  if ($node->sort != 11 && $single_classes['isV2Ray'] == 1)
					  continue;
				  
                  if ($node->sort == 9 && $single_classes['isV2Ray'] == 0) {
                      $mu_user = User::where('port', '=', $node->server)->first();
                      $mu_user->obfs_param = $this->user->getMuMd5();
                      array_push($node_muport, array('server' => $node,'user' => $mu_user));
                      continue;
                  }

                  $temp = explode(" | ", $node->name);
                  if (!isset($node_prefix[$temp[0]])) {
                      $node_prefix[$temp[0]] = array();
                      $node_order[$temp[0]] = $a;
                      $node_alive[$temp[0]] = 0;

                      if (isset($temp[1])) {
                          $node_method[$temp[0]] = $temp[1];
                      } else {
                          $node_method[$temp[0]] = "";
                      }

                      $a++;
                  }


                  if ($node->sort == 0||$node->sort == 7 || $node->sort == 8 || $node->sort == 10 || $node->sort == 11) {
                      $node_tempalive = $node->getOnlineUserCount();
                      $node_prealive[$node->id] = $node_tempalive;
                      if ($node->isNodeOnline() !== null) {
                          if ($node->isNodeOnline() === false) {
                              $node_heartbeat[$temp[0]] = "离线";
                          } else {
                              $node_heartbeat[$temp[0]] = "在线";
                          }
                      } else {
                          $node_heartbeat[$temp[0]]="暂无数据";
                      }

                      if ($node->node_bandwidth_limit==0) {
                          $node_bandwidth[$temp[0]]=(int)($node->node_bandwidth / 1024 / 1024 / 1024)." GB / ∞";
                      } else {
                          $node_bandwidth[$temp[0]]=(int)($node->node_bandwidth / 1024 / 1024 / 1024)." GB / ".(int)($node->node_bandwidth_limit / 1024 / 1024 / 1024)." GB";
                      }

                      if ($node_tempalive != "暂无数据") {
                          $node_alive[$temp[0]] = $node_alive[$temp[0]]+$node_tempalive;
                      }
                  } else {
                      $node_prealive[$node->id] = "暂无数据";
                      if (!isset($node_heartbeat[$temp[0]])) {
                          $node_heartbeat[$temp[0]] = "暂无数据";
                      }
                  }

                  if (isset($temp[1])) {
                      if (strpos($node_method[$temp[0]], $temp[1]) === false) {
                          $node_method[$temp[0]] = $node_method[$temp[0]]." ".$temp[1];
                      }
                  }
                  array_push($node_prefix[$temp[0]], $node);
               }
            }

            $single_classes["nodes"]=$node_prefix;
        }
        $node_classes = (object)$node_classes;
        $node_order = (object)$node_order;
        $tools = new Tools();
        return $this->view()
        ->assign('relay_rules', $relay_rules)
        ->assign('tools', $tools)
        ->assign('node_method', $node_method)
        ->assign('node_muport', $node_muport)
        ->assign('node_bandwidth', $node_bandwidth)
        ->assign('node_heartbeat', $node_heartbeat)
        ->assign('node_classes', $node_classes)
        ->assign('node_prefix', $node_prefix)
        ->assign('node_prealive', $node_prealive)
        ->assign('node_order', $node_order)
        ->assign('user', $user)
        ->assign('node_alive', $node_alive)
        ->assign('node_latestload', $node_latestload)
        ->registerClass("URL", "App\Utils\URL")
        ->display('user/node.tpl');
    }


    public function nodeInfo($request, $response, $args)
    {
        $user = Auth::getUser();
        $id = $args['id'];
        $mu = $request->getQueryParams()["ismu"];
        $relay_rule_id = $request->getQueryParams()["relay_rule"];
        $node = Node::find($id);

        if ($node == null) {
            return null;
        }


        switch ($node->sort) {

            case 0:
                if ((($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0))||$user->is_admin)&&($node->node_bandwidth_limit==0||$node->node_bandwidth<$node->node_bandwidth_limit)) {
                    return $this->view()
                    ->assign('node', $node)
                    ->assign('user', $user)
                    ->assign('mu', $mu)
                    ->assign('relay_rule_id', $relay_rule_id)->registerClass("URL", "App\Utils\URL")->display('user/nodeinfo.tpl');
                }
            break;

            case 1:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);
                    $json_show="VPN 信息<br>地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfovpn.tpl');
                }
            break;

            case 2:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);
                    $json_show="SSH 信息<br>地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfossh.tpl');
                }

            break;


            case 3:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);
                    $exp = explode(":", $node->server);
                    $token = LinkController::GenerateCode(3, $exp[0], $exp[1], 0, $this->user->id);
                    $json_show="PAC 信息<br>地址：".Config::get('apiUrl')."/link/".$token."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfopac.tpl');
                }

            break;

            case 4:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);
                    $json_show="APN 信息<br>下载地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfoapn.tpl');
                }

            break;

            case 5:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);

                    $json_show="Anyconnect 信息<br>地址：".$node->server."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfoanyconnect.tpl');
                }


            break;

            case 6:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);
                    $exp = explode(":", $node->server);

                    $token_cmcc = LinkController::GenerateApnCode("cmnet", $exp[0], $exp[1], $this->user->id);
                    $token_cnunc = LinkController::GenerateApnCode("3gnet", $exp[0], $exp[1], $this->user->id);
                    $token_ctnet = LinkController::GenerateApnCode("ctnet", $exp[0], $exp[1], $this->user->id);

                    $json_show="APN 文件<br>移动地址：".Config::get('apiUrl')."/link/".$token_cmcc."<br>联通地址：".Config::get('apiUrl')."/link/".$token_cnunc."<br>电信地址：".Config::get('apiUrl')."/link/".$token_ctnet."<br>"."用户名：".$email."<br>密码：".$this->user->passwd."<br>支持方式：".$node->method."<br>备注：".$node->info;

                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfoapndownload.tpl');
                }


            break;

            case 7:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);
                    $token = LinkController::GenerateCode(7, $node->server, ($this->user->port-20000), 0, $this->user->id);
                    $json_show="PAC Plus 信息<br>PAC 地址：".Config::get('apiUrl')."/link/".$token."<br>支持方式：".$node->method."<br>备注：".$node->info;


                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfopacplus.tpl');
                }


            break;

            case 8:
                if ($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0)) {
                    $email=$this->user->email;
                    $email=Radius::GetUserName($email);
                    $token = LinkController::GenerateCode(8, $node->server, ($this->user->port-20000), 0, $this->user->id);
                    $token_ios = LinkController::GenerateCode(8, $node->server, ($this->user->port-20000), 1, $this->user->id);
                    $json_show="PAC Plus Plus信息<br>PAC 一般地址：".Config::get('apiUrl')."/link/".$token."<br>PAC iOS 地址：".Config::get('apiUrl')."/link/".$token_ios."<br>"."备注：".$node->info;

                    return $this->view()
                    ->assign('json_show', $json_show)
                    ->display('user/nodeinfopacpp.tpl');
                }


            break;


            case 10:
                if ((($user->class>=$node->node_class&&($user->node_group==$node->node_group||$node->node_group==0))||$user->is_admin)&&($node->node_bandwidth_limit==0||$node->node_bandwidth<$node->node_bandwidth_limit)) {
                    return $this->view()
                    ->assign('node', $node)
                    ->assign('user', $user)
                    ->assign('mu', $mu)
                    ->assign('relay_rule_id', $relay_rule_id)
                    ->registerClass("URL", "App\Utils\URL")
                    ->display('user/nodeinfo.tpl');
                }
                break;
            default:
                echo ":)";

        }
    }

    public function GetPcConf($request, $response, $args)
    {
        $is_mu = $request->getQueryParams()["is_mu"];
        $is_ss = $request->getQueryParams()["is_ss"];

        $newResponse = $response->withHeader('Content-type', ' application/octet-stream')->withHeader('Content-Disposition', ' attachment; filename=gui-config.json');//->getBody()->write($builder->output());
        $newResponse->getBody()->write(LinkController::GetPcConf($this->user, $is_mu, $is_ss));

        return $newResponse;
    }

    public function GetIosConf($request, $response, $args)
    {
        $newResponse = $response->withHeader('Content-type', ' application/octet-stream')->withHeader('Content-Disposition', ' attachment; filename=Dler Cloud.conf');//->getBody()->write($builder->output());
        if ($this->user->is_admin) {
            $newResponse->getBody()->write(LinkController::GetIosConf(Node::where(
                function ($query) {
                    $query->where('sort', 0)
                        ->orWhere('sort', 10);
                }
            )->where("type", "1")->get(), $this->user));
        } else {
            $newResponse->getBody()->write(LinkController::GetIosConf(Node::where(
                function ($query) {
                    $query->where('sort', 0)
                        ->orWhere('sort', 10);
                }
            )->where("type", "1")->where(
                function ($query) {
                    $query->where("node_group", "=", $this->user->node_group)
                        ->orWhere("node_group", "=", 0);
                }
            )->where("node_class", "<=", $this->user->class)->get(), $this->user));
        }
        return $newResponse;
    }


    public function profile($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $paybacks = Payback::where("ref_by", $this->user->id)->orderBy("datetime", "desc")->paginate(15, ['*'], 'page', $pageNum);
        $paybacks->setPath('/user/profile');

        $iplocation = new QQWry();

        $userip = array();

        $total = Ip::where("datetime",">=",time() - 300)->where('userid', '=',$this->user->id)->get();

        $totallogin = LoginIp::where('userid', '=', $this->user->id)->where("type", "=", 0)->orderBy("datetime", "desc")->take(10)->get();

        $userloginip=array();

        foreach ($totallogin as $single) {
            //if(isset($useripcount[$single->userid]))
            {
                if (!isset($userloginip[$single->ip])) {
                    //$useripcount[$single->userid]=$useripcount[$single->userid]+1;
                    $location=$iplocation->getlocation($single->ip);
                    $userloginip[$single->ip] = iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
                }
            }
        }

        foreach($total as $single)
        {
            //if(isset($useripcount[$single->userid]))
            {
                $single->ip = Tools::getRealIp($single->ip);
                $is_node = Node::where("node_ip", $single->ip)->first();
                if($is_node) {
                    continue;
                }


                if(!isset($userip[$single->ip]))
                {
                    //$useripcount[$single->userid]=$useripcount[$single->userid]+1;
                    $location=$iplocation->getlocation($single->ip);
                    $userip[$single->ip]=iconv('gbk', 'utf-8//IGNORE', $location['country'].$location['area']);
                }
            }
        }



        return $this->view()
        ->assign("userip",$userip)
        ->assign("userloginip", $userloginip)
        ->assign("paybacks", $paybacks)
        ->display('user/profile.tpl');
    }


    public function announcement($request, $response, $args)
    {
        $Anns = Ann::orderBy('date', 'desc')->get();



        return $this->view()
        ->assign("anns", $Anns)
        ->display('user/announcement.tpl');
    }




    public function edit($request, $response, $args)
    {
        $themes = Tools::getDir(BASE_PATH."/resources/views");

        $BIP = BlockIp::where("ip", $_SERVER["REMOTE_ADDR"])->first();
        if ($BIP == null) {
            $Block = "IP: ".$_SERVER["REMOTE_ADDR"]." 未封禁";
            $isBlock = 0;
        } else {
            $Block = "IP: ".$_SERVER["REMOTE_ADDR"]." 已封禁";
            $isBlock = 1;
        }

        $bind_token = TelegramSessionManager::add_bind_session($this->user);

        $config_service = new Config();

        return $this->view()
        ->assign('user', $this->user)
        ->assign('themes', $themes)
        ->assign('isBlock', $isBlock)
        ->assign('Block', $Block)
        ->assign('bind_token', $bind_token)
        ->assign('telegram_bot', Config::get('telegram_bot'))
        ->assign('config_service', $config_service)
        ->registerClass("URL", "App\Utils\URL")
        ->display('user/edit.tpl');
    }


    public function invite($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $codes = InviteCode::where('user_id', $this->user->id)->orderBy("created_at", "desc")->paginate(15, ['*'], 'page', $pageNum);
        $codes->setPath('/user/invite');



        return $this->view()
        ->assign('codes', $codes)
        ->display('user/invite.tpl');
    }

    public function doInvite($request, $response, $args)
    {
        $n = $this->user->invite_num;
        if ($n < 1) {
            $res['ret'] = 0;
            $res['msg'] = "失败";
            return $response->getBody()->write(json_encode($res));
        }
        for ($i = 0; $i < $n; $i++) {
            $char = Tools::genRandomChar(32);
            $code = new InviteCode();
            $code->code = $char;
            $code->user_id = $this->user->id;
            $code->save();
        }
        $this->user->invite_num = 0;
        $this->user->save();
        $res['ret'] = 1;
        $res['msg'] = "生成成功。";
        return $this->echoJson($response, $res);
    }

    public function sys()
    {
        return $this->view()
        ->assign('ana', "")
        ->display('user/sys.tpl');
    }

    public function updatePassword($request, $response, $args)
    {
        $oldpwd = $request->getParam('oldpwd');
        $pwd = $request->getParam('pwd');
        $repwd = $request->getParam('repwd');
        $user = $this->user;
        if (!Hash::checkPassword($user->pass, $oldpwd)) {
            $res['ret'] = 0;
            $res['msg'] = "旧密码错误";
            return $response->getBody()->write(json_encode($res));
        }
        if ($pwd != $repwd) {
            $res['ret'] = 0;
            $res['msg'] = "两次输入不符合";
            return $response->getBody()->write(json_encode($res));
        }

        if (strlen($pwd) < 8) {
            $res['ret'] = 0;
            $res['msg'] = "密码太短啦";
            return $response->getBody()->write(json_encode($res));
        }
        $hashPwd = Hash::passwordHash($pwd);
        $user->pass = $hashPwd;
        $user->save();

        $user->clean_link();

        $res['ret'] = 1;
        $res['msg'] = "修改成功";
        return $this->echoJson($response, $res);
    }

    public function updateHide($request, $response, $args)
    {
        $hide = $request->getParam('hide');
        $user = $this->user;
        $user->is_hide = $hide;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "修改成功";
        return $this->echoJson($response, $res);
    }

    public function Unblock($request, $response, $args)
    {
        $user = $this->user;
        $BIP = BlockIp::where("ip", $_SERVER["REMOTE_ADDR"])->get();
        foreach ($BIP as $bi) {
            $bi->delete();
        }

        $UIP = new UnblockIp();
        $UIP->userid = $user->id;
        $UIP->ip = $_SERVER["REMOTE_ADDR"];
        $UIP->datetime = time();
        $UIP->save();


        $res['ret'] = 1;
        $res['msg'] = $_SERVER["REMOTE_ADDR"];
        return $this->echoJson($response, $res);
    }

    public function shop($request, $response, $args)
    {
        $shops = Shop::where("status", 1)->get();

        return $this->view()
        ->assign('shops', $shops)
        ->display('user/shop.tpl');
    }

    public function CouponCheck($request, $response, $args)
    {
        $coupon = $request->getParam('coupon');
        $coupon = trim($coupon);

        $shop = $request->getParam('shop');

        $shop = Shop::where("id", $shop)->where("status", 1)->first();

        if ($shop == null) {
            $res['ret'] = 0;
            $res['msg'] = "非法请求";
            return $response->getBody()->write(json_encode($res));
        }

        if ($coupon == "") {
            $res['ret'] = 1;
            $res['name'] = $shop->name;
            $res['credit'] = "0 %";
            $res['total'] = $shop->price."元";
            return $response->getBody()->write(json_encode($res));
        }

        $coupon=Coupon::where("code", $coupon)->first();

        if ($coupon == null) {
            $res['ret'] = 0;
            $res['msg'] = "优惠码无效";
            return $response->getBody()->write(json_encode($res));
        }

        if ($coupon->order($shop->id) == false) {
            $res['ret'] = 0;
            $res['msg'] = "此优惠码不可用于此商品";
            return $response->getBody()->write(json_encode($res));
        }

        $res['ret'] = 1;
        $res['name'] = $shop->name;
        $res['credit'] = $coupon->credit." %";
        $res['total'] = $shop->price * ((100 - $coupon->credit) / 100)."元";

        return $response->getBody()->write(json_encode($res));
    }

    public function buy($request, $response, $args)
    {
        $coupon = $request->getParam('coupon');
        $coupon = trim($coupon);
        $code = $coupon;
        $shop = $request->getParam('shop');
        $disableothers = $request->getParam('disableothers');
        $autorenew = $request->getParam('autorenew');

        $shop = Shop::where("id", $shop)->where("status", 1)->first();

        if ($shop == null) {
            $res['ret'] = 0;
            $res['msg'] = "非法请求";
            return $response->getBody()->write(json_encode($res));
        }

        if (!$shop->canBuy($this->user)) {
            $res['ret'] = 0;
            $res['msg'] = "您不符合购买此商品的条件";
            return $response->getBody()->write(json_encode($res));
        }

        if ($coupon == "") {
            $credit = 0;
        } else {
            $coupon = Coupon::where("code", $coupon)->first();

            if ($coupon == null) {
                $credit = 0;
            } else {
                if ($coupon->onetime == 1) {
                    $onetime = true;
                }

                $credit=$coupon->credit;
            }

            if ($coupon->order($shop->id) == false) {
                $res['ret'] = 0;
                $res['msg'] = "此优惠码不可用于此商品";
                return $response->getBody()->write(json_encode($res));
            }

            if ($coupon->expire<time()) {
                $res['ret'] = 0;
                $res['msg'] = "此优惠码已过期";
                return $response->getBody()->write(json_encode($res));
            }

            if ($coupon->number != 0) {
                $boughts = Bought::where('coupon', $code)->get();
                if (count($boughts) >= $coupon->number) {
                    $res['ret'] = 0;
                    $res['msg'] = "此优惠码已用完";
                    return $response->getBody()->write(json_encode($res));
                }
            }

            if ($coupon->times != 0) {
                $boughts = Bought::where('coupon', $code)->where('userid', $this->user->id)->get();
                if (count($boughts) >= $coupon->times) {
                    $res['ret'] = 0;
                    $res['msg'] = "此优惠码已达单账号使用次数上限";
                    return $response->getBody()->write(json_encode($res));
                }
            }
        }

        $price = $shop->price * ((100 - $credit) / 100);
        $user = $this->user;

        if ((float)$user->money < (float)$price) {
            $res['ret'] = 0;
            $res['msg'] = '当前余额不足，总价为'.$price.'元。</br><a href="/user/code">点击进入充值界面</a>';
            return $response->getBody()->write(json_encode($res));
        }

        $user->money = $user->money - $price;
        $user->save();

        if($disableothers == 1){
            $boughts = Bought::where("userid", $user->id)->get();
            foreach($boughts as $disable_bought){
                $disable_bought->renew = 0;
                $disable_bought->save();
            }
        }

        $bought = new Bought();
        $bought->userid = $user->id;
        $bought->shopid = $shop->id;
        $bought->datetime = time();
        if ($autorenew == 0 || $shop->auto_renew == 0) {
            $bought->renew = 0;
        } else {
            $bought->renew = time() + $shop->auto_renew * 86400;
        }

        $bought->coupon = $code;


        if (isset($onetime)) {
            $price = $shop->price;
        }
        $bought->price = $price;
        $bought->save();

        $shop->buy($user);

        $res['ret'] = 1;
        $res['msg'] = "购买成功";

        return $response->getBody()->write(json_encode($res));
    }

    public function bought($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $shops = Bought::where("userid", $this->user->id)->orderBy("id", "desc")->paginate(15, ['*'], 'page', $pageNum);
        $shops->setPath('/user/bought');

        return $this->view()
        ->assign('shops', $shops)
        ->display('user/bought.tpl');
    }

    public function deleteBoughtGet($request, $response, $args)
    {
        $id = $request->getParam('id');
        $shop = Bought::where("id", $id)->where("userid", $this->user->id)->first();

        if ($shop == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "自动续费失败，订单不存在。";
            return $response->getBody()->write(json_encode($rs));
        }

        if ($this->user->id == $shop->userid) {
            $shop->renew = 0;
        }

        if (!$shop->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "取消自动续费失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "已取消自动续费";
        return $response->getBody()->write(json_encode($rs));
    }


    public function ticket($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $tickets = Ticket::where("userid", $this->user->id)->where("rootid", 0)->orderBy("datetime", "desc")->paginate(15, ['*'], 'page', $pageNum);
        $tickets->setPath('/user/ticket');

        return $this->view()
        ->assign('tickets', $tickets)
        ->display('user/ticket.tpl');
    }

    public function ticket_create($request, $response, $args)
    {
        return $this->view()
        ->display('user/ticket_create.tpl');
    }

    public function ticket_add($request, $response, $args)
    {
        $title = $request->getParam('title');
        $content = $request->getParam('content');


        if ($title == "" || $content == "") {
            $res['ret'] = 0;
            $res['msg'] = "请填全";
            return $this->echoJson($response, $res);
        }

        if (strpos($content, "admin") != false || strpos($content, "user") != false) {
            $res['ret'] = 0;
            $res['msg'] = "请求中有不正当的词语。";
            return $this->echoJson($response, $res);
        }


        $ticket = new Ticket();

        $antiXss = new AntiXSS();

        $ticket->title = $antiXss->xss_clean($title);
        $ticket->content = $antiXss->xss_clean($content);
        $ticket->rootid = 0;
        $ticket->userid = $this->user->id;
        $ticket->datetime = time();
        $ticket->save();

        $adminUser = User::where("is_admin", "=", "1")->get();
        foreach ($adminUser as $user) {
            $subject = Config::get('appName')."-新工单被开启";
            $to = $user->email;
            $text = "管理员您好，有人开启了新的工单，请您及时处理。。" ;
            try {
                Mail::send($to, $subject, 'news/warn.tpl', [
                    "user" => $user,"text" => $text
                ], [
                ]);
            } catch (Exception $e) {
                echo $e->getMessage();
            }
        }

        $res['ret'] = 1;
        $res['msg'] = "提交成功";
        return $this->echoJson($response, $res);
    }

    public function ticket_update($request, $response, $args)
    {
        $id = $args['id'];
        $content = $request->getParam('content');
        $status = $request->getParam('status');

        if ($content == ""||$status == "") {
            $res['ret'] = 0;
            $res['msg'] = "请填全";
            return $this->echoJson($response, $res);
        }

        if (strpos($content, "admin") != false||strpos($content, "user") != false) {
            $res['ret'] = 0;
            $res['msg'] = "请求中有不正当的词语。";
            return $this->echoJson($response, $res);
        }


        $ticket_main = Ticket::where("id", "=", $id)->where("rootid", "=", 0)->first();
        if ($ticket_main->userid != $this->user->id) {
            $newResponse = $response->withStatus(302)->withHeader('Location', '/user/ticket');
            return $newResponse;
        }

        if ($status == 1 && $ticket_main->status != $status) {
            $adminUser = User::where("is_admin", "=", "1")->get();
            foreach ($adminUser as $user) {
                $subject = Config::get('appName')."-工单被重新开启";
                $to = $user->email;
                $text = "管理员您好，有人重新开启了<a href=\"".Config::get('baseUrl')."/admin/ticket/".$ticket_main->id."/view\">工单</a>，请您及时处理。" ;
                try {
                    Mail::send($to, $subject, 'news/warn.tpl', [
                        "user" => $user,"text" => $text
                    ], [
                    ]);
                } catch (Exception $e) {
                    echo $e->getMessage();
                }
            }
        } else {
            $adminUser = User::where("is_admin", "=", "1")->get();
            foreach ($adminUser as $user) {
                $subject = Config::get('appName')."-工单被回复";
                $to = $user->email;
                $text = "管理员您好，有人回复了<a href=\"".Config::get('baseUrl')."/admin/ticket/".$ticket_main->id."/view\">工单</a>，请您及时处理。" ;
                try {
                    Mail::send($to, $subject, 'news/warn.tpl', [
                        "user" => $user,"text" => $text
                    ], [
                    ]);
                } catch (Exception $e) {
                    echo $e->getMessage();
                }
            }
        }

        $antiXss = new AntiXSS();

        $ticket = new Ticket();
        $ticket->title = $antiXss->xss_clean($ticket_main->title);
        $ticket->content = $antiXss->xss_clean($content);
        $ticket->rootid = $ticket_main->id;
        $ticket->userid = $this->user->id;
        $ticket->datetime = time();
        $ticket_main->status = $status;

        $ticket_main->save();
        $ticket->save();




        $res['ret'] = 1;
        $res['msg'] = "提交成功";
        return $this->echoJson($response, $res);
    }

    public function ticket_view($request, $response, $args)
    {
        $id = $args['id'];
        $ticket_main = Ticket::where("id", "=", $id)->where("rootid", "=", 0)->first();
        if ($ticket_main->userid != $this->user->id) {
            $newResponse = $response->withStatus(302)->withHeader('Location', '/user/ticket');
            return $newResponse;
        }

        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }


        $ticketset = Ticket::where("id", $id)->orWhere("rootid", "=", $id)->orderBy("datetime", "desc")->paginate(5, ['*'], 'page', $pageNum);
        $ticketset->setPath('/user/ticket/'.$id."/view");


        return $this->view()
        ->assign('ticketset', $ticketset)
        ->assign("id", $id)
        ->display('user/ticket_view.tpl');
    }


    public function updateWechat($request, $response, $args)
    {
        $type = $request->getParam('imtype');
        $wechat = $request->getParam('wechat');
        $wechat = trim($wechat);

        $user = $this->user;

        if ($user->telegram_id != 0) {
            $res['ret'] = 0;
            $res['msg'] = "您绑定了 Telegram ，所以此项并不能被修改。";
            return $response->getBody()->write(json_encode($res));
        }

        if ($wechat == ""||$type == "") {
            $res['ret'] = 0;
            $res['msg'] = "请填好";
            return $response->getBody()->write(json_encode($res));
        }

        $user1 = User::where('im_value', $wechat)->where('im_type', $type)->first();
        if ($user1 != null) {
            $res['ret'] = 0;
            $res['msg'] = "此联络方式已经被注册了";
            return $response->getBody()->write(json_encode($res));
        }

        $user->im_type = $type;
        $antiXss = new AntiXSS();
        $user->im_value = $antiXss->xss_clean($wechat);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "修改成功";
        return $this->echoJson($response, $res);
    }


    public function updateSSR($request, $response, $args)
    {
        $protocol = $request->getParam('protocol');
        $obfs = $request->getParam('obfs');

        $user = $this->user;

        if ($obfs == ""||$protocol == "") {
            $res['ret'] = 0;
            $res['msg'] = "请填好";
            return $response->getBody()->write(json_encode($res));
        }

        if (!Tools::is_param_validate('obfs', $obfs)) {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        if (!Tools::is_param_validate('protocol', $protocol)) {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        $antiXss = new AntiXSS();

        $user->protocol = $antiXss->xss_clean($protocol);
        $user->obfs = $antiXss->xss_clean($obfs);

/*
        if (!Tools::checkNoneProtocol($user)) {
            $res['ret'] = 0;
            $res['msg'] = "您将要设置为的协议并不在以下协议<br>".implode(',', Config::getSupportParam('allow_none_protocol')).'<br>之内，请您先修改您的加密方式，再来修改此处设置。';
            return $this->echoJson($response, $res);
        }

        if (!URL::SSCanConnect($user) && !URL::SSRCanConnect($user)) {
            $res['ret'] = 0;
            $res['msg'] = "您这样设置之后，就没有客户端能连接上了，所以系统拒绝了您的设置，请您检查您的设置之后再进行操作。";
            return $this->echoJson($response, $res);
        }
*/
        $user->save();

        if (!URL::SSCanConnect($user)) {
            $res['ret'] = 1;
            $res['msg'] = "已修改为 SSR 模式，请您自行更换客户端。";
            return $this->echoJson($response, $res);
        }

        if (!URL::SSRCanConnect($user)) {
            $res['ret'] = 1;
            $res['msg'] = "已修改为 SS 模式，请您自行更换客户端。";
            return $this->echoJson($response, $res);
        }

        $res['ret'] = 1;
        $res['msg'] = "设置成功，您可自由选用客户端来连接。";
        return $this->echoJson($response, $res);
    }

    public function updateTheme($request, $response, $args)
    {
        $theme = $request->getParam('theme');

        $user = $this->user;

        if ($theme == "") {
            $res['ret'] = 0;
            $res['msg'] = "???";
            return $response->getBody()->write(json_encode($res));
        }


        $user->theme = filter_var($theme, FILTER_SANITIZE_STRING);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "ok";
        return $this->echoJson($response, $res);
    }


    public function updateMail($request, $response, $args)
    {
        $mail = $request->getParam('mail');
        $mail = trim($mail);
        $user = $this->user;

        if (!($mail == "1"||$mail == "0")) {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }


        $user->sendDailyMail = $mail;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "ok";
        return $this->echoJson($response, $res);
    }

    public function updateEmail($request, $response, $args)
    {
        $email = $request->getParam('email');
        $code = $request->getParam('code');

        if ($code == "") {
            $res['ret'] = 0;
            $res['msg'] = "你似乎没有填写你的验证码";
            return $response->getBody()->write(json_encode($res));
        }

        if (!Check::isEmailLegal($email)) {
            $res['ret'] = 0;
            $res['msg'] = "邮箱无效";
            return $response->getBody()->write(json_encode($res));
        }

        $user = $this->user;
        $mailcount = EmailVerify::where('userid', '=', $user->id)->where('code', '=', $code)->where('expire_in', '>', time())->first();
        if ($mailcount == null) {
            $res['ret'] = 0;
            $res['msg'] = "您的邮箱验证码不正确";
            return $response->getBody()->write(json_encode($res));
        }
        EmailVerify::where('email', '=', $email)->delete();

        $user->email = $email;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "修改成功！";
        return $response->getBody()->write(json_encode($res));
    }

    public function verifyEmail($request, $response, $next)
    {
        $email = $request->getParam('email');

        if ($email == "") {
            $res['ret'] = 0;
            $res['msg'] = "哦？你填了你的邮箱了吗？";
            return $response->getBody()->write(json_encode($res));
        }

        // check email format
        if (!Check::isEmailLegal($email)) {
            $res['ret'] = 0;
            $res['msg'] = "邮箱无效";
            return $response->getBody()->write(json_encode($res));
        }

        $user = $this->user;

        $users = User::where("email","=",$email)->first();
        if ($users != null){
            $res['ret'] = 0;
            $res['msg'] = "此邮箱已被使用。";
            return $response->getBody()->write(json_encode($res));
        }

        $ipcount = EmailVerify::where('userid', '=', $user->id)->where('expire_in', '>', time())->count();
        if ($ipcount>=(int)Config::get('email_verify_iplimit')) {
            $res['ret'] = 0;
            $res['msg'] = "你的请求次数过多，请稍候再试";
            return $response->getBody()->write(json_encode($res));
        }

        $code = Tools::genRandomChar(6);

        $ev = new EmailVerify();
        $ev->expire_in = time() + Config::get('email_verify_ttl');
        $ev->ip = $_SERVER["REMOTE_ADDR"];
        $ev->email = $email;
        $ev->code = $code;
        $ev->userid = $user->id;
        $ev->save();

        $subject = Config::get('appName')."- 验证邮件";

        try {
            Mail::send($email, $subject, 'auth/verify.tpl', [
                "code" => $code,"expire" => date("Y-m-d H:i:s", time() + Config::get('email_verify_ttl'))
            ], [
                //BASE_PATH.'/public/assets/email/styles.css'
            ]);
        } catch (Exception $e) {
            return false;
        }

        $res['ret'] = 1;
        $res['msg'] = "验证码发送成功，请查收邮件。";
        return $response->getBody()->write(json_encode($res));
    }

    public function PacSet($request, $response, $args)
    {
        $pac = $request->getParam('pac');

        $user = $this->user;

        if ($pac == "") {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }


        $user->pac = $pac;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "ok";
        return $this->echoJson($response, $res);
    }


    public function updateSsPwd($request, $response, $args)
    {
        $user = Auth::getUser();
        $pwd = $request->getParam('sspwd');
        $pwd= trim($pwd);

        if ($pwd == "") {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        if (!Tools::is_validate($pwd)) {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        $user->updateSsPwd($pwd);
        $res['ret'] = 1;


        Radius::Add($user, $pwd);




        return $this->echoJson($response, $res);
    }

    public function updateMethod($request, $response, $args)
    {
        $user = Auth::getUser();
        $method = $request->getParam('method');
        $method = strtolower($method);

        if ($method == "") {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        if (!Tools::is_param_validate('method', $method)) {
            $res['ret'] = 0;
            $res['msg'] = "悟空别闹";
            return $response->getBody()->write(json_encode($res));
        }

        $user->method = $method;
/*
        if (!Tools::checkNoneProtocol($user)) {
            $res['ret'] = 0;
            $res['msg'] = "您的协议并不在以下协议<br>".implode(',', Config::getSupportParam('allow_none_protocol')).'<br>之内，请您先修改您的协议，再来修改此处设置。';
            return $this->echoJson($response, $res);
        }

        if(!URL::SSCanConnect($user) && !URL::SSRCanConnect($user)) {
            $res['ret'] = 0;
            $res['msg'] = "您这样设置之后，就没有客户端能连接上了，所以系统拒绝了您的设置，请您检查您的设置之后再进行操作。";
            return $this->echoJson($response, $res);
        }
*/
        $user->updateMethod($method);

        if(!URL::SSCanConnect($user)) {
            $res['ret'] = 0;
            $res['msg'] = "已修改为 SSR 模式，请您自行更换客户端。";
            return $this->echoJson($response, $res);
        }

        if(!URL::SSRCanConnect($user)) {
            $res['ret'] = 0;
            $res['msg'] = "已修改为 SS 模式，请您自行更换客户端。";
            return $this->echoJson($response, $res);
        }

        $res['ret'] = 0;
        $res['msg'] = "设置成功，您可自由选用两种客户端来进行连接。";
        return $this->echoJson($response, $res);
    }

    public function logout($request, $response, $args)
    {
        Auth::logout();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/auth/login');
        return $newResponse;
    }

    public function doCheckIn($request, $response, $args)
    {
        if (Config::get('enable_geetest_checkin') == 'true') {
            $ret = Geetest::verify($request->getParam('geetest_challenge'), $request->getParam('geetest_validate'), $request->getParam('geetest_seccode'));
            if (!$ret) {
                $res['ret'] = 0;
                $res['msg'] = "系统无法接受您的验证结果，请刷新页面后重试。";
                return $response->getBody()->write(json_encode($res));
            }
        }

        if (!$this->user->isAbleToCheckin()) {
            $res['msg'] = "您似乎已经签到过了...";
            $res['ret'] = 1;
            return $response->getBody()->write(json_encode($res));
        }
        $traffic = rand(0, Config::get('checkinMax') - Config::get('checkinMin')) + Config::get('checkinMin');
        $this->user->transfer_enable = $this->user->transfer_enable + Tools::toMB($traffic);
        $this->user->last_check_in_time = time();
        $this->user->save();
        //$res['msg'] = sprintf("获得了 %u MB 流量.", $traffic);
        $res['msg'] = sprintf( (($traffic<0)?"减少了":"增加了")." %u MB 流量.", abs($traffic));
        $res['ret'] = 1;
        return $this->echoJson($response, $res);
    }

    public function kill($request, $response, $args)
    {
        return $this->view()
        ->display('user/kill.tpl');
    }

    public function handleKill($request, $response, $args)
    {
        $user = Auth::getUser();

        $email=$user->email;

        $passwd = $request->getParam('passwd');
        // check passwd
        $res = array();
        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = " 密码错误";
            return $this->echoJson($response, $res);
        }

        Auth::logout();
        $user->kill_user();
        $res['ret'] = 1;
        $res['msg'] = "GG!您的帐号已经从我们的系统中删除.";
        return $this->echoJson($response, $res);
    }

    public function trafficLog($request, $response, $args)
    {
        $traffic = TrafficLog::where('user_id', $this->user->id)->where("log_time", ">", (time()-3 * 86400))->orderBy('id', 'desc')->get();
        return $this->view()
        ->assign('logs', $traffic)
        ->display('user/trafficlog.tpl');
    }

    public function detect_index($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = DetectRule::paginate(15, ['*'], 'page', $pageNum);
        $logs->setPath('/user/detect');
        return $this->view()
        ->assign('rules', $logs)
        ->display('user/detect_index.tpl');
    }

    public function detect_log($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = DetectLog::orderBy('id', 'desc')->where('user_id', $this->user->id)->paginate(15, ['*'], 'page', $pageNum);
        $logs->setPath('/user/detect/log');
        return $this->view()
        ->assign('logs', $logs)
        ->display('user/detect_log.tpl');
    }

    public function disable($request, $response, $args)
    {
        return $this->view()
        ->display('user/disable.tpl');
    }

    public function telegram_reset($request, $response, $args)
    {
        $user = $this->user;
        $user->telegram_id = 0;
        $user->save();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/user/edit');
        return $newResponse;
    }

    public function resetURL($request, $response, $args)
    {
        $user = $this->user;
        $user->clean_link();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/user');
        return $newResponse;
    }
}