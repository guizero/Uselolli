<?php
class ControllerModulefbjsconnect extends Controller {
	protected function index($setting) {

		$this->language->load('module/fbjsconnect'); 
		$this->data['heading_title'] = $this->language->get('heading_title');
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = $this->config->get('config_ssl');
		} else {
			$this->data['base'] = $this->config->get('config_url');
		}
		$this->data['logging_text'] = $this->language->get('logging_text');
		$this->data['canclled_text'] = $this->language->get('canclled_text');
		if(!$this->customer->isLogged()){
			
			$this->data['fbjsconnect']['appid'] = $this->config->get('fbjsconnect_apikey');
			$this->data['fbjsconnect']['secret'] = $this->config->get('fbjsconnect_apisecret');
			$this->data['fbjsconnect']['scope'] = 'email,user_birthday,user_location,user_hometown';
			$this->data['fbjsconnect']['redirect_uri'] = $this->url->link('account/fbjsconnect', '', 'SSL');

			if(!isset($this->fbjsconnect)){			
				require_once(DIR_SYSTEM . 'vendor/facebook-sdk/facebook.php');
				$this->fbjsconnect = new Facebook(array(
					'appId'  => $this->data['fbjsconnect']['appid'],
					'secret' => $this->data['fbjsconnect']['secret'],
				));
			}
			
			$this->data['fbjsconnect_url'] = $this->fbjsconnect->getLoginUrl(
				array(
					'scope' => $this->data['fbjsconnect']['scope'],
					'redirect_uri'  => $this->data['fbjsconnect']['redirect_uri']
				)
			);

			if($this->config->get('fbjsconnect_button_' . $this->config->get('config_language_id'))){
				$this->data['fbjsconnect_button'] = html_entity_decode($this->config->get('fbjsconnect_button_' . $this->config->get('config_language_id')));
			}
			else $this->data['fbjsconnect_button'] = $this->language->get('heading_title');
			
			
			if($this->config->get('fbjsconnect_button2_' . $this->config->get('config_language_id'))){
				$this->data['fbjsconnect_button2'] = html_entity_decode($this->config->get('fbjsconnect_button2_' . $this->config->get('config_language_id')));
			}
			else $this->data['fbjsconnect_button2'] = $this->language->get('heading_title');
			
			if($this->config->get('fbjsconnect_button3_' . $this->config->get('config_language_id'))){
				$this->data['fbjsconnect_button3'] = html_entity_decode($this->config->get('fbjsconnect_button3_' . $this->config->get('config_language_id')));
			}
			else $this->data['fbjsconnect_button3'] = $this->language->get('heading_title');
			
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
			if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = 'HTTPS_IMAGE';
		} else {
			$server = 'HTTP_IMAGE';
		}	
			if ($this->config->get('config_botonfc') && file_exists(DIR_IMAGE . $this->config->get('config_botonfc'))) {
			$this->data['botonfc'] = $server . $this->config->get('config_botonfc');
		} else {
			$this->data['botonfc'] = '';
		}
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/fbjsconnect.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/fbjsconnect.tpl';
			} else {
				$this->template = 'default/template/module/fbjsconnect.tpl';
			}

			$this->render();
		}				

	}
}
?>