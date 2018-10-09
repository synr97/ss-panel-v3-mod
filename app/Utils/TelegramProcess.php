<?php

namespace App\Utils;

use App\Controllers\LinkController;
use App\Models\User;
use App\Models\Ann;
use App\Services\Config;

class TelegramProcess
{
    private static function needbind_method($bot, $message, $command, $user, $reply_to = null)
    {
        if ($user != null) {
            switch ($command) {
                case 'announcement':
                    $Ann = Ann::orderBy('date', 'desc')->first();
                    $bot->sendMessage($message->getChat()->getId(), "最新公告：
																	".(($Ann != null) ? $Ann->markdown : "无"), $parseMode = "Markdown", $disablePreview = false, $replyToMessageId = $reply_to);
                break;
                case 'connectinfo':
                    $text = "连接信息：
								当前设置个人端口支持的客户端为：";
                    $pre_user = URL::cloneUser($user);
                    if (URL::SSRCanConnect($pre_user)) {
                        $ssr_user = URL::getSSRConnectInfo($pre_user);
                        $apiUrl = Config::get('apiUrl');
                        $ssr_sub_token = LinkController::GenerateSSRSubCode($pre_user->id, 0);
                        if (URL::SSRCanConnect($pre_user) && URL::SSCanConnect($pre_user)) {
                            $text .= "SS / ";
                        }
                        $text .= "SSR

								端口：".$ssr_user->port."
								密码：".$ssr_user->passwd."
								加密：".$ssr_user->method."
								协议：".$ssr_user->protocol."
								混淆：".$ssr_user->obfs."

								SSR 个人端口订阅地址：
								".$apiUrl."/link/".$ssr_sub_token."?mu=0
								SSR 公共端口订阅地址：
								".$apiUrl."/link/".$ssr_sub_token."?mu=1
								Surge 2&3 / Surfboard 公共端口托管地址：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=1&mitm=0
								Surge 2&3 公共端口托管地址（MitM）：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=1&mitm=1
								V2Ray 公共端口订阅地址：
								".$apiUrl."/link/".$ssr_sub_token."?mu=2

								客户端配置指导请进入网站查看，加密/协议/混淆 可以在用户中心的资料编辑页面修改。";
                    } else if (URL::SSCanConnect($pre_user)) {
                        $ss_user = URL::getSSConnectInfo($pre_user);
                        $apiUrl = Config::get('apiUrl');
                        $ios_token = LinkController::GenerateIosCode("smart", 0, $user->id, 0, "smart");
                        $ssr_sub_token = LinkController::GenerateSSRSubCode($pre_user->id, 0);
                        $text .= "SS

								端口：".$ss_user->port."
								密码：".$ss_user->passwd."
								加密：".$ss_user->method."
								混淆：".$ss_user->obfs."

								SSR 公共端口订阅地址：
								".$apiUrl."/link/".$ssr_sub_token."?mu=1
								SSD 个人端口订阅地址：
								".$apiUrl."/link/".$ssr_sub_token."?mu=3
								Surge 2&3 / Surfboard 个人端口托管地址：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=0&mitm=0
								Surge 2&3 / Surfboard 公共端口托管地址：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=1&mitm=0
								Surge 2&3 个人端口托管地址（MitM）：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=0&mitm=1
								Surge 2&3 公共端口托管地址（MitM）：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=1&mitm=1
								Surge 3 个人端口托管地址（MitM）：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=0&mitm=1&new=1
								Surge 3 公共端口托管地址（MitM）：
								".$apiUrl."/link/".$ios_token."?is_ss=1&is_mu=1&mitm=1&new=1
								V2Ray 公共端口订阅地址：
								".$apiUrl."/link/".$ssr_sub_token."?mu=2

								客户端配置指导请进入网站查看，加密/协议/混淆 可以在用户中心的资料编辑页面修改。";
                    } else {
                        $text .= "无";
                    }
                    $bot->sendMessage($message->getChat()->getId(), $text, $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;

                case 'usage':
                    $bot->sendMessage($message->getChat()->getId(), "账户信息：
																	用户名：".$user->user_name."
																	帐号等级：".$user->class."
																	到期时间：".$user->class_expire."
																	余额：".$user->money."
																	在线 IP：".$user->online_ip_count()." / ".(($user->node_connector != 0) ? $user->node_connector : "∞")
																	, $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;

                case 'traffic':
                    $bot->sendMessage($message->getChat()->getId(), "您当前的流量使用情况：
																	今日已使用 ".$user->TodayusedTraffic()." ".number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100, 2)."%
																	今日之前已使用 ".$user->LastusedTraffic()." ".number_format($user->last_day_t/$user->transfer_enable*100, 2)."%
																	未使用 ".$user->unusedTraffic()." ".number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100, 2)."%"
																	, $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;

                 case 'shadowrocket':
                    $bot->sendMessage($message->getChat()->getId(), "Apple ID：
																	pEdmunds139@icloud.com
																	Dd1122556677
																	
																	请使用此 Apple ID 登陆到 App Store 搜索「Shadowrocket」并下载。"
                    												, $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;

                case 'checkin':
                    if (!$user->isAbleToCheckin()) {
                        $bot->sendMessage($message->getChat()->getId(), "亲爱的猪猪，您今天签到过了。", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                        break;
                    }
                    $traffic = rand(Config::get('checkinMin'), Config::get('checkinMax'));
                    $user->transfer_enable = $user->transfer_enable + Tools::toMB($traffic);
                    $user->last_check_in_time = time();
                    $user->save();
                    $bot->sendMessage($message->getChat()->getId(), "天若有情天亦老，我为长者续一秒！恭喜这位猪猪获得了 ".$traffic." MB 流量！", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;

                default:
                    $bot->sendMessage($message->getChat()->getId(), "???", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
            }
        } else {
            $bot->sendMessage($message->getChat()->getId(), "您未绑定本站账号。", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
        }
    }


    public static function telegram_process($bot, $message, $command)
    {
        $user = User::where('telegram_id', $message->getFrom()->getId())->first();

        if ($message->getChat()->getId() > 0) {
            //个人
            $bot->sendChatAction($message->getChat()->getId(), 'typing');

            switch ($command) {
                case 'ping':
                    $bot->sendMessage($message->getChat()->getId(), 'Pong！这个聊天窗口的 ID 是：'.$message->getChat()->getId());
                    break;
                case 'chat':
                    $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), substr($message->getText(), 5)));
                    break;
                case 'announcement':
                    TelegramProcess::needbind_method($bot, $message, $command, $user);
                    break;
                case 'connectinfo':
                    TelegramProcess::needbind_method($bot, $message, $command, $user);
                    break;
                case 'usage':
                    TelegramProcess::needbind_method($bot, $message, $command, $user);
                    break;
                case 'traffic':
                    TelegramProcess::needbind_method($bot, $message, $command, $user);
                    break;
                case 'shadowrocket':
                    TelegramProcess::needbind_method($bot, $message, $command, $user);
                    break;
                case 'checkin':
                    TelegramProcess::needbind_method($bot, $message, $command, $user);
                    break;
                case 'help':
                    $help_list = "命令列表：
                    	/checkin 每日签到
						/usage 账户信息（仅限私聊使用）
						/connectinfo 订阅托管（仅限私聊使用）
						/traffic 查询流量（仅限私聊使用）
						/announcement 最新公告（仅限私聊使用）
						/help 获取帮助信息

						您可以在用户中心的资料编辑看到 Telegram 绑定指示，绑定您的账号，更多精彩功能等着您去发掘！
					          ";
                    $bot->sendMessage($message->getChat()->getId(), $help_list);
                    break;
                default:
                    if ($message->getPhoto() != null) {
                        $bot->sendMessage($message->getChat()->getId(), "正在解析，请稍候...");
                        $bot->sendChatAction($message->getChat()->getId(), 'typing');

                        $photos = $message->getPhoto();

                        $photo_size_array = array();
                        $photo_id_array = array();
                        $photo_id_list_array = array();


                        foreach ($photos as $photo) {
                            $file = $bot->getFile($photo->getFileId());
                            $real_id = substr($file->getFileId(), 0, 36);
                            if (!isset($photo_size_array[$real_id])) {
								$photo_size_array[$real_id] = 0;
                            }

                            if ($photo_size_array[$real_id] < $file->getFileSize()) {
								$photo_size_array[$real_id] = $file->getFileSize();
								$photo_id_array[$real_id] = $file->getFileId();
								if (!isset($photo_id_list_array[$real_id])) {
								    $photo_id_list_array[$real_id] = array();
								}

								array_push($photo_id_list_array[$real_id], $file->getFileId());
                            }
                        }

                        foreach ($photo_id_array as $key => $value) {
                            $file = $bot->getFile($value);
                            $qrcode_text = QRcode::decode("https://api.telegram.org/file/bot".Config::get('telegram_token')."/".$file->getFilePath());

                            if ($qrcode_text == null) {
								foreach ($photo_id_list_array[$key] as $fail_key => $fail_value) {
								    $fail_file = $bot->getFile($fail_value);
								    $qrcode_text = QRcode::decode("https://api.telegram.org/file/bot".Config::get('telegram_token')."/".$fail_file->getFilePath());
								    if ($qrcode_text != null) {
								        break;
								    }
								}
                            }

                            if (substr($qrcode_text, 0, 11) == 'mod://bind/' && strlen($qrcode_text) == 27) {
								$uid = TelegramSessionManager::verify_bind_session(substr($qrcode_text, 11));
								if ($uid != 0) {
								    $user = User::where('id', $uid)->first();
								    $user->telegram_id = $message->getFrom()->getId();
								    $user->im_type = 4;
								    $user->im_value = $message->getFrom()->getUsername();
								    $user->save();
								    $bot->sendMessage($message->getChat()->getId(), "绑定成功，邮箱：".$user->email);
								} else {
								    $bot->sendMessage($message->getChat()->getId(), "绑定失败，二维码无效。".substr($qrcode_text, 11));
								}
                            }

                            if (substr($qrcode_text, 0, 12) == 'mod://login/' && strlen($qrcode_text) == 28) {
								if ($user != null) {
								    $uid = TelegramSessionManager::verify_login_session(substr($qrcode_text, 12), $user->id);
								    if ($uid != 0) {
								        $bot->sendMessage($message->getChat()->getId(), "登录验证成功。邮箱：".$user->email);
								    } else {
								        $bot->sendMessage($message->getChat()->getId(), "登录验证失败，二维码无效。".substr($qrcode_text, 12));
								    }
								} else {
								    $bot->sendMessage($message->getChat()->getId(), "登录验证失败，您未绑定本站账号。".substr($qrcode_text, 12));
								}
                            }

                            break;
                        }
                    } else {
                        if (is_numeric($message->getText()) && strlen($message->getText()) == 6) {
                            if ($user != null) {
								$uid = TelegramSessionManager::verify_login_number($message->getText(), $user->id);
								if ($uid != 0) {
								    $bot->sendMessage($message->getChat()->getId(), "登录验证成功。邮箱：".$user->email);
								} else {
								    $bot->sendMessage($message->getChat()->getId(), "登录验证失败，数字无效。");
								}
                            } else {
								$bot->sendMessage($message->getChat()->getId(), "登录验证失败，您未绑定本站账号。");
                            }
                            break;
                        }
                        $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), $message->getText()));
                    }
            }
        } else {
            //群组
            if (Config::get('telegram_group_quiet') == 'true') {
                return;
            }

            $bot->sendChatAction($message->getChat()->getId(), 'typing');

            switch ($command) {
                case 'ping':
                    $bot->sendMessage($message->getChat()->getId(), 'Pong! 这个群组的 ID 是:'.$message->getChat()->getId(), $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                case 'chat':
                    if ($message->getChat()->getId() == Config::get('telegram_chatid')) {
                        $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), substr($message->getText(), 5)), $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    } else {
                        $bot->sendMessage($message->getChat()->getId(), '不约，叔叔我们不约。', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    }
                    break;
                case 'announcement':
                    $bot->sendMessage($message->getChat()->getId(), "仅限私聊使用", $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                case 'connectinfo':
                    $bot->sendMessage($message->getChat()->getId(), "仅限私聊使用", $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                case 'usage':
                    $bot->sendMessage($message->getChat()->getId(), "仅限私聊使用", $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                case 'traffic':
                    $bot->sendMessage($message->getChat()->getId(), "仅限私聊使用", $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                case 'shadowrocket':
                    $bot->sendMessage($message->getChat()->getId(), "不可用", $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                case 'checkin':
                    TelegramProcess::needbind_method($bot, $message, $command, $user, $message->getMessageId());
                    break;
                case 'help':
                    $help_list_group = "命令列表：
						/checkin 每日签到
						/usage 账户信息（仅限私聊使用）
						/connectinfo 订阅托管（仅限私聊使用）
						/traffic 查询流量（仅限私聊使用）
						/announcement 最新公告（仅限私聊使用）
						/help 获取帮助信息

						您可以在用户中心的资料编辑看到 Telegram 绑定指示，绑定您的账号，更多精彩功能等着您去发掘！
					";
                    $bot->sendMessage($message->getChat()->getId(), $help_list_group, $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                default:
                    if ($message->getText() != null) {
                        if ($message->getChat()->getId() == Config::get('telegram_chatid')) {
                            $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), $message->getText()), $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                        } else {
                            $bot->sendMessage($message->getChat()->getId(), '不约，叔叔我们不约。', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                        }
                    }
            }
        }

        $bot->sendChatAction($message->getChat()->getId(), '');
    }

    public static function process()
    {
        try {
            $bot = new \TelegramBot\Api\Client(Config::get('telegram_token'));
            // or initialize with botan.io tracker api key
            // $bot = new \TelegramBot\Api\Client('YOUR_BOT_API_TOKEN', 'YOUR_BOTAN_TRACKER_API_KEY');

            $command_list = array("ping", "chat", "announcement", "connectinfo", "usage", "traffic", "shadowrocket", "checkin", "help");
            foreach ($command_list as $command) {
                $bot->command($command, function ($message) use ($bot, $command) {
                    TelegramProcess::telegram_process($bot, $message, $command);
                });
            }

            $bot->on($bot->getEvent(function ($message) use ($bot) {
                TelegramProcess::telegram_process($bot, $message, '');
            }), function () {
                return true;
            });

            $bot->run();
        } catch (\TelegramBot\Api\Exception $e) {
            $e->getMessage();
        }
    }
}