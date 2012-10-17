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

/*require ('https://aquariustest.cocacola.es/appsaquarius/escuela/php-library-for-cokeid/libcokeid/LibCokeId.php');
require ('https://aquariustest.cocacola.es/appsaquarius/escuela/php-library-for-cokeid/libcokeid/class.HeaderApi.php');*/



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

    <meta content="text/html;charset=utf-8" http-equiv="Content-Type" />
    <title>Login</title>
    <style type="text/css">

        body
        {
            background-image: url("imgs/trama.png");
        }

        @font-face {
            font-family: 'Fuente';
            src: url('A_Font_with_Serifs.eot');
            src: local('☺'), url('A_Font_with_Serifs.ttf') format('truetype');
            font-weight: normal;
            font-style: normal;
        }

        div.caja
        {
            width: 384px;
            height: 228px;
            position: relative;
            margin: 200px auto;
            padding-top: 1px;
            background-image: url("imgs/caja_login.png");
        }

        div.caja p {
            font-family: Fuente;
            position: relative;
            margin-top: 90px;
            color: #94682e;
            margin-left: 35px;
            font-size: 18px;
            text-align: center;
        }


        a.enlace_doble:link,
        a.enlace_doble:hover,
        a.enlace_doble:visited
        {
            font-family: "Fuente";
            text-transform: uppercase;
            display: block;
            width: 83px;
            height: 28px;
            color: #5E411E;
            font-size: 14px;
            text-decoration: none;
            background-image: url("imgs/boton.png");
            text-align: center;
            line-height: 30px;
            float: left;
            margin-left: 70px;
            margin-top: 7px;
        }

    </style>

</head>


<body>

<div class="caja">

    <p>Para jugar tienes que estar registrado en Coca Cola. <br />Si no lo ha hecho aún regístrate aquí.</p>

    <a class="enlace_doble" id="enlace_login" href="<?php echo $urlBuilder->getUrlLogin(); ?>">Login</a>
    <a class="enlace_doble" id="enlace_registro" href="<?php echo $urlBuilder->getUrlRegister(); ?>">Registro</a>

</div>






</body>


</html>