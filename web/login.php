<?php
/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 03/10/12
 * Time: 13:57
 * To change this template use File | Settings | File Templates.
 */

require (dirname(__FILE__).'/php-library-for-cokeid/libcokeid/LibCokeId.php');
require (dirname(__FILE__).'/php-library-for-cokeid/libcokeid/class.HeaderApi.php');



/*use \libCokeId\LibCokeId;
use \libCokeId\Console;
use \libCokeId\HeaderApi;
use \libCokeId\CokeIdUrlBuilder;

require ('./php-library-for-cokeid/libcokeid/LibCokeId.php');
require ('./php-library-for-cokeid/libcokeid/class.HeaderApi.php');
require ('./php-library-for-cokeid/libcokeid/class.CokeIdUrlBuilder.php');*/

$libCokeId = new \libCokeId\LibCokeId();
//$libCokeId->synchronizeSessionWithServer();
$urlBuilder = new \libCokeId\CokeIdUrlBuilder($libCokeId);


?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-ES" lang="es-ES">


<head>

    <title>Login</title>

</head>


<body>

<p>Aquí hay toda una creatividad</p>


<a id="enlace_login" href="<?php echo $urlBuilder->getUrlLogin(); ?>">Login</a>
<a id="enlace_registro" href="<?php echo $urlBuilder->getUrlRegister(); ?>">Registro</a>


</body>


</html>