<?php
class ControllerCommonSeoUrl extends Controller {
    /* SEO Custom URL */
    private $url_list = array (
        'common/home' => '',
        'account/wishlist' => 'lista-presentes',
        'account/account' => 'conta',
        'account/edit' => 'conta/editar',
        'account/password' => 'conta/senha',
        'account/address' => 'conta/enderecos',
        'account/reward' => 'conta/pontos',
        'account/login' => 'conta/acessar',
        'account/logout' => 'conta/sair',
        'account/order' => 'conta/historico',
        'account/newsletter' => 'conta/informativo',
        'account/forgotten' => 'conta/recuperar',
        'account/download' => 'conta/downloads',
        'account/return' => 'conta/devolucoes',
        'account/transaction' => 'conta/transacoes',
        'account/register' => 'conta/registrar',
        'account/return/insert' => 'conta/devolucoes/registrar',
        'affiliate/account' => 'afiliados',
        'affiliate/edit' => 'afiliados/editar',
        'affiliate/password' => 'afiliados/senha',
        'affiliate/payment' => 'afiliados/pagamento',
        'affiliate/tracking' => 'afiliados/codigo',
        'affiliate/transaction' => 'afiliados/transacoes',
        'affiliate/logout' => 'afiliados/sair',
        'affiliate/forgotten' => 'afiliados/recuperar',
        'affiliate/register' => 'afiliados/registrar',
        'affiliate/login' => 'afiliados/acessar',
        'checkout/cart' => 'sacola',
        'checkout/checkout' => 'sacola/finalizar',
        'checkout/voucher' => 'vale-presentes',
        'information/contact' => 'contato',
        'information/sitemap' => 'mapa-loja',
        'product/special' => 'promocoes',
        'product/manufacturer' => 'fabricantes',
        'product/compare' => 'lista-comparacao',
        'product/search' => 'busca'
    );
    /* SEO Custom URL */
 
    public function index() {
        // Add rewrite to url class
        if ($this->config->get('config_seo_url')) {
            $this->url->addRewrite($this);
        }
 
        // Decode URL
        if (isset($this->request->get['_route_'])) {
            $parts = explode('/', $this->request->get['_route_']);
 
            foreach ($parts as $part) {
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
 
                if ($query->num_rows) {
                    $url = explode('=', $query->row['query']);
 
                    if ($url[0] == 'product_id') {
                        $this->request->get['product_id'] = $url[1];
                    }
 
                    if ($url[0] == 'category_id') {
                        if (!isset($this->request->get['path'])) {
                            $this->request->get['path'] = $url[1];
                        } else {
                            $this->request->get['path'] .= '_' . $url[1];
                        }
                    }    
 
                    if ($url[0] == 'manufacturer_id') {
                        $this->request->get['manufacturer_id'] = $url[1];
                    }
 
                    if ($url[0] == 'information_id') {
                        $this->request->get['information_id'] = $url[1];
                    }
                } else {
                    $this->request->get['route'] = 'error/not_found';    
                }
            }
 
            /* SEO Custom URL */
            if ( $_s = $this->setURL($this->request->get['_route_']) ) {
                    $this->request->get['route'] = $_s;
            }/* SEO Custom URL */
 
            if (isset($this->request->get['product_id'])) {
                $this->request->get['route'] = 'product/product';
            } elseif (isset($this->request->get['path'])) {
                $this->request->get['route'] = 'product/category';
            } elseif (isset($this->request->get['manufacturer_id'])) {
                $this->request->get['route'] = 'product/manufacturer/info';
            } elseif (isset($this->request->get['information_id'])) {
                $this->request->get['route'] = 'information/information';
            }
 
            if (isset($this->request->get['route'])) {
                return $this->forward($this->request->get['route']);
            }
        }
    }
 
    public function rewrite($link) {
        if ($this->config->get('config_seo_url')) {
            $url_data = parse_url(str_replace('&amp;', '&', $link));
 
            $url = ''; 
 
            $data = array();
 
            parse_str($url_data['query'], $data);
 
            foreach ($data as $key => $value) {
                if (isset($data['route'])) {
                    if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
                        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
 
                        if ($query->num_rows) {
                            $url .= '/' . $query->row['keyword'];
 
                            unset($data[$key]);
                        }                    
                    } elseif ($key == 'path') {
                        $categories = explode('_', $value);
 
                        foreach ($categories as $category) {
                            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");
 
                            if ($query->num_rows) {
                                $url .= '/' . $query->row['keyword'];
                            }                            
                        }
 
                        unset($data[$key]);
                    }
                    /* SEO Custom URL */
                    if( $_u = $this->getURL($data['route']) ){
                        $url .= $_u;
                        unset($data[$key]);
                    }/* SEO Custom URL */ 
                }
            }
 
            if ($url) {
                unset($data['route']);
 
                $query = '';
 
                if ($data) {
                    foreach ($data as $key => $value) {
                        $query .= '&' . $key . '=' . $value;
                    }
 
                    if ($query) {
                        $query = '?' . trim($query, '&');
                    }
                }
 
                return $url_data['scheme'] . '://' . $url_data['host'] . (isset($url_data['port']) ? ':' . $url_data['port'] : '') . str_replace('/index.php', '', $url_data['path']) . $url . $query;
            } else {
                return $link;
            }
        } else {
            return $link;
        }        
    }
 
    /* SEO Custom URL */
    public function getURL($route) {
            if( count($this->url_list) > 0) {
                 foreach ($this->url_list as $key => $value) {
                    if($route == $key) {
                        return '/'.$value;
                    }
                 }
            }
            return false;
    }
    public function setURL($_route) {
            if( count($this->url_list) > 0 ){
                 foreach ($this->url_list as $key => $value) {
                    if($_route == $value) {
                        return $key;
                    }
                 }
            }
            return false;
    }/* SEO Custom URL */
}
?>