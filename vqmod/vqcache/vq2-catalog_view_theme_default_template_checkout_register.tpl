
				<script type="text/javascript">
				$(function(){
					$('input[name="postcode"]').blur(function(){
						var cep = $.trim($('input[name="postcode"]').val().replace('-', ''));

						$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+cep, function(){
							if(resultadoCEP["resultado"] == "1"){
								$('input[name="address_1"]').val(unescape(resultadoCEP["tipo_logradouro"])+" "+unescape(resultadoCEP["logradouro"]));
								$('input[name="address_2"]').val(unescape(resultadoCEP["bairro"]));
								$('input[name="city"]').val(unescape(resultadoCEP["cidade"]));

								$('select[name="country_id"]').find('option[value="30"]').attr('selected', true);
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
							}
						});
					});
				});
				</script>
			<div class="left form">
  <h2><?php echo $text_your_details; ?></h2>
  <span class="required">*</span> <?php echo $entry_firstname; ?><br />
  <input type="text" name="firstname" value="" required/>
  <br />
  <br />
  <span class="required">*</span> <?php echo $entry_lastname; ?><br />
  <input type="text" name="lastname" value="" class="large-field" required/>
  <br />
  <br />
  <span class="required">*</span> <?php echo $entry_email; ?><br />
  <input type="text" name="email" value="" class="large-field" required/>
  <br />
  <br />

				<span class="required">*</span> <?php echo $entry_email_confirm; ?><br />
  <input type="text" name="email_confirm" value="" class="large-field" />
  <br />
  <br />
			
  <span class="required">*</span> <?php echo $entry_telephone; ?><br />
  <input type="text" name="telephone" value="" class="large-field phone" required/>
  <br />
  <br />
  <?php echo $entry_fax; ?><br />
  
				<input type="text" name="fax" value="" class="large-field phone" /><br />
			
  <br />
  <br />

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
					<script type="text/javascript">
					$(function(){
						/* Registro - Tipo de Pessoa (PF/PJ) */
						$('.pessoa_fisica').show();
						$('.pessoa_juridica').hide();

						$('#juridica').click( function() {
						$('.pessoa_fisica').hide();
							$("#cpf").val("");
							$("#rg").val("");
							$('.pessoa_juridica').show();
						});
						$('#fisica').click( function() {
						$('.pessoa_fisica').show();
							$("#cnpj").val("");
							$("#razao_social").val("");
							$("#inscricao_estadual").val("");
							$('.pessoa_juridica').hide();
						});

						/* Mascaras e Formatos */
						if($('input.phone').length > 0) $('input.phone').mask('(99) 9999-9999?9');
						if($('input.date').length > 0) $('input.date').mask('99/99/9999');
						if($('input.cpf').length > 0) $('input.cpf').mask('999.999.999-99');
						if($('input.cnpj').length > 0) $('input.cnpj').mask('99.999.999/9999-99');
						if($('input.alphanumeric').length > 0) $('input.alphanumeric').alphanumeric();
						if($('input.numeric').length > 0) $('input.numeric').numeric();
					});
					</script>
					Sexo:<br />
					<input type="radio" name="sexo" checked value="m">Masculino
					<input type="radio" name="sexo" value="f">Feminino
					<br /><br />Data de Nascimento:<br />
					<input type="text" name="data_nascimento" class="large-field date" /><br />
					<div class="some">Tipo:<br />
					<input type="radio" name="pessoa" id="fisica" checked value="fisica">
					Pessoa Física 
					<input type="radio" id="juridica" name="pessoa" value="juridica">
					Pessoa Juridica</div>
					<div class="pessoa_fisica">
					  <br /><span class="required">*</span> CPF:<br />
					  <input type="text" name="cpf" id="cpf" class="large-field cpf" required/><br /><br />
					  RG:<br />
					  <input type="text" name="rg" id="rg" class="large-field numeric" /><br /><br />
					</div>
					<div class="pessoa_juridica">
					  <br /><span class="required">*</span> CNPJ:<br />
					  <input type="text" name="cnpj" id="cnpj" class="large-field cnpj" /><br /><br /><br />
					  Razão Social:<br />
					  <input type="text" name="razao_social" id="razao_social" class="large-field" /><br /><br />
					  Inscrição Estadual:<br />
					  <input type="text" name="inscricao_estadual" id="inscricao_estadual" class="large-field alphanumeric" /><br /><span class="field-info">(apenas números e letras)</span>
					  <br />
					  <br />
					</div>
				<?php } ?>
			
  <h2><?php echo $text_your_password; ?></h2>
  <span class="required">*</span> <?php echo $entry_password; ?><br />
  <input type="password" name="password" value="" class="large-field" requried />
  <br />
  <br />
  <span class="required">*</span> <?php echo $entry_confirm; ?> <br />
  <input type="password" name="confirm" value="" class="large-field" required/>
  <br />
  <br />
  <br />
</div>
<div class="right form">
  <h2><?php echo $text_your_address; ?></h2>

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				Local:<br />
				<input type="text" name="apelido" value="" class="large-field" /><br /><span class="field-info">(Ex: Casa, Trabalho, etc)</span>
				<br />
				<br />
				<?php } ?>
			
  <input type="hidden" name="company" value="" class="large-field" />
  <div style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
  <?php echo $entry_customer_group; ?><br />
  <?php foreach ($customer_groups as $customer_group) { ?>
  <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
  <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
  <br />
  <?php } else { ?>
  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
  <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
  <br />
  <?php } ?>
  <?php } ?>
  <br />
</div>
<div id="company-id-displa" class="some"><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?><br />
  <input type="text" name="company_id" value="" class="large-field" />
  <br />
  <br />
</div>
<div id="tax-id-display" class="some"><span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?><br />
  <input type="text" name="tax_id" value="" class="large-field" />
  <br />
  <br />
</div>
<span class="required">*</span> <?php echo $entry_address_1; ?><br />
<input type="text" name="address_1" value="" class="large-field" />
<br />
<br />

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				<span class="required">*</span> Número:<br />
				<input type="text" name="numero" value="" class="large-field numeric" required/>
				<br />
				<br />
				<?php } ?>
			
<?php echo $entry_address_2; ?><br />
<input type="text" name="address_2" value="" class="large-field" />
<br />
<br />

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				Complemento:<br />
				<input type="text" name="complemento" value="" class="large-field" /><br /><span class="field-info">&nbsp;(Ex: Ap. 105)</span>
				<br />
				<br />
				<?php } ?>
			
<span class="required">*</span> <?php echo $entry_city; ?><br />
<input type="text" name="city" value="" class="large-field" />
<br />
<br />
<span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?><br />

				<input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field numeric" /><br />
			
<br />
<br />
<div class="some">
<span class="required">*</span> <?php echo $entry_country; ?><br />
<select name="country_id" class="large-field">
  <option value=""><?php echo $text_select; ?></option>
  <?php foreach ($countries as $country) { ?>
  <?php if ($country['country_id'] == $country_id) { ?>
  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
  <?php } else { ?>
  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
  <?php } ?>
  <?php } ?>
</select>
</div>
<span class="required">*</span> <?php echo $entry_zone; ?><br />
<select name="zone_id" class="large-field">
</select>
<br />
<br />
<br />
</div>
<div style="clear: both; padding-top: 15px; border-top: 1px solid #EEEEEE;">
  <input type="checkbox" name="newsletter" value="1" id="newsletter" />
  <label for="newsletter"><?php echo $entry_newsletter; ?></label>
  <br />
  <?php if ($shipping_required) { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
  <label for="shipping"><?php echo $entry_shipping; ?></label>
  <br />
  <?php } ?>
  <br />
  <br />
</div>
<?php if ($text_agree) { ?>
<div class="buttons">
  <div class="right"><?php echo $text_agree; ?>
    <input type="checkbox" name="agree" value="1" />
    <input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" />
  </div>
</div>
<?php } else { ?>
<div class="buttons">
  <div class="right">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" />
  </div>
</div>
<?php } ?>
<script type="text/javascript"><!--
$('#payment-address input[name=\'customer_group_id\']:checked').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('#payment-address input[name=\'customer_group_id\']:checked').trigger('change');
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
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script> 