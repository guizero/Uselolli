<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>

        		<?php if(isset($yotpoConversionUrl)) { ?>
					<img 
					   	src="<?php echo $yotpoConversionUrl ?>"
						width="1"
						height="1"></img>
				<?php } ?>
        
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <?php echo $text_message; ?>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php echo $content_bottom; ?></div>

				<?php if (isset($ecommerce_tracking_status)) { ?>
					<?php if ($ecommerce_tracking_status && $order && $products) { ?>
						<?php echo $start_google_code; ?>

						_gaq.push(['_set', 'currencyCode', '<?php echo $order['currency_code']; ?>']);
						_gaq.push(['_addTrans',
							"<?php echo $order['order_id']; ?>",
							"<?php echo $order['store_name']; ?>",
							"<?php echo $order['order_total']; ?>",
							"<?php echo $order['order_tax']; ?>",
							"<?php echo $order['order_shipping']; ?>",
							"<?php echo $order['payment_city']; ?>",
							"<?php echo $order['payment_zone']; ?>",
							"<?php echo $order['payment_country']; ?>"
						]);

						<?php foreach($products as $product) { ?>
						_gaq.push(['_addItem',
							"<?php echo $product['order_id']; ?>",
							"<?php echo ($product['sku'] ? $product['sku'] : $product['product_id']); ?>",
							"<?php echo $product['name']; ?>",
							"<?php echo $product['category']; ?>",
							"<?php echo $product['price']; ?>",
							"<?php echo $product['quantity']; ?>"
						]);
						<?php } ?>

						_gaq.push(['_trackTrans']);

						<?php echo $end_google_code; ?>
					<?php } else { ?>
						<?php echo $google_analytics; ?>
					<?php } ?>
				<?php } ?>
			
<?php echo $footer; ?>