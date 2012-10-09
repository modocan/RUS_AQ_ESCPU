<?php
/** 
 * aviso. Se abre en popup
 * 
 * GET 
 * er = 'login_pueblo' => Para solicitar la adopción debes registrarte en cocacola.es' 
 *  
 * er = 'login_urbanita' => Para identificarte como huérfano debes registrarte en cocacola.es' 
 *  
 * er = 'datos' => debes rellenar datos de prmo
 * 			En este caso tambien vendrá:
 * 			_GET['uid'] (opcional) => id de usuario
 * 			 
 * er = 'rec_pueblo' => aviso de ok de save-urbanita con recomendación de pueblo según test
 * 			En este caso tambien vendrá:
 * 			_GET['tid'] (opcional) => town id. Si existe en la ventana de aviso que abro como ok de ficha, se muestra además este pueblo recomendado
 * 			         
 * er = 'reg_test' => aviso de que no ha rellenado el test
 * 
 */
use \libCokeId\LibCokeId;
use \libCokeId\Console;
use \libCokeId\HeaderApi;
use \libCokeId\CokeIdUrlBuilder;

require 'php/utils/config.php';

if ( ! isset($_GET['er'])) exit();

// sanitize input
$sanInput = array(
	'er' => array(
		'allow' => array('login_pueblo', 'login_urbanita', 'datos', 'rec_pueblo', 'reg_test'),
		'default' => ''
		)
	);
foreach ($sanInput as $p => $ap) {
	if ( ! isSet($_GET[$p]) || ! in_array($_GET[$p], $sanInput[$p]['allow'])) {
		$_GET[$p] = $sanInput[$p]['default'];
	}
}


// checks
if ( empty($_GET['er'])) exit();
if ( $_GET['er'] == 'datos' ) {
	if (isset($_GET['uid'])) $_GET['uid'] = (int)$_GET['uid'];
}
if ( $_GET['er'] == 'rec_pueblo' ) {
	if (isset($_GET['tid'])) $_GET['tid'] = (int)$_GET['tid'];
}

header("Content-type: text/html; charset=UTF-8");

require ($_SERVER['DOCUMENT_ROOT'].'/php-library-for-cokeid/libcokeid/LibCokeId.php');
require ($_SERVER['DOCUMENT_ROOT'].'/php-library-for-cokeid/libcokeid/class.HeaderApi.php');
$libCokeId = new LibCokeId();

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-ES" lang="es-ES">
	<head>	
	<link href="static/css/aquarius-huerfanos.css" rel="stylesheet" type="text/css" />
	</head>
	<body class="huerfanos" id="bodyaviso">
		<!--- Content -->
		<div class="popupaviso <?php echo $_GET['er'] ?>">
			<div class="alert">
				<?php 
				if ($_GET['er'] == 'login_pueblo') {
					//require 'header.php';
					$libCokeId->synchronizeSessionWithServer();
					$urlBuilder = new CokeIdUrlBuilder($libCokeId);
				?>
					<div class="alert-txt">Para solicitar la adopción debes registrarte en cocacola.es<br />
					<br /><a href="<?php echo $urlBuilder->getUrlRegister() ?>" target="_parent">Registro &raquo;</a>
					<br />
					<br /><a href="<?php echo $urlBuilder->getUrlLogin() ?>" target="_parent">Identifícate &raquo;</a>
					</div>
				<?php } 
				elseif ($_GET['er'] == 'login_urbanita') {
					//require 'header.php'; 
					$libCokeId->synchronizeSessionWithServer();
					$urlBuilder = new CokeIdUrlBuilder($libCokeId);
				?>
					<div class="alert-txt">Para identificarte como huérfano debes registrarte en cocacola.es<br />
					<br /><a href="<?php echo $urlBuilder->getUrlRegister() ?>" target="_parent">Registro &raquo;</a>
					<br />
					<br /><a href="<?php echo $urlBuilder->getUrlLogin() ?>" target="_parent">Identifícate &raquo;</a>
					</div>

				<?php } 
				elseif ($_GET['er'] == 'datos') {
				?>
					<div class="alert-txt">Para hacer esto necesitas <br />completar tus datos.<br />
					<br /><a href="<?php echo URL_APP ?>urbanitas-huerfanos.php<?php if (isset($_GET['uid'])) echo '?uid='.$_GET['uid'] ?>" target="_parent">continuar &raquo;</a>
					</div>
				<?php }	
				elseif ($_GET['er'] == 'rec_pueblo') {
				
					// ok de completado de datos (razones + foto opcional) + (opcional) cuestionario
					$msg = '';
					if (isset($_GET['tid'])) {
						$p = aq_cargaDatosPueblo($_GET['tid']);
						$msg .= 'Según tus respuestas<br />el pueblo que mejor va contigo es:<br />'
							.'¡<a href="pueblo.php?id='.$_GET['tid'].'" target="_parent"><b>'.((string)$p->nombre).'</b></a>!';
					}
				?>
					<div class="alert-txt"><b>Tus datos han sido<br />registrados correctamente.</b><br /><br />
					<?php echo $msg ?>
					</div>
				<?php } 
				elseif ($_GET['er'] == 'reg_test') {
				?>
					<div class="alert-txt"><b>Si no completas<br />el cuestionario</b><br /><br />
						no te podremos recomendar <br />el pueblo que mejor te va<br /><br />
						<a href="#" onclick="parent.$.prettyPhoto.close();">&laquo; volver</a>
						&nbsp;&nbsp;&nbsp;
						<a href="#" onclick="parent.$.prettyPhoto.close();parent.$('#save-urbanita').submit()">continuar &raquo;</a>
					</div>
				<?php }	?>

			</div>
		</div>
		<!--- Content end -->
	</body>
</html>
