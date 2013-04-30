<?php
class ControllerModulefbjsconnect extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/fbjsconnect');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

		$opencartversion = (int)VERSION.'.'.str_replace('.',"",substr(VERSION,2));

		if((float)$opencartversion<1.51){
			if ($this->request->server['REQUEST_METHOD'] == 'POST') {			
				$module=array();
				$i=0;
				if(isset($this->request->post['fbjsconnect_module'])){
					foreach($this->request->post['fbjsconnect_module'] as $k=>$v){
						foreach($v as $key=>$value){
							$this->request->post['fbjsconnect_'.$k.'_'.$key]=$value;
						}
						$module[]=$i;
						$i++;
					}
				}
				$this->request->post['fbjsconnect_module']=implode(',',$module);
			}
		}
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('fbjsconnect', $this->request->post);					
			$this->session->data['success'] = $this->language->get('text_success');						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->load->model('localisation/language');
//PARTE DE lenguajes
		$languages = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $languages;
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_browse']  = $this->language->get('text_browse');
		$this->data['text_clear']  = $this->language->get('text_clear');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_module_settings'] = $this->language->get('text_module_settings');
		$this->data['text_support'] = $this->language->get('text_support');
		$this->data['text_button_settings'] = $this->language->get('text_button_settings');
		
		
		//redirect text 
		$this->data['text_home'] = $this->language->get('text_home');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_cart'] = $this->language->get('text_cart');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_newletter'] = $this->language->get('text_newletter');
		//end redirect text 
		
		$this->data['entry_creator'] = $this->language->get('entry_creator');
		$this->data['entry_version'] = $this->language->get('entry_version');
		$this->data['entry_updated'] = $this->language->get('entry_updated');
		$this->data['entry_licence'] = $this->language->get('entry_licence');
		$this->data['entry_botonfc'] = $this->language->get('entry_botonfc');
		$this->data['entry_setting'] = $this->language->get('entry_setting');
		$this->data['entry_show_setting'] = $this->language->get('entry_show_setting');
		$this->data['entry_show_desc'] = $this->language->get('entry_show_desc');

		$this->data['entry_apikey'] = $this->language->get('entry_apikey');
		$this->data['entry_apisecret'] = $this->language->get('entry_apisecret');
		$this->data['entry_pwdsecret'] = $this->language->get('entry_pwdsecret');
		$this->data['entry_pwdsecret_desc'] = $this->language->get('entry_pwdsecret_desc');
		$this->data['entry_button'] = $this->language->get('entry_button');
		$this->data['entry_button_desc'] = $this->language->get('entry_button_desc');
		$this->data['entry_show_box'] = $this->language->get('entry_show_box');
		$this->data['entry_box_desc'] = $this->language->get('entry_box_desc');
		$this->data['entry_redirect'] = $this->language->get('entry_redirect');
		$this->data['entry_redirect_desc'] = $this->language->get('entry_redirect_desc');
		$this->data['entry_boxtitle'] = $this->language->get('entry_boxtitle');
		$this->data['entry_boxtitle_desc'] = $this->language->get('entry_boxtitle_desc');
		
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['code'])) {
			$this->data['error_code'] = $this->error['code'];
		} else {
			$this->data['error_code'] = '';
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
			'href'      => $this->url->link('module/fbjsconnect', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->data['action'] = $this->url->link('module/fbjsconnect', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];
		
		$this->data['modules'] = array();
		
		$this->load->model('tool/image');

		if (isset($this->request->post['config_botonfc'])) {
			$this->data['config_botonfc'] = $this->request->post['config_botonfc'];
		} else {
			$this->data['config_botonfc'] = $this->config->get('config_botonfc');			
		}

		if ($this->config->get('config_botonfc') && file_exists(DIR_IMAGE . $this->config->get('config_botonfc')) && is_file(DIR_IMAGE . $this->config->get('config_botonfc'))) {
			$this->data['botonfc'] = $this->model_tool_image->resize($this->config->get('config_botonfc'), 100, 100);		
		} else {
			$this->data['botonfc'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}
	
	$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
	
		foreach ($languages as $language) {
			if (isset($this->request->post['fbjsconnect_button_' . $language['language_id']])) {
				$this->data['fbjsconnect_button_' . $language['language_id']] = $this->request->post['fbjsconnect_button_' . $language['language_id']];
			} else {
				if($this->config->get('fbjsconnect_button_' . $language['language_id']) != ''){
					$this->data['fbjsconnect_button_' . $language['language_id']] = $this->config->get('fbjsconnect_button_' . $language['language_id']);
				}else{
					$this->data['fbjsconnect_button_' . $language['language_id']] = 'Connect with';
				}
			}
			
			if (isset($this->request->post['fbjsconnect_button2_' . $language['language_id']])) {
				$this->data['fbjsconnect_button2_' . $language['language_id']] = $this->request->post['fbjsconnect_button2_' . $language['language_id']];
			} else {
				if($this->config->get('fbjsconnect_button2_' . $language['language_id']) != ''){
					$this->data['fbjsconnect_button2_' . $language['language_id']] = $this->config->get('fbjsconnect_button2_' . $language['language_id']);
				}else{
					$this->data['fbjsconnect_button2_' . $language['language_id']] = 'Facebook';
				}
			}
			
			if (isset($this->request->post['fbjsconnect_button3_' . $language['language_id']])) {
				$this->data['fbjsconnect_button3_' . $language['language_id']] = $this->request->post['fbjsconnect_button3_' . $language['language_id']];
			} else {
				if($this->config->get('fbjsconnect_button3_' . $language['language_id']) != ''){
					$this->data['fbjsconnect_button3_' . $language['language_id']] = $this->config->get('fbjsconnect_button3_' . $language['language_id']);
				}else{
					$this->data['fbjsconnect_button3_' . $language['language_id']] = 'Connect Facebook';
				}
			}
		}

		if (isset($this->request->post['fbjsconnect_apikey'])) {
			$this->data['fbjsconnect_apikey'] = $this->request->post['fbjsconnect_apikey'];
		} elseif ($this->config->get('fbjsconnect_apikey')) { 
			$this->data['fbjsconnect_apikey'] = $this->config->get('fbjsconnect_apikey');
		} else $this->data['fbjsconnect_apikey'] = '';

		if (isset($this->request->post['fbjsconnect_apisecret'])) {
			$this->data['fbjsconnect_apisecret'] = $this->request->post['fbjsconnect_apisecret'];
		} elseif ($this->config->get('fbjsconnect_apisecret')) { 
			$this->data['fbjsconnect_apisecret'] = $this->config->get('fbjsconnect_apisecret');
		} else $this->data['fbjsconnect_apisecret'] = '';

		if (isset($this->request->post['fbjsconnect_pwdsecret'])) {
			$this->data['fbjsconnect_pwdsecret'] = $this->request->post['fbjsconnect_pwdsecret'];
		} elseif ($this->config->get('fbjsconnect_pwdsecret')) { 
			$this->data['fbjsconnect_pwdsecret'] = $this->config->get('fbjsconnect_pwdsecret');
		} else $this->data['fbjsconnect_pwdsecret'] = '';

		   if (isset($this->request->post['box'])) {
			$this->data['box'] = $this->request->post['box'];
		} else {
			$this->data['box'] = $this->config->get('box');
		}
		if (isset($this->request->post['efect'])) {
			$this->data['efect'] = $this->request->post['efect'];
		} else {
			$this->data['efect'] = $this->config->get('efect');
		}
	if (isset($this->request->post['redirect'])) {
			$this->data['redirect'] = $this->request->post['redirect'];
		} else {
			$this->data['redirect'] = $this->config->get('redirect');
		}
	
			
		if($opencartversion<1.51){
			$this->data['modules']=array();
			$toarray=$obj_get='';
			if(isset($this->request->post['fbjsconnect_module'])){
				$toarray=$this->request->post['fbjsconnect_module'];
				$obj_get='post';
			}
 			elseif ($this->config->get('fbjsconnect_module')!='') { 
				$toarray=$this->config->get('fbjsconnect_module');
				$obj_get='config';
			}
			if($toarray!=',' && $obj_get!=''){
				$i=count(explode(',',$toarray));
				$array_key=array('layout_id','position','status','sort_order');
				for($k=0; $k<$i; $k++){
					$array=array();
					foreach($array_key as $key){
						if($obj_get=="config")
							$array[$key]=$this->config->get('fbjsconnect_'.$k.'_'.$key);
						else
							$array[$key]=$this->request->post['fbjsconnect_'.$k.'_'.$key];
					}
					$this->data['modules'][] = $array;
				}
			}
		}
		else{		
			if (isset($this->request->post['fbjsconnect_module'])) {
				$this->data['modules'] = $this->request->post['fbjsconnect_module'];
			} elseif ($this->config->get('fbjsconnect_module')) { 
				$this->data['modules'] = $this->config->get('fbjsconnect_module');
			}		
		}

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/fbjsconnect.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/fbjsconnect')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['fbjsconnect_apikey'] || !$this->request->post['fbjsconnect_apisecret'] || !$this->request->post['fbjsconnect_pwdsecret']) {
			$this->error['code'] = $this->language->get('error_code');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>