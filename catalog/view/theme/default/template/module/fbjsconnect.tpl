<head>
<style type="text/css">
/*
 * Facebook Connect and Register v2.0
 * http://josemariani.com
 *
 * Septiembre 2012
 */
/* FCR styles */

.tipotexto{font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;}

.cursor{
cursor:hand;
cursor:pointer;
}

.bold{font-weight:bold}

.button-image .img{background:transparent url(catalog/view/theme/default/image/f.png) no-repeat -168px -27px;display:block;
width:8px;
height:11px;
margin:7px 9px}

.sprite-button .button-text{border-top:1px solid #f7bf7a;border-bottom:1px solid #e79966;
border-left:1px solid #f89c4d;
display:inline-block;
height:34px;
color:#f8f0e5;
text-shadow:0 1px 1px #666;
text-decoration:none;
font-size:16px;padding:0 17px;line-height:34px;
background-image:-webkit-gradient(linear,left top,right bottom,color-stop(0.08,#f79424),color-stop(0.79,#f5731c));
background-image:-moz-linear-gradient(left top,#f79424 8%,#f5731c 79%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#F79424',endColorstr='#F5731C',GradientType=0);
white-space:nowrap;
vertical-align:top;
text-align:center;
margin-bottom:5px
}

/* FACEBOOK BUTTON */
.facebook-button{
border-left:1px solid #748eb6;
border-right:1px solid #748eb6;
font-weight:normal}

/* FACEBOOK BUTTON IMAGEN */
.facebook-button .button-image{
border-top:1px solid #748eb6;
border-bottom:1px solid #748eb6;
border-right:1px solid #748eb6;
background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.08,#748eb6),color-stop(0.79,#4b6294));
background-image:-moz-linear-gradient(center top,#748eb6 8%,#4b6294 79%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

.facebook-button:hover.button-image{
background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.11,#748eb6),color-stop(0.66,#4b6294));
background-image:-moz-linear-gradient(center top,#748eb6 11%,#4b6294 66%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

.facebook-button:active .button-image{
border-right:1px solid #748eb6;background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.15,#748eb6),color-stop(0.85,#4b6294));
background-image:-moz-linear-gradient(center top,#748eb6 15%,#4b6294 85%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

/* FACEBOOK BUTTON TEXT */

.facebook-button .button-text{
border-top:1px solid #748eb6;
border-bottom:1px solid #748eb6;
border-left:1px solid #748eb6;
background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.08,#748eb6),color-stop(0.79,#4b6294));
background-image:-moz-linear-gradient(center top,#748eb6 8%,#4b6294 79%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',
endColorstr='#4B6294',GradientType=0)}

.facebook-button:hover .button-text{
background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.11,#748eb6),color-stop(0.66,#4b6294));
background-image:-moz-linear-gradient(center top,#748eb6 11%,#4b6294 66%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

.facebook-button:active .button-text{
border-left:1px solid #748eb6;ackground-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.15,#748eb6),color-stop(0.85,#4b6294));
background-image:-moz-linear-gradient(center top,#748eb6 15%,#4b6294 85%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}


/* FACEBOOK LOGIN */
.facebook-login{
border-top: 0px solid #03477B;
border-left: 0px solid #03477B;
border-right: 0 px solid #03477B;
border-bottom: 0px solid #00386A;
-webkit-border-radius:6px;
-moz-border-radius:6px;
border-radius:6px;
-moz-box-shadow:inherit;
-webkit-box-shadow:inherit;
box-shadow:inherit;
line-height:49px;
height:49px;
width: 320px;
overflow:hidden}

.facebook-login .button-image{
border-top:1px solid #7b9dbd;border-bottom:1px solid #4575a4;border-right:1px solid #4575a4;-webkit-border-radius:6px 0 0 6px;-moz-border-radius:6px 0 0 6px;border-radius:6px 0 0 6px;background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.08,#5f8db9),color-stop(0.79,#29547b));
background-image:-moz-linear-gradient(center top,#5f8db9 8%,#29547b 79%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5F8DB9',endColorstr='#29547B',GradientType=0);
line-height:49px;
height:49px;
width:49px;float:left}

.facebook-login .button-image .img{
background:transparent url(catalog/view/theme/default/image/f.png) no-repeat -243px -404px;margin:5px 0 0 12px;width:26px;height:43px}

.facebook-login .button-text{
border-top:1px solid #7b9dbd;border-bottom:1px solid #4575a4;border-left:1px solid #4575a4;-webkit-border-radius:0 6px 6px 0;-moz-border-radius:0 6px 6px 0;border-radius:0 6px 6px 0;background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.08,#5f8db9),color-stop(0.79,#29547b));background-image:-moz-linear-gradient(center top,#5f8db9 8%,#29547b 79%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5F8DB9',endColorstr='#29547B',GradientType=0);padding:0 25px;line-height:49px;height:49px;color:#FFF;font-size:19px;text-shadow:0 0 8px #efefef;font-weight:normal}

.facebook-login .button-text .bold{line-height:48px}

.facebook-login:hover .button-text{
background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.11,#748eb6),color-stop(0.66,#4b6294));background-image:-moz-linear-gradient(center top,#748eb6 11%,#4b6294 66%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

.facebook-login:hover .button-image{
background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.11,#748eb6),color-stop(0.66,#4b6294));background-image:-moz-linear-gradient(center top,#748eb6 11%,#4b6294 66%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

.facebook-login:active .button-text{
border-left:1px solid #748eb6;background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.15,#748eb6),color-stop(0.85,#4b6294));background-image:-moz-linear-gradient(center top,#748eb6 15%,#4b6294 85%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

.facebook-login:active .button-image{
border-right:1px solid #748eb6;background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0.15,#748eb6),color-stop(0.85,#4b6294));
background-image:-moz-linear-gradient(center top,#748eb6 15%,#4b6294 85%);
filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#748EB6',endColorstr='#4B6294',GradientType=0)}

.facebook-login.noimage .button-text{-webkit-border-radius:0;-moz-border-radius:0;border-radius:0}

</style>
</head>
<body>
<script type="text/javascript">
var jQueryScriptOutputted = false;
function init2JQuery() {
    
    //if the jQuery object isn't available
    if (typeof(jQuery) == 'undefined') {
    
    
        if (! jQueryScriptOutputted) {
            //only output the script once..
            jQueryScriptOutputted = true;
            
            //output the script (load it from jquery)
            document.write("<scr" + "ipt type=\"text/javascript\" src=\"http://code.jquery.com/jquery-1.9.1.min.js\"></scr" + "ipt>");
        


		}
        setTimeout("initJQuery()", 50);
		 //alert( "si lo cargo");
    } else {
                        
        $(function() {  
         //alert( "NO ES NESESARIO");
		 //do anything that needs to be done on document.ready
        });
    }
            
}

init2JQuery();

window.fbAsyncInit = function () {

	FB.init({
		appId: 		'<?php echo $fbjsconnect["appid"];?>',
		cookie: 	true,
		oauth:		true
	});
	
	var fb_busy = false;
	$('#fb-login').on('click',function () {
		if (fb_busy) return;
		fb_busy = true;

		$('#login-fb-waiting-text').text('Connecting with Facebook...');

		$('#login-btr').hide('fade', 300);
		$('#login-fb-waiting').delay(300).show('fade', 250).delay(400);

		FB.login(function (res) {
			$('#login-fb-waiting').queue(function (next) {
				if (res.status == 'connected' && res.authResponse != null) {
					$('#login-fb-waiting-text').hide('fade', 250, function () {
						$(this).text('<?php echo $logging_text;?>').show('fade', 250).delay(400).queue(function (next2) {
							//$('#mode').val('facebook-auto');
							document.location.href='<?php echo $fbjsconnect["redirect_uri"];?>';
							//$('#login-btr').submit();

							next2();
						});
					});
				}
				else {
					$('#login-fb-waiting-text').hide('fade', 300, function () {
						$(this).text('<?php echo $canclled_text;?>').show('fade', 250).delay(400).queue(function (next2) {
							$('#login-fb-waiting').hide('fade', 300, function () {
								$('#login-btr').show('fade', 400, function () { fb_busy = false; });
							});

							next2();
						});
					});
				}

				next();
			});
		}, {
			scope: '<?php echo $fbjsconnect["scope"];?>'
		});
	});
};

$(function () {
	var e = document.createElement('script'); e.type = 'text/javascript'; e.async = true;
	e.src = 'https:' + '//connect.facebook.net/en_US/all.js';
	$('#fb-root').append(e);
});
</script>
<div id="fb-root"></div>
<div class="box box-fbconnect" id="login-btr">
 <?php if ($box==1) { ?>
 <?php if ($efect==1){ ?>

	 <div class="box-heading"><?php echo $fbjsconnect_button3; ?></div>
	  <div class="box-fbconnect-a box-content" id="fb-login">
	 <img src="<?php echo $botonfc; ?>" <span class="cursor"></spam>
     </div>

 <?php  ?>
 <?php }else{ ?> 
 <?php  ?>
 <div class="box-heading"><?php echo $fbjsconnect_button3; ?></div>
 <div class="box-content"><a class="sprite-button facebook-login" id="fb-login"><span class="button-image"><span class="img"></span></span> <span class="button-text tipotexto"><? echo $fbjsconnect_button;?> <span class="bold"><? echo $fbjsconnect_button2;?></span>
</a></div>
 
 <?php } ?>
 <?php }else{ ?>
 <?php if ($efect==1){ ?>

  <div class="box-fbconnect-a" id="fb-login">
	 <img src="<?php echo $botonfc; ?>" <span class="cursor"></spam>
     </div>

 <?php }else{ ?>
  <div><a class="sprite-button facebook-login" id="fb-login"><span class="button-image"><span class="img"></span></span> <span class="button-text tipotexto"><? echo $fbjsconnect_button;?> <span class="bold"><?echo $fbjsconnect_button2;?></span></span>
  </a></div>

 <?php }} ?>

</div>
<form id="login-fb-waiting" style="display: none; height: 40px; margin-top: 10px;">
    <div style="margin-top: 60px; text-align: center;">
        <img src="<?php echo $base;?>catalog/view/theme/default/image/fb_loader.gif" style="margin-right: 10px; vertical-align: middle;"> <span id="login-fb-waiting-text"></span>
    </div>
</form>
</body>
