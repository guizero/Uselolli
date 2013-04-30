<!-- Custom Styles -->
<?php
$bgrs_dir = 'admin/view/image/bgrs/'; 

// Display the THEME SETTINGS popout if set in admin
$GLOBALS["display_theme_settings"] = isset($styles['display_theme_settings']) ? $styles['display_theme_settings'] : 0;

$GLOBALS["styles"] = $styles; 

?>
<style>
 <?php if($styles['main_color']!='F71277' && $styles['main_color']!='f71277'){ ?>
		
		a:hover { color: #<?php echo $styles['main_color'];?>;}
		#menu-holder { border-bottom: 2px solid #<?php echo $styles['main_color'];?>;}
		#menu > ul > li:hover > a { background: #<?php echo $styles['main_color'];?>;}
		#menu > ul > li ul > li > a:hover { background: #<?php echo $styles['main_color'];?>;}
		a.button:hover, input.button:hover { background: #<?php echo $styles['main_color'];?>;}
		.buttons .right .button:hover { background: #<?php echo $styles['main_color'];?>;}
		.box-category > ul > li a:hover { color: #<?php echo $styles['main_color'];?>;}
		.box-category > ul > li ul > li > a:hover { color: #<?php echo $styles['main_color'];?>;}
		.product_holder .name a:hover { color: #<?php echo $styles['main_color'];?>;}
		.product-info .description a:hover { color: #<?php echo $styles['main_color'];?>;}
		.product-info .cart .button { background: #<?php echo $styles['main_color'];?>;}
		.product-info a.icon_plus:hover { color: #<?php echo $styles['main_color'];?>;}
		.product-info .review a.rev_count:hover { color: #<?php echo $styles['main_color'];?>;}
		#language a:hover  { color: #<?php echo $styles['main_color'];?>;}
		#currency a:hover  { color: #<?php echo $styles['main_color'];?>;}
		#header #welcome a:hover { color: #<?php echo $styles['main_color'];?>;}
		#header .links a:hover { color: #<?php echo $styles['main_color'];?>;}

		.camera_prevThumbs:hover, .camera_nextThumbs:hover, .camera_prev:hover, .camera_next:hover, .camera_commands:hover, .camera_thumbs_cont:hover { background: #<?php echo $styles['main_color'];?>;}
		.camera_wrap .camera_pag .camera_pag_ul li.cameracurrent > span  { background: #<?php echo $styles['main_color'];?>;}

		.jcarousel-skin-opencart .jcarousel-next-horizontal:hover  { background-color: #<?php echo $styles['main_color'];?>;}
		.jcarousel-skin-opencart .jcarousel-prev-horizontal:hover  { background-color: #<?php echo $styles['main_color'];?>;}
		.jcarousel-skin-opencart .jcarousel-next-disabled-horizontal:hover  { background-color: #ccc;}
		.jcarousel-skin-opencart .jcarousel-prev-disabled-horizontal:hover  { background-color: #ccc;}

		.pagination .links a:hover  { background: #<?php echo $styles['main_color'];?>;}
		.category-list ul li a:hover   { color: #<?php echo $styles['main_color'];?>;}
		.product-filter .display a:hover  { color: #<?php echo $styles['main_color'];?>;}		
		.product-compare a:hover  { color: #<?php echo $styles['main_color'];?>;}
		.product-list .compare a:hover, .product-list .wishlist a:hover  { color: #<?php echo $styles['main_color'];?>;}
		
 <?php } ?>


 <?php if($styles['nav_bgr']!='000000'){ ?>
		#menu { 
			background: #<?php echo $styles['nav_bgr'];?>;
		}			
 <?php } ?>
 
 
 <?php if($styles['bgr_image']!='1.png'){ ?>
	body{ 
		background: url(<?php echo $bgrs_dir.$styles['bgr_image'];?>);
	}	
 <?php } ?>
</style>

<script type="text/javascript">
	fading_effects = <?php echo $styles['fading_effects'];?>;
</script>