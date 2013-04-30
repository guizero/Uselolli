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
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/ownedit');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->request->post['ownedit_module'][0]['sort_order'] = 999;
			$this->request->post['ownedit_module'][0]['position'] = "content_bottom";
			$this->request->post['ownedit_module'][0]['layout_id'] = "7"; 
					
			$this->model_setting_setting->editSetting('ownedit', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_banner_position'] = $this->language->get('entry_banner_position');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_store_id'] = $this->language->get('entry_store_id');
				
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/ownedit', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/ownedit', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		
		if (isset($this->request->post['ownedit_module'])) {
			$this->data['modules'] = $this->request->post['ownedit_module'];
		} elseif ($this->config->get('ownedit_module')) {
			$this->data['modules'] = $this->config->get('ownedit_module');
		}
				
		$this->template = 'module/ownedit.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/ownedit')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
