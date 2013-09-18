<?php
class ControllerCheckoutSuccess extends Controller { 
	public function index() { 	
    
        	$app_key = $this->config->get('yotpo_appkey');    	
        	if (isset($this->session->data['order_id']) && !empty($app_key)) {      	
				$this->load->model('account/order');				
				$orders_total = $this->model_account_order->getOrderTotals($this->session->data['order_id']);
				$total = null;
				foreach ($orders_total as $order_total) {	
					if ($order_total['code'] == 'total') {
						
						$total = $order_total['value'];
					}
				}
				$conversion_params = "app_key="			.$app_key.
						 			 "&order_id="		.$this->session->data['order_id'].
						 			 "&order_amount="	.$total.
						 			 "&order_currency="	.$this->session->data['currency'];
				$conversion_url = "https://api.yotpo.com/conversion_tracking.gif?$conversion_params";
				$this->data['yotpoConversionUrl'] = $conversion_url;
			}
        

				$this->data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
				$this->data['ecommerce_tracking_status'] = false;
				$this->data['order'] = array();
				$this->data['products'] = array();

				if ($this->config->get('config_google_analytics') && $this->config->get('ecommerce_tracking_status')) {
					$this->data['ecommerce_tracking_status'] = true;
					$this->data['start_google_code'] = substr($this->data['google_analytics'], 0, strpos($this->data['google_analytics'], 'function') - 2);
					$this->data['end_google_code'] = substr($this->data['google_analytics'], strpos($this->data['google_analytics'], 'function') - 2, strlen($this->data['google_analytics']));

					if (isset($this->session->data['order_id'])) {
						$order_id = $this->session->data['order_id'];

						$this->load->model('account/order');

						$order_info = $this->model_account_order->getOrder($order_id);

						if ($order_info) {
							$tax = 0;
							$shipping = 0;

							$order_totals = $this->model_account_order->getOrderTotals($order_id);

							foreach ($order_totals as $order_total) {
								if ($order_total['code'] == 'tax') {
									$tax += $order_total['value'];
								} elseif($order_total['code'] == 'shipping') {
									$shipping += $order_total['value'];
								}
							}

							// Data required for _addTrans
							$this->data['order'] = $order_info;
							$this->data['order']['store_name'] = $this->config->get('config_name');
							$this->data['order']['order_total'] = $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'], false);
							$this->data['order']['order_tax'] = $this->currency->format($tax, $order_info['currency_code'], $order_info['currency_value'], false);
							$this->data['order']['order_shipping'] = $this->currency->format($shipping, $order_info['currency_code'], $order_info['currency_value'], false);

							// Data required for _addItem
							$products = $this->model_account_order->getOrderProducts($order_id);

							$this->load->model('catalog/product');
							$this->load->model('catalog/category');

							foreach ($products as $product) {
								$sku = '';

								if ($this->config->get('ecommerce_tracking_sku')) {
									$product_info = $this->model_catalog_product->getProduct($product['product_id']);

									if ($product_info) {
										$sku = $product_info['sku'];
									}
								}

								$categories = array();

								$product_categories = $this->model_catalog_product->getCategories($product['product_id']);

								if ($product_categories) {
									foreach ($product_categories as $product_category) {
										$category_data = $this->model_catalog_category->getCategory($product_category['category_id']);

										if ($category_data) {
											$categories[] = $category_data['name'];
										}
									}
								}

								$this->data['products'][] = array(
									'order_id'   => $order_id,
									'product_id' => $product['product_id'],
									'sku'        => $sku,
									'name'       => $product['name'],
									'category'   => implode(',', $categories),
									'quantity'   => $product['quantity'],
									'price'      => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value'], false)
								);
							}
						}
					}
				}
			
		if (isset($this->session->data['order_id'])) {
			// Begin Owned it social referrals.
			$this->session->data['ownedit_order_id'] = $this->session->data['order_id'];
			// End Owned it social referrals.
			$this->cart->clear();

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['guest']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);	
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);
		}	
									   
		$this->language->load('checkout/success');
		
		
			$this->document->setTitle($this->language->get('heading_title')." - ".$this->config->get('config_title'));
		
		$this->data['breadcrumbs'] = array(); 

      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('common/home'),
        	'text'      => $this->language->get('text_home'),
        	'separator' => false
      	); 
		
      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('checkout/cart'),
        	'text'      => $this->language->get('text_basket'),
        	'separator' => $this->language->get('text_separator')
      	);
				
		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('checkout/checkout', '', 'SSL'),
			'text'      => $this->language->get('text_checkout'),
			'separator' => $this->language->get('text_separator')
		);	
					
      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('checkout/success'),
        	'text'      => $this->language->get('text_success'),
        	'separator' => $this->language->get('text_separator')
      	);

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		if ($this->customer->isLogged()) {
    		$this->data['text_message'] = sprintf($this->language->get('text_customer'), $this->url->link('account/account', '', 'SSL'), $this->url->link('account/order', '', 'SSL'), $this->url->link('account/download', '', 'SSL'), $this->url->link('information/contact'));
		} else {
    		$this->data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('information/contact'));
		}
		
    	$this->data['button_continue'] = $this->language->get('button_continue');

    	$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'			
		);
				
		$this->response->setOutput($this->render());
  	}
}
?>