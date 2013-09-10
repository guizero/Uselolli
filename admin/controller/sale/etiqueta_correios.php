<?php

	Class ControllerSaleEtiquetaCorreios extends Controller{

		public function gerarEtiqueta(){

			$this->load->model('sale/order');

			$order_info = $this->model_sale_order->getOrder($this->request->get['order_id']);

			$data = array(
				//Remetente
				'remetenteCep' 				=> $this->config->get('etiquetaCorreios_Cep'),
				'remetenteNome' 			=> $this->config->get('etiquetaCorreios_Nome'),
				'remetenteEmpresa' 			=> $this->config->get('etiquetaCorreios_Empresa'),
				'remetenteEndereco' 		=> $this->config->get('etiquetaCorreios_Endereco'),
				'remetenteNumero' 			=> $this->config->get('etiquetaCorreios_Numero'),
				'remetenteComplemento' 		=> $this->config->get('etiquetaCorreios_Complemento'),
				'remetenteTelefone' 		=> $this->config->get('etiquetaCorreios_Telefone'),
				'remetenteBairro' 			=> $this->config->get('etiquetaCorreios_Bairro'),
				'remetenteCidade' 			=> $this->config->get('etiquetaCorreios_Cidade'),
				'remetenteUf' 				=> $this->config->get('etiquetaCorreios_Uf'),
				
				//Destinatário
				'destinatarioCep' 			=> $order_info['shipping_postcode'],
				'destinatarioNome' 			=> $order_info['shipping_firstname'] . ' ' . $order_info['shipping_lastname'],
				'destinatarioEmpresa' 		=> $order_info['shipping_company'],
				'destinatarioEndereco' 		=> $order_info['shipping_address_1'],
				'destinatarioNumero' 		=> $order_info['shipping_numero'],
				'destinatarioComplemento'	=> $order_info['shipping_complemento]',
				'destinatarioTelefone' 		=> $order_info['telephone'],
				'destinatarioBairro' 		=> $order_info['shipping_address_2'],
				'destinatarioCidade' 		=> $order_info['shipping_city'],
				'destinatarioUf' 			=> $order_info['shipping_zone_code'],
			);
			
			$ch = curl_init('http://obaratodachina.com.br/lojaTeste/etqCorreios.php');
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_REFERER, HTTP_SERVER);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
			$response = curl_exec($ch);
			curl_close($ch);

			$this->template = '';
			$this->children = array(
				'common/header'
			);
			$this->response->setOutput($response);
			$this->load->model('sale/order');

			$order_info = $this->model_sale_order->getOrder($this->request->get['order_id']);

			$data = array(
				'tipo' 						=> 'etiqueta',

				//Remetente
				'remetenteCep' 				=> $this->config->get('etiquetaCorreios_Cep'),
				'remetenteNome' 			=> $this->config->get('etiquetaCorreios_Nome'),
				'remetenteEmpresa' 			=> $this->config->get('etiquetaCorreios_Empresa'),
				'remetenteEndereco' 		=> $this->config->get('etiquetaCorreios_Endereco'),
				'remetenteNumero' 			=> $this->config->get('etiquetaCorreios_Numero'),
				'remetenteComplemento' 		=> $this->config->get('etiquetaCorreios_Complemento'),
				'remetenteTelefone' 		=> $this->config->get('etiquetaCorreios_Telefone'),
				'remetenteBairro' 			=> $this->config->get('etiquetaCorreios_Bairro'),
				'remetenteCidade' 			=> $this->config->get('etiquetaCorreios_Cidade'),
				'remetenteUf' 				=> $this->config->get('etiquetaCorreios_Uf'),
				
				//Destinatário
				'destinatarioCep' 			=> $order_info['shipping_postcode'],
				'destinatarioNome' 			=> $order_info['shipping_firstname'] . ' ' . $order_info['shipping_lastname'],
				'destinatarioEmpresa' 		=> $order_info['shipping_company'],
				'destinatarioEndereco' 		=> $order_info['shipping_address_1'],
				'destinatarioNumero' 		=> $order_info['shipping_numero'],
				'destinatarioComplemento'	=> $order_info['shipping_complemento]',
				'destinatarioTelefone' 		=> $order_info['telephone'],
				'destinatarioBairro' 		=> $order_info['shipping_address_2'],
				'destinatarioCidade' 		=> $order_info['shipping_city'],
				'destinatarioUf' 			=> $order_info['shipping_zone_code'],
			);
			
			$ch = curl_init('http://obaratodachina.com.br/valdeir/etqCorreios/index.php');
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_REFERER, HTTP_SERVER);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
			$response = curl_exec($ch);
			curl_close($ch);

			$this->response->setOutput($response);
		}

		public function gerarAr(){

			$this->load->model('sale/order');

			$order_info = $this->model_sale_order->getOrder($this->request->get['order_id']);

			$data = array(
				'tipo' 						=> 'ar',

				//Remetente
				'remetenteCep' 				=> $this->config->get('etiquetaCorreios_Cep'),
				'remetenteNome' 			=> $this->config->get('etiquetaCorreios_Nome'),
				'remetenteEmpresa' 			=> $this->config->get('etiquetaCorreios_Empresa'),
				'remetenteEndereco' 		=> $this->config->get('etiquetaCorreios_Endereco'),
				'remetenteNumero' 			=> $this->config->get('etiquetaCorreios_Numero'),
				'remetenteComplemento' 		=> $this->config->get('etiquetaCorreios_Complemento'),
				'remetenteTelefone' 		=> $this->config->get('etiquetaCorreios_Telefone'),
				'remetenteBairro' 			=> $this->config->get('etiquetaCorreios_Bairro'),
				'remetenteCidade' 			=> $this->config->get('etiquetaCorreios_Cidade'),
				'remetenteUf' 				=> $this->config->get('etiquetaCorreios_Uf'),
				
				//Destinatário
				'destinatarioCep' 			=> $order_info['shipping_postcode'],
				'destinatarioNome' 			=> $order_info['shipping_firstname'] . ' ' . $order_info['shipping_lastname'],
				'destinatarioEmpresa' 		=> $order_info['shipping_company'],
				'destinatarioEndereco' 		=> $order_info['shipping_address_1'],
				'destinatarioNumero' 		=> $order_info['shipping_numero'],
				'destinatarioComplemento'	=> $order_info['shipping_complemento]',
				'destinatarioTelefone' 		=> $order_info['telephone'],
				'destinatarioBairro' 		=> $order_info['shipping_address_2'],
				'destinatarioCidade' 		=> $order_info['shipping_city'],
				'destinatarioUf' 			=> $order_info['shipping_zone_code'],
			);
			
			$ch = curl_init('http://obaratodachina.com.br/valdeir/etqCorreios/index.php');
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_REFERER, 'http://localhost/');
			curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
			$response = curl_exec($ch);
			curl_close($ch);

			$this->response->setOutput($response);

		}

	}

?>