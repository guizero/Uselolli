<?php
class ControllerModuleocOptionImage extends Controller {
	
	
	public function index() {   
		
		
		$query=$this->db->query("SELECT * FROM information_schema.COLUMNS WHERE TABLE_NAME = '" . DB_PREFIX . "product_option_value' AND COLUMN_NAME = 'opt_image'");
			if(!$query->num_rows){ //no exits
				$this->db->query("ALTER TABLE `" . DB_PREFIX . "product_option_value` ADD `opt_image` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL");
			}
		
		
		
		
		
		
		
		$this->load->language('module/ocoptionimage');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$path =substr_replace(DIR_SYSTEM, '', -7) . 'vqmod/' . 'xml/';
			$vqmod = "options_images_products";

				if ($this->request->post['oc_option_image_settings']['enable']){
					if (file_exists($path . $vqmod . '.xml_disable')) {
					   rename($path . $vqmod . '.xml_disable', $path . $vqmod . '.xml');
					}
				}else{
					if (file_exists($path . $vqmod . '.xml')) {
					   rename($path . $vqmod . '.xml', $path . $vqmod . '.xml_disable');
				    }
				}
			
			$this->model_setting_setting->editSetting('ocoptionimage', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_yes'] 	= $this->language->get('text_yes');
		$this->data['text_no'] 		= $this->language->get('text_no');
		$this->data['entry_additional_images'] = $this->language->get('entry_additional_images');
		$this->data['additional_images_help'] = $this->language->get('additional_images_help');
		$this->data['entry_enable_module'] = $this->language->get('entry_enable_module');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');


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
			'href'      => $this->url->link('module/ocoptionimage', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/ocoptionimage', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

				
		$this->data['settings'] = array();
		
		if (isset($this->request->post['oc_option_image_settings'])) {
			$this->data['settings'] = $this->request->post['oc_option_image_settings'];
		} elseif ($this->config->get('oc_option_image_settings')) { 
			$this->data['settings'] = $this->config->get('oc_option_image_settings');
		}			
		
		
		if (isset($this->data['settings']['enable'])){
			$this->data['settings_enable']=$this->data['settings']['enable'];
		}else{
			$this->data['settings_enable']=0;
		}
		
		
		if (isset($this->data['settings']['additional_images'])){
			$this->data['settings_additional_images']=$this->data['settings']['additional_images'];
			
		}else{
			$this->data['settings_additional_images']=0;
		}
		
						
				
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/ocoptionimage.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/ocoptionimage')) {
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