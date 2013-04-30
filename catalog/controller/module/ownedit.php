<?php
/**
 *Product Name : Owned It Checkout Extension
 *Copyright (c) 2012 Owned It Ltd
 *
 * Owned It:
 *
 * NOTICE OF LICENSE
 *
 *Copyright (c) <2011> <Owned It Ltd>
 *
 *Permission is hereby granted, free of charge, to any person 
 *obtaining a copy of this software and associated 
 *documentation files (the "Software"),to deal in the Software 
 *without restriction,including without limitation the rights
 *to use, copy, modify, merge, publish, distribute, sublicense,
 *and/or sell copies of the Software, and to permit persons 
 *to whom the Software is furnished to do so, subject to the 
 *following conditions:
 *
 *The above copyright notice and this permission notice shall be
 *included in all copies or substantial portions of the Software.
 *  
 *THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
 *OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
 *LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 *FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 *IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS 
 *BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,             
 *WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 *ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR  
 *THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *
 * @license http://www.opensource.org/licenses/mit-license.php(MIT)
 * @author Owned It Ltd. (http://www.ownedit.com)
 *
**/
class ControllerModuleOwnedit extends Controller {

	protected function index() {
  	$this->load->model('checkout/order');
	$this->load->model('account/order');
	$this->load->model('catalog/product');
	$this->load->model('localisation/currency');
	$this->load->model('catalog/category');
    $this->id = 'ownedit';
    $this->template = 'default/template/module/ownedit.tpl';
    $braggJS = '';
    if ($this->getOwneditId() != '' && $this->isEnabled()) {
	   if (isset($this->request->get['route']) && $this->request->get['route'] == "checkout/success" && isset($this->session->data['ownedit_order_id'])) {
	  	 	$braggJS.="<script type=\"text/javascript\" src=\"https://www.ownedit.com/ownedit_js/ownedit.js?store_id=".$this->getOwneditId()."&anchor=".$this->bannerPosition()."\"></script>";
	   		$order = $this->model_checkout_order->getOrder($this->session->data['ownedit_order_id']);
	        $order_products = $this->model_account_order->getOrderProducts($order['order_id']);
	  	    $arr = array();
	     	$arr['order_id'] = $order['order_id'];
	     	$arr['customer_email'] = $order['email'];
			$arr['order_value'] = sprintf("%.2f",$order['total']);
			$arr['order_currency'] = $order['currency_code'];
	      	$arr['store_name']=$this->config->get('config_name');
	      	$products = array();
	      
	        foreach ($order_products as $purchaseItem) {
	        	$product_id = $purchaseItem['product_id'];
	        	$product_price = $purchaseItem['price'];
		   	    $product_details = $this->model_catalog_product->getProduct($product_id);
		        $prod = array();
	    	    $prod['product_name']=$product_details['name'];   		
	    	    $prod['product_url']=HTTP_SERVER. 'index.php?route=product/product&product_id=' . $product_details['product_id'];
	       	    $prod['product_desc']= strip_tags(html_entity_decode($product_details['description'], ENT_QUOTES, 'UTF-8'));     
	       	    $prod['product_image_url']=HTTP_IMAGE . $product_details['image'];
	       	    $prod['product_price']=sprintf("%.2f",$product_price);
	       		$prod['currency']=$this->currency->getCode();
	       		$prod['product_id']=$product_id;
				$prod['product_quantity'] = $purchaseItem['quantity'];
	       
	       		$product_category = $this->model_catalog_product->getCategories($product_id);
	       		$category_id = $product_category[0]['category_id'];
	       		$category_details = $this->model_catalog_category->getCategory($category_id);
	       		$prod['product_category']=  $category_details['name'];
	       		array_push($products,$prod);
	      }
	  	    $arr['products']=$products;
	      	$json = json_encode($arr);       
	      
	        $braggJS.="<script type=\"text/javascript\">";
	  	    $braggJS.="function post_to_owned_it(){";
	    	$braggJS.="var details =$json;";
	      	$braggJS.="post_it(details);}onLoadCallBack(post_to_owned_it);</script>";
	       	unset($this->session->data['ownedit_order_id']);
	    }
	
	    else {
	      if (isset($this->session->data['order_id']))
	      {
	        $this->session->data['ownedit_order_id'] = $this->session->data['order_id'];
	      }
	
	    }
    }
    else 
    {
      $braggJS = "<!-- Either Owned It module is not enabled or Owned It Store ID is not set -->";
    }
    $this->data['braggJS'] = $braggJS;

    $this->render();
  }
  private function getOwneditId()
  {
  	
    $ownedit_config =  $this->config->get('ownedit_module');
    return $ownedit_config[0]['store_id'];
    unset($ownedit_config);    
  }
  
  private function bannerPosition()
  {
  	$ownedit_config = $this->config->get('ownedit_module');
    if($ownedit_config[0]['position_class']!=NULL && $ownedit_config[0]['position_class']!=''){
    	
    	$position = $ownedit_config[0]['position_class'];
    	
    }    
    else {    
    	$position = 'buttons';
     }    
  	return $position;
  	unset($ownedit_config);
  	unset($position);  
  }  
  
  private function isEnabled()
  {
    $ownedit_config = $this->config->get('ownedit_module');
    return $ownedit_config[0]['status'];
  }

}


?>
