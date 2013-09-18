
				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
					<script type="text/javascript">
					$(function(){
						/* Mascaras e Formatos */
						if($('input.numeric').length > 0) $('input.numeric').numeric();
					});
					</script>
				<?php } ?>
			
				<script type="text/javascript">
				$(function(){
					$('input[name="postcode"]').blur(function(){
						var cep = $.trim($('input[name="postcode"]').val().replace('-', ''));

						$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+cep, function(){
							if(resultadoCEP["resultado"] == "1"){
								$('input[name="address_1"]').val(unescape(resultadoCEP["tipo_logradouro"])+" "+unescape(resultadoCEP["logradouro"]));
								$('input[name="address_2"]').val(unescape(resultadoCEP["bairro"]));
								$('input[name="city"]').val(unescape(resultadoCEP["cidade"]));

								$('select[name="country_id"] option[value="30"]').attr('selected', true);
								$('select[name="zone_id"]').load('index.php?route=account/register/country&country_id=30', function(){
									$.post('index.php?route=account/register/estado_autocompletar&estado=' + unescape(resultadoCEP['uf']), function(zone_id){
										$.ajax({
											url: 'index.php?route=account/register/country&country_id=30',
											dataType: 'json',
											beforeSend: function() {
												$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/graveagudo2012/image/loading.gif" alt="" /></span>');
											},
											complete: function() {
												$('.wait').remove();
											},			
											success: function(json) {
												if (json['postcode_required'] == '1') {
													$('#postcode-required').show();
												} else {
													$('#postcode-required').hide();
												}
		
												var html = '<option value=""><?php echo $text_select; ?></option>';
		
												if (json['zone'] != '') {
													for (i = 0; i < json['zone'].length; i++) {
														html += '<option value="' + json['zone'][i]['zone_id'] + '"';
														
														if (json['zone'][i]['zone_id'] == zone_id) {
															html += ' selected="selected"';
														}
										
														html += '>' + json['zone'][i]['name'] + '</option>';
													}
												} else {
													html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
												}
		
												$('select[name=\'zone_id\']').html(html);
											}
										});
									});
								});
							}
						});
					});
				});
				</script>
			<table class="form">
  <tr>
    <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
    <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
    <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" /></td>

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<tr>
				  <td>Complemento</td>
				  <td><input type="text" name="complemento" value="<?php echo $complemento; ?>" class="large-field" /><span class="field-info">&nbsp;(Ex: Ap. 105)</span></td>
				</tr>
				<?php } ?>
			

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<tr>
				  <td>Local</td>
				  <td><input type="text" name="apelido" value="<?php echo $apelido; ?>" class="large-field" /><span class="field-info">&nbsp;(Ex: Casa, Trabalho, etc)</span></td></td>
				</tr>
				<?php } ?>
			
  </tr>
  <tr>
    <td><?php echo $entry_company; ?></td>
    <td><input type="text" name="company" value="<?php echo $company; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
    <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" class="large-field" /></td>

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<tr>
				  <td><span class="required">*</span> Número</td>
				  <td><input type="text" name="numero" value="<?php echo $numero; ?>" class="large-field numeric" /></td>
				</tr>
				<?php } ?>
			
  </tr>
  <tr>
    <td><?php echo $entry_address_2; ?></td>
    <td><input type="text" name="address_2" value="<?php echo $address_2; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_city; ?></td>
    <td><input type="text" name="city" value="<?php echo $city; ?>" class="large-field" /></td>
  </tr>
  <tr>
    <td><span id="shipping-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
    <td>
				<input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field numeric" />
			</td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_country; ?></td>
    <td><select name="country_id" class="large-field">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($countries as $country) { ?>
        <?php if ($country['country_id'] == $country_id) { ?>
        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
        <?php } ?>
        <?php } ?>
      </select></td>
  </tr>
  <tr>
    <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
    <td><select name="zone_id" class="large-field">
      </select></td>
  </tr>
</table>
<br />
<div class="buttons">
  <div class="right"><input type="button" value="<?php echo $button_continue; ?>" id="button-guest-shipping" class="button" /></div>
</div>
<script type="text/javascript"><!--
$('#shipping-address select[name=\'country_id\']').bind('change', function() {
	if (this.value == '') return;
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#shipping-postcode-required').show();
			} else {
				$('#shipping-postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#shipping-address select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#shipping-address select[name=\'country_id\']').trigger('change');
//--></script>