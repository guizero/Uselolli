<?php
//==============================================================================
// MailChimp Integration v155.3
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ControllerModuleMailchimpIntegration extends Controller {
	private $type = 'module';
	private $name = 'mailchimp_integration';
	private $module;
	
	protected function index($module = '') {
		$v14x = $this->data['v14x'] = (!defined('VERSION') || VERSION < 1.5);
		$v150 = $this->data['v150'] = (defined('VERSION') && strpos(VERSION, '1.5.0') === 0);
		$settings = $this->data['settings'] = ($v14x || $v150) ? unserialize($this->config->get($this->name . '_data')) : $this->config->get($this->name . '_data');
		
		if (empty($settings['status']) || empty($settings['apikey']) || empty($settings['listid'])) return;
		
		$type = $this->data['type'] = $this->type;
		$name = $this->data['name'] = $this->name;
		
		$this->module = $module;
		$this->data = array_merge($this->data, $this->load->language($this->type . '/' . $this->name));
		
		$this->data['position'] = $this->getModuleSetting('position');
		$this->data['name_field'] = $this->getModuleSetting('name_field');
		
		$template = (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->type . '/' . $this->name . '.tpl')) ? $this->config->get('config_template') : 'default';
		$this->template = $template . '/template/' . $this->type . '/' . $this->name . '.tpl';
		$this->id = $this->name;
		$this->render();
	}
	
	private function getModuleSetting($setting) {
		if (!defined('VERSION') || VERSION < 1.5) {
			$value = $this->config->get($this->name . '_' . $setting);
		} elseif (strpos(VERSION, '1.5.0') === 0) {
			$value = $this->config->get($this->name . '_' . $this->module . '_' . $setting);
		} else {
			$value = (!empty($this->module[$setting])) ? $this->module[$setting] : false;
		}
		return (is_string($value) && strpos($value, 'a:') === 0) ? unserialize($value) : $value;
	}
	
	private function makeURL($route, $args = '', $connection = 'NONSSL', $rewrite = true) {
		if (!defined('VERSION') || VERSION < 1.5 || !$rewrite) {
			$url = ($connection == 'NONSSL') ? HTTP_SERVER : HTTPS_SERVER;
			$url .= 'index.php?route=' . $route;
			$url .= ($args) ? '&' . ltrim($args, '&') : '';
			if ($rewrite) {
				$this->load->model('tool/seo_url');
				$url = $this->model_tool_seo_url->rewrite($url);
			}
			return $url;
		} else {
			return $this->url->link($route, $args, $connection);
		}
	}
	
	public function subscribe() {
		$firstlast = explode(' ', $this->request->post['name'], 2);
		$data = array(
			'newsletter'	=> 1,
			'email'			=> $this->request->post['email'],
			'firstname'		=> $firstlast[0],
			'lastname'		=> isset($firstlast[1]) ? $firstlast[1] : ''
		);
		$this->load->library($this->name);
		$mailchimp_integration = new MailChimp_Integration($this->config, $this->db, $this->log);
		echo $mailchimp_integration->send($data);
	}
	
	public function webhook() {
		if (!isset($this->request->post['type']) || !isset($this->request->post['data']) || !isset($this->request->get['code'])) return;
		
		$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		$settings = ($version < 151) ? unserialize($this->config->get($this->name . '_data')) : $this->config->get($this->name . '_data');
		
		if ($this->request->get['code'] != $settings['urlcode']) {
			if ($settings['logerrors']) {
				$this->log->write(strtoupper($this->name) . ' WEBHOOK ERROR: webhook URL code ' . $this->request->get['code'] . ' does not match the extension code ' . $settings['urlcode'] . ' for action "' . $this->request->post['type'] . '" for e-mail address ' . $this->request->post['data']['email']);
			}
			return;
		}
		
		$this->load->library('mailchimp_integration');
		$mailchimp_integration = new MailChimp_Integration($this->config, $this->db, $this->log);
		$mailchimp_integration->webhook($this->request->post['type'], $this->request->post['data']);
	}
}
?>