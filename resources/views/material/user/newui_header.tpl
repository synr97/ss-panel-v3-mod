<!DOCTYPE html>
<html>
<head>
  <title>Dler Cloud</title>
  <meta name="msvalidate.01" content="4652A53480D3E379798BE86168C0A149" />
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta property="og:title" content="Dler Cloud">
  	<meta property="og:image" content="https://cat.flyue.cc/favicon.ico">
  	<meta property="og:description" content="Dler Cloud">
  	<meta name="keywords" content="Dler Cloud">
	<meta name="description" content="Dler Cloud">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
  <link href="https://cdn.godann.com/kitui/vendor/nucleo/css/nucleo.css" rel="stylesheet">
  <link href="https://cdn.godann.com/kitui/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link type="text/css" href="https://cdn.godann.com/kitui/css/argon.css?v=1.0.0" rel="stylesheet">
  <script type="application/ld+json">{
            "@context": "http://schema.org",
            "@type": "Website",
            "name": "Dler Cloud",
            "headline": "Dler Cloud",
            "author": {
                "@type": "Organization",
                "name": "Dler Cloud",
                "logo": {
                    "@type": "ImageObject",
                    "url": "https://cat.flyue.cc/favicon.ico"
                },
                "description": "Dler Cloud"
            },
            "url": "https://dlercloud.com",
            "image": {
                "@type": "ImageObject",
                "url": "https://cat.flyue.cc/favicon.ico"
            },
            "mainEntityOfPage": {
                "@type": "Website",
                "@id": "https://dlercloud.com"
            },
            
                "keywords": "Dler Cloud",
            
            "description": "Dler Cloud"
            }
	</script>	
</head>

<body>
  <header class="header-global">
    <nav id="navbar-main" class="navbar navbar-main navbar-expand-lg navbar-transparent navbar-light">
      <div class="container">
        <a class="navbar-brand mr-lg-5" href="/">
          <img src="https://cdn.godann.com/kitui/img/brand/white.png">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar_global" aria-controls="navbar_global" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="navbar-collapse collapse" id="navbar_global">
          <div class="navbar-collapse-header">
            <div class="row">
              <div class="col-6 collapse-brand">
                <a href="/">
                  <img src="https://cdn.godann.com/kitui/img/brand/blue.png">
                </a>
              </div>
              <div class="col-6 collapse-close">
                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbar_global" aria-controls="navbar_global" aria-expanded="false" aria-label="Toggle navigation">
                  <span></span>
                  <span></span>
                </button>
              </div>
            </div>
          </div>
          
          <ul class="navbar-nav navbar-nav-hover align-items-lg-center">
            <li class="nav-item dropdown">
              <a href="#" class="nav-link" data-toggle="dropdown" href="#" role="button">
                <i class="ni ni-circle-08"></i>
                <span class="nav-link-inner--text">个人</span>
              </a>
              <div class="dropdown-menu">
                <a href="/user/edit" class="dropdown-item">资料编辑</a>
                <a href="/user/profile" class="dropdown-item">账户信息</a>
                <a href="/user/relay" class="dropdown-item">中转规则</a>
              </div>
            </li>
            <li class="nav-item dropdown">
              <a href="#" class="nav-link" data-toggle="dropdown" href="#" role="button">
                <i class="ni ni-cart"></i>
                <span class="nav-link-inner--text">交易</span>
              </a>
              <div class="dropdown-menu">
                <a href="/user/code" class="dropdown-item">充值</a>
                <a href="/user/shop" class="dropdown-item">购买</a>
                <a href="/user/bought" class="dropdown-item">购买记录</a>
              </div>
            </li>
            <li class="nav-item dropdown">
              <a href="/user/invite" class="nav-link" >
                <i class="ni ni-money-coins"></i>
                <span class="nav-link-inner--text">推介计划</span>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a href="/user/ticket" class="nav-link" >
                <i class="ni ni-single-copy-04"></i>
                <span class="nav-link-inner--text">工单系统</span>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a href="/user/logout" class="nav-link">
                <i class="ni ni-user-run"></i>
                <span class="nav-link-inner--text">登出</span>
              </a>
            </li>
            {if $user->isAdmin()}
            <li class="nav-item dropdown">
              <a href="#" class="nav-link"  data-toggle="dropdown" href="#" role="button">
                <i class="ni ni-settings"></i>
                <span class="nav-link-inner--text">管理员</span>
              </a>
              <div class="dropdown-menu">
                <a href="/admin" class="dropdown-item">管理面板</a>
              </div>
            </li>
            {/if}
          </ul>
        </div>
      </div>
    </nav>
  </header>