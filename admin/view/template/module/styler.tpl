<?php echo $header; ?>
	
	<link rel="stylesheet" href="view/javascript/colorpicker/css/colorpicker.css" type="text/css" />
	<script type="text/javascript" src="view/javascript/colorpicker/js/colorpicker.js"></script>
    <script type="text/javascript" src="view/javascript/colorpicker/js/eye.js"></script>
    <script type="text/javascript" src="view/javascript/colorpicker/js/utils.js"></script>
    <script type="text/javascript" src="view/javascript/colorpicker/js/layout.js?ver=1.0.2"></script>
	
<script type="text/javascript">

$(document).ready(function(){

	$('#main_color').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
	
	$('#nav_bgr').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
});

</script>
		    
    
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" />Theme Settings</h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span>Save</span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span>Cancel</span></a></div>
  </div>
  <div class="content">
   <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    <table class="form">
            <tbody><tr>
                <td><b>Status</b></td>
                <td>
                    <select name="styler_module[status]">
                            <option value="0" <?php echo ((!isset($modules['status']) || (!$modules['status'])) ? ' selected="selected"':'');?>>Disabled</option>
                            <option value="1" <?php echo (isset($modules['status']) && $modules['status']?' selected="selected"':'');?>>Enabled</option>
                    </select>
                </td>
            </tr>

			<tr>
                <td>Show SETTINGS in Front Store</td>
                <td>
                    <select name="styler_module[display_theme_settings]">
                            <option value="0" <?php echo ((!isset($modules['display_theme_settings']) || (!$modules['display_theme_settings'])) ? ' selected="selected"':'');?>>Disabled</option>
                            <option value="1" <?php echo (isset($modules['display_theme_settings']) && $modules['display_theme_settings']?' selected="selected"':'');?>>Enabled</option>
                    </select>
                &nbsp; <em>Display the Theme Settings in the Front of your store (don't forget to disable after saving your settings)</em></td>
            </tr>

            <tr>
                <td>Main color</td>
                <td><input type="text" maxlength="6" size="6" id='main_color' name="styler_module[main_color]" value="<?php echo (isset($modules['main_color']) ? $modules['main_color'] : 'F71277');?>" />
                &nbsp; <em>Default is "F71277"</em></td>
            </tr>
            
            <tr>
                <td>Navigation Background</td>
                <td><input type="text" maxlength="6" size="6" id='nav_bgr' name="styler_module[nav_bgr]" value="<?php echo (isset($modules['nav_bgr']) ? $modules['nav_bgr'] : '000000');?>" />
                &nbsp; <em>Default is "000000"</em></td>
            </tr>            

            <tr>
                <td>Main Background</td>
                <td>
                	<select name="styler_module[bgr_image]">                	
		                <?php foreach ($img_files as $i=>$img_file) { ?>
		                <?php if ($img_file == $modules['bgr_image']) { ?>
		                <option value="<?php echo $img_file;?>" selected="selected"><?php echo ($i==0 ? "Default" : "Pattern ".$i++)?></option>
		                <?php } else { ?>
		                <option value="<?php echo $img_file; ?>"><?php echo ($i==0 ? "Default" : "Pattern ".$i++)?></option>
		                <?php } ?>
		                <?php } ?>
                    </select>
                </td>
            </tr>
			<tr>
                <td>Fading Effects</td>
                <td>
                    <select name="styler_module[fading_effects]">
                            <option value="0" <?php echo ((!isset($modules['fading_effects']) || (!$modules['fading_effects'])) ? ' selected="selected"':'');?>>Disabled</option>
                            <option value="1" <?php echo (isset($modules['fading_effects']) && $modules['fading_effects']?' selected="selected"':'');?>>Enabled</option>
                    </select>
                &nbsp; <em>Fade Out neighbouring products when hovering a product</em></td>
            </tr>

        </tbody></table>
    </form>
  </div>
</div>

<?php echo $footer; ?>