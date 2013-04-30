<?php echo $header; ?>
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
    <h1><img src="view/image/fcr.png" alt="" /> <?php echo $heading_title; ?></h1>
	
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
	<?php if ($error_code) { ?>
        <tr>
          <td colspan="2"><span class="error"><?php echo $error_code; ?></span></td>
        </tr>
	<?php } ?>
	
	 <tr>
						<td colspan="2"><strong><?php echo $entry_setting; ?> </strong> </td>
					</tr>
	
      	<tr>
          <td><span class="required">*</span> <?php echo $entry_apikey; ?></td>
          <td><input type="text" name="fbjsconnect_apikey" id="fbjsconnect_apikey" size="50" value="<?php echo $fbjsconnect_apikey; ?>" /> </td>
	</tr>
      	<tr>
          <td><span class="required">*</span> <?php echo $entry_apisecret; ?></td>
          <td><input type="text" name="fbjsconnect_apisecret" id="fbjsconnect_apisecret" size="50" value="<?php echo $fbjsconnect_apisecret; ?>" /> </td>
	</tr>
      	<tr>
          <td><span class="required">*</span> <?php echo $entry_pwdsecret; ?></td>
          <td><input type="text" name="fbjsconnect_pwdsecret" id="fbjsconnect_pwdsecret" size="10" value="<?php echo $fbjsconnect_pwdsecret; ?>" /><br>
		<span class="help"><?php echo $entry_pwdsecret_desc; ?></span>
	</td>
	</tr>
	
	 <tr>
<td colspan="2"><strong><?php echo $entry_show_box; ?> </strong>
                      <?php if($box) { 
						$checked1 = ' checked'; 
						} else { 
						$checked1 = '';  
						} ?> 

<input type="checkbox" name="box" <?php echo $checked1; ?> id="box" value="1"/>
<span class="help"><?php echo $entry_box_desc; ?>
</td>
</tr>
<tr>
<?php foreach ($languages as $language) { ?>
<td><?php echo $entry_boxtitle; ?><span class="help"><?php echo $entry_boxtitle_desc; ?></span></td>
<td><input type="text" name="fbjsconnect_button3_<?php echo $language['language_id']; ?>" id="fbjsconnect_button3_<?php echo $language['language_id']; ?>" size="20" value="<?php echo ${'fbjsconnect_button3_' . $language['language_id']}; ?>" />
<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br>		
	</td>
	<?php } ?>
     </tr>    		
	
	<tr>
	<td colspan="2"><strong><?php echo $entry_show_setting; ?> </strong>
<span class="help"><?php echo $entry_show_desc; ?><br>
   
					      
				<?php if($efect) { 
				  $checked1 = ' checked="checked"'; 
				  $checked0 = ''; 
					} else { 
						$checked1 = ''; 
						$checked0 = ' checked="checked"'; 
					} ?> 
		<input type="radio" name="efect"<?php echo $checked1; ?> id="1" value="1" /><?php echo $entry_botonfc; ?><br>
		<input type="radio" name="efect"<?php echo $checked0; ?> id="0" value="0" /><?php echo $entry_button; ?>
					
	</td>				
	</tr>
	
	<tr>
	<td colspan="2"><strong><?php echo $text_button_settings; ?></strong><td></tr>
            <tr>
              <td><?php echo $entry_botonfc; ?></td>
              <td><div class="image"><img src="<?php echo $botonfc; ?>" alt="" id="thumb-botonfc" />
                  <input type="hidden" name="config_botonfc" value="<?php echo $config_botonfc; ?>" id="botonfc" />
                  <br />
                  <a onclick="image_upload('botonfc', 'thumb-botonfc');">
				  <?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb-botonfc').attr('src', '<?php echo $no_image; ?>'); $('#botonfc').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
             
			</tr>
	
	<?php foreach ($languages as $language) { ?>
	<tr>
	<td><?php echo $entry_button; ?></td>
	  <td>
	  
	  <input type="text" name="fbjsconnect_button_<?php echo $language['language_id']; ?>" id="fbjsconnect_button_<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'fbjsconnect_button_' . $language['language_id']}; ?>" />
	  <input type="text" name="fbjsconnect_button2_<?php echo $language['language_id']; ?>" id="fbjsconnect_button2_<?php echo $language['language_id']; ?>" size="10" value="<?php echo ${'fbjsconnect_button2_' . $language['language_id']}; ?>" />
	    	
			<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
		<span class="help"><?php echo $entry_button_desc; ?></span>
     	  </td>
	</tr>
	<?php } ?>
	 <!--<tr>
<td colspan="2"><strong><?php echo $entry_redirect; ?> </strong>
 <select name="redirect" id="redirect">
    <option value="common/home"><?php echo $text_home; ?></option>
    <option value="account/account"><?php echo $text_account; ?></option>
    <option value="checkout/cart"><?php echo $text_cart; ?></option>
    <option value="information/contact"><?php echo $text_contact; ?></option>
    <option value="account/wishlist"><?php echo $text_wishlist; ?></option>
    <option value="account/order"><?php echo $text_order; ?></option>
    <option value="account/newsletter"><?php echo $text_newletter; ?></option>
  </select>
<span class="help"><?php echo $entry_redirect_desc; ?>
</td>		
	</tr>-->
	<tr>
					<td colspan="4">
					<img
									src="view/image/atention_fc.png"
									alt="FaceBook Connect Mariani" /><b> <?php echo $text_support; ?></b>
					</td>
				</tr>
	<tr>
					<td colspan="4">
						<span style='text-align: center;'><b><?php echo $text_module_settings; ?></b></span>
					</td>
				</tr>
      </table>
      <table id="module" class="list">
		<thead>
          <tr>
            <td class="left"><?php echo $entry_layout; ?></td>
            <td class="left"><?php echo $entry_position; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td class="left"><select name="fbjsconnect_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="fbjsconnect_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="left"><select name="fbjsconnect_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input type="text" name="fbjsconnect_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="4"></td>
            <td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="fbjsconnect_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="fbjsconnect_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="fbjsconnect_module[' + module_row + '][status]">';
	html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '      <option value="0"><?php echo $text_disabled; ?></option>';
	html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="fbjsconnect_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>

<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
<br>
		<div style="text-align:center; color:#222222;"><?php echo $entry_version; ?><?php echo $entry_licence; ?><?php echo $entry_creator; ?><br><?php echo$entry_updated; ?></div>
</div>
<?php echo $footer; ?>