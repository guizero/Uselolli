<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
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
                $parcela_minima = 5;
                $parcelas_sem_juros = 3;
                $juros = 1.99;
                $moeda_da_loja = 'R$ ';
                $tipo_de_calculo = 1;

                if (!$special) {
                  $preco_numero = str_replace(',','.',str_replace('.','', str_replace($moeda_da_loja,"",strip_tags($price))));
                } else {
                  $preco_numero = str_replace(',','.',str_replace('.','', str_replace($moeda_da_loja,"",strip_tags($special))));
                }

                if ($preco_numero >= $parcela_minima*2) {
                $valor_parcela = $preco_numero / 3;
                $valor_parcela = number_format($valor_parcela, 2, ',', '.');

                // Titulo
                echo '<div class="parceladolista">
                        <p class="paragrafopreco">
                          <strong class="precolista">
                          <span class="precotexto">3x </span>
                          <span class="precocifrao">'. $moeda_da_loja . $valor_parcela .'</span><span class="cond"></span>
                          <span class="precotexto">sem juros</span>
                          </strong>
                        </p>
                      </div>';

               }
               echo $valor_parcela;

?>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
      </div>
      <?php } ?>
    </div>
  </div>
</div>
