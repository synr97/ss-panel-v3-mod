<?php

namespace App\Controllers\Client;

use voku\helper\AntiXSS;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;

use App\Utils\Pay;
use App\Utils\Hash;
use App\Utils\Da;
use App\Utils\Duoshuo;
use App\Utils\GA;
use App\Utils\Wecenter;
use App\Utils\Geetest;
use App\Utils\TelegramSessionManager;
use App\Utils\Helper;
use App\Utils\Check;
use App\Utils\Tools;
use App\Utils\Radius;
use App\Utils\URL;

use App\Controllers\BaseController;
use App\Controllers\LinkController;

use App\Services\Config;
use App\Services\Auth;
use App\Services\Mail;
use App\Services\Factory;

use App\Models\Shop;
use App\Models\Code;
use App\Models\InviteCode;
use App\Models\User;
use App\Models\LoginIp;
use App\Models\EmailVerify;
use App\Models\Ann;
header("Access-Control-Allow-Origin: *");
class leon extends BaseController{

public function apiregister($request, $response, $next)
    {
        $email =  $request->getParam('email');
        $name =  $email;
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');
        $repasswd = $passwd;

        $user = User::where('email', $email)->first();
        if ($user != null) {
            $res['status'] = 0;
            $res['reason'] = "邮箱已被注册";
            return $response->getBody()->write(json_encode($res));
        }

        // do reg user
        $user = new User();
        $antiXss = new AntiXSS();
        $user->user_name = $antiXss->xss_clean($name);
        $user->email = $email;
        $user->pass = Hash::passwordHash($passwd);
        $user->passwd = Tools::genRandomChar(6);
        $user->port = Tools::getAvPort();
        $user->t = 0;
        $user->u = 0;
        $user->d = 0;
        $user->method = Config::get('reg_method');
        $user->protocol = Config::get('reg_protocol');
        $user->protocol_param = Config::get('reg_protocol_param');
        $user->obfs = Config::get('reg_obfs');
        $user->obfs_param = Config::get('reg_obfs_param');
        $user->forbidden_ip = Config::get('reg_forbidden_ip');
        $user->forbidden_port = Config::get('reg_forbidden_port');
        $user->transfer_enable = Tools::toGB(Config::get('defaultTraffic'));
        $user->invite_num = Config::get('inviteNum');
        $user->auto_reset_day = Config::get('reg_auto_reset_day');
        $user->auto_reset_bandwidth = Config::get('reg_auto_reset_bandwidth');
        $user->money = 0;
        $user->class_expire=date("Y-m-d H:i:s", time()+Config::get('user_class_expire_default')*3600);
        $user->class = Config::get('user_class_default');
        $user->node_connector = Config::get('user_conn');
        $user->node_speedlimit = Config::get('user_speedlimit');
  		$user->ref_by = -1;
        $user->expire_in=date("Y-m-d H:i:s", time()+Config::get('user_expire_in_default')*86400);
        $user->reg_date = date("Y-m-d H:i:s");
        $user->reg_ip = $_SERVER["REMOTE_ADDR"];
        $user->class_expire = date("Y-m-d H:i:s", time()+Config::get('user_class_expire_default')*3600);
        $user->class = Config::get('user_class_default');
        $user->plan = 'A';
        $user->theme = Config::get('theme');

        $group=Config::get('ramdom_group');
        $Garray=explode(",", $group);

        $user->node_group = $Garray[rand(0, count($group)-1)];

        $ga = new GA();
        $secret = $ga->createSecret();

        $user->ga_token = $secret;
        $user->ga_enable = 0;


        if ($user->save()) {
            $res['status'] = 1;
            $res['reason'] = "注册成功";
            return $response->getBody()->write(json_encode($res));
        }
        $res['status'] = 0;
        $res['reason'] = "未知错误";
        return $response->getBody()->write(json_encode($res));
    }


      public function apilogin($request, $response, $args)
    {
        // $data = $request->post('sdf');
        $email =  $request->getParam('email');
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');
        // Handle Login
        $user = User::where('email', '=', $email)->first();

        if ($user == null) {
            $res['status'] = 0;
            $res['reason'] = "邮箱或者密码错误";
            return $response->getBody()->write(json_encode($res));
        }

        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['status'] = 0;
            $res['reason'] = "邮箱或者密码错误";


            $loginip=new LoginIp();
            $loginip->ip = $_SERVER["REMOTE_ADDR"];
            $loginip->userid = $user->id;
            $loginip->datetime = time();
            $loginip->type = 1;
            $loginip->save();

            return $response->getBody()->write(json_encode($res));
        }
        $temparray = array();
        $pre_user = URL::cloneUser($user);
		if (URL::SSRCanConnect($pre_user)) {
        $items = URL::getAllItems($user, 0, 0);
        } else if (URL::SSCanConnect($pre_user)) {
        $items = URL::getAllItems($user, 1, 0);
        }
        foreach($items as $item) {
            array_push($temparray, array("name"=>$item['remark'],
                                        "server"=>$item['address'],
                                        "server_port"=>$item['port'],
                                        "method"=>$item['method'],
                                        "obfs"=>$item['obfs'],
                                        "obfsparam"=>$item['obfs_param'],
                                        "password"=>$item['passwd'],
                                        "group"=>Config::get('appName'),
                                        "protocol"=>$item['protocol'],
                                        "protoparam"=>$item['protocol_param'],
                                        "protocolparam"=>$item['protocol_param']));
        }

        function sizecount($filesize) {
         if($filesize >= 1073741824) {
          $filesize = round($filesize / 1073741824 * 100) / 100 . 'G';
         } elseif($filesize >= 1048576) {
          $filesize = round($filesize / 1048576 * 100) / 100 . 'M';
         } elseif($filesize >= 1024) {
          $filesize = round($filesize / 1024 * 100) / 100 . 'K';
         } else {
          $filesize = $filesize . 'B';
         }
         return $filesize;
        }

		$res['status'] = 1;
		$res['class'] = $user->class;
    $res['level'] = $user->class;
    $res['sspanelName'] = Config::get('appName');
		$res['expire_in'] = $user->class_expire;
		$res['money'] = $user->money;
		$res['usedTraffic'] = sizecount($user->u + $user->d);
		$res['Traffic'] = sizecount($user->transfer_enable);
    $res['residue'] = sizecount($user->transfer_enable - ($user->u + $user->d));
    $res['all'] = intval(sizecount($user->transfer_enable) - sizecount($user->u + $user->d));
		$res['nodes'] = $temparray;
	if (URL::SSRCanConnect($pre_user)) {
    $res['link'] = Config::get('apiUrl').'/link/'.LinkController::GenerateSSRSubCode($user->id, 0).'?mu=0';
    } elseif (URL::SSCanConnect($pre_user)) {
    $res['link'] = Config::get('apiUrl').'/link/'.LinkController::GenerateSSRSubCode($user->id, 0).'?mu=1';
    }
        return $response->getBody()->write(json_encode($res));
    }

}
