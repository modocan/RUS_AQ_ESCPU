<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:og="http://ogp.me/ns#"
      xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
    <title>Escuela de pueblo Aquarius</title>
    <meta property="og:title" content="Escuela de pueblo Aquarius" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://apps.facebook.com/pruebas-papaditas" />
    <meta property="og:image" content="https://aquarius.cocacola.es/appsaquarius/escuela/imgs/90x90.jpg" />
    <meta property="og:site_name" content="Escuela de pueblo Aquarius" />
	<meta property="fb:app_id" content="290061231098321" />
    <meta name="language" content="es" />
	<meta name="description" content="Escuela de pueblo Aquarius" />
	<meta name="keywords" content="Escuela de pueblo Aquarius" />
	<link rel="image_src" href="https://aquarius.cocacola.es/appsaquarius/escuela/imgs/90x90.jpg" />
<!--    <link rel="shortcut icon" href="./icon/icona.ico"/>
-->	<style type="text/css">
	  
	  		body{
				margin:0px;
				padding:0px;
				position: absolute;
				top: 50%;
				left: 50%;
				margin-left: -405px;
				margin-top: -400px;
				text-align:center;
				height:100%;
				background-image:url(imgs/trama.png);
			}	
			
			#imagen{
				width: 810px;
				height: 800px;
			}
			
			
		</style>

        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="https://connect.facebook.net/en_US/all.js"></script>

    <script type="text/javascript">

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

            //FB.Canvas.setSize({ width: 810, height: 800 });
            FB.getLoginStatus(handleLoginStatus);

        });
		  
          function handleLoginStatus(response) {

              if(response.status != 'connected')
              {
                  window.top.location.href = 'https://www.facebook.com/dialog/oauth/?client_id='+APP_ID+'&redirect_uri='+REDIRECT_URI+'&scope='+PERMS;
              }
              else
              {

                  var _swf = "EscuelaPueblo.swf?<?php echo(time()) ?>";
                  var params = {};

                  params.wmode = "transparent";
                  params.scale = "noscale";
                  params.allowfullscreen = "true";
                  params.allowscriptaccess = "always";

                  if (response.authResponse) { //Show the SWF

                      $('#imagen').append('<h1>You need at least Flash Player 10.0 to view this page.</h1><p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>');
                      swfobject.embedSWF(_swf, "imagen", "810", "800", "10.0", null, params, {name: "imagen"})

                  } else { //ask the user to login

                      var params = window.location.toString().slice(window.location.toString().indexOf('?'));
                      top.location = 'https://graph.facebook.com/oauth/authorize?client_id='+APP_ID+'&scope='+PERMS+'&redirect_uri=' + REDIRECT_URI + params;

                  }

              }


          }

        function conectaFB()
        {
            FB.init({appId:APP_ID, status: true, cookie: true, oauth:true});
            FB.login(function(response)
            {

                if(response.authResponse)
                {

                    FB.api('me', function(res){
                        fl = document.getElementById('imagen');
                        fl.reciboDatos(res);
						
                    });
					/*FB.api('me/friends', function(res){
						thisMovie("imagen").reciboTodosLosAmigos(res); 
						console.log('trajo a los amigos');
				    });*/

                }
            }, {scope: PERMS});
        }


        function pideAmigos()
        {
            FB.api('me/friends', function(res){
                thisMovie("imagen").reciboTodosLosAmigos(res);
                console.log('trajo a los amigos');
            });
        }


      function cargarAmigos(){
          var respuesta;
          FB.api({
                method: 'friends.getAppUsers',
                urls: 'facebook.com,developers.facebook.com'
              },
              function(response) {
                  respuesta=response;
                  thisMovie("imagen").sendToActionScript(respuesta);

              }
          );

      }

       function thisMovie(movieName) {
         if (navigator.appName.indexOf("Microsoft") != -1) {
             return window[movieName];
         } else {
             return document[movieName];
         }
     }

       

    </script>
   
	</head>
<body>
<div id="fb-root"></div>
<div id="imagen"></div>
</body>
</html>