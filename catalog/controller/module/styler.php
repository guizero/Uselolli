<?php  
class ControllerModuleStyler extends Controller {
	protected function index($setting) {
		
		$this->data['styles'] = $setting;
			
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/styler.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/styler.tpl';
		} else {
			$this->template = 'default/template/module/styler.tpl';
		}
		
		$this->render();
	}
}
?>