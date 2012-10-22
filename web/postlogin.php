<?php
/*use \libCokeId\LibCokeId;
use \libCokeId\Console;
use \libCokeId\HeaderApi;*/

//use \libCokeId\LibCokeId;

require ('ChromePhp.php');
require (dirname(__FILE__).'/../php-library-for-cokeid/libcokeid/LibCokeId.php');



/*if(isset($_SESSION['prop']))
{
    ChromePhp::log('[EXISTE] \n');
}
else{
    ChromePhp::log('[NO EXISTE] \n');
}*/


//require 'header.php';
//header("Content-type: text/html; charset=UTF-8");





if (isset($_SESSION['last_url_oauth'])){
    $url = $_SESSION['last_url_oauth']."?".$_SERVER['QUERY_STRING'];
}else {
    $url = "/?".$_SERVER['QUERY_STRING'];
}

ChromePhp::log($url);


if ($url!=''){
    $libCokeId = new \libCokeId\LibCokeId();
    //$libCokeId->synchronizeSessionWithServer();

    $miData = $libCokeId->getUserLogged()->id;
    ChromePhp::log($libCokeId->getUserLogged());






    /*
           // si queremos que la llamada a completar datos se efectúe cuando
           // un usuario se loga
         if (isset($_SESSION['scope'])){
             $userComplete = $libCokeId->checkUserComplete($_SESSION['scope']);

             if ($libCokeId->isConnected()){
                 if (!$userComplete){
                     $url = '/ckactions/completeaccount/'.$_SESSION['scope'];
                 }
             }
         }
         */
    //PUTA LLEVALO DONDE TE PLAZCA!!!!
    //header('Location: '.$url);
}




?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            display: none;
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
            margin-left: 155px;
            margin-top: 7px;
        }

    </style>

    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="https://connect.facebook.net/en_US/all.js"></script>
    <script language="javascript">

        var datos = <?php echo $miData; ?>;
        var _this = this;
        var APP_ID = "273344839447085";
        var REDIRECT_URI = "https://apps.facebook.com/escuela_aquarius/";
        var PERMS = "publish_stream";

        $(function(){

            $('a.enlace_doble').bind('click', recarga);

            FB.init({
                appId      : APP_ID, // App ID
                status     : true, // check login status
                cookie     : true, // enable cookies to allow the server to access the session
                xfbml      : true,  // parse XFBML
                oauth		 : true
            });



            FB.getLoginStatus(function(resp){

                $.post('updateCokeId.php', {id_coke: datos, id_fb: resp.authResponse.userID}, function(res){

                    /*console.log('viene');
                    console.log(res);*/

                    if(res == 'OK')
                    {
                        $('div.caja').show('400');
                    }

                });

            });

        });


        function recarga()
        {
            $('a.enlace_doble').bind('click', recarga);
            window.top.location.href = 'https://apps.facebook.com/escuela_aquarius/';

            return false;
        }


    </script>

</head>

<body>

<div id="fb-root"></div>

<div class="caja">

    <p>¡Bien hecho!<br />Ya puedes participar en La Escuela de Pueblo</p>

    <a class="enlace_doble" id="enlace_login" href="#">Entrar</a>

</div>

</body>

</html>













