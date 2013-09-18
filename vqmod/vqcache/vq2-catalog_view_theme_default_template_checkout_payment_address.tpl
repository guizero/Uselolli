
				<script type="text/javascript">
				$(function(){
					$('div#payment-new').find('input[name="postcode"]').blur(function(){
						var cep = $.trim($('div#payment-new').find('input[name="postcode"]').val().replace('-', ''));

						$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+cep, function(){
							if(resultadoCEP["resultado"] == "1"){
								$('div#payment-new').find('input[name="address_1"]').val(unescape(resultadoCEP["tipo_logradouro"])+" "+unescape(resultadoCEP["logradouro"]));
								$('div#payment-new').find('input[name="address_2"]').val(unescape(resultadoCEP["bairro"]));
								$('div#payment-new').find('input[name="city"]').val(unescape(resultadoCEP["cidade"]));

								$('div#payment-new').find('select[name="country_id"] option[value="30"]').attr('selected', true);
								$('div#payment-new').find('select[name="zone_id"]').load('index.php?route=account/register/country&country_id=30', function(){
									$.post('index.php?route=account/register/estado_autocompletar&estado=' + unescape(resultadoCEP['uf']), function(zone_id){
										$.ajax({
											url: 'index.php?route=account/register/country&country_id=30',
											dataType: 'json',
											beforeSend: function() {
												$('div#payment-new').find('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/graveagudo2012/image/loading.gif" alt="" /></span>');
											},
											complete: function() {
												$('.wait').remove();
											},			
											success: function(json) {
												if (json['postcode_required'] == '1') {
													$('div#payment-new').find('#postcode-required').show();
												} else {
													$('div#payment-new').find('#postcode-required').hide();
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
		
												$('div#payment-new').find('select[name=\'zone_id\']').html(html);
											}
										});
									});
								});
							}
						});
					});
				});
				</script>

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<script type="text/javascript">
				$(function(){
					// Mascaras e Formatos
					if($('input.numeric').length > 0) $('input.numeric').numeric();
					if($('input.alpha').length > 0) $('input.alpha').alpha();
					if($('input.alphanumeric').length > 0) $('input.alphanumeric').alphanumeric();
				});
				</script>
				<?php }?>
			
			<?php if ($addresses) { ?>
<input type="radio" name="payment_address" value="existing" id="payment-address-existing" checked="checked" />
<label for="payment-address-existing"><?php echo $text_address_existing; ?></label>
<div id="payment-existing">
  <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
    <?php foreach ($addresses as $address) { ?>
    <?php if (($address['city'] != "") && ($address['zone'] != "") && ($address['address_1'] != "")) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    
				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<?php
				$apelido     = ($address['apelido'] != '') ? '('. $address['apelido'] .') ' : '';
				$bairro      = ($address['address_2'] != '') ? ', ' . $address['address_2'] : '';
				$complemento = ($address['complemento'] != '') ? ', ' . $address['complemento'] : '';
				?>
				<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $apelido . $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['numero'] . $bairro . $complemento; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
				<?php }else{ ?>
				<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
				<?php } ?>
			
    <?php } else { ?>
    
				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<?php
				$apelido     = ($address['apelido'] != '') ? '('. $address['apelido'] .') ' : '';
				$bairro      = ($address['address_2'] != '') ? ', ' . $address['address_2'] : '';
				$complemento = ($address['complemento'] != '') ? ', ' . $address['complemento'] : '';
				?>
				<option value="<?php echo $address['address_id']; ?>"><?php echo $apelido . $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['numero'] . $bairro . $complemento; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
				<?php }else{ ?>
				<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
				<?php } ?>
			
    <?php } ?>
    <?php } ?>
    <?php } ?>
  </select>
</div>
<p>
  <input type="radio" name="payment_address" value="new" id="payment-address-new" />
  <label for="payment-address-new"><?php echo $text_address_new; ?></label>
</p>
<?php } ?>
<div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
  <table class="form">

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<tr>
				  <td>Local:</td>
				  <td><input type="text" name="apelido" value="" class="large-field" /><span class="field-info">&nbsp;(Ex: Casa, Trabalho, etc)</span></td>
				</tr>
				<?php } ?>
			
    <tr>
      <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
      <td><input type="text" name="firstname" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
      <td><input type="text" name="lastname" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><?php echo $entry_company; ?></td>
      <td><input type="text" name="company" value="" class="large-field" /></td>
    </tr>
    <?php if ($company_id_display) { ?>
    <tr>
      <td><?php if ($company_id_required) { ?>
        <span class="required">*</span>
        <?php } ?>
        <?php echo $entry_company_id; ?></td>
      <td><input type="text" name="company_id" value="" class="large-field" /></td>
    </tr>
    <?php } ?>
    <?php if ($tax_id_display) { ?>
    <tr>
      <td><?php if ($tax_id_required) { ?>
        <span class="required">*</span>
        <?php } ?>
        <?php echo $entry_tax_id; ?></td>
      <td><input type="text" name="tax_id" value="" class="large-field" /></td>
    </tr>
    <?php } ?>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
      <td><input type="text" name="address_1" value="" class="large-field" /></td>
    </tr>

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<tr>
				  <td><span class="required">*</span> Número:</td>
				  <td><input type="text" name="numero" value="" class="large-field numeric" /></td>
				</tr>
				<?php } ?>
			
    <tr>
      <td><?php echo $entry_address_2; ?></td>
      <td><input type="text" name="address_2" value="" class="large-field" /></td>
    </tr>

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<tr>
				  <td>Complemento:</td>
				  <td><input type="text" name="complemento" value="" class="large-field" /><span class="field-info">&nbsp;(Ex: Ap. 105)</span></td>
				</tr>
				<?php } ?>
			
    <tr>
      <td><span class="required">*</span> <?php echo $entry_city; ?></td>
      <td><input type="text" name="city" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
      <td>
				<input type="text" name="postcode" value="" class="large-field numeric" />
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
</div>
<br />
<div class="buttons">
  <div class="right">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-address" class="button" />
  </div>
</div>
<script type="text/javascript"><!--
$('#payment-address input[name=\'payment_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#payment-existing').hide();
		$('#payment-new').show();
	} else {
		$('#payment-existing').show();
		$('#payment-new').hide();
	}
});
//--></script> 
<script type="text/javascript"><!--
$('#payment-address select[name=\'country_id\']').bind('change', function() {
	if (this.value == '') return;
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#payment-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#payment-postcode-required').show();
			} else {
				$('#payment-postcode-required').hide();
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
			
			$('#payment-address select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#payment-address select[name=\'country_id\']').trigger('change');
//--></script>