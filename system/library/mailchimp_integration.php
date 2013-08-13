<?php
//==============================================================================
// MailChimp Integration v155.3
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class Mailchimp_Integration {
	private $type = 'module';
	private $name = 'mailchimp_integration';
	
  	public function __construct($config, $db, $log) {
		$this->config = $config;
		$this->db = $db;
		$this->log = $log;
	}
	
	public function getLists($settings) {
		$curl_data = array(
			'method'	=> 'lists',
			'apikey'	=> $settings['apikey'],
			'limit'		=> 100
		);
		$response = $this->curlRequest($curl_data);
		if (!empty($response['error']) && $settings['logerrors']) {
			$this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
		}
		return $response;
	}
	
	public function send($data) {
		$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		$settings = ($version < 151) ? unserialize($this->config->get($this->name . '_data')) : $this->config->get($this->name . '_data');
		
		if (empty($settings['status']) || empty($settings['apikey']) || empty($settings['listid'])) return;
		
		// Get customer information
		if (!empty($data['customer_id'])) {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = " . (int)$data['customer_id']);
			$customer = $customer_query->row;
		} else {
			$customer = array(
				'customer_group_id'	=> '',
				'email'				=> (isset($data['email'])) ? $data['email'] : '',
				'firstname'			=> '',
				'lastname'			=> '',
				'address_id'		=> '',
				'telephone'			=> '0000000000'
			);
		}
		
		// Determine which list to use
		if (!empty($settings['lists'][(int)$this->config->get('config_store_id')][(int)$customer['customer_group_id']])) {
			$listid = $settings['lists'][(int)$this->config->get('config_store_id')][(int)$customer['customer_group_id']];
		} else {
			$listid = $settings['listid'];
		}
		
		// Get address information
		$address_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "address WHERE address_id = " . (int)$customer['address_id']);
		if ($address_query->num_rows) {
			$customer['address'] = $address_query->row;
			
			$country_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE country_id = " . (int)$customer['address']['country_id']);
			$customer['address']['iso_code_2'] = (!empty($country_query->row['iso_code_2'])) ? $country_query->row['iso_code_2'] : '';
			
			$zone_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE zone_id = " . (int)$customer['address']['zone_id']);
			$customer['address']['zone'] = (!empty($zone_query->row['name'])) ? html_entity_decode($zone_query->row['name'], ENT_QUOTES, 'UTF-8') : '(none)';
		} else {
			$customer['address'] = array(
				'address_1'		=> '',
				'address_2'		=> '',
				'city'			=> '',
				'zone'			=> '',
				'postcode'		=> '',
				'iso_code_2'	=> ''
			);
		}
		
		// Subscribe or Unsubscribe
		if (!empty($data['newsletter'])) {
			// E-mail merge
			$merge_array = array(
				'EMAIL'	=> (isset($data['email'])) ? $data['email'] : $customer['email']
			);
			
			// First Name merge
			if ($settings['fname']) {
				$merge_array[$settings['fname']] = (isset($data['firstname'])) ? $data['firstname'] : $customer['firstname'];
			}
			
			// Last Name merge
			if ($settings['lname']) {
				$merge_array[$settings['lname']] = (isset($data['lastname'])) ? $data['lastname'] : $customer['lastname'];
			}
			
			// Address merge
			if ($settings['address']) {
				if (!empty($data['addresses'])) $data['address'] = $data['addresses'];
				if (!empty($data['address'])) {
					foreach ($data['address'] as $address_data) {
						$address = $address_data;
						if (!empty($address['default'])) break;
					}
				} else {
					$address = $data;
				}
				
				if (!empty($address['country_id'])) {
					$country_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE country_id = " . (int)$address['country_id']);
					$address['iso_code_2'] = (!empty($country_query->row['iso_code_2'])) ? $country_query->row['iso_code_2'] : '';
				}
				
				if (!empty($address['zone_id'])) {
					$zone_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE zone_id = " . (int)$address['zone_id']);
					$address['zone'] = (!empty($zone_query->row['name'])) ? html_entity_decode($zone_query->row['name'], ENT_QUOTES, 'UTF-8') : '(none)';
				}
				
				$merge_array[$settings['address']] = array(
					'addr1'		=> (isset($address['address_1']))	? $address['address_1']		: $customer['address']['address_1'],
					'addr2'		=> (isset($address['address_2']))	? $address['address_2']		: $customer['address']['address_2'],
					'city'		=> (isset($address['city']))		? $address['city']			: $customer['address']['city'],
					'state'		=> (isset($address['zone']))		? $address['zone']			: $customer['address']['zone'],
					'zip'		=> (isset($address['postcode']))	? $address['postcode']		: $customer['address']['postcode'],
					'country'	=> (isset($address['iso_code_2']))	? $address['iso_code_2']	: $customer['address']['iso_code_2']
				);
			}
			
			// Phone merge
			if ($settings['phone']) {
				$phone = preg_replace('/[^0-9]/', '', (isset($data['telephone'])) ? $data['telephone'] : $customer['telephone']);
				$merge_array[$settings['phone']] = substr($phone,0,3) . '-' . substr($phone,3,3) . '-' . substr($phone,6);
			}
			
			// Check for required merge tags that are not set
			$curl_data = array(
				'method'	=> 'listMergeVars',
				'apikey'	=> $settings['apikey'],
				'id'		=> $settings['listid']
			);
			$response = $this->curlRequest($curl_data);
			if (!empty($response['error'])) {
				if ($settings['logerrors']) $this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
				return empty($response['error']);
			}
			foreach ($response as $mergetag) {
				if (!$mergetag['req'] || !empty($merge_array[$mergetag['tag']])) {
					continue;
				} elseif ($mergetag['field_type'] == 'zip') {
					$merge_array[$mergetag['tag']] = '00000';
				} else {
					$merge_array[$mergetag['tag']] = '(none)';
				}
			}
			
			// Subscribe
			$curl_data = array(
				'method'			=> 'listSubscribe',
				'apikey'			=> $settings['apikey'],
				'id'				=> $listid,
				'email_address'		=> $customer['email'],
				'merge_vars'		=> $merge_array,
				'email_type'		=> 'html',
				'double_optin'		=> (isset($data['double_optin']) ? $data['double_optin'] : $settings['double_optin']),
				'update_existing'	=> true,
				'send_welcome'		=> false
			);
		} else {
			// Unsubscribe
			$curl_data = array(
				'method'			=> 'listUnsubscribe',
				'apikey'			=> $settings['apikey'],
				'id'				=> $listid,
				'email_address'		=> $customer['email'],
				'delete_member'		=> false,
				'send_goodbye'		=> true,
				'send_notify'		=> true
			);
		}
		
		$response = $this->curlRequest($curl_data);
		if (!empty($response['error']) && $settings['logerrors']) {
			$this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
		}
		return empty($response['error']);
	}
	
	public function sync($settings) {
		if (empty($settings['status']) || empty($settings['apikey']) || empty($settings['listid'])) return;
		$output = "Completed!\n\n";
		
		$customers = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer ORDER BY customer_group_id ASC");
		$opencart_emails = array();
		foreach ($customers->rows as $customer) {
			$opencart_emails[] = $customer['email'];
		}
		
		// MailChimp to OpenCart
		if ($settings['autocreate']) {
			$created = 0;
			
			$lists = $this->getLists($settings);
			$lists = (empty($lists['error'])) ? $lists['data'] : array();
			
			foreach ($lists as $list) {
				$curl_data = array(
					'method'	=> 'listMembers',
					'apikey'	=> $settings['apikey'],
					'id'		=> $list['id'],
					'limit'		=> 15000
				);
				$response = $this->curlRequest($curl_data);
				if (!empty($response['error'])) {
					if ($settings['logerrors']) $this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
					return $response['error'];
				}
				
				$mailchimp_emails = array();
				foreach ($response['data'] as $member) {
					$mailchimp_emails[] = $member['email'];
				}
				$diff_emails = array_diff($mailchimp_emails, $opencart_emails);
				
				for ($i = 0; $i < count($diff_emails); $i += 50) {
					$curl_data = array(
						'method'			=> 'listMemberInfo',
						'apikey'			=> $settings['apikey'],
						'id'				=> $list['id'],
						'email_address'		=> array_slice($diff_emails, $i, 50)
					);
					
					$response = $this->curlRequest($curl_data);
					if (!empty($response['error'])) {
						if ($settings['logerrors']) $this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
						return $response['error'];
					}
					
					foreach ($response['data'] as $data) {
						$this->createCustomer($data, $settings);
						$created++;
					}
				}
			}
			
			$output .= $created . " customer(s) created in OpenCart\n";
		}
		
		// Check for required merge tags that are not set
		$merge_array = array();
		$curl_data = array(
			'method'	=> 'listMergeVars',
			'apikey'	=> $settings['apikey'],
			'id'		=> $settings['listid']
		);
		$response = $this->curlRequest($curl_data);
		if (!empty($response['error'])) {
			if ($settings['logerrors']) $this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
			return empty($response['error']);
		}
		foreach ($response as $mergetag) {
			if (!$mergetag['req'] || !empty($merge_array[$mergetag['tag']])) {
				continue;
			} elseif ($mergetag['field_type'] == 'zip') {
				$merge_array[$mergetag['tag']] = '00000';
			} else {
				$merge_array[$mergetag['tag']] = '(none)';
			}
		}
		
		// OpenCart to MailChimp
		$batch = array();
		$customer_group_id = 0;
		$add_count = 0;
		$update_count = 0;
		$error_count = 0;
		
		foreach (array_merge($customers->rows, array(array('newsletter' => true, 'customer_group_id' => 0, 'stop' => true))) as $customer) {
			if (!$customer['newsletter']) continue;
			
			if ($customer['customer_group_id'] != $customer_group_id) {
				// Determine which list to use
				if (!empty($settings['lists'][(int)$this->config->get('config_store_id')][(int)$customer_group_id])) {
					$listid = $settings['lists'][(int)$this->config->get('config_store_id')][(int)$customer_group_id];
				} else {
					$listid = $settings['listid'];
				}
				
				if (!empty($batch)) {
					$curl_data = array(
						'method'			=> 'listBatchSubscribe',
						'apikey'			=> $settings['apikey'],
						'id'				=> $listid,
						'batch'				=> $batch,
						'double_optin'		=> false,
						'update_existing'	=> true
					);
					
					$response = $this->curlRequest($curl_data);
					if (!empty($response['error'])) {
						if ($settings['logerrors']) $this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
						return $response['error'];
					} else {
						$add_count += $response['add_count'];
						$update_count += $response['update_count'];
						$error_count += $response['error_count'];
					}
				}
				
				$batch = array();
				$customer_group_id = $customer['customer_group_id'];
			}
			
			if (isset($customer['stop'])) break;
			
			$data = $merge_array;
			$data['EMAIL'] = $customer['email'];
			if ($settings['fname']) {
				$data[$settings['fname']] = $customer['firstname'];
			}
			if ($settings['lname']) {
				$data[$settings['lname']] = $customer['lastname'];
			}
			if ($settings['address']) {
				$address_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "address WHERE address_id = " . (int)$customer['address_id']);
				if ($address_query->num_rows) {
					$address = $address_query->row;
					if (!empty($address['country_id'])) {
						$country_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE country_id = " . (int)$address['country_id']);
						$address['iso_code_2'] = (!empty($country_query->row['iso_code_2'])) ? $country_query->row['iso_code_2'] : '';
					}
					if (!empty($address['zone_id'])) {
						$zone_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE zone_id = " . (int)$address['zone_id']);
						$address['zone'] = (!empty($zone_query->row['name'])) ? html_entity_decode($zone_query->row['name'], ENT_QUOTES, 'UTF-8') : '(none)';
					}
					$data[$settings['address']] = array(
						'addr1'		=> $address['address_1'],
						'addr2'		=> $address['address_2'],
						'city'		=> $address['city'],
						'state'		=> (isset($address['zone'])) ? $address['zone'] : '(none)',
						'zip'		=> $address['postcode'],
						'country'	=> (isset($address['iso_code_2'])) ? $address['iso_code_2'] : ''
					);
				}
			}
			if ($settings['phone']) {
				$phone = preg_replace('/[^0-9]/', '', $customer['telephone']);
				$data[$settings['phone']] = substr($phone,0,3) . '-' . substr($phone,3,3) . '-' . substr($phone,6);
			}
			$batch[] = $data;
		}
		
		$output .= $add_count . " customer(s) added to MailChimp\n";
		$output .= $update_count . " customer(s) updated in MailChimp\n";
		$output .= $error_count . " customer(s) failed sending to MailChimp\n\n";
		if (!empty($response['errors'])) {
			$output .= "Error(s):\n";
			foreach ($response['errors'] as $error) {
				$output .= $error['message'] . "\n";
			}
		}
		return $output;
	}
	
	public function addWebhooks($settings) {
		if (empty($settings['status']) || empty($settings['apikey']) || empty($settings['listid']) || empty($settings['urlcode']) || empty($settings['webhooks'])) return;
		
		$catalog_url = ($this->config->get('config_ssl') || $this->config->get('config_use_ssl')) ? str_replace('http:', 'https:', HTTP_CATALOG) : HTTP_CATALOG;
		$url = $catalog_url . 'index.php?route=' . $this->type . '/' . $this->name . '/webhook&code=' . $settings['urlcode'];
		
		$lists = $this->getLists($settings);
		$lists = (empty($lists['error'])) ? $lists['data'] : array();
		
		foreach ($lists as $list) {
			$curl_data = array(
				'method'	=> 'listWebhooks',
				'apikey'	=> $settings['apikey'],
				'id'		=> $list['id']
			);
			$response = $this->curlRequest($curl_data);
			
			$mc_webhooks = array();
			foreach ($response as $mc_webhook) {
				$mc_webhooks[] = $mc_webhook['url'];
			}
			
			if (!in_array($url, $mc_webhooks)) {
				$curl_data = array(
					'method'	=> 'listWebhookAdd',
					'apikey'	=> $settings['apikey'],
					'id'		=> $list['id'],
					'url'		=> $url,
					'actions'	=> array(
						'subscribe'		=> !empty($settings['webhooks']['subscribe']),
						'unsubscribe'	=> !empty($settings['webhooks']['unsubscribe']),
						'profile'		=> !empty($settings['webhooks']['profile']),
						'upemail'		=> !empty($settings['webhooks']['profile']),
						'cleaned'		=> !empty($settings['webhooks']['cleaned']),
						'campaign'		=> false
					)
				);
				$response = $this->curlRequest($curl_data);
				if (!empty($response['error']) && $settings['logerrors']) {
					$this->log->write(strtoupper($this->name) . ' ' . $response['code'] . ' ERROR: ' . $response['error']);
				}
			}
		}
	}
	
	public function webhook($type, $data) {
		$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		$settings = ($version < 151) ? unserialize($this->config->get($this->name . '_data')) : $this->config->get($this->name . '_data');
		
		$webhooks = $settings['webhooks'];
		
		$listid = $settings['listid'];
		$customer_group_id = $this->config->get('config_customer_group_id');
		foreach ($settings['lists'][0] as $cg_id => $cg_list) {
			if ($cg_list == $data['list_id']) {
				$listid = $cg_list;
				$customer_group_id = $cg_id;
				break;
			}
		}
		
		if ($data['list_id'] != $listid) {
			if ($settings['logerrors']) {
				$this->log->write(strtoupper($this->name) . ' WEBHOOK ERROR: webhook List ID ' . $data['list_id'] . ' does not match the List ID ' . $listid . ' for action "' . $type . '" for e-mail address ' . $data['email']);
			}
			return;
		}
		
		$success = false;
		$data['customer_group_id'] = $customer_group_id;
		
		if ($type == 'subscribe' && $webhooks['subscribe']) {
			if ($settings['autocreate']) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE email = '" . $this->db->escape($data['email']) . "'");
				if (!$query->num_rows) {
					$this->createCustomer($data, $settings);
				}
			}
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = 1 WHERE email = '" . $this->db->escape($data['email']) . "'");
			$success = true;
		} elseif (($type == 'unsubscribe' && $webhooks['unsubscribe']) || ($type == 'cleaned' && $webhooks['cleaned'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = 0 WHERE email = '" . $this->db->escape($data['email']) . "'");
			$success = true;
		} elseif ($type == 'profile' && $webhooks['profile']) {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE email = '" . $this->db->escape($data['email']) . "'");
			if (empty($customer_query->row['address_id'])) {
				$this->log->write('not updating address_id ' . $customer_query->row['address_id']);
				return;
			}
			if ($customer['firstname']) {
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET firstname = '" . $this->db->escape($customer['firstname']) . "' WHERE email = '" . $this->db->escape($data['email']) . "'");
				$this->db->query("UPDATE " . DB_PREFIX . "address SET firstname = '" . $this->db->escape($customer['firstname']) . "' WHERE address_id = " . (int)$customer_query->row['address_id']);
			}
			if ($customer['lastname']) {
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET lastname = '" . $this->db->escape($customer['lastname']) . "' WHERE email = '" . $this->db->escape($data['email']) . "'");
				$this->db->query("UPDATE " . DB_PREFIX . "address SET lastname = '" . $this->db->escape($customer['lastname']) . "' WHERE address_id = " . (int)$customer_query->row['address_id']);
			}
			if ($customer['address']) {
				$country_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE iso_code_2 = '" . $this->db->escape($customer['address']['country']) . "'");
				$zone_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE (`name` = '" . $this->db->escape($customer['address']['state']) . "' OR `code` = '" . $this->db->escape($customer['address']['state']) . "') AND country_id = '" . $this->db->escape($country->row['country_id']) . "'");
				
				$this->db->query("
					UPDATE " . DB_PREFIX . "address SET
					address_1 = '" . $this->db->escape($customer['address']['addr1']) . "',
					address_2 = '" . $this->db->escape($customer['address']['addr2']) . "',
					city = '" . $this->db->escape($customer['address']['city']) . "',
					zone_id = " . ($zone_query->num_rows ? (int)$zone->row['zone_id'] : 0) . ",
					postcode = '" . $this->db->escape($data_address['zip']) . "',
					country_id = " . ($country_query->num_rows ? (int)$country->row['country_id'] : 0) . "
					WHERE address_id = " . (int)$customer_query->row['address_id'] . "
				");
			}
			if ($data_phone) {
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET telephone = '" . $this->db->escape($customer['telephone']) . "' WHERE email = '" . $this->db->escape($data['email']) . "'");
			}
			$success = true;
		} elseif ($type == 'upemail' && $webhooks['profile']) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET email = '" . $this->db->escape($data['new_email']) . "' WHERE email = '" . $this->db->escape($data['old_email']) . "'");
		}
		
		if ($settings['logerrors'] && $success) {
			$this->log->write(strtoupper($this->name) . ' WEBHOOK SUCCESS: ' . $type . ' ' . $data['email'] . ' (List ID ' . $data['list_id'] . ')');
		}
	}
	
	private function createCustomer($data, $settings) {
		$customer = array(
			'status'			=> ($settings['autocreate'] == 2),
			'customer_group_id'	=> (!empty($data['customer_group_id']) ? $data['customer_group_id'] : $this->config->get('config_customer_group_id')),
			'email'				=> $data['email'],
			'firstname'			=> (!empty($data['merges'][$settings['fname']]) ? $data['merges'][$settings['fname']] : ''),
			'lastname'			=> (!empty($data['merges'][$settings['lname']]) ? $data['merges'][$settings['lname']] : ''),
			'telephone'			=> (!empty($data['merges'][$settings['phone']]) ? $data['merges'][$settings['phone']] : ''),
			'address'			=> (!empty($data['merges'][$settings['address']]) ? $data['merges'][$settings['address']] : array()),
			'ip'				=> $data['ip_opt']
		);
		
		$this->db->query("
			INSERT INTO " . DB_PREFIX . "customer SET
			status = " . (int)$customer['status'] . ",
			approved = 1,
			newsletter = 1,
			customer_group_id = " . (int)$customer['customer_group_id'] . ",
			email = '" . $this->db->escape($customer['email']) . "',
			firstname = '" . $this->db->escape($customer['firstname']) . "',
			lastname = '" . $this->db->escape($customer['lastname']) . "',
			telephone = '" . $this->db->escape($customer['telephone']) . "',
			ip = '" . $this->db->escape($customer['ip']) . "',
			password = '" . $this->db->escape(md5(rand())) . "',
			date_added = NOW()
		");
		
		if (!isset($customer['address']['addr1']))		$customer['address']['addr1']	= '';
		if (!isset($customer['address']['addr2']))		$customer['address']['addr2']	= '';
		if (!isset($customer['address']['city']))		$customer['address']['city']	= '';
		if (!isset($customer['address']['zip']))		$customer['address']['zip']	= '';
		if (!isset($customer['address']['country']))	$customer['address']['country']	= '';
		if (!isset($customer['address']['state']))		$customer['address']['state'] = '';
		
		$customer_id = $this->db->getLastId();
		$country_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE iso_code_2 = '" . $this->db->escape($customer['address']['country']) . "'");
		$country_id = ($country_query->num_rows) ? $country_query->row['country_id'] : 0;
		$zone_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE (`name` = '" . $this->db->escape($customer['address']['state']) . "' OR `code` = '" . $this->db->escape($customer['address']['state']) . "') AND country_id = " . (int)$country_id);
		$zone_id =  ($zone_query->num_rows) ? $zone_query->row['zone_id'] : 0;
		
		$this->db->query("
			INSERT INTO " . DB_PREFIX . "address SET
			customer_id = " . (int)$customer_id . ",
			firstname = '" . $this->db->escape($customer['firstname']) . "',
			lastname = '" . $this->db->escape($customer['lastname']) . "',
			address_1 = '" . $this->db->escape($customer['address']['addr1']) . "',
			address_2 = '" . $this->db->escape($customer['address']['addr2']) . "',
			city = '" . $this->db->escape($customer['address']['city']) . "',
			zone_id = " . (int)$zone_id . ",
			postcode = '" . $this->db->escape($customer['address']['zip']) . "',
			country_id = " . (int)$country_id . "
		");
		
		$address_id = $this->db->getLastId();
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = " . (int)$address_id . " WHERE customer_id = " . (int)$customer_id);
		
		if ($settings['logerrors']) {
			$this->log->write(strtoupper($this->name) . ' CUSTOMER CREATED: ' . $customer['firstname'] . ' ' . $customer['lastname'] . ' (' . $customer['email'] . ')');
		}
	}
	
	private function curlRequest($data = array()) {
		$data_center = explode('-', $data['apikey']);
		$url = 'https://' . (isset($data_center[1]) ? $data_center[1] : 'us1') . '.api.mailchimp.com/1.3/?output=json&method=' . $data['method'];
		
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 10);
		curl_setopt($curl, CURLOPT_FORBID_REUSE, true);
		curl_setopt($curl, CURLOPT_FRESH_CONNECT, true);
		curl_setopt($curl, CURLOPT_HEADER, false);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data, '', '&'));
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_TIMEOUT, 30);
		$response = json_decode(curl_exec($curl), true);
		
		if (curl_error($curl)) {
			$response = array('code' => 'CURL', 'error' => curl_errno($curl) . ': ' . curl_error($curl));
		} elseif (empty($response)) {
			$response = array('code' => 'CURL', 'error' => 'Empty gateway response');
		} elseif (!empty($response->error)) {
			$response = array('code' => $response->code, 'error' => $response->error);
		}
		curl_close($curl);
		
		return $response;
	}
}
?>