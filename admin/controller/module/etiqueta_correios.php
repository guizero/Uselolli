<?php

	Class ControllerModuleEtiquetaCorreios extends Controller{

		private $error = array();

		public function index(){

			//Salva as informações
			if(($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()){
				$this->load->model('setting/setting');

				$this->model_setting_setting->editSetting('etiqueta_correios', $this->request->post);

				$this->session->data['success'] = 'Você modificou o módulo <b>Etiqueta Correios</b> com sucesso!';

				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token']));
			}


			//Nome
			if (isset($this->request->post['etiquetaCorreios_Nome'])){
				$this->data['etiquetaCorreios_Nome'] = $this->request->post['etiquetaCorreios_Nome'];
			}else{
				$this->data['etiquetaCorreios_Nome'] = $this->config->get('etiquetaCorreios_Nome');
			}

			//Empresa
			if (isset($this->request->post['etiquetaCorreios_Empresa'])){
				$this->data['etiquetaCorreios_Empresa'] = $this->request->post['etiquetaCorreios_Empresa'];
			}elseif($this->config->get('etiquetaCorreios_Empresa')){
				$this->data['etiquetaCorreios_Empresa'] = $this->config->get('etiquetaCorreios_Empresa');
			}else{
				$this->data['etiquetaCorreios_Empresa'] = $this->config->get('config_name');
			}

			//Telefone
			if (isset($this->request->post['etiquetaCorreios_Telefone'])){
				$this->data['etiquetaCorreios_Telefone'] = $this->request->post['etiquetaCorreios_Telefone'];
			}elseif($this->config->get('etiquetaCorreios_Telefone')){
				$this->data['etiquetaCorreios_Telefone'] = $this->config->get('etiquetaCorreios_Telefone');
			}else{
				$this->data['etiquetaCorreios_Telefone'] = $this->config->get('config_telephone');
			}

			//CEP
			if (isset($this->request->post['etiquetaCorreios_Cep'])){
				$this->data['etiquetaCorreios_Cep'] = $this->request->post['etiquetaCorreios_Cep'];
			}else{
				$this->data['etiquetaCorreios_Cep'] = $this->config->get('etiquetaCorreios_Cep');
			}

			//Endereço
			if (isset($this->request->post['etiquetaCorreios_Endereco'])){
				$this->data['etiquetaCorreios_Endereco'] = $this->request->post['etiquetaCorreios_Endereco'];
			}else{
				$this->data['etiquetaCorreios_Endereco'] = $this->config->get('etiquetaCorreios_Endereco');
			}

			//Número
			if(isset($this->request->post['etiquetaCorreios_Numero'])){
				$this->data['etiquetaCorreios_Numero'] = $this->request->post['etiquetaCorreios_Numero'];
			}else{
				$this->data['etiquetaCorreios_Numero'] = $this->config->get('etiquetaCorreios_Numero');
			}

			//Complemento
			if(isset($this->request->post['etiquetaCorreios_Complemento'])){
				$this->data['etiquetaCorreios_Complemento'] = $this->request->post['etiquetaCorreios_Complemento'];
			}else{
				$this->data['etiquetaCorreios_Complemento'] = $this->config->get('etiquetaCorreios_Complemento');
			}

			//Bairro
			if(isset($this->request->post['etiquetaCorreios_Bairro'])){
				$this->data['etiquetaCorreios_Bairro'] = $this->request->post['etiquetaCorreios_Bairro'];
			}else{
				$this->data['etiquetaCorreios_Bairro'] = $this->config->get('etiquetaCorreios_Bairro');
			}

			//Cidade
			if(isset($this->request->post['etiquetaCorreios_Cidade'])){
				$this->data['etiquetaCorreios_Cidade'] = $this->request->post['etiquetaCorreios_Cidade'];
			}else{
				$this->data['etiquetaCorreios_Cidade'] = $this->config->get('etiquetaCorreios_Cidade');
			}

			//Estado / UF
			if(isset($this->request->post['etiquetaCorreios_Uf'])){
				$this->data['etiquetaCorreios_Uf'] = $this->request->post['etiquetaCorreios_Uf'];
			}else{
				$this->data['etiquetaCorreios_Uf'] = $this->config->get('etiquetaCorreios_Uf');
			}

			$this->load->model('localisation/zone');

			$this->data['zones'] = $this->model_localisation_zone->getZonesByCountryId(30);

			/*************************
				Erros | Inicio
			*************************/

			//Warning
			if(isset($this->error['warning'])){
				$this->data['warning'] = $this->error['warning'];
			}else{
				$this->data['warning'] = '';
			}

			//Nome
			if(isset($this->error['error_nome'])){
				$this->data['error_nome'] = $this->error['error_nome'];
			}else{
				$this->data['error_nome'] = '';
			}
			
			//CEP
			if(isset($this->error['error_cep'])){
				$this->data['error_cep'] = $this->error['error_cep'];
			}else{
				$this->data['error_cep'] = '';
			}

			//Endereço
			if(isset($this->error['error_endereco'])){
				$this->data['error_endereco'] = $this->error['error_endereco'];
			}else{
				$this->data['error_endereco'] = '';
			}

			//Numero
			if(isset($this->error['error_numero'])){
				$this->data['error_numero'] = $this->error['error_numero'];
			}else{
				$this->data['error_numero'] = '';
			}

			//Cidade
			if(isset($this->error['error_cidade'])){
				$this->data['error_cidade'] = $this->error['error_cidade'];
			}else{
				$this->data['error_cidade'] = '';
			}

			//Estado
			if(isset($this->error['error_estado'])){
				$this->data['error_estado'] = $this->error['error_estado'];
			}else{
				$this->data['error_estado'] = '';
			}

			/*************************
				Erros | Fim
			*************************/

			//Links
			$this->data['action'] = $this->url->link('module/etiqueta_correios', 'token=' . $this->session->data['token']);
			$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token']);

			//Breadcrumbs
			$this->data['breadcrumbs'] = array();
			$this->data['breadcrumbs'][] = array(
				'text' 		=> 'Home',
				'href' 		=> $this->url->link('common/home', 'token=' . $this->session->data['token']),
				'separator' => false
			);
			$this->data['breadcrumbs'][] = array(
				'text' 		=> 'Modules',
				'href' 		=> $this->url->link('extension/module', 'token=' . $this->session->data['token']),
				'separator' => '::'
			);
			$this->data['breadcrumbs'][] = array(
				'text' 		=> 'Etiqueta Correios',
				'href' 		=> $this->url->link('module/etiqueta_correios', 'token=' . $this->session->data['token']),
				'separator' => '::'
			);


			$this->template = 'module/etiqueta_correios.tpl';
			$this->children = array(
				'common/header',
				'common/footer'
			);
			$this->response->setOutput($this->render());

		}


		private function validate(){

			if (!$this->user->hasPermission('modify', 'module/etiqueta_correios')){
				$this->error['warning'] = 'Atenção: Você não possui permissão para modificar esse módulo!';
			}

			if (empty($this->request->post['etiquetaCorreios_Nome'])){
				$this->error['error_nome'] = 'Campo Obrigatório';
			}

			if (empty($this->request->post['etiquetaCorreios_Cep'])){
				$this->error['error_cep'] = 'Campo Obrigatório';
			}

			if (empty($this->request->post['etiquetaCorreios_Endereco'])){
				$this->error['error_endereco'] = 'Campo Obrigatório';
			}

			if (empty($this->request->post['etiquetaCorreios_Numero'])){
				$this->error['error_numero'] = 'Campo Obrigatório';
			}

			if (empty($this->request->post['etiquetaCorreios_Cidade'])){
				$this->error['error_cidade'] = 'Campo Obrigatório';
			}

			if (empty($this->request->post['etiquetaCorreios_Uf'])){
				$this->error['error_estado'] = 'Campo Obrigatório';
			}

			if ($this->error){
				return false;
			}else{
				return true;
			}

		}

	}

?>