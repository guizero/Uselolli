<?php echo $header ?>

<div id="content">

	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb): ?>
			<?php echo $breadcrumb['separator'] ?> <a href="<?php echo $breadcrumb['href'] ?>"><?php echo $breadcrumb['text']?></a>
		<?php endforeach ?>
	</div>
	
	<?php if ($warning): ?>
	<div class="warning"><?php echo $warning ?></div>
	<?php endif ?>

	<div class="box">
		<div class="heading">
			<h1>Etiqueta Correios</h1>
			<div class="buttons">
				<a onClick="$('form').submit()" class="button">Salvar</a>
				<a href="<?php echo $cancel ?>" class="button">Cancelar</a>
			</div>
		</div>

		<div class="content">

			<form action="<?php echo $action ?>" method="post">
				<table class="form">
					<tbody>
						<tr>
							<td><span class="required">*</span> Nome:</td>
							<td>
								<input type="text" name="etiquetaCorreios_Nome" value="<?php echo $etiquetaCorreios_Nome ?>" />
								<?php if($error_nome): ?>
								<span class="error">Obrigatório</span>
								<?php endif ?>
							</td>
						</tr>
						
						<tr>
							<td>Empresa:</td>
							<td><input type="text" name="etiquetaCorreios_Empresa" value="<?php echo $etiquetaCorreios_Empresa ?>" /></td>
						</tr>
						
						<tr>
							<td>Telefone:</td>
							<td><input type="text" name="etiquetaCorreios_Telefone" value="<?php echo $etiquetaCorreios_Telefone ?>" /></td>
						</tr>
						
						<tr>
							<td><span class="required">*</span> CEP:</td>
							<td>
								<input type="text" name="etiquetaCorreios_Cep" value="<?php echo $etiquetaCorreios_Cep ?>" />
								<?php if($error_cep): ?>
								<span class="error">Obrigatório</span>
								<?php endif ?>
							</td>
						</tr>
						
						<tr>
							<td><span class="required">*</span> Endereço:</td>
							<td>
								<input type="text" name="etiquetaCorreios_Endereco" value="<?php echo $etiquetaCorreios_Endereco ?>" />
								<?php if($error_endereco): ?>
								<span class="error">Obrigatório</span>
								<?php endif ?>
							</td>
						</tr>
						
						<tr>
							<td><span class="required">*</span> Numero:</td>
							<td>
								<input type="text" name="etiquetaCorreios_Numero" value="<?php echo $etiquetaCorreios_Numero ?>" />
								<?php if($error_numero): ?>
								<span class="error">Obrigatório</span>
								<?php endif ?>
							</td>
						</tr>
						
						<tr>
							<td>Complemento:</td>
							<td><input type="text" name="etiquetaCorreios_Complemento" value="<?php echo $etiquetaCorreios_Complemento ?>" /></td>
						</tr>
						
						<tr>
							<td>Bairro:</td>
							<td><input type="text" name="etiquetaCorreios_Bairro" value="<?php echo $etiquetaCorreios_Bairro ?>" /></td>
						</tr>
						
						<tr>
							<td><span class="required">*</span> Cidade:</td>
							<td>
								<input type="text" name="etiquetaCorreios_Cidade" value="<?php echo $etiquetaCorreios_Cidade ?>" />
								<?php if($error_cidade): ?>
								<span class="error">Obrigatório</span>
								<?php endif ?>
							</td>
						</tr>
						
						<tr>
							<td><span class="required">*</span> Uf:</td>
							<td>
								<select name="etiquetaCorreios_Uf">
									<option> -- Selecione -- </option>
									<?php foreach($zones as $zone): ?>
									<?php if ($zone['code'] == $etiquetaCorreios_Uf): ?>
									<option value="<?php echo $zone['code'] ?>" selected="selected"><?php echo $zone['name'] ?></option>
									<?php else: ?>
									<option value="<?php echo $zone['code'] ?>"><?php echo $zone['name'] ?></option>
									<?php endif ?>
									<?php endforeach ?>
								</select>
								<?php if($error_estado): ?>
								<span class="error">Obrigatório</span>
								<?php endif ?>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>

</div>

<?php echo $footer ?>