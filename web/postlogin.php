<?php
/*use \libCokeId\LibCokeId;
use \libCokeId\Console;
use \libCokeId\HeaderApi;*/

//use \libCokeId\LibCokeId;

require ('ChromePhp.php');
require (dirname(__FILE__).'/../php-library-for-cokeid/libcokeid/LibCokeId.php');



if(isset($_SESSION['prop']))
{
    ChromePhp::log('[EXISTE] \n');
}
else{
    ChromePhp::log('[NO EXISTE] \n');
}


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
    <title>amfPHP JSON Pizza Example</title>

    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="https://connect.facebook.net/en_US/all.js"></script>
    <script language="javascript">

        var datos = <?php echo $miData; ?>;
        var _this = this;
        var APP_ID = "290061231098321";
        var REDIRECT_URI = "https://apps.facebook.com/pruebas-papaditas/";
        var PERMS = "publish_stream";

        $(function(){

            FB.init({
                appId      : APP_ID, // App ID
                status     : true, // check login status
                cookie     : true, // enable cookies to allow the server to access the session
                xfbml      : true,  // parse XFBML
                oauth		 : true
            });



            FB.getLoginStatus(function(resp){

                $.post('updateCokeId.php', {id_coke: datos, id_fb: resp.authResponse.userID}, function(res){

                    console.log('viene');
                    console.log(res);

                    if(res == 'OK')
                    {
                        window.top.location.href = 'https://apps.facebook.com/pruebas-papaditas/';
                    }

                });

            });







        });


    </script>

</head>

<body>

<div id="fb-root"></div>

<h1>Soy yo</h1>

</body>

</html>













