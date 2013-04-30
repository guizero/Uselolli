<?php
class ControllerModuleFieldsRegisterBrazil extends Controller {
	private $error = array(); 

	public function index() {   
		$this->load->language('module/fields_register_brazil');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->model_setting_setting->editSetting('fields_register_brazil', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['link'] = $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		}else{
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
			'href'      => $this->url->link('module/fields_register_brazil', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('module/fields_register_brazil', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['fields_register_brazil_status'])) {
			$this->data['fields_register_brazil_status'] = $this->request->post['fields_register_brazil_status'];
		}elseif($this->config->get('fields_register_brazil_status')) {
			$this->data['fields_register_brazil_status'] = $this->config->get('fields_register_brazil_status');
		}else{
			$this->data['fields_register_brazil_status'] = '';
		}

		// chama a view
		$this->template = 'module/fields_register_brazil.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

    public function install() {
		$query = $this->db->query("ALTER TABLE `" . DB_PREFIX . "customer` 
								   ADD `cpf` VARCHAR( 14 ) NOT NULL AFTER `fax` ,
								   ADD `cnpj` VARCHAR( 18 ) NOT NULL AFTER `cpf` ,
								   ADD `rg` VARCHAR( 9 ) NOT NULL AFTER `cnpj` ,
								   ADD `razao_social` VARCHAR( 250 ) NOT NULL AFTER `rg` ,
								   ADD `inscricao_estadual` VARCHAR( 200 ) NOT NULL AFTER `razao_social` ,
								   ADD `data_nascimento` DATE NOT NULL AFTER `inscricao_estadual`,
								   ADD `sexo` CHAR( 1 ) NOT NULL AFTER `data_nascimento`;
		");
		$query = $this->db->query("ALTER TABLE `" . DB_PREFIX . "address` 
								   ADD `apelido` VARCHAR( 128 ) NOT NULL AFTER `lastname`,
								   ADD `numero` VARCHAR( 14 ) NOT NULL AFTER `address_1`,
								   ADD `complemento` VARCHAR( 18 ) NOT NULL AFTER `address_2`;
		");
		$query = $this->db->query("ALTER TABLE `" . DB_PREFIX . "order` 
								   ADD `cpf` VARCHAR( 14 ) NOT NULL AFTER `fax` ,
								   ADD `cnpj` VARCHAR( 18 ) NOT NULL AFTER `cpf` ,
								   ADD `rg` VARCHAR( 9 ) NOT NULL AFTER `cnpj` ,
								   ADD `razao_social` VARCHAR( 250 ) NOT NULL AFTER `rg` ,
								   ADD `inscricao_estadual` VARCHAR( 200 ) NOT NULL AFTER `razao_social` ,
								   ADD `data_nascimento` DATE NOT NULL AFTER `inscricao_estadual`,
								   ADD `sexo` CHAR( 1 ) NOT NULL AFTER `data_nascimento`,
								   ADD `payment_apelido` VARCHAR( 128 ) NOT NULL AFTER `sexo`,
								   ADD `payment_numero` VARCHAR( 14 ) NOT NULL AFTER `payment_address_1`,
								   ADD `payment_complemento` VARCHAR( 18 ) NOT NULL AFTER `payment_address_2`,
								   ADD `shipping_apelido` VARCHAR( 128 ) NOT NULL AFTER `payment_code`,
								   ADD `shipping_numero` VARCHAR( 14 ) NOT NULL AFTER `shipping_address_1`,
								   ADD `shipping_complemento` VARCHAR( 18 ) NOT NULL AFTER `shipping_address_2`;
		");
	}

    public function uninstall() {
		$query = $this->db->query("ALTER TABLE `" . DB_PREFIX . "customer` 
								   DROP `cpf`,
								   DROP `cnpj`,
								   DROP `rg`,
								   DROP `razao_social`,
								   DROP `inscricao_estadual`,
								   DROP `data_nascimento`,
								   DROP `sexo`;
		");
		$query = $this->db->query("ALTER TABLE `" . DB_PREFIX . "address` 
								   DROP `apelido`,
								   DROP `numero`,
								   DROP `complemento`;
		");
		$query = $this->db->query("ALTER TABLE `" . DB_PREFIX . "order` 
								   DROP `cpf`,
								   DROP `cnpj`,
								   DROP `rg`,
								   DROP `razao_social`,
								   DROP `inscricao_estadual`,
								   DROP `data_nascimento`,
								   DROP `sexo`,
								   DROP `payment_apelido`,
								   DROP `payment_numero`,
								   DROP `payment_complemento`,
								   DROP `shipping_apelido`,
								   DROP `shipping_numero`,
								   DROP `shipping_complemento`;
		");
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('fields_register_brazil', array('fields_register_brazil_status' => '0'));
    }       
}
?>