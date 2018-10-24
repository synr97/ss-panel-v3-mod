<?php

namespace App\Models;

use App\Services\Config;

class Shop extends Model
{
	protected $connection = "default";
	protected $table = "shop";

	public function content()
	{
		$content = json_decode($this->attributes['content'], true);
		$content_text="";
		$i = 0;
		foreach ($content as $key=>$value) {
			switch ($key) {
				case "group_limit":
					$content_text .= "仅限 ".$value." 群组购买";
					break;
				case "class_limit_operator":
					switch ($value) {
						case "equal":
							$operator = "等于";
							break;
						case "greater":
							$operator = "大于";
							break;
						case "greater_equal":
							$operator = "大于等于";
							break;
						case "less":
							$operator = "小于";
							break;
						case "less_equal":
							$operator = "小于等于";
							break;
						case "not":
							$operator = "非";
							break;
						default:
							$operator = "";
					}
					$content_text .= "仅限等级".$operator." ".$content["class_limit_content"]." 的用户购买";
					break;
				case "bandwidth":
					if (isset($content["traffic_package"])) {
						$content_text .= "流量包: ";
					}
					$content_text .= "月度流量".$value." G";
					break;
				case "node_speedlimit":
					$content_text .= "".$value."mbps 速率";
					break;
				case "node_connector":
					$content_text .= "最多支持 ".$value."IP 同时在线";
					break;
				case "expire":
					$content_text .= "账号有效期添加 ".$value." 天";
					break;
				case "class":
					$content_text .= "套餐有效期 ".$content["class_expire"]." 天";
					break;
				case "reset":
					$content_text .= "每 ".$value." 天重置一次流量";
					break;
				case "node_group":
					$content_text .= "修为用户为 ".$value." 组";
					break;

				default:
					continue 2;
			}

			if ($i<count($content)&&$key!="reset_exp") {
				$content_text .= ", ";
			}

			$i++;
		}

		if (substr($content_text, -2, 2)==", ") {
			$content_text=substr($content_text, 0, -2);
		}

		return $content_text;
	}

	public function group_limit()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->group_limit)) {
			return $content->group_limit;
		} else {
			return '';
		}
	}

	public function class_limit_operator()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->class_limit_operator)) {
			return $content->class_limit_operator;
		} else {
			return 'none';
		}
	}

	public function class_limit_content()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->class_limit_content)) {
			return $content->class_limit_content;
		} else {
			return '';
		}
	}

	public function bandwidth()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->bandwidth)) {
			return $content->bandwidth;
		} else {
			return 0;
		}
	}

	public function traffic_package()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->traffic_package)) {
			return $content->traffic_package;
		} else {
			return 0;
		}
	}

	public function node_speedlimit()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->node_speedlimit)) {
			return $content->node_speedlimit;
		} else {
			return 0;
		}
	}

	public function node_connector()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->node_connector)) {
			return $content->node_connector;
		} else {
			return 0;
		}
	}

	public function expire()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->expire)) {
			return $content->expire;
		} else {
			return 0;
		}
	}

	public function reset()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->reset)) {
			return $content->reset;
		} else {
			return 0;
		}
	}

	public function reset_value()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->reset_value)) {
			return $content->reset_value;
		} else {
			return 0;
		}
	}

	public function reset_exp()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->reset_exp)) {
			return $content->reset_exp;
		} else {
			return 0;
		}
	}

	public function user_class()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->class)) {
			return $content->class;
		} else {
			return 0;
		}
	}

	public function class_expire()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->class_expire)) {
			return $content->class_expire;
		} else {
			return 0;
		}
	}

	public function node_group()
	{
		$content = json_decode($this->attributes['content']);
		if (isset($content->node_group)) {
			return $content->node_group;
		} else {
			return 0;
		}
	}

	public function canBuy($user)
	{
		$content = json_decode($this->attributes['content'], true);
		
		if (isset($content["group_limit"])) {
			$group_array=explode(",", $content["group_limit"]);
			if (!in_array($user->node_group, $group_array)) {
				return false;
			}
		}
		
		if (isset($content["class_limit_operator"])) {
			switch ($content["class_limit_operator"]) {
				case "equal":
					$class_array=explode(",", $content["class_limit_content"]);
					if (!in_array($user->class, $class_array)) {
						return false;
					}
					break;
				case "greater":
					if (!($user->class > $content["class_limit_content"])) {
						return false;
					}
					break;
				case "greater_equal":
					if (!($user->class >= $content["class_limit_content"])) {
						return false;
					}
					break;
				case "less":
					if (!($user->class < $content["class_limit_content"])) {
						return false;
					}
					break;
				case "less_equal":
					if (!($user->class <= $content["class_limit_content"])) {
						return false;
					}
					break;
				case "not":
					$class_array = explode(",", $content["class_limit_content"]);
					if (in_array($user->class, $class_array)) {
						return false;
					}
					break;
				default:
			}
		}
		
		if (isset($content["traffic_package"])) {
			if (strtotime($user->expire_in) < time()) {
				return false;
			}
			
			$bought = Bought::where("userid", "=", $user->id)->first();
			if ($bought == null) {
				return false;
			}
		}
		
		return true;
	}

	public function buy($user, $is_renew = 0)
	{
		$content = json_decode($this->attributes['content'], true);
		$content_text = "";

		foreach ($content as $key => $value) {
			switch ($key) {
				case "bandwidth":
					if (!isset($content["traffic_package"] && $content['class'] != $user->class && $shop->auto_reset_bandwidth == 1) {
						$user->transfer_enable = $value * 1024 * 1024 * 1024;
						$user->u = 0;
						$user->d = 0;
						$user->last_day_t = 0;
						$user->auto_reset_day = 1;
						$user->auto_reset_bandwidth = $value;
					} else {
						$user->transfer_enable = $user->transfer_enable + $value * 1024 * 1024 * 1024;
					}
					break;
				case "expire":
					if (time() > strtotime($user->expire_in)) {
						$user->expire_in = date("Y-m-d H:i:s", time() + $value * 86400);
					} else {
						$user->expire_in = date("Y-m-d H:i:s", strtotime($user->expire_in) + $value * 86400);
					}
					break;
				case "class":
					if ($user->class == 0 || $user->class != $value) {
						$user->class_expire = date("Y-m-d H:i:s", time());
					}
					$user->class_expire = date("Y-m-d H:i:s", strtotime($user->class_expire) + $content["class_expire"] * 86400);
					$user->class = $value;
					break;
				case "node_speedlimit":
					$user->node_speedlimit = $value;
					break;
				case "node_group":
				  $user->node_group = $value;
				  break;
				case "node_connector":
					$user->node_connector = $value;
					break;
				default:
			}
		}

		$user->save();
	}
}
