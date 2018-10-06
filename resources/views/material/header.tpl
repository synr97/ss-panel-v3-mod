<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta content="IE=edge" http-equiv="X-UA-Compatible">
	<meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
	<meta name="theme-color" content="#000000">
	<title>{$config["appName"]}</title>

	<!-- css -->
	<link href="/theme/material/css/base.min.css" rel="stylesheet">
	<link href="/theme/material/css/project.min.css" rel="stylesheet">
	<link href="https://fonts.loli.net/css?family=Roboto:300,300italic,400,400italic,500,500italic" rel="stylesheet">
	<link href="https://fonts.loli.net/css?family=Material+Icons">
	
	<!-- favicon -->
	<!-- ... -->
</head>
<body class="page-brand">
	<header class="header header-transparent header-waterfall ui-header">
		<ul class="nav nav-list pull-left">
			<li>
				<a data-toggle="menu" href="#ui_menu">
					<span class="icon icon-lg">menu</span>
				</a>
			</li>
		</ul>
		
		<ul class="nav nav-list pull-right">
			<li class="dropdown margin-right">
				<a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown">
				{if $user->isLogin}
					<span class="access-hide">{$user->user_name}</span>
					<span class="avatar avatar-sm"><img alt="alt text for John Smith avatar" src="{$user->gravatar}"></span>
					</a>
					<ul class="dropdown-menu dropdown-menu-right">
						<li>
							<a class="padding-right-lg waves-attach" href="/user/"><span class="icon icon-lg margin-right">account_box</span>用户中心</a>
						</li>
						<li>
							<a class="padding-right-lg waves-attach" href="/user/logout"><span class="icon icon-lg margin-right">exit_to_app</span>登出</a>
						</li>
					</ul>
				{else}
					<span class="access-hide">未登录</span>
					<span class="avatar avatar-sm"><img alt="alt text for John Smith avatar" src="/theme/material/images/users/avatar.png"></span>
					</a>
				{/if}
			</li>
		</ul>
	</header>
	<nav aria-hidden="true" class="menu menu-left nav-drawer nav-drawer-md" id="ui_menu" tabindex="-1">
		<div class="menu-scroll">
			<div class="menu-content">
				<a class="menu-logo" href="/user"><i class="icon icon-lg">restaurant_menu</i>&nbsp;菜单</a>
				<ul class="nav">
					<li>
						<a  href="https://dlercloud.com"><i class="icon icon-lg">home</i>&nbsp;首页</a>
					</li>
					<li>
						<a  href="/tos.html"><i class="icon icon-lg">text_format</i>&nbsp;TOS</a>
					</li>
					<li>
						<a  href="/use_policy.html"><i class="icon icon-lg">text_format</i>&nbsp;AUP</a>
					</li>
					<li>
						<a  href="/client.html" target="_blank"><i class="icon icon-lg">library_books</i>&nbsp;软件中心</a>
					</li>
					<li>
						<a  href="https://docs.lhie1.com/black-hole" target="_blank"><i class="icon icon-lg">library_books</i>&nbsp;文档中心</a>
					</li>
					<li>
						<a  href="/code"><i class="icon icon-lg">code</i>&nbsp;邀请码</a>
					</li>
					{if $user->isLogin}
					<li>
						<a  href="/user"><i class="icon icon-lg">person</i>&nbsp;用户中心</a>
					</li>
					<li>
						<a  href="/user/logout"><i class="icon icon-lg">call_missed_outgoing</i>&nbsp;退出</a>
					</li>
					{else}
					<li>
						<a  href="/password/reset"><i class="icon icon-lg">security</i>&nbsp;忘记密码</a>
					</li>
					{/if}
				</ul>
			</div>
		</div>
	</nav>
