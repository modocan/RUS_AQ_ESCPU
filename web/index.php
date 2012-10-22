<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:og="http://ogp.me/ns#"
      xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
    <title>Escuela de pueblo Aquarius</title>
    <meta property="og:title" content="Escuela de pueblo Aquarius" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://apps.facebook.com/pruebas-papaditas/" />
    <meta property="og:image" content="https://aquarius.cocacola.es/appsaquarius/escuela/imgs/90x90.jpg" />
    <meta property="og:site_name" content="Escuela de pueblo Aquarius" />
	<meta property="fb:app_id" content="273344839447085" />
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
				text-align:center;
				height:100%;
                width: 100%;
				background-image:url(imgs/trama.png);
			}	
			
			#imagen{
				width: 790px;
				height: 800px;
                position: relative;
                z-index: 2;
                margin-top: 20px;
			}


            #frame
            {
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                left: 0;
                background-color: #fff;
                display: none;
                z-index: 3;
            }

                #frame iframe
                {
                    width: 100%;
                    height: 100%;
                }



              @font-face {
                  font-family: 'Fuente';
                  src: url('A_Font_with_Serifs.eot');
                  src: local('☺'), url('https://aquariustest.cocacola.es/appsaquarius/escuela/A_Font_with_Serifs.ttf') format('truetype');
                  font-weight: normal;
                  font-style: normal;
              }

              h4
              {
                  text-align: center;
                  font-family: 'Fuente';
                  font-size: 14px;
                  color: #333;
                  text-transform: uppercase;
              }

              div.separador
              {
                  margin: 0 auto;
                  clear: both;
              }

              #pie
              {
                  position: relative;
                  background-image: url("https://aquariustest.cocacola.es/appsaquarius/escuela/imgs/fondo_pie.png");
                  width: 795px;
                  height: 135px;
                  margin: 0 auto;
                  padding-top: 1px;
                  overflow: hidden;
                  display: none;
                  top: -30px;
                  z-index: 1;
              }


              #enlaces_pie
              {
                  overflow: auto;
                  width: 181px;
                  float: left;
                  margin-left: 140px;
              }


              #enlaces_pie a:link,
              #enlaces_pie a:visited,
              #enlaces_pie a:hover
              {
                  text-decoration: none;
                  text-indent: -10000px;
                  display: block;
                  float: left;
                  margin-right: 10px;
                  width: 49px;
                  height: 55px;
              }

              #com_fb
              {
                  background-image: url("https://aquariustest.cocacola.es/appsaquarius/escuela/imgs/comp_facebook.png");
              }

              #com_twt
              {
                  background-image: url("https://aquariustest.cocacola.es/appsaquarius/escuela/imgs/comp_twitter.png");
              }

              #com_tnt
              {
                  background-image: url("https://aquariustest.cocacola.es/appsaquarius/escuela/imgs/comp_tuenti.png");
              }

              a.enlace_flotante:link,
              a.enlace_flotante:hover,
              a.enlace_flotante:visited
              {
                  display: block;
                  float: left;
                  text-indent: -10000px;
              }

              a#flota_aquarius
              {
                  background-image: url("https://aquariustest.cocacola.es/appsaquarius/escuela/imgs/logo_aqua.png");
                  width: 154px;
                  height: 100px;
                  margin-top: -30px;
                  margin-left: 20px;
              }

              a#flota_coca
              {
                  background-image: url("https://aquariustest.cocacola.es/appsaquarius/escuela/imgs/logo_cocacola.png");
                  width: 69px;
                  height: 25px;
                  margin-top: 10px;
                  float: right;
                  margin-right: 50px;
              }

              #sep_central
              {
                  margin-top: -15px;
              }

              p.centrado
              {
                  font-family: Arial;
                  font-size: 12px;
                  color: #333;
                  text-align: center;
              }

              p.centrado a:link,
              p.centrado a:visited
              {
                  color: #333;
                  text-decoration: none;
              }

              p.centrado a:hover
              {
                  text-decoration: underline;
              }

              p.centrado span
              {
                  font-family: Arial;
                  font-size: 9px;
                  color: #333;
              }

              #sub_pie
              {
                  position: relative;
                  top: -16px;
              }



    </style>

        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="https://connect.facebook.net/en_US/all.js"></script>

    <script type="text/javascript">

        var APP_ID = "273344839447085";
		var REDIRECT_URI = "https://apps.facebook.com/escuela_aquarius/";
		var PERMS = "publish_stream,user_photos,friends_photos";


        $(function(){

            FB.init({
                appId      : APP_ID, // App ID
                status     : true, // check login status
                cookie     : true, // enable cookies to allow the server to access the session
                xfbml      : true,  // parse XFBML
                oauth		 : true
            });

            $('#comp_fb').bind('click', clicComparteFB);

            //FB.Canvas.setSize({ width: 810, height: 800 });
            FB.getLoginStatus(handleLoginStatus);

        });

          function colocaPie()
          {
              $('#pie').css({display: 'block'});
              $('#com_fb').bind('click', clicComparteFB);
          }

		  
          function handleLoginStatus(response) {

              if(response.status != 'connected')
              {
                  window.top.location.href = 'https://www.facebook.com/dialog/oauth/?client_id='+APP_ID+'&redirect_uri='+REDIRECT_URI+'&scope='+PERMS;
              }
              else
              {

                  var _swf = "https://aquariustest.cocacola.es/appsaquarius/escuela/main_escuela.swf?<?php echo(time()) ?>";
                  var params = {};

                  params.wmode = "transparent";
                  params.scale = "noscale";
                  params.allowfullscreen = "true";
                  params.allowscriptaccess = "always";

                  if (response.authResponse) { //Show the SWF

                      $('#imagen').append('<h1>You need at least Flash Player 10.0 to view this page.</h1><p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>');
                      swfobject.embedSWF(_swf, "imagen", "810", "800", "10.0", null, params, {name: "imagen", wmode: "transparent"}) ;
                      fl = document.getElementById('imagen');

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


        function prueba()
        {
            //console.log('probando!');
        }


        function pideAmigos()
        {

        }


      function cargarAmigos(){
          var respuesta;
          var resp2;

          FB.api('me/friends', function(res){

              resp2 = res;


              FB.api({
                    method: 'friends.getAppUsers',
                    urls: 'facebook.com,developers.facebook.com'
                  },
                  function(response) {
                      respuesta=response;
                      thisMovie("imagen").reciboTodosLosAmigos(resp2, respuesta);
                      console.log('PHP - cargarAmigos');
                      console.log(respuesta);
                  }
              );

          });

      }

        function compartirAvatar(nombre)
        {
            FB.ui({

                method: 'feed',
                name: 'Escuela de Pueblo',
                link: REDIRECT_URI,
                picture: 'https://aquariustest.cocacola.es/appsaquarius/escuela/img_fb.png',
                caption: 'Compartiendo',
                description: 'Estoy compartiendo la foto de mi avatar'

            }, function(resp){

                console.log(resp);

                if(resp.post_id)
                {
                    thisMovie("imagen").publicarAvatar();
                    //thisMovie("imagen").publicarAvatar();
                }

            });
        }

        function clicComparteFB()
        {
            $('#comp_fb').unbind('click', clicComparteFB);

            FB.ui({

                method: 'feed',
                name: 'Escuela de Pueblo',
                link: REDIRECT_URI,
                picture: 'https://aquariustest.cocacola.es/appsaquarius/escuela/img_fb.png',
                caption: 'Compartiendo',
                description: 'Estoy compartiendo la App'

            });

            $('#comp_fb').bind('click', clicComparteFB);

            return false;
        }

        function compartirJuego()
        {
            FB.ui({

                method: 'feed',
                name: 'Escuela de Pueblo',
                link: REDIRECT_URI,
                picture: 'https://aquariustest.cocacola.es/appsaquarius/escuela/img_fb.png',
                caption: 'Compartiendo',
                description: 'Lorem ipsum dolor sit amet'

            }, function(resp){

                if(resp.post_id)
                {
                    fl = document.getElementById('imagen');
                    fl.juegoCompartido();
                }

            });
        }

       function thisMovie(movieName) {
         if (navigator.appName.indexOf("Microsoft") != -1) {
             return window[movieName];
         } else {
             return document[movieName];
         }
     }


       function crearLoginCoke(_datos)
       {
           //console.log('login_coke');

           $('iframe').attr('rel', _datos);
           $('#frame').show('600');

       }

       

    </script>
   
	</head>
<body>
<div id="fb-root"></div>
<div id="imagen"></div>
<div id="pie">

    <div class="separador">

        <h4>compartir:</h4>

    </div>

    <div id="sep_central" class="separador">

        <a id="flota_aquarius" class="enlace_flotante" href="#">Aquarius</a>

        <div id="enlaces_pie">

            <a id="com_fb" href="#">FB</a>
            <a id="com_twt" href="#">TWT</a>
            <a id="com_tnt" href="#">TNT</a>

        </div>

        <a id="flota_coca" class="enlace_flotante" href="#">Aquarius</a>

    </div>

    <div id="sub_pie" class="separador">

        <p class="centrado">

            <a href="#">Enlace</a>
            <span> | </span>
            <a href="#">Enlace</a>
            <span> | </span>
            <a href="#">Enlace</a>
            <span> | </span>
            <a href="#">Enlace</a>
            <span> | </span>
            <a href="#">Enlace</a>

        </p>

    </div>

</div>
<div id="frame">

    <iframe src="https://aquariustest.cocacola.es/appsaquarius/escuela/login.php" rel=""></iframe>

</div>
</body>
</html>