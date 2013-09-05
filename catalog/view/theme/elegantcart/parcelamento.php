
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

                if (!$product['special']) {
                  $preco_numero = str_replace(',','.',str_replace('.','', str_replace($moeda_da_loja,"",strip_tags($product['price']))));
                } else {
                  $preco_numero = str_replace(',','.',str_replace('.','', str_replace($moeda_da_loja,"",strip_tags($product['special']))));
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

?>