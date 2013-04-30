<?php echo $header; ?>

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
			
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<!--<?php echo $column_left; ?>--><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h2>Conecte-se através do Facebook:</h2>
  <p><span id="fb-root"></span><span class="box box-fbconnect" id="login-btr"><span class="box-fbconnect-a" id="fb-login"><img src="https://www.farfeloo.com/image/data/facebookgrande.png" style="vertical-align:middle"> <span class="cursor"></span></span></span></p>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2>Ou, preencha nosso formulário abaixo:</h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
          <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="Maria" required />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?></td>
        
          <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
          <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="Silva" required/>
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_email; ?></td>
          <td><input type="email" name="email" value="<?php echo $email; ?>" placeholder="mariasilva@exemplo.com" required/>
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?></td>
          <td><span class="required">*</span> <?php echo $entry_email_confirm; ?></td>
          <td><input type="email" name="email_confirm" value="<?php echo $email_confirm; ?>" placeholder="mariasilva@exemplo.com" required/>
            <?php if ($error_email_confirm) { ?>
            <span class="error"><?php echo $error_email_confirm; ?></span>
            <?php } ?></td>
        </tr>

        <tr>
          <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
          <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" class="phone" placeholder="Apenas números: DDD + Número" required pattern="[\(]\d{2}[\)] \d{4}[\-]\d{4}"/>
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?></td>
          <td><span class="required">*</span> Data de Nascimento:</td>
          <td>
            <input type="text" name="data_nascimento" value="<?php echo $data_nascimento; ?>" class="date" required placeholder="DD/MM/AAAA" pattern="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"/>
          <?php if ($error_data_nascimento) { ?>
          <span class="error"><?php echo $error_data_nascimento; ?></span>
          <?php } ?>
          </td>
        </tr>
        
        <tr class="pessoa_fisica">
          <td><span class="required">*</span> CPF:</td>
          <td>
            <input type="text" name="cpf" id="cpf" value="<?php echo $cpf; ?>" class="cpf" placeholder="Apenas números" required pattern="\d{3}[\.]\d{3}[\.]\d{3}[\-]\d{2}"/></span>
          <?php if ($error_cpf) { ?>
          <span class="error"><?php echo $error_cpf; ?></span>
          <?php } ?>
          </td>
          <td><span class="required">*</span> Sexo:</td>
          <td>
            <?php if ($sexo == 'm'){ ?>
          <input type="radio" name="sexo" checked value="f">Feminino
          <input type="radio" name="sexo" value="m">Masculino
          <?php }else if($sexo == 'f'){ ?>
          <input type="radio" name="sexo" value="f">Feminino
          <input type="radio" name="sexo" checked value="m">Masculino
          <?php }else{ ?>
          <input type="radio" name="sexo" checked value="f">Feminino
          <input type="radio" name="sexo" value="m">Masculino
          <?php } ?>
          </td>
        </tr>
        
        <tr class="some">
          <td>Tipo:</td>
          <td>
            <?php if($pessoa == 'fisica'){ ?>
          <input type="radio" name="pessoa" id="fisica" checked value="fisica">Pessoa Física
          <input type="radio" id="juridica" name="pessoa" value="juridica">Pessoa Juridica
          <?php }else if($pessoa == 'juridica'){ ?>
          <input type="radio" name="pessoa" id="fisica" value="fisica">Pessoa Física
          <input type="radio" id="juridica" name="pessoa" checked value="juridica">Pessoa Juridica
          <?php }else{ ?>
          <input type="radio" name="pessoa" id="fisica" checked value="fisica">Pessoa Física
          <input type="radio" id="juridica" name="pessoa" value="juridica">Pessoa Juridica
          <?php } ?>
          </td>
        </tr>
        <tr class="pessoa_juridica">
          <td><span class="required">*</span> CNPJ:</td>
          <td>
            <input type="text" name="cnpj" id="cnpj" value="<?php echo $cnpj; ?>" class="cnpj" /></span>
          <?php if($error_cnpj){ ?>
          <span class="error"><?php echo $error_cnpj; ?></span>
          <?php } ?>
          </td>
        </tr>
        <tr class="pessoa_juridica">
          <td>Razão Social:</td>
          <td><input type="text" name="razao_social" id="razao_social" value="<?php echo $razao_social; ?>"></td>
        </tr>
        <tr class="pessoa_juridica">
          <td>Inscrição Estadual:</td>
          <td><input type="text" name="inscricao_estadual" id="inscricao_estadual" value="<?php echo $inscricao_estadual; ?>" class="alphanumeric" /></td>
        </tr>         
        
       


          <input type="hidden" name="rg" id="rg" value="" class="numeric" />
          <input type="hidden" name="fax" value="<?php echo $fax; ?>" />
          <input type="hidden" name="apelido" value="Casa" />
          <input type="hidden" name="numero" value="100"/>
          <input type="hidden" name="complemento" value="<?php echo $complemento; ?>" />

        
      </table>
    </div>
    <h2 class="some"><?php echo $text_your_address; ?></h2>
    <div class="content some">
      <table class="form">
        <tr>
          <td><?php echo $entry_company; ?></td>
          <td><input type="text" name="company" value="<?php echo $company; ?>" /></td>
        </tr>        
        <tr style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
          <td><?php echo $entry_customer_group; ?></td>
          <td><?php foreach ($customer_groups as $customer_group) { ?>
            <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />
            <?php } else { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />
            <?php } ?>
            <?php } ?></td>
        </tr>      
        <tr id="company-id-display">
          <td><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?></td>
          <td><input type="text" name="company_id" value="<?php echo $company_id; ?>" />
            <?php if ($error_company_id) { ?>
            <span class="error"><?php echo $error_company_id; ?></span>
            <?php } ?></td>
        </tr>
        <tr id="tax-id-display">
          <td><span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?></td>
          <td><input type="text" name="tax_id" value="<?php echo $tax_id; ?>" />
            <?php if ($error_tax_id) { ?>
            <span class="error"><?php echo $error_tax_id; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
          <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <span class="error"><?php echo $error_address_1; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_address_2; ?></td>
          <td><input type="text" name="address_2" value="<?php echo $address_2; ?>" /></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_city; ?></td>
          <td><input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <span class="error"><?php echo $error_city; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
          <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_country; ?></td>
          <td><select name="country_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
          <td><select name="zone_id">
            </select>
            <?php if ($error_zone) { ?>
            <span class="error"><?php echo $error_zone; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <h2><?php echo $text_your_password; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_password; ?></td>
          <td><input type="password" name="password" value="<?php echo $password; ?>" />
            <?php if ($error_password) { ?>
            <span class="error"><?php echo $error_password; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_confirm; ?></td>
          <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <span class="error"><?php echo $error_confirm; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <h2><?php echo $text_newsletter; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_newsletter; ?></td>
          <td><?php if ($newsletter) { ?>
            <input type="radio" name="newsletter" value="1" checked="checked" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="newsletter" value="1" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <?php if ($text_agree) { ?>
    <div class="buttons">
      <div class="right"><?php echo $text_agree; ?>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?>
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" style="width:200px;height: 60px; font-size:16px; color:white;" />
      </div>
    </div>
    <?php } else { ?>
    <div class="buttons">
      <div class="right">
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" style="width:200px;height: 60px; font-size:16px; color:white;"/>
      </div>
    </div>
    <?php } ?>
  </form>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('input[name=\'customer_group_id\']:checked').live('change', function() {
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

$('input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=account/register/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
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
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		width: 640,
		height: 480
	});
});
//--></script> 
<?php echo $footer; ?>