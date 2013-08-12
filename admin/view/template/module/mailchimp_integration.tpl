<?php
//==============================================================================
// MailChimp Integration v155.7
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php echo str_replace('<body>', '<body><div id="syncing" style="display: none">' . $text_syncing . '</div>', $header); ?>
<style type="text/css">
	div {
		white-space: nowrap;
	}
	.content .heading {
		background: #E4EEF7;
		font-weight: bold;
	}
	.help {
		font-style: italic;
		margin-top: 5px;
		white-space: normal;
	}
	.scrollbox {
		height: 200px;
	}
	.scrollbox .heading {
		padding: 7px;
	}
	.scrollbox .customer-group {
		text-align: right;
	}
	.green {
		background: #080 !important;
	}
	.red {
		background: #B00 !important;
	}
	.status {
		color: #FFF; 
		cursor: pointer;
		font-size: 18px;
	}
	#syncing {
		background: #000;
		color: #FFF;
		font-size: 100px;
		height: 100%;
		opacity: 0.5;
		padding-top: 10%;
		position: fixed;
		text-align: center;
		width: 100%;
		z-index: 10000;
	}
</style>
<?php if ($version > 149) { ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
<?php } ?>
<?php if ($error_warning) { ?><div class="warning"><?php echo $error_warning; ?></div><?php } ?>
<?php if ($success) { ?><div class="success"><?php echo $success; ?></div><?php } ?>
<div class="box">
	<?php if ($version < 150) { ?><div class="left"></div><div class="right"></div><?php } ?>
	<div class="heading">
		<h1 style="padding: 10px 2px 0"><img src="view/image/<?php echo $type; ?>.png" alt="" style="vertical-align: middle" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="$('#form').attr('action', location + '&exit=true'); $('#form').submit()" class="button"><span><?php echo $button_save_exit; ?></span></a>
			<a onclick="$('#form').submit()" class="button"><span><?php echo $button_save_keep_editing; ?></span></a>
			<a onclick="location = '<?php echo $exit; ?>'" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
	</div>
	<div class="content">
		<form action="" method="post" enctype="multipart/form-data" id="form">
			<table class="form">
				<tr class="heading">
					<td colspan="2"><?php echo $entry_general_settings; ?></td>
				</tr>
				<tr>
					<td colspan="2"><?php echo $help_general_settings; ?></td>
				</tr>
				<tr>
					<td style="min-width: 300px"><?php echo $entry_status; ?>:</td>
					<td><select name="<?php echo $name; ?>_data[status]">
							<option value="1" <?php if (!empty(${$name.'_data'}['status'])) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
							<option value="0" <?php if (empty(${$name.'_data'}['status'])) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_api_key; ?></td>
					<td><input type="text" size="50" name="<?php echo $name; ?>_data[apikey]" value="<?php echo (!empty(${$name.'_data'}['apikey'])) ? ${$name.'_data'}['apikey'] : ''; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_newsletter_status; ?></td>
					<td><?php echo $text_subscribed_customers; ?>
						<select name="<?php echo $name; ?>_data[subscribed_group]">
							<?php foreach ($customer_groups as $customer_group) { ?>
								<option value="<?php echo $customer_group['customer_group_id']; ?>" <?php if (!empty(${$name.'_data'}['subscribed_group']) && $customer_group['customer_group_id'] == ${$name.'_data'}['subscribed_group']) echo 'selected="selected"'; ?>>
									<?php echo ($customer_group['customer_group_id']) ? $customer_group['name'] : $text_no_change; ?>
								</option>
							<?php } ?>
						</select>
						<br />
						<?php echo $text_unsubscribed_customers; ?>
						<select name="<?php echo $name; ?>_data[unsubscribed_group]">
							<?php foreach ($customer_groups as $customer_group) { ?>
								<option value="<?php echo $customer_group['customer_group_id']; ?>" <?php if (!empty(${$name.'_data'}['unsubscribed_group']) && $customer_group['customer_group_id'] == ${$name.'_data'}['unsubscribed_group']) echo 'selected="selected"'; ?>>
									<?php echo ($customer_group['customer_group_id']) ? $customer_group['name'] : $text_no_change; ?>
								</option>
							<?php } ?>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_default_list; ?></td>
					<td><?php if (empty($lists)) { ?>
							<em><?php echo $text_enter_an_api_key; ?></em>
						<?php } else { ?>
							<select name="<?php echo $name; ?>_data[listid]">
								<?php foreach ($lists as $list) { ?>
									<option value="<?php echo $list['id']; ?>" <?php if (!empty(${$name.'_data'}['listid']) && $list['id'] == ${$name.'_data'}['listid']) echo 'selected="selected"'; ?>>
										<?php echo $list['name']; ?>
									</option>
								<?php } ?>
							</select>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_list_mapping; ?></td>
					<td><?php if (empty($lists)) { ?>
							<em><?php echo $text_enter_an_api_key; ?></em>
						<?php } else { ?>
							<div class="scrollbox">
								<?php foreach ($stores as $store) { ?>
									<div class="heading"><?php echo $store['name']; ?></div>
									<?php foreach ($customer_groups as $customer_group) { ?>
										<div class="customer-group">
											<?php echo $customer_group['name']; ?>:
											<select name="<?php echo $name; ?>_data[lists][<?php echo $store['store_id']; ?>][<?php echo $customer_group['customer_group_id']; ?>]">
												<option value="0"><?php echo $text_default_list; ?></option>
												<?php $list_id = (!empty(${$name.'_data'}['lists'][$store['store_id']][$customer_group['customer_group_id']])) ? ${$name.'_data'}['lists'][$store['store_id']][$customer_group['customer_group_id']] : 0; ?>
												<?php foreach ($lists as $list) { ?>
													<option value="<?php echo $list['id']; ?>" <?php if ($list['id'] == $list_id) echo 'selected="selected"'; ?>>
														<?php echo $list['name']; ?>
													</option>
												<?php } ?>
											</select>
										</div>
									<?php } ?>
								<?php } ?>
							</div>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_autocreate; ?></td>
					<td><select name="<?php echo $name; ?>_data[autocreate]">
							<?php $autocreate = (empty(${$name.'_data'}['autocreate'])) ? 0 : ${$name.'_data'}['autocreate']; ?>
							<option value="0" <?php if ($autocreate == 0) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							<option value="1" <?php if ($autocreate == 1) echo 'selected="selected"'; ?>><?php echo $text_yes_disabled; ?></option>
							<option value="2" <?php if ($autocreate == 2) echo 'selected="selected"'; ?>><?php echo $text_yes_enabled; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_double_optin; ?></td>
					<td><select name="<?php echo $name; ?>_data[double_optin]">
							<option value="1" <?php if (!isset(${$name.'_data'}['double_optin']) || ${$name.'_data'}['double_optin']) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
							<option value="0" <?php if (isset(${$name.'_data'}['double_optin']) && !${$name.'_data'}['double_optin']) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_log_errors_and; ?></td>
					<td><select name="<?php echo $name; ?>_data[logerrors]">
							<option value="0" <?php if (empty(${$name.'_data'}['logerrors'])) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							<option value="1" <?php if (!empty(${$name.'_data'}['logerrors'])) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
						</select>
					</td>
				</tr>
				<tr class="heading">
					<td colspan="2"><?php echo $entry_merge_tags; ?></td>
				</tr>
				<tr>
					<td colspan="2"><?php echo $help_merge_tags; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_fname_merge_tag; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[fname]" value="<?php echo (isset(${$name.'_data'}['fname'])) ? ${$name.'_data'}['fname'] : 'FNAME'; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_lname_merge_tag; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[lname]" value="<?php echo (isset(${$name.'_data'}['lname'])) ? ${$name.'_data'}['lname'] : 'LNAME'; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_address_merge_tag; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[address]" value="<?php echo (isset(${$name.'_data'}['address'])) ? ${$name.'_data'}['address'] : 'ADDRESS'; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_phone_merge_tag; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[phone]" value="<?php echo (isset(${$name.'_data'}['phone'])) ? ${$name.'_data'}['phone'] : 'PHONE'; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_default_language; ?></td>
					<td><select name="<?php echo $name; ?>_data[default_language]">
							<?php $default_language = (isset(${$name.'_data'}['default_language'])) ? ${$name.'_data'}['default_language'] : ''; ?>
							<?php foreach ($mc_language as $text => $code) { ?>
								<option value="<?php echo $code; ?>" <?php if ($code == $default_language) echo 'selected="selected"'; ?>><?php echo $text; ?></option>
							<?php } ?>
						</select>
					</td>
				</tr>
				<tr class="heading">
					<td colspan="2"><?php echo $entry_webhook_settings; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_webhooks; ?></td>
					<td><input type="checkbox" value="1" name="<?php echo $name; ?>_data[webhooks][subscribe]" <?php if (!empty(${$name.'_data'}['webhooks']['subscribe'])) echo 'checked="checked"'; ?> />
						<?php echo $text_subscribes; ?>
						<br />
						<input type="checkbox" value="1" name="<?php echo $name; ?>_data[webhooks][unsubscribe]" <?php if (!empty(${$name.'_data'}['webhooks']['unsubscribe'])) echo 'checked="checked"'; ?> />
						<?php echo $text_unsubscribes; ?>
						<br />
						<input type="checkbox" value="1" name="<?php echo $name; ?>_data[webhooks][profile]" <?php if (!empty(${$name.'_data'}['webhooks']['profile'])) echo 'checked="checked"'; ?> />
						<?php echo $text_profile_updates; ?>
						<br />
						<input type="checkbox" value="1" name="<?php echo $name; ?>_data[webhooks][cleaned]" <?php if (!empty(${$name.'_data'}['webhooks']['cleaned'])) echo 'checked="checked"'; ?> />
						<?php echo $text_cleaned_addresses; ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_url_code; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[urlcode]" value="<?php echo (!empty(${$name.'_data'}['urlcode'])) ? ${$name.'_data'}['urlcode'] : ''; ?>" onkeyup="$(this).val($(this).val().replace(/[^\w]/g, '')); $('#webhook-url-code').html($(this).val())" /></td>
				</tr>
				<tr class="heading">
					<td colspan="2"><?php echo $entry_manual_sync; ?></td>
				</tr>
				<tr>
					<td colspan="2"><?php echo $help_manual_sync; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_sync_opencart; ?></td>
					<td><a class="button" onclick="sync()"><span><?php echo $button_sync; ?></span></a></td>
				</tr>
				<tr class="heading">
					<td colspan="2"><strong><?php echo $entry_modules; ?></strong></td>
				</tr>
				<tr>
					<td colspan="2" style="border-bottom: none; padding-bottom: 0"><?php echo $help_modules; ?></td>
				</tr>
			</table>
			<table class="list">
			<thead>
				<tr style="height: 40px">
					<td class="center" style="width: 1px"><?php echo $entry_status; ?></td>
					<td class="center"><?php echo $entry_options; ?></td>
					<?php if ($version > 149) { ?><td class="center"><?php echo $entry_layout; ?></td><?php } ?>
					<td class="center"><?php echo $entry_position; ?></td>
					<td class="center"><?php echo $entry_sort_order; ?></td>
					<?php if ($version > 149) { ?><td class="left"></td><?php } ?>
				</tr>
			</thead>
			<?php $row = 1; ?>
			<?php $modules = (!empty(${$name.'_module'})) ? ${$name.'_module'} : array(''); ?>
			<?php foreach ($modules as $module) { ?>
				<tr>
					<td class="center status <?php echo (!empty($module['status'])) ? 'green' : 'red'; ?>" onclick="toggleStatus($(this))">
						<span><?php echo (!empty($module['status'])) ? '&#10004;' : '&#10008;'; ?></span>
						<input type="hidden" name="<?php echo $name; ?>_module[<?php echo $row; ?>][status]" value="<?php echo (!empty($module['status'])) ? 1 : 0; ?>" />
					</td>
					<td class="center">
						<div <?php if ($version < 152) echo 'style="display: none"'; ?>>
							<?php echo $text_display_as_popup; ?>
							<select name="<?php echo $name; ?>_module[<?php echo $row; ?>][popup]">
								<option value="0" <?php if (empty($module['popup'])) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
								<option value="1" <?php if (!empty($module['popup'])) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
							</select>
						</div>
						<div><?php echo $text_name_field; ?>
							<select name="<?php echo $name; ?>_module[<?php echo $row; ?>][name_field]">
								<?php $name_field = (!empty($module['name_field'])) ? $module['name_field'] : 'none'; ?>
								<option value="none" <?php if ($name_field == 'none') echo 'selected="selected"'; ?>><?php echo $text_none; ?></option>
								<option value="optional" <?php if ($name_field == 'optional') echo 'selected="selected"'; ?>><?php echo $text_optional; ?></option>
								<option value="required" <?php if ($name_field == 'required') echo 'selected="selected"'; ?>><?php echo $text_required; ?></option>
							</select>
						</div>
						<div><?php echo $text_redirect_url; ?>
							<input type="text" name="<?php echo $name; ?>_module[<?php echo $row; ?>][redirect]" value="<?php echo (!empty($module['redirect'])) ? $module['redirect'] : ''; ?>" />
						</div>
					</td>
				<?php if ($version > 149) { ?>
					<td class="center">
						<select name="<?php echo $name; ?>_module[<?php echo $row; ?>][layout_id]">
							<?php $layout_id = (!empty($module['layout_id'])) ? $module['layout_id'] : $this->config->get('config_layout_id'); ?>
							<?php foreach ($layouts as $layout) { ?>
								<option value="<?php echo $layout['layout_id']; ?>" <?php if ($layout_id == $layout['layout_id']) echo 'selected="selected"'; ?>><?php echo $layout['name']; ?></option>
							<?php } ?>
						</select>
					</td>
				<?php } ?>
					<td class="center">
						<select name="<?php echo $name; ?>_module[<?php echo $row; ?>][position]">
							<?php $position = (!empty($module['position'])) ? $module['position'] : ''; ?>
							<?php foreach ($positions as $pos) { ?>
								<option value="<?php echo $pos; ?>" <?php if ($position == $pos) echo 'selected="selected"'; ?>><?php echo ${'text_'.$pos}; ?></option>
							<?php } ?>
						</select>
					</td>
					<td class="center">
						<input type="text" size="1" name="<?php echo $name; ?>_module[<?php echo $row; ?>][sort_order]" value="<?php echo (isset($module['sort_order'])) ? $module['sort_order'] : ''; ?>" />
					</td>
				<?php if ($version > 149) { ?>
					<td class="left" style="width: 1px">
						<a onclick="removeRow($(this))"><img src="view/image/error.png" title="Remove" /></a>
						<br /><br />
						<a onclick="copyRow($(this))"><img src="view/image/category.png" title="Copy" /></a>
					</td>
				<?php } ?>
				</tr>
				<?php $row++; ?>
			<?php } ?>
				<?php if ($version > 149) { ?>
					<tr>
						<td class="left" colspan="7" style="background: #EEE"><a onclick="addRow($(this), false)" class="button"><span><?php echo $button_add_module; ?></span></a></td>
					</tr>
				<?php } ?>
			</table>
		</form>
		<?php echo $copyright; ?>
	</div>
</div>
<?php if ($version > 149) { ?>
	</div>
<?php } ?>
<script type="text/javascript"><!--
	function toggleStatus(element) {
		if (element.hasClass('green')) {
			element.removeClass('green').addClass('red');
			element.find('span').html('&#10008;');
			element.find('input').val('0');
		} else {
			element.removeClass('red').addClass('green');
			element.find('span').html('&#10004;');
			element.find('input').val('1');
		}
	}
	
	var newRow = <?php echo $row; ?>;
	
	function addRow(element) {
		var clone = element.parent().parent().prev().clone();
		clone.html(clone.html().replace(/\[\d+\]/g, '['+newRow+']'));
		clone.find('.status').removeClass('red').addClass('green');
		clone.find('.status span').html('&#10004;');
		clone.find('.status input').val('1');
		clone.find('input[type="text"]').val('');
		clone.find(':selected').removeAttr('selected');
		element.parent().parent().before(clone);
		window.scrollTo(0, document.body.scrollHeight);
		newRow++;
	}
	
	function copyRow(element) {
		var row = element.parent().parent();
		row.find('input').each(function(){
			$(this).attr('value', $(this).val());
		});
		var clone = row.clone();
		row.find('option').each(function(i){
			if($(this).is(':selected')) {
				clone.find('option').eq(i).attr('selected', 'selected');
			} else {
				clone.find('option').eq(i).removeAttr('selected');
			}
		});
		clone.html(clone.html().replace(/\[\d+\]/g, '['+newRow+']'));
		$('.list > tbody > tr:last-child').before(clone);
		window.scrollTo(0, document.body.scrollHeight);
		newRow++;
	}
	
	function removeRow(element) {
		if ($('.list > tbody > tr').length < 3) {
			element.parent().parent().find('.status').removeClass('red').addClass('green');
			element.parent().parent().find('.status span').html('&#10004;');
			element.parent().parent().find('.status input').val('1');
			element.parent().parent().find('input[type="text"]').val('');
			element.parent().parent().find('option:first-child').attr('selected', 'selected');
		} else {
			element.parent().parent().remove();
		}
	}
	
	function sync() {
		var apikey = $('input[name$="apikey]"]').val();
		var listid = $('select[name$="listid]"]').val();
		
		if (!apikey || !listid) {
			alert('<?php echo $text_sync_error; ?>');
		} else {
			if (confirm('<?php echo $text_sync_note; ?>')) {
				$('#syncing').fadeIn();
				$.ajax({
					type: 'POST',
					url: 'index.php?route=<?php echo $type; ?>/<?php echo $name; ?>/sync&token=<?php echo $token; ?>',
					data: $('#form :input'),
					success: function(data) {
						alert(data);
						$('#syncing').fadeOut();
					}
				});
			}
		}
	}
//--></script>
<?php echo $footer; ?>