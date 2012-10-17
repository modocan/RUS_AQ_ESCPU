<?php
/*use \libCokeId\LibCokeId;
use \libCokeId\Console;
use \libCokeId\HeaderApi;*/

//use \libCokeId\LibCokeId;

require (dirname(__FILE__).'/../php-library-for-cokeid/libcokeid/LibCokeId.php');




//require 'header.php';
//header("Content-type: text/html; charset=UTF-8");



$url = '';

if (isset($_SESSION['last_url_oauth'])){
    $url = $_SESSION['last_url_oauth']."?".$_SERVER['QUERY_STRING'];
}else {
    $url = "/?".$_SERVER['QUERY_STRING'];
}


if ($url!=''){
    $libCokeId = new \libCokeId\LibCokeId();
    $libCokeId->synchronizeSessionWithServer();

    $miData = $libCokeId->getUserLogged()->id;
    //ChromePhp::log($libCokeId->getUserLogged());




}




?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Post Register</title>

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
            margin-left: 15px;
            font-size: 18px;
            text-align: center;
        }

    </style>


</head>

<body>


<div class="caja">

    <p>Ahora solo tienes que revisar tu correo para <br />confirmar el registro en Coca Cola</p>

</div>


</body>

</html>













