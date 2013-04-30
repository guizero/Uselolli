<?php
class ControllerAccountEdit extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/edit', '', 'SSL');

			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->language->load('account/edit');
		
		
			$this->document->setTitle($this->language->get('heading_title')." - ".$this->config->get('config_title'));
		
		$this->load->model('account/customer');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_account_customer->editCustomer($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('account/account', '', 'SSL'));
		}

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),     	
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),        	
        	'separator' => $this->language->get('text_separator')
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_edit'),
			'href'      => $this->url->link('account/edit', '', 'SSL'),       	
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_details'] = $this->language->get('text_your_details');

		$this->data['entry_firstname'] = $this->language->get('entry_firstname');
		$this->data['entry_lastname'] = $this->language->get('entry_lastname');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_fax'] = $this->language->get('entry_fax');

		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_back'] = $this->language->get('button_back');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['firstname'])) {
			$this->data['error_firstname'] = $this->error['firstname'];
		} else {
			$this->data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$this->data['error_lastname'] = $this->error['lastname'];
		} else {
			$this->data['error_lastname'] = '';
		}
		

				if ($this->config->get('fields_register_brazil_status')){ 
					if (isset($this->error['data_nascimento'])) {
						$this->data['error_data_nascimento'] = $this->error['data_nascimento'];
					} else {
						$this->data['error_data_nascimento'] = '';
					}
	
					if (isset($this->error['cpf'])) {
						$this->data['error_cpf'] = $this->error['cpf'];
					} else {
						$this->data['error_cpf'] = '';
					}
	
					if (isset($this->error['cnpj'])) {
						$this->data['error_cnpj'] = $this->error['cnpj'];
					} else {
						$this->data['error_cnpj'] = '';
					}
				}
			
		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}	
		
		if (isset($this->error['telephone'])) {
			$this->data['error_telephone'] = $this->error['telephone'];
		} else {
			$this->data['error_telephone'] = '';
		}	

		$this->data['action'] = $this->url->link('account/edit', '', 'SSL');

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
		}

		if (isset($this->request->post['firstname'])) {
			$this->data['firstname'] = $this->request->post['firstname'];
		} elseif (isset($customer_info)) {
			$this->data['firstname'] = $customer_info['firstname'];
		} else {
			$this->data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$this->data['lastname'] = $this->request->post['lastname'];
		} elseif (isset($customer_info)) {
			$this->data['lastname'] = $customer_info['lastname'];
		} else {
			$this->data['lastname'] = '';
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} elseif (isset($customer_info)) {
			$this->data['email'] = $customer_info['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$this->data['telephone'] = $this->request->post['telephone'];
		} elseif (isset($customer_info)) {
			$this->data['telephone'] = $customer_info['telephone'];
		} else {
			$this->data['telephone'] = '';
		}

				if ($this->config->get('fields_register_brazil_status')){ 
					if (isset($this->request->post['pessoa'])) {
						$this->data['pessoa'] = $this->request->post['pessoa'];
					} else {
						$this->data['pessoa'] = '';
					}

					if (isset($this->request->post['sexo'])) {
						$this->data['sexo'] = $this->request->post['sexo'];
					} elseif (isset($customer_info)) {
						$this->data['sexo'] = $customer_info['sexo'];
					} else {
						$this->data['sexo'] = '';
					}
	
					if (isset($this->request->post['data_nascimento'])) {
						$this->data['data_nascimento'] = $this->request->post['data_nascimento'];
					} elseif (isset($customer_info)) {
						$this->data['data_nascimento'] = $customer_info['data_nascimento'];
					} else {
						$this->data['data_nascimento'] = '';
					}
	
					if (isset($this->request->post['cpf'])) {
						$this->data['cpf'] = preg_replace('/([^0-9])/i','',$this->request->post['cpf']);
					} elseif (isset($customer_info)) {
						$this->data['cpf'] = $customer_info['cpf'];
					} else {
						$this->data['cpf'] = '';
					}
	
					if (isset($this->request->post['rg'])) {
						$this->data['rg'] = preg_replace('/([^0-9])/i','',$this->request->post['rg']);
					} elseif (isset($customer_info)) {
						$this->data['rg'] = $customer_info['rg'];
					} else {
						$this->data['rg'] = '';
					}
	
					if (isset($this->request->post['cnpj'])) {
						$this->data['cnpj'] = preg_replace('/([^0-9])/i','',$this->request->post['cnpj']);
					} elseif (isset($customer_info)) {
						$this->data['cnpj'] = $customer_info['cnpj'];
					} else {
						$this->data['cnpj'] = '';
					}
	
					if (isset($this->request->post['razao_social'])) {
						$this->data['razao_social'] = $this->request->post['razao_social'];
					} elseif (isset($customer_info)) {
						$this->data['razao_social'] = $customer_info['razao_social'];
					} else {
						$this->data['razao_social'] = '';
					}
	
					if (isset($this->request->post['inscricao_estadual'])) {
						$this->data['inscricao_estadual'] = preg_replace('/([^a-z0-9])/i','',$this->request->post['inscricao_estadual']);
					} elseif (isset($customer_info)) {
						$this->data['inscricao_estadual'] = $customer_info['inscricao_estadual'];
					} else {
						$this->data['inscricao_estadual'] = '';
					}
				}
			

		if (isset($this->request->post['fax'])) {
			$this->data['fax'] = $this->request->post['fax'];
		} elseif (isset($customer_info)) {
			$this->data['fax'] = $customer_info['fax'];
		} else {
			$this->data['fax'] = '';
		}

		$this->data['back'] = $this->url->link('account/account', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/edit.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/edit.tpl';
		} else {
			$this->template = 'default/template/account/edit.tpl';
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


				public function isCpf($cpf){
					$cpf        = preg_replace('/([^0-9])/i','',$cpf);
					$digitoUm   = 0;
					$digitoDois = 0;
				
					for($i = 0, $x = 10; $i <= 8; $i++, $x--){
						$digitoUm += $cpf[$i] * $x;
					}
				
					for($i = 0, $x = 11; $i <= 9; $i++, $x--){
						if(str_repeat($i, 11) == $cpf){
							return false;
						}
						$digitoDois += $cpf[$i] * $x;
					}
				
					$calculoUm   = (($digitoUm % 11) < 2) ? 0 : 11 - ($digitoUm % 11);
					$calculoDois = (($digitoDois % 11) < 2) ? 0 : 11 - ($digitoDois % 11);
				
					if($calculoUm != $cpf[9] || $calculoDois != $cpf[10]){
						return false;
					}
				
					return true;
				}
			
	protected function validate() {
		if ((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 32)) {
			$this->error['firstname'] = $this->language->get('error_firstname');
		}

		if ((utf8_strlen($this->request->post['lastname']) < 1) || (utf8_strlen($this->request->post['lastname']) > 32)) {
			$this->error['lastname'] = $this->language->get('error_lastname');
		}

		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

				if ($this->config->get('fields_register_brazil_status')){ 
					// Valida campo Data de Nascimento
					$dataparts = explode("/",$this->request->post['data_nascimento']);
					if (strlen(utf8_decode($this->request->post['data_nascimento'])) > 0) {
						// Se o array não tiver 3 posições a data esta incorreta
						if (sizeof($dataparts) != '3'){
							$this->error['data_nascimento'] = "Atenção: A data informada é inválida";
						}else{
							// Checa validade da data
							if (!checkdate($dataparts[1],$dataparts[0],$dataparts[2])) {
								$this->error['data_nascimento'] = "Atenção: A data informada é inválida";
							}
						} 
					}

					// Valida CPF e CNPJ
					if ($this->request->post['pessoa'] == "fisica"){
						if(isset($this->request->post['cpf'])){
							$cpf = preg_replace('/([^0-9])/i','',$this->request->post['cpf']);
							if ((strlen(utf8_decode($cpf)) < 1) || (strlen(utf8_decode($cpf)) > 14)) {
								$this->error['cpf'] = "Atenção: O CPF não deve passar de 14 caracteres";  
							}elseif(!$this->isCpf($cpf)){
								$this->error['cpf'] = "Atenção: O CPF informado é inválido";
							}
						}
					}else if ($this->request->post['pessoa'] == "juridica"){
						if(isset($this->request->post['cnpj'])){
							$cnpj = preg_replace('/([^0-9])/i','',$this->request->post['cnpj']);
							if ((strlen(utf8_decode($cnpj)) < 1) || (strlen(utf8_decode($cnpj)) > 18)&&($this->request->post['pessoa'] == "juridica")) {
								$this->error['cnpj'] = "Atenção: O CNPJ não deve passar de 18 caracteres";
							}
						}
					}
				}
			
		
		if (($this->customer->getEmail() != $this->request->post['email']) && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_exists');
		}

		if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>