<?php
use \libCokeId\LibCokeId;
use \libCokeId\Console;
use \libCokeId\HeaderApi;
require ($_SERVER['DOCUMENT_ROOT'].'/php-library-for-cokeid/libcokeid/LibCokeId.php');
require ($_SERVER['DOCUMENT_ROOT'].'/php-library-for-cokeid/libcokeid/class.HeaderApi.php');
$libCokeId = new LibCokeId();

//require 'header.php';
header("Content-type: text/html; charset=UTF-8");
require 'php/utils/config.php';

try {

//$libCokeId->synchronizeSessionWithServer();
$headerApi = new HeaderApi($libCokeId);

if (isset($_GET['error']) && $_GET['error'] == 'user_cancel') {
	if (isset($_SESSION['last_url_oauth'])){
		$url = $_SESSION['last_url_oauth']."?".$_SERVER['QUERY_STRING'];
	}else {
		$url = "/?".$_SERVER['QUERY_STRING'];
	}
	header('Location: '.$url);
	exit();
}

$headerApi->getHeader(array(COKEID_API_HEADER_ID));

// html
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-ES" lang="es-ES">
	<head>	
	<link href="static/css/aquarius-huerfanos.css" rel="stylesheet" type="text/css" />
	</head>
	<body class="huerfanos" id="postregister">
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
							<div class="alert-txt">Para activar tu registro debes <strong>hacer clic en el enlace de autenticación de identidad</strong><br /> que te hemos enviado por correo electrónico.
							<br /><a href="<?php echo URL_APP ?>">continuar &raquo;</a></div>
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