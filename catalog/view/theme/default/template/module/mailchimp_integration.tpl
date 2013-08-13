<?php
//==============================================================================
// MailChimp Integration v155.3 (atualizado)
//
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php $module_id = rand(); ?>
<style type="text/css">
	.mi-message {
		display: none;
		font-size: 11px;
		margin-bottom: 6px;
		background-color:#e9e9e9;
	}
	.mi-block {
			display: inline-block;
		margin: 20px;
		color:white;

	}
	.mi-email, .mi-name {
		width: 140px;
	}
	.mi-loading {
		display: none;
	}
	.msgnews {
		display: inline-block;
margin: 19px;
float: left;
text-align: left;
color: white;
	}

	.nui {
		background-color:#8c0a1a;
		text-align:right;
		height: 70px;		
	}
</style>

<?php if ($popup) { ?>
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
	<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js"></script>
	<style type="text/css">
		.mailchimp-integration {
			display: none;
		}
	</style>
	<script type="text/javascript"><!--
		$(document).ready(function(){
			$('.mailchimp-popup').colorbox({
				fixed: true,
				inline: true,
				width: '184px',
				height: '250px'
			});
		});
	//--></script>
<?php } ?>

<?php if ($position == 'home') { ?>
	<div class="top">
		<div class="left"></div>
		<div class="right"></div>
		<div class="center"><h1><?php echo $heading_title; ?></h1></div>
	</div>
<?php } else { ?>
	<div class="mailchimp-integration box">
		<div class="box-heading top">
			<?php if ($version < 150) { ?><img src="catalog/view/theme/default/image/contact.png" alt="" /><?php } ?>
			<?php echo $heading_title; ?>
		</div>
<?php } ?>
<div class="mi-message"></div>
	<div class="middle nui">
		<div class="msgnews">Cadastre-se em nossa lista de emails<br>e receba primeiro nossas novidades e promoções
		</div>
		<div class="mi-block">
			<span class="required">*</span> <?php echo $text_email_address; ?>
			<input type="text" class="mi-email" onkeydown="if (event.keyCode == 13) miSubscribe<?php echo $module_id; ?>($(this))" />
		</div>
		<?php if ($name_field != 'none') { ?>
			<div class="mi-block">
				<?php if ($name_field == 'required') { ?>
					<span class="required">*</span>
				<?php } ?>
				<?php echo $text_name; ?>
				<input type="text" class="mi-name" onkeydown="if (event.keyCode == 13) miSubscribe<?php echo $module_id; ?>($(this))" />
			</div>
		<?php } ?>
		<div class="mi-block">
			<a class="button" onclick="miSubscribe<?php echo $module_id; ?>($(this))"><span><?php echo $button_subscribe; ?></span></a>
			<img class="mi-loading" src="catalog/view/theme/default/image/loading<?php if ($version < 150) echo '_1'; ?>.gif" />
		</div>
	</div>
	
	<div class="bottom"><?php if ($position == 'home') { ?><div class="left"></div><div class="right"></div><div class="center"></div><?php } ?></div>
</div>
<script type="text/javascript"><!--
	function miSubscribe<?php echo $module_id; ?>(element) {
		var message = element.parent().parent().find('.mi-message');
		var email = $.trim(element.parent().parent().find('.mi-email').val());
		var name = $.trim(element.parent().parent().find('.mi-name').val());
		var loading = element.parent().parent().find('.mi-loading');
		
		loading.show();
		message.slideUp(function(){
			message.removeClass('attention success warning');
			if (!email.match(/^[^\@]+@.*\.[a-z]{2,6}$/i)) {
				message.html('<?php echo str_replace("'", "\'", $text_please_use); ?>').addClass('<?php echo ($version < 150) ? 'warning' : 'attention'; ?>').slideDown();
				loading.hide();
		<?php if ($name_field == 'required') { ?>
			} else if (!name) {
				message.html('<?php echo str_replace("'", "\'", $text_please_fill_in); ?>').addClass('<?php echo ($version < 150) ? 'warning' : 'attention'; ?>').slideDown();
				loading.hide();
		<?php } ?>
			} else {
				$.ajax({
					type: 'POST',
					url: 'index.php?route=<?php echo $type; ?>/<?php echo $name; ?>/subscribe',
					data: {email: email, name: name},
					dataType: 'json',
					success: function(error) {
						if (error['code'] == 0) {
							<?php if ($redirect) { ?>
								alert('<?php echo $text_success; ?>');
								location = '<?php echo $redirect; ?>';
							<?php } else { ?>
								message.html('<?php echo str_replace("'", "\'", $text_success); ?>').addClass('success').slideDown();
							<?php } ?>
						} else if (error['code'] == 214) {
							message.html(<?php echo ($text_already_subscribed) ? '\'' . str_replace("'", "\'", $text_already_subscribed) . '\'' : 'error[\'error\']'; ?>).addClass('attention').slideDown();
						} else {
							message.html(<?php echo ($text_error) ? '\'' . str_replace("'", "\'", $text_error) . '\'' : 'error[\'error\']'; ?>).addClass('warning').slideDown();
						}
						loading.hide();
					}
				});
			}
		});
	}
//--></script>
