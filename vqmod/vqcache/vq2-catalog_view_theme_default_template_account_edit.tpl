<?php echo $header; ?>
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
  <h1><?php echo $heading_title; ?></h1>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_your_details; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
          <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?></td>
        
          <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
          <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_email; ?></td>
          <td><input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?></td>
        
          <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
          <td>
				<input type="text" name="telephone" value="<?php echo $telephone; ?>" class="phone" />
			
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_fax; ?></td>
          <td>
				<input type="text" name="fax" value="<?php echo $fax; ?>" class="phone" />
			</td>
      

				<?php if ($this->config->get('fields_register_brazil_status')){ ?>
				
				  <td>Sexo:</td>
				  <td>
				    <?php if ($sexo == 'f'){ ?>
					<input type="radio" name="sexo" checked value="f">Feminino
					<input type="radio" name="sexo" value="m">Masculino
					<?php }else if($sexo == 'm'){ ?>
					<input type="radio" name="sexo" value="f">Feminino
					<input type="radio" name="sexo" checked value="m">Masculino
					<?php }else{ ?>
					<input type="radio" name="sexo" checked value="f">Feminino
					<input type="radio" name="sexo" value="m">Masculino
					<?php } ?>
				  </td>
				</tr>
				<tr>
				  <td>Data de Nascimento:</td>
				  <?php 
				  $dataparts = explode("-",$data_nascimento);
				  if (sizeof($dataparts) != '3'){
					  $data = $data_nascimento;
				  }else{
					  $data = $dataparts[2]."/".$dataparts[1]."/".$dataparts[0]; 
				  }
				  $data = ($data != '00/00/0000') ? $data : '';
				  ?>
				  <td><input type="text" name="data_nascimento" value="<?php echo $data; ?>" class="date" />
				  <?php if ($error_data_nascimento) { ?>
				  <span class="error"><?php echo $error_data_nascimento; ?></span>
				  <?php } ?>
				  </td>
				
				  <td><span class="required">*</span> CPF:</td>
				  <td>
				    <input type="text" name="cpf" id="cpf" value="<?php echo $cpf; ?>" class="cpf" />
					<?php if ($error_cpf) { ?>
					<span class="error"><?php echo $error_cpf; ?></span>
					<?php } ?>
				  </td>
				</tr>
				<tr class="pessoa_fisica">
				  <td>RG:</td>
				  <td><input type="text" name="rg" id="rg" value="<?php echo $rg; ?>" class="numeric" /></td>
				</tr>
				
				<?php } ?>
			

      <input type="hidden" name="pessoa" value="">  
      <input type="hidden" name="cnpj" value="">  
      <input type="hidden" name="inscricao_estadual" value="">  
      <input type="hidden" name="razao_social" value="">  
      <input type="hidden" name="pessoa" value="">  
      </table>
    </div>
    <div class="buttons">
      <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
      <div class="right">
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
  </form>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>