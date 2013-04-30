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
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="form">
          <tr>
            <td><?php echo $entry_adminuid; ?></td>
            <td><input type="text" name="adminuid" value="<?php echo $adminuid; ?>" /></td>
          </tr>
          <tr>
           <td><?php echo $entry_appid; ?></td>
            <td><input type="text" name="appid" value="<?php echo $appid; ?>" /></td>
          </tr>
        </table>
        <table id="module" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_siteurl; ?></td>
			  <td class="left"><?php echo $entry_colorscheme; ?></td>
              <td class="left"><?php echo $entry_width; ?></td>
			  <td class="left"><?php echo $entry_numpost; ?></td>
              <td class="left"><?php echo $entry_layout; ?></td>
              <td class="left"><?php echo $entry_position; ?></td>
			  <td class="left"><?php echo $entry_store; ?></td>
              <td class="left"><?php echo $entry_status; ?></td>
              <td class="right"><?php echo $entry_sort_order; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($modules as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
				<td class="left"><select name="facebook_module[<?php echo $module_row; ?>][urltype]">
					<option value="0"><?php echo $text_chooseurl; ?></option>
					<?php if ($module['urltype'] == '1') { ?>
					<option value="1" selected="selected"><?php echo $text_staticurl; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_staticurl; ?></option>
					<?php } ?>
					<?php if ($module['urltype'] == '2') { ?>
						<option value="2" selected="selected"><?php echo $text_dynamicurl; ?></option>
					<?php } else { ?>
						<option value="2"><?php echo $text_dynamicurl; ?></option>
					<?php } ?>
				</select></td>
				<td class="left"><select name="facebook_module[<?php echo $module_row; ?>][colorscheme]">
					<option value=""><?php echo $text_choosecolor; ?></option>
					<?php if ($module['colorscheme'] == 'light') { ?>
					<option value="light" selected="selected"><?php echo $text_lightcolor; ?></option>
					<?php } else { ?>
					<option value="light"><?php echo $text_lightcolor; ?></option>
					<?php } ?>
					<?php if ($module['colorscheme'] == 'dark') { ?>
						<option value="dark" selected="selected"><?php echo $text_darkcolor; ?></option>
					<?php } else { ?>
						<option value="dark"><?php echo $text_darkcolor; ?></option>
					<?php } ?>
				</select></td>
				<td class="left"><input type="text" name="facebook_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" style="width:50px;" />
                <?php if (isset($error_dimension[$module_row])) { ?>
                <span class="error"><?php echo $error_dimension[$module_row]; ?></span>
                <?php } ?></td>
				<td class="left"><input type="text" name="facebook_module[<?php echo $module_row; ?>][numpost]" value="<?php echo $module['numpost']; ?>" style="width:50px;" />
                <?php if (isset($error_numpost[$module_row])) { ?>
                <span class="error"><?php echo $error_numpost[$module_row]; ?></span>
                <?php } ?></td>
				<td class="left"><select name="facebook_module[<?php echo $module_row; ?>][layout_id]">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              <td class="left"><select name="facebook_module[<?php echo $module_row; ?>][position]">
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
				<td class="left"><select name="facebook_module[<?php echo $module_row; ?>][store]">
				<option value="default">Default</option>
				<?php foreach ($stores as $store) { ?>
                  <?php if ($module['store'] == $store['url']) { ?>
                  <option value="<?php echo $store['url']; ?>" selected="selected"><?php echo $store['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $store['url']; ?>"><?php echo $store['name']; ?></option>
                  <?php } 
				  }?>
                </select></td>
              <td class="left"><select name="facebook_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td class="right"><input type="text" name="facebook_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" style="width:50px;" /></td>
              <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $module_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="9"></td>
              <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="facebook_module[' + module_row + '][urltype]">';
	html += '      <option value="0"><?php echo $text_chooseurl; ?></option>';
	html += '      <option value="1"><?php echo $text_staticurl; ?></option>';
	html += '      <option value="2"><?php echo $text_dynamicurl; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="facebook_module[' + module_row + '][colorscheme]">';
	html += '      <option value=""><?php echo $text_choosecolor; ?></option>';
	html += '      <option value="light"><?php echo $text_lightcolor; ?></option>';
	html += '      <option value="dark"><?php echo $text_darkcolor; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><input type="text" name="facebook_module[' + module_row + '][width]" value=""  style="width:50px;" /></td>';
	html += '    <td class="left"><input type="text" name="facebook_module[' + module_row + '][numpost]" value=""  style="width:50px;" /></td>';	
	html += '    <td class="left"><select name="facebook_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="facebook_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="facebook_module[' + module_row + '][store]">';
	html += '      <option value="default">Default</option>';
	<?php foreach ($stores as $store) { ?>
	html += '      <option value="<?php echo $store['url']; ?>"><?php echo addslashes($store['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="facebook_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="facebook_module[' + module_row + '][sort_order]" value="" style="width:50px;" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script> 
<?php echo $footer; ?>