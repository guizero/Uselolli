<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="inside_page"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>

  <div class="product-info">
  
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div class="image"><div class="image_inside"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class='cloud-zoom' id='zoom1' rel="tint: '#ffffff',tintOpacity:0.5 ,smoothMove:3,zoomWidth:390, zoomHeight:390, adjustY:-10, adjustX:28"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div><div class="zoom_btn">
            <a id="zoomer" class="colorbox" href="<?php echo $popup; ?>">Zoom</a>        
      </div></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <a href='<?php echo $popup; ?>' class='cloud-zoom-gallery' title='<?php echo $heading_title; ?>' rel="useZoom: 'zoom1', smallImage: '<?php echo $thumb; ?>' "><img class="zoom-tiny-image" src="<?php echo $thumb; ?>" alt = "<?php echo $heading_title; ?>"/></a>  
        <?php foreach ($images as $image) { ?>
        <a href='<?php echo $image['popup']; ?>' class='cloud-zoom-gallery' title='<?php echo $heading_title; ?>' rel="useZoom: 'zoom1', smallImage: '<?php echo $image['thumb']; ?>' "><img class="zoom-tiny-image" src="<?php echo $image['thumb']; ?>" alt = "<?php echo $heading_title; ?>"/></a>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php } ?>

    <div class="right"> 
      <h1 class="pr_name"><?php echo $heading_title; ?></h1>
 
      <?php if ($price) { ?>
      <div class="price">
      	<span class="txt_price"><?php echo $text_price; ?></span>
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
        <?php } ?>
        <br />
        <?php if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
        <?php } ?>
        <?php if ($discounts) { ?>
        <br />
        <div class="discount">
          <?php foreach ($discounts as $discount) { ?>
          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      <?php } ?>

       <!-- Exibicao de parcelas -->
              <?php
                /*
                  Configuracoes do sistema de parcelamento
                  ----------------------------------------
                  $maximo_parcelas = Define a quantidade maxima de parcelas aceita pela loja
                  $parcela_minima = Valor minimo da parcela aceito pela loja
                  $parcelas_sem_juros = Define quantas parcelas nao terao juros
                  $juros = Taxa de juros mensal
                  $moeda_da_loja = Permite especificar a moeda utilizada na loja

                  $tipo_de_calculo = Permite escolher o tipo de calculo a ser utilizado
                  0 = Juros simples (Pagamento Digital)
                  1 = Tabela Price (PagSeguro e outros)
                */

                $maximo_parcelas = 18;
                $parcela_minima = 15;
                $parcelas_sem_juros = 3;
                $juros = 1.95;
                $moeda_da_loja = 'R$ ';
                $tipo_de_calculo = 1;

                if (!$special) {
                  $preco_numero = str_replace(',','.',str_replace('.','', str_replace($moeda_da_loja,"",strip_tags($price))));
                } else {
                  $preco_numero = str_replace(',','.',str_replace('.','', str_replace($moeda_da_loja,"",strip_tags($special))));
                }

                if ($preco_numero >= $parcela_minima*2) {

                // Titulo
                echo '<b>Parcelamento no cart&atilde;o de cr&eacute;dito</b><br />';
                echo '<table width="100%">';

                // Inicia a primeira coluna
                echo '<div style="width: 50%; float:left;">';

                // Exibicao das parcelas
                for ($p = 2; $p <= $maximo_parcelas; $p++) {

                  // Se a parcela nao tiver juros
                  if ($p <= $parcelas_sem_juros) {
                    $valor_parcela = $preco_numero / $p;
                  }

                  // Se a parcela tiver juros
                  if ($p > $parcelas_sem_juros) {
                    if ($tipo_de_calculo == 0) {
                      $valor_parcela = ($preco_numero * pow(1+($juros/100), $p))/$p;
                    }
                    if ($tipo_de_calculo == 1) {
                      $valor_parcela = ($preco_numero * ($juros/100))/(1-(1/(pow(1+($juros/100), $p))));
                    }
                  }

                  // Escreve a parcela se ela for maior do que a parcela minima
                  if ($valor_parcela >= $parcela_minima) {
                    $valor_parcela = number_format($valor_parcela, 2, ',', '.');
                    if ($p <= $parcelas_sem_juros) {
                      echo '<span style="color: darkgreen;">' . $p . 'x de ' . $moeda_da_loja . $valor_parcela . ' sem juros</span><br />';
                    } else {
                      echo $p . 'x de ' . $moeda_da_loja . $valor_parcela . ' com juros<br />';
                    }
                  }

                  // Fecha a primeira coluna e inicia a segunda
                  if ($p == intval($maximo_parcelas/2)+1) { echo '</div><div style="width: 50%; float:right;">'; }
                }

                // Exibe os juros utilizados e o valor minimo da parcela se esta for maior que zero
                if ($parcelas_sem_juros < $maximo_parcelas) {
                  $juros = number_format($juros, 2, ',', '.');
                  echo '<span style="font-size: smaller;">Juros de ' . $juros . '% ao m&ecirc;s</span>';
                }
                if ($parcela_minima > 0) {
                  $parcela_minima = number_format($parcela_minima, 2, ',', '.');
                  echo '<br /><span style="font-size: smaller;">Parcela m&iacute;nima de ' . $moeda_da_loja . $parcela_minima . '</span>';
                }

                // Fecha a segunda coluna e finaliza
                echo '</div>';
                echo '</table><br />';
                }
              ?>
            <!-- Exibicao de parcelas -->
    
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span>&nbsp; <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <span><?php echo $text_model; ?></span>&nbsp; <?php echo $model; ?><br />
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span>&nbsp; <?php echo $reward; ?><br />
        <?php } ?>
        <span><?php echo $text_stock; ?></span>&nbsp; <?php echo $stock; ?></div>
      <?php if ($options) { ?>
      <div class="options">
        <h2><?php echo $text_option; ?></h2>
        <br />
        <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <select name="option[<?php echo $option['product_option_id']; ?>]">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
            </option>
            <?php } ?>
          </select>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'radio') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'image') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
            <table class="option-image">
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <tr>
                <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label></td>
              </tr>
              <?php } ?>
            </table>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <a id="button-option-<?php echo $option['product_option_id']; ?>" class="button"><?php echo $button_upload; ?></a>
          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
        </div>
        <br />
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>
      <div class="cart">
        <div><?php echo $text_qty; ?>
          <input type="text" name="quantity" class='qty_input' size="2" value="<?php echo $minimum; ?>" />
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          &nbsp;<input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
          </div>
          <span class="cart_clearer"></span>
          &nbsp;<a onclick="addToWishList('<?php echo $product_id; ?>');" class="icon_plus wishlist_link"><?php echo $button_wishlist; ?></a> &nbsp;&nbsp;
          <a onclick="addToCompare('<?php echo $product_id; ?>');" class="icon_plus compare_link"><?php echo $button_compare; ?></a>
        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
      </div>
      <?php if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/elegantcart/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;(<a onclick="$('a[href=\'#tab-review\']').trigger('click');" class='rev_count'><?php echo $reviews; ?></a>)&nbsp;&nbsp;&nbsp;<span class="divider">|</span>&nbsp;&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');" class="icon_plus"><?php echo $text_write; ?></a></div>
        <div class="share"><!-- AddThis Button BEGIN -->
          <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
          <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
          <!-- AddThis Button END --> 
        </div>
      </div>
      <?php } ?>
    </div>
  </div>

  <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>

    <a href="#tab-tamanhos">Guia de Medidas</a>
  </div>
  <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <div class='r_label'><?php echo $entry_name; ?></div>
    <input type="text" name="name" value="" class='ie_left'/>
    <div class='r_label'><?php echo $entry_review; ?></div>
    <textarea name="text" cols="40" rows="8" style="width: 98%;" class='ie_left'></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b class='r_label'><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp; <span><?php echo $entry_good; ?></span><br />
    <br />
    <div class='r_label'><?php echo $entry_captcha; ?></div>
    <input type="text" name="captcha" value=""  class='ie_left'/>
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>

<div id="tab-tamanhos" class="tab-content">
    <div id="tamanhos"></div>
    <h2 id="tamanhos-title">Guia de tamanhos</h2>
    <h2>Guia de Medidas</h2>
<p>Este guia de medidas vai ajudar você a encontrar o produto no tamanho correto.</p>
<p><b>Cintos</b></p>
É importante que você tenha em mente que o tamanho do seu cinto não corresponde exatamente ao tamanho da calça que você usa, ou de sua cintura; isso acontece, pois o cinto passa em volta de você e de sua calça, ou de uma blusa que você use para dentro. Por este motivo, o seu cinto deve ser medido considerando um número de 4 centímetros maior do que a sua cintura.</p>
<p>Os nossos cintos seguem o seguinte padrão:

<div class="CSSTableGenerator">
<table border="0" class="tabela-medidas" cellspacing="0" cellpadding="0">
    <tbody><tr class="head">
<td>Tamanho</td>
      <td width="93" valign="top"><br>
        Medida da Cintura </td>
      <td>Medida do quadril</td>
      <td>Manequim (calça)</td>
<td>Tamanho da Tira</td>

      
    </tr>
    <tr>
<td>P</td>
      <td>85 cm</td>
      <td>90 cm</td>
      <td>34-36</td>
<td>95 cm</td>
      
    </tr>
    <tr>
<td>M</td>
      <td>90 cm</td>
      <td>92 cm</td>
      <td>38-40</td>
<td>100 cm</td>
      
    </tr>
    <tr>
<td>G</td>
      <td>95 cm</td>
      <td>95 cm</td>
      <td>40-42</td>
<td>105 cm</td>
      
    </tr>
  </tbody></table></div>
<p>.</p><p>Obs: Os cintos em tamanho único seguem o padrão de 85cm de tira, mas, por serem feitos geralmente com elástico, são ajustáveis a todos os tamanhos.
  </div>

<?php echo $content_bottom; ?>

  <?php if ($products) { ?>
  <h1 class="general_heading"><?php echo $tab_related; ?></h1>
  <div class="products_container cleared" style='margin-bottom: -10px;'>
    <?php foreach ($products as $product) { ?><div class='product_holder'>
		<div class='product_holder_inside'>
	    <?php if ($product['special']) { ?>
	    <?php echo '<div class="special_promo"></div>'; ?>
	    <?php } ?> 
	            
	        <?php if ($product['thumb']) { ?>
	        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
	        <?php } ?>
	        <div class="pr_info">
		        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
		        <?php if ($product['price']) { ?>
		        <div class="price">
		          <?php if (!$product['special']) { ?>
		          <?php echo $product['price']; ?>
		          <?php } else { ?>
		          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
		          <?php } ?>
		        </div>
		        <?php } ?>
		        <div class="cart"><a class='button' onclick="addToCart('<?php echo $product['product_id']; ?>');"><span><?php echo $button_cart; ?></span></a></div>
			</div>
	   </div>
	</div><?php } ?>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><?php echo $text_tags; ?> &nbsp;
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  
</div>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	overlayClose: true,
	opacity: 0.4
});
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/elegantcart/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 

        window.location.href = '/sacola';  // redireciona para o carrinho //
			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/elegantcart/image/loading.gif" class="loading" style="padding-left: 5px;" />');
	},
	onComplete: function(file, json) {
		$('.error').remove();
		
		if (json.success) {
			alert(json.success);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json.file);
		}
		
		if (json.error) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json.error + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').slideUp('slow');
		
	$('#review').load(this.href);
	
	$('#review').slideDown('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/elegantcart/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data.error) {
				$('#review-title').after('<div class="warning">' + data.error + '</div>');
			}
			
			if (data.success) {
				$('#review-title').after('<div class="success">' + data.success + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
if ($.browser.msie && $.browser.version == 6) {
	$('.date, .datetime, .time').bgIframe();
}

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script>


<?php echo $footer; ?>