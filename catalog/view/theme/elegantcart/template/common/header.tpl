<?php if (isset($_SERVER['HTTP_USER_AGENT']) && !strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 6')) echo '<?xml version="1.0" encoding="UTF-8"?>'. "\n"; ?>
<!DOCTYPE html>
<html>
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/elegantcart/stylesheet/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/elegantcart/lightbox/css/lightbox.css" media="screen" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="/catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="/catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="/catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="/catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="/catalog/view/javascript/common.js"></script>
<script type="text/javascript" src="/catalog/view/theme/elegantcart/javascript/elegantcart_custom.js"></script>
<script type="text/javascript" src="/catalog/view/theme/elegantcart/javascript/cloud_zoom.js"></script>
<script type="text/javascript" src="/catalog/view/theme/elegantcart/javascript/conectafacebook.js"></script>
<script type="text/javascript" src="/catalog/view/theme/elegantcart/lightbox/js/lightbox.js"></script>


<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600' rel='stylesheet' type='text/css'>
<meta property="fb:app_id" content="488143071223582">

<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/elegantcart/stylesheet/ie8.css" />
<![endif]-->
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/elegantcart/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/default/stylesheet/ie6.css" />
<script type="text/javascript" src="/catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<?php echo $google_analytics; ?>

</head>
<body>

<div id="container">

<div id="header">
  <?php if ($logo) { ?>
  <div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
  <?php } ?>

	  <div id="welcome">
	    <?php if (!$logged) { ?>
	    <?php echo $text_welcome; ?>
	    <?php } else { ?>      
	    <?php echo $text_logged; ?>
	    <?php } ?>
	  </div>
	 
	  <div class="links" id="header_links"><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a><a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a> <a href="<?php echo $account; ?>"><?php echo $text_account; ?></a><a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></div>
	  <?php echo $cart; ?>


  <div id='header_btm'>
  	<div id="search">
	  	<div class="search_inside">
			<input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="" />
		    <div class="button-search"></div>
	    </div>
	  </div>
  	<?php echo $language; ?>
  	<?php echo $currency; ?>
  </div>
 
</div>

<?php if ($categories) { ?>
<div id="menu-holder" class="hidden-phone">
<div id="menu">
  <ul>
  	<li><a href="<?php echo $home; ?>"><span class='home_icon'></span></a>
    <?php foreach ($categories as $category) { ?>
    <li class="<?php echo $category['name']; ?>"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
      <?php if ($category['children']) { ?>
      <div>
        <?php for ($i = 0; $i < count($category['children']);) { ?>
        <ul>
          <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
          <?php for (; $i < $j; $i++) { ?>
          <?php if (isset($category['children'][$i])) { ?>
          <li><a<?php echo ($i==(count($category['children'])-1) ? " class='last_submenu_item'" : '');?> href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
          <?php } ?>
          <?php } ?>
        </ul>
        <?php } ?>
      </div>
      <?php } ?>
    </li>
    <?php } ?>
  </ul>
</div>
</div>
<?php } ?>


<!-- PHONE::Start nada de phon -->

<?php if ($categories) { ?>
<div id="menu-phone" class="shown-phone" style="display: none;">
  <div id="menu-phone-button">Menu</div>
  <select id="menu-phone-select" onchange="location = this.value">
  	<option value=""></option>
    <?php foreach ($categories as $category) { ?>
    <option value="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></option>
    <?php } ?>
  </select>
</div>

<script type="text/javascript">
	// Bind the Phone menu dropdown
	$('#menu-phone-button').bind('click', function() {
		$("#menu-phone-select").css({'opacity':'1'});
	});
</script>
<?php } ?>

<!-- PHONE::End -->

<div id="notification"></div>

<form id="login-fb-waiting" style="display: none; height: 40px; margin-top: 10px;">
    <div style="margin-top: 60px; text-align: center;">
        <img src="/catalog/view/theme/default/image/fb_loader.gif" style="margin-right: 10px; vertical-align: middle;"> <span id="login-fb-waiting-text"></span>
    </div>
</form>
<<<<<<< HEAD

<div style="display:none">
<div id="modal-conteudo">
  <div id="modal-titulo">
    <h1>Ganhe 10% OFF</h1>
  </div>
  <div id="modal-descricao">
    <b>Cadastre-se</b> e ganhe <b>10%</b> de desconto em sua primeira compra!*
  </div>
  
    <form id="formulariopop" action="http://uselolli.us7.list-manage.com/subscribe/post-json?u=24c9d739ac3ca2fbf8dcdd59b&id=ce4cdb44ec&c=?" method="get" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
      <div id="modal-formulario" style="text-align:center">
        <div style="float:left; width:40%">
      
      <input type="text" value="" name="FNAME" class="" id="mce-FNAME" placeholder="Digite seu nome">
        </div>
        <div style="float:left; width:40%">
      
      <input type="text" value="" name="EMAIL" class="required email" id="mce-EMAIL" placeholder="Digite seu email">
        </div>
       <input type="submit" value="Enviar" name="subscribe" id="mc-embedded-subscribe" class="button">
      </div>
      
    </form>
  
  

</div>
</div>

<div style="display:none">
<div id="modal-sucesso">
  <div id="modal-titulo">
    <h1>Obrigado!</h1>
  </div>
  <div id="modal-descricao">
    <b>Verifique sua caixa de e-mails</b> e clique no link enviado para confirmar seu cadastro. O código de desconto virá em um novo e-mail de confirmação. <b>Boas compras!</b>
  </div>
</div>
</div>
=======
>>>>>>> parent of e846b29... colorbox
