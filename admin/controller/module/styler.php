<?php
class ControllerModuleStyler extends Controller {
	private $error = array(); 
	
	public function index() {   
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			for ($i=1;$i<=15;$i++){
				$settings['styler_module'][] = array_merge(array (
					'layout_id' => $i,
					'position' => 'content_top',
					'sort_order' => ''
				),$this->request->post['styler_module']);
			}
			

			$this->model_setting_setting->editSetting('styler', $settings);	
					
			$this->session->data['success'] = 'Success: You have modified module Theme Settings!';
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
				
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => 'Home',
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => 'Modules',
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => 'Theme Settings',
			'href'      => $this->url->link('module/styler', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/styler', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['styler_module'])) {
			$this->data['modules'] = $this->request->post['styler_module'];
		} elseif ($this->config->get('styler_module')) { 
			$layout_modules = $this->config->get('styler_module');
			$this->data['modules'] = $layout_modules['0'];
		}	

		$this->data['img_files'] = array();
		$curr_theme = $this->config->get("config_template");

		// Usage 
		$dir = 'view/image/bgrs/';
		$this->data['img_files'] = ReadFolderDirectory($dir);
				
		$this->template = 'module/styler.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/styler')) {
			$this->error['warning'] = "Warning: You do not have permission to modify module banner!";
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}


function ReadFolderDirectory($dir) 
    { 
        $listDir = array(); 
        if($handler = opendir($dir)) { 
            while (($sub = readdir($handler)) !== FALSE) { 
                if ($sub != "." && $sub != ".." && $sub != "Thumb.db") { 
                    if(is_file($dir."/".$sub)) { 
                        $listDir[] = $sub; 
                    }elseif(is_dir($dir."/".$sub)){ 
                        $listDir[$sub] = $this->ReadFolderDirectory($dir."/".$sub); 
                    } 
                } 
            }    
            closedir($handler); 
        } 
        return $listDir;    
    } 
?>