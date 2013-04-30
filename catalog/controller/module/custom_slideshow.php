<?php  
class ControllerModuleCustomSlideshow extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('design/banner');
		$this->load->model('tool/image');
		
		$this->document->addScript('catalog/view/javascript/jquery/jquery.easing.1.3.js');
//		$this->document->addScript('catalog/view/javascript/jquery/camera.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/camera.js');
		
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/camera.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/camera.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/camera.css');
		}
		
		$this->data['width'] = $setting['width'];
		$this->data['height'] = $setting['height'];
		
		$this->data['banners'] = array();
		
		if (isset($setting['banner_id'])) {
			$results = $this->model_design_banner->getBanner($setting['banner_id']);
			  
			foreach ($results as $result) {
				if (file_exists(DIR_IMAGE . $result['image'])) {
					$this->data['banners'][] = array(
						'title' => $result['title'],
						'link'  => $result['link'],
						'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
					);
				}
			}
		}
		
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/custom_slideshow.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/custom_slideshow.tpl';
		} else {
			$this->template = 'default/template/module/custom_slideshow.tpl';
		}
		
		$this->render();
	}
}
?>