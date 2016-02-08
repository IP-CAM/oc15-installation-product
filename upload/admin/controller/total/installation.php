<?php 
class ControllerTotalInstallation extends Controller { 
	private $error = array(); 
	public function index() { 
		$this->language->load('total/installation');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('installation', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}

//Text and language vatiables section 
		$this->data['heading_title'] = $this->language->get('heading_title'); //Head of module inside admin panel

		$this->data['text_enabled'] = $this->language->get('text_enabled'); //Text of status
		$this->data['text_disabled'] = $this->language->get('text_disabled'); //Text of disable status
		$this->data['text_none'] = $this->language->get('text_none');

		$this->data['entry_total'] = $this->language->get('entry_total');
		$this->data['entry_fee'] = $this->language->get('entry_fee');
		$this->data['entry_tax_class'] = $this->language->get('entry_tax_class');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

//Error display cyrcle
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

//Breadcumps section
		$this->data['breadcrumbs'] = array();

		//'Home' section breadcrumbs
		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		// 'Total' sectition of breadcrumbs
		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		// 'Installation' section of vreadcrumbs
		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/installation', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

$this->data['action'] = $this->url->link('total/installation', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['installation_status'])) {
			$this->data['installation_status'] = $this->request->post['installation_status'];
		} else {
			$this->data['installation_status'] = $this->config->get('installation_status');
		}

		if (isset($this->request->post['installation_sort_order'])) {
			$this->data['installation_sort_order'] = $this->request->post['installation_sort_order'];
		} else {
			$this->data['installation_sort_order'] = $this->config->get('installation_sort_order');
		}

		$this->template = 'total/installation.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'total/installation')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>