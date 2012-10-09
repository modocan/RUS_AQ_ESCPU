<?php
use \libCokeId\LibCokeId;
use \libCokeId\Console;
use \libCokeId\HeaderApi;
use \libCokeId\CokeIdUrlBuilder;
require ($_SERVER['DOCUMENT_ROOT'].'/php-library-for-cokeid/libcokeid/LibCokeId.php');
require ($_SERVER['DOCUMENT_ROOT'].'/php-library-for-cokeid/libcokeid/class.HeaderApi.php');


//require 'header.php';
header("Content-type: text/html; charset=UTF-8");
require 'php/utils/config.php';

try {
	
$libCokeId = new LibCokeId();
$libCokeId->synchronizeSessionWithServer();

// si le han dado a volver en el form de modifiación de datas
if (isset($_GET['error']) && $_GET['error'] == 'user_cancel') {
	if (isset($_SESSION['last_url_oauth'])){
		$url = $_SESSION['last_url_oauth']."?".$_SERVER['QUERY_STRING'];
	}else {
		$url = "/?".$_SERVER['QUERY_STRING'];
	}
	header('Location: '.str_replace("?error=user_cancel", "", $url));
	exit();
}

$urlBuilder = new CokeIdUrlBuilder($libCokeId);

/**
 * hablando con Alejandro Gonzalez me dice que 'probablemente' al actualizar datos cocacola desloguea al usuario
 */
if ( ! $libCokeId->isConnected()) {
	header('Location: '.$urlBuilder->getUrlLogin());
	exit;
}

$headerApi = new HeaderApi($libCokeId);
$headerApi->getHeader(array(COKEID_API_HEADER_ID));

// html
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-ES" lang="es-ES">
	<head>	
	<link href="static/css/aquarius-huerfanos.css" rel="stylesheet" type="text/css" />
	</head>
	<body class="huerfanos" id="posteditaccount">
		<!--- cocacola.es header -->
		<div id="header">
		<?php echo $headerApi->html;?>
		</div>
		<!--- cocacola.es header end --> 
		<!--- Content -->
		<div id="main-body">
			<div id="main-body-inner" class="ie-rel-fix">

                <p>Entorno Papaditas</p>

			<div class="wrap-container">
				<div class="container">
					<div class="mainh-content">
						<div class="alert">
							<img src="static/img/alert.png" width="620" height="408" />
							<?php
							if ($libCokeId->isConnected()) {
	
								// ...mirar si ha completado el registro en CokeID y en esta promo "aquarius-pueblos 2012": es decir, validar si ha entrado al registro por 'nuestra section'							
								$userCompletePromo = $libCokeId->checkUserComplete($libCokeId->oauth_config->getSection('default'));
								
								if ($userCompletePromo) {

									// miraremos si no existe en nuestra bbdd para darlo de alta
									require_once 'php/utils/conexion.php';
									require_once 'php/utils/class_aq_user.php';

									// consulta de datos de user logado
									$userLogged  = $libCokeId->getUserLogged();
						
									$oUser = new aq_user();
									$uid = $oUser->_existe(array('COKEID_ID' => $userLogged->id));
									if ($uid == 0) {
										// no lo tenemos, así que lo registramos
										$sql = "INSERT INTO ".$oUser->_get_config('db_table')." (USER_ID, COKEID_ID, PICTURE, DESCRIPTION, STATUS,CREATED_ON)"
											. " VALUES(AQ_USERS_SEQ.nextval, '".$userLogged->id."', NULL, NULL, 'C', sysdate)";
										$oUser->_db_query($sql);
										// obtener id
										//$uid = $oUser->_existe(array('COKEID_ID' => $userLogged->id));
									}
									?>
									<div class="alert-txt">Datos actualizados<br />correctamente.<br />
									<br /><a href="<?php echo isset($_SESSION['last_url_oauth']) ? $_SESSION['last_url_oauth'] : URL_APP ?>">continuar &raquo;</a>
									</div>
									<?php
								}
								else {
									// aún le falta 'completeaccount' (supongo que le ha dado a 'volver', así que le volvemos a mostrar que se identifique)
									?>
									<div class="alert-txt">Para identificarte como huérfano debes registrarte en Aquarius Pueblos<br />
									<br /><a href="/ckactions/completeaccount/<?php echo $libCokeId->oauth_config->getSection('default') ?>"><!--Completar registro Aquarius-Pueblos 2012 en Cocacola-->continuar &raquo;</a>
									</div>
									<?php
								}
								
							}
							else {
								// puede ser que haya cambiado de contraseña y entonces le han deslogado en cocacola
								?>
								<div class="alert-txt">Datos actualizados<br />correctamente.<br />
								<br />Para identificarte como huérfano debes registrarte en cocacola.es<br />
								<br /><a href="<?php echo $urlBuilder->getUrlRegister() ?>">Registro &raquo;</a>
								<br />
								<br /><a href="<?php echo $urlBuilder->getUrlLogin() ?>">Identifícate &raquo;</a>
								</div>
								<?php
							}
							?>
						</div>
					</div>
				</div>
			</div>


			</div>
		</div>
		<!--- Content end -->
		<!--- footer -->
		<?php echo $headerApi->getFooter();?>
		<!--- footer end -->
<?php include 'stats.php'; ?>
	</body>
</html>
<?php 
} catch (Exception $e) {

	header('Location: /error.php?er='.$e->getCode());
}
?>