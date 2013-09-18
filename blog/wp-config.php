<?php
/** 
 * As configurações básicas do WordPress.
 *
 * Esse arquivo contém as seguintes configurações: configurações de MySQL, Prefixo de Tabelas,
 * Chaves secretas, Idioma do WordPress, e ABSPATH. Você pode encontrar mais informações
 * visitando {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. Você pode obter as configurações de MySQL de seu servidor de hospedagem.
 *
 * Esse arquivo é usado pelo script ed criação wp-config.php durante a
 * instalação. Você não precisa usar o site, você pode apenas salvar esse arquivo
 * como "wp-config.php" e preencher os valores.
 *
 * @package WordPress
 */

// ** Configurações do MySQL - Você pode pegar essas informações com o serviço de hospedagem ** //
/** O nome do banco de dados do WordPress */
define('DB_NAME', 'bloguselolli');

/** Usuário do banco de dados MySQL */
define('DB_USER', 'bloguselolli');

/** Senha do banco de dados MySQL */
define('DB_PASSWORD', 'Divert0205!');

/** nome do host do MySQL */
define('DB_HOST', 'bloguselolli.db.10981442.hostedresource.com');

/** Conjunto de caracteres do banco de dados a ser usado na criação das tabelas. */
define('DB_CHARSET', 'utf8');

/** O tipo de collate do banco de dados. Não altere isso se tiver dúvidas. */
define('DB_COLLATE', '');

/**#@+
 * Chaves únicas de autenticação e salts.
 *
 * Altere cada chave para um frase única!
 * Você pode gerá-las usando o {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * Você pode alterá-las a qualquer momento para desvalidar quaisquer cookies existentes. Isto irá forçar todos os usuários a fazerem login novamente.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'x{R&t-?]a&|pn[hK:FgrqTsXAtIE^(GR8hsXok81Wl+]cKBd83O)0NZcF0~@5jlb');
define('SECURE_AUTH_KEY',  'gQmA{xLCHGr/fQY0~|.%,:I.L4sGs|+$VT*$Pj<,,O.n. PZiFd[J14@~l9@EcKQ');
define('LOGGED_IN_KEY',    'M|d|s_L{&2&i.97X|93KaW.QYLe:|C0~_9m0Ir0@9mR0g0_c@12}!&CbE1 -gT&9');
define('NONCE_KEY',        'sNEZhrwu]?Qux~H )3m~]v!+yVH&jbf`?i{,1LlL`PQ /]U_DEzpN$0UMt.X4|Ho');
define('AUTH_SALT',        'f7}0W&hWfQ&z+XQMq>;n(m)3pQNN*$H}rAFPBUf]mN#QIAg1!rK`2cZ%Ur;QH=Z ');
define('SECURE_AUTH_SALT', '>oMDLv([i*VLA)+b|N2=us!m}DyKp?SlU^EL0sjR0bhL~W$j~.5($Ab0!{eNq#e_');
define('LOGGED_IN_SALT',   '=TX 5(u(,tb]ecjyGrjf[#d~2I|Ff<pFQ|WG-^<v5{9pf,s^g41|aL>,Zm+]t>`4');
define('NONCE_SALT',       ']*;vy9*xH1`)gbP,o:- 7q}.tcI|5WYt`k5itm^G[*JBJdE;68nrMVeZO}h;x}c$');

/**#@-*/

/**
 * Prefixo da tabela do banco de dados do WordPress.
 *
 * Você pode ter várias instalações em um único banco de dados se você der para cada um um único
 * prefixo. Somente números, letras e sublinhados!
 */
$table_prefix  = 'wp_';

/**
 * O idioma localizado do WordPress é o inglês por padrão.
 *
 * Altere esta definição para localizar o WordPress. Um arquivo MO correspondente ao
 * idioma escolhido deve ser instalado em wp-content/languages. Por exemplo, instale
 * pt_BR.mo em wp-content/languages e altere WPLANG para 'pt_BR' para habilitar o suporte
 * ao português do Brasil.
 */
define('WPLANG', 'pt_BR');

/**
 * Para desenvolvedores: Modo debugging WordPress.
 *
 * altere isto para true para ativar a exibição de avisos durante o desenvolvimento.
 * é altamente recomendável que os desenvolvedores de plugins e temas usem o WP_DEBUG
 * em seus ambientes de desenvolvimento.
 */
define('WP_DEBUG', false);

/* Isto é tudo, pode parar de editar! :) */

/** Caminho absoluto para o diretório WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
	
/** Configura as variáveis do WordPress e arquivos inclusos. */
require_once(ABSPATH . 'wp-settings.php');