<?php 
class ControllerAccountfbjsconnect extends Controller {
	private $error = array();
	      
  	public function index() {

  		
		if ($this->customer->isLogged()) {

	  		if (isset($this->request->get['pagina'])) {
			$this->redirect($this->url->link('checkout/checkout', '', 'SSL'));
			}
			else {
				$this->redirect($this->url->link('common/home', '', 'SSL'));
			}

		}

		$this->language->load('module/fbjsconnect');

		if(!isset($this->fbjsconnect)){			
			require_once(DIR_SYSTEM . 'vendor/facebook-sdk/facebook.php');

			$this->fbjsconnect = new Facebook(array(
				'appId'  => $this->config->get('fbjsconnect_apikey'),
				'secret' => $this->config->get('fbjsconnect_apisecret'),
			));
		}

		$_SERVER_CLEANED = $_SERVER;
		$_SERVER = $this->clean_decode($_SERVER);

		$fbuser = $this->fbjsconnect->getUser();
		$fbuser_profile = null;
		if ($fbuser){
			try {
				$fbuser_profile = $this->fbjsconnect->api("/$fbuser");
			} catch (FacebookApiException $e) {
				error_log($e);
				$fbuser = null;
			}
		}

		$_SERVER = $_SERVER_CLEANED;
	
		if($fbuser_profile['id'] && $fbuser_profile['email'] && $fbuser_profile['verified']){
			$this->load->model('account/customer');

			$email = $fbuser_profile['email'];
			$password = $this->get_password($fbuser_profile['id']);

			if($this->customer->login($email, $password)){
				if (isset($this->request->get['pagina']))  {
			$this->redirect($this->url->link('checkout/checkout', '', 'SSL'));
		}
		else {
			$this->redirect($this->url->link('common/home', '', 'SSL'));
		}
			}

			$email_query = $this->db->query("SELECT `email` FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(strtolower($email)) . "'");

			if($email_query->num_rows){
				$this->model_account_customer->editPassword($email, $password);
				
				if($this->customer->login($email, $password)){
					if (isset($this->request->get['pagina'])) {
			$this->redirect($this->url->link('checkout/checkout', '', 'SSL'));
		}
		else {
			$this->redirect($this->url->link('common/home', '', 'SSL'));
		}
				}
			}
			else{
				$config_customer_approval = $this->config->get('config_customer_approval');
				$this->config->set('config_customer_approval',0);

				$this->request->post['email'] = $email;
			
				$add_data=array();
				$add_data['email'] = $fbuser_profile['email'];
				$add_data['password'] = $password;
				$add_data['firstname'] = isset($fbuser_profile['first_name']) ? $fbuser_profile['first_name'] : '';
				$add_data['lastname'] = isset($fbuser_profile['last_name']) ? $fbuser_profile['last_name'] : '';
				$add_data['fax'] = '';
				$add_data['telephone'] = '';
				$add_data['company'] = '';
				$add_data['address_1'] = '';
				$add_data['address_2'] = '';
				$add_data['city'] = '';
				$add_data['postcode'] = '';
				$add_data['country_id'] = 30;
				$add_data['zone_id'] = 0;
	            $add_data['company_id'] = '';
				$add_data['tax_id'] = '';
				$add_data['cpf'] = '';
				$add_data['cnpj'] = '';
				$add_data['rg'] = '';
				$add_data['razao_social'] = '';
				$add_data['sexo'] = '';
				$add_data['apelido'] = 'casa';
				$add_data['numero'] = '';
				$add_data['complemento'] = '';
				$add_data['data_nascimento'] = '';
				$add_data['inscricao_estadual'] = '';

				$this->model_account_customer->addCustomer($add_data);
				$this->config->set('config_customer_approval',$config_customer_approval);

				if($this->customer->login($email, $password)){
					unset($this->session->data['guest']);
					$this->redirect($this->url->link('account/success'));
				}
			}

		}
		if (isset($this->request->get['pagina'])) {
			$this->redirect($this->url->link('checkout/checkout', '', 'SSL'));
		}
		else {
			$this->redirect($this->url->link('common/home', '', 'SSL'));
		}

	}

	private function get_password($str) {
		$password = $this->config->get('fbjsconnect_pwdsecret') ? $this->config->get('fbjsconnect_pwdsecret') : 'fb';
		$password.=substr($this->config->get('fbjsconnect_apisecret'),0,3).substr($str,0,3).substr($this->config->get('fbjsconnect_apisecret'),-3).substr($str,-3);
		return strtolower($password);
	}

	private function clean_decode($data) {
    		if (is_array($data)) {
	  		foreach ($data as $key => $value) {
				unset($data[$key]);
				$data[$this->clean_decode($key)] = $this->clean_decode($value);
	  		}
		} else { 
	  		$data = htmlspecialchars_decode($data, ENT_COMPAT);
		}

		return $data;
	}
	
}
?>