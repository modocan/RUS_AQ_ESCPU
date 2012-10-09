<?php    

	namespace libCokeId;
	use Exception;
	
	if(session_id() == '') {    
		session_start();
	}
	include_once(dirname(__FILE__).'/../config/config.php');
	include_once ('Console.php');
	include_once ('class.OAuth.php');
	include_once('class.OAuthConfigParser.php');
	include_once ('class.CokeIdUser.php');
	include_once ('class.LoginStatus.php');
	include_once ('class.CokeIdThings.php');
	include_once ('class.CokeIdUrlBuilder.php');
	
	class LibCokeId {
		
		public $cokeIdThings;
		public $oauth_client;
		public $oauth_config;
		
		/**
		 * When you instanciate the library, the constructor loads the configuration that is defined in oauthconf.xml 
		 * file of the environment defined in config.php.
		 * 
		 */
		public function __construct(){			
			# Cargo el archivo de configuracion de la aplicacion.								
			$this->oauth_config = new OAuthConfigParser();		
			$this->oauth_config->loadFromFile(dirname(__FILE__).'/'.Config::OAUTH_CONF_PATH,Config::environment());
			# Cargo el cliente de oauth
			$this->oauth_client = new OAuth($this->oauth_config->getItem('client_id'),  $this->oauth_config->getItem('client_secret'));	
			$this->cokeIdThings = new CokeIdThings();

			//echo $this->oauth_config->getSection('default');
			if (!defined('LOG_ERRORS_APIS'))
			{
				define('LOG_ERRORS_APIS', Config::LOG_ERRORS_APIS);
			}
		}
		
		/**
		 * This method verifies the authorization tokens (client_token, access_token and refresh_token)
		 * Also updates the web client status, storing the client_token, access_token and refresh tokend and 
		 * login_status in the library.
		 * <strong>You should invoke it on each request</strong> in order to check and update the status of the user 
		 * (not logged, logged or connected), and verify that every token that you are gonna use before is going to be 
		 * valid.
		 */
		public function synchronizeSessionWithServer(){
			try {
				Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']' );
				$this->checkAndUpdateClientToken();
				$this->loadUserTokenFromEventPersistence();
				
				$this->checkLoginConnect();
				
				if (!is_null($this->cokeIdThings->userToken)){
										
					$this->checkAndRefreshAccessToken();
					
					if (!is_null($this->cokeIdThings->userToken)){
						$this->checkLoginStatus();
						
						if (!$this->isConnected()){
							$this->clearLocalSessionData();	
						}
					}
				}
				
			} catch ( Exception $e ) {				
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
				throw $e;
			}
		}

		/**
		 * Check if the user is connected. A user conected is a user logged on Coke ID.
		 * 
		 * @return boolean True is logged, False is not logged
		 */
		public function isConnected(){
			if ((!is_null($this->cokeIdThings))&&(!is_null($this->cokeIdThings->userToken))&&(!is_null($this->cokeIdThings->loginStatus))&&($this->cokeIdThings->loginStatus->connect_state=='connected')){
				return true;	
			}
			return false;
						
		}
							
		/**
		 * In that case, the post-login URL will revieve an authorization code as a GET parameter.
		 * Once the authorization code is provided to the web client, the SDK will send again to Coke ID the 
		 * token_endpoint to obtain the access_token of the user and create the cookie
		 * 
		 * The metod is needed to authorize de user when the web client takes back the control of the browser.
		 */
		public function authorizeUser($code){
			try {
				Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'." autorizamos a los usuarios");
				if ($code == '') { throw new Exception('Authorize Code is empty'); }
				$this->oauth_client->doGetAccessToken($this->oauth_config->getItem('token_endpoint'), $code, $this->oauth_config->getItem('redirect_post_login'));
				
				$this->checkAndRefreshAccessToken();
				
				$this->checkLoginStatus();
			} catch ( Exception $e ) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
		}
		
		/**
		 * This method checks if the user have completed all the fields needed for that section.
		 *
		 * the $scope (section) is a group of fields configured in Coke ID for a web client.
		 * A section can be also defined as a "part" (section) of the website (web client) that only can be accesed by a
		 *  user who have filled a set of personal information configured in Coke ID (all of the fields required for 
		 *  that section).
		 *  
		 * This method is commonly used for promotions or sweepstakes: if a user wants to participate in a promotion, 
		 * the web client must ensure that the user have all the fields filled in order to let him participate.
		 * @param string $scope section-key identifier of the web client. The section-key is located in oauthconf.xml
		 * file
		 * @return boolean TRUE if the user have already completed all the fields needed for that section
		 */
		public function checkUserComplete($scope){
			try {
				Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'." comprobamos Usuario completo en scope");
				
				if ($this->isConnected()){
					$userCompleted = $this->oauth_client->doCheckUserCompleted($this->oauth_config->getItem('api_query'),$scope);
				} else {
					$userCompleted = false;
				}
				return $userCompleted;
			} catch ( Exception $e ) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
				throw $e;
			}
		}				

		/**
		 * This method is needed to logout a user. 
		 * It makes 
		 * - the logout call to Coke ID 
		 * - clear cookies
		 * - tokens and local data for the logged user
		 */
		public function logoutUser(){
			try {
				if ((!is_null($this->cokeIdThings->userToken))&&(!is_null($this->cokeIdThings->refreshToken))){
					
					Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']' );
					
					$this->oauth_client->doLogout($this->oauth_config->getItem('logout_endpoint'));
					
					$this->clearLocalSessionData();				
				}
				
			} catch ( Exception $e ) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
		}
		/**
		 * This method returns the PII of the logged user
		 * 
		 * @param StoredToken $client_token 
		 *
		 * @result CokeIdUser instance of logged user PII
		 */
		public function getUserLogged(){
			$userLogged = new CokeIdUser();
			try {
		
				$loginStatus = $this->oauth_client->doLoginStatus($this->oauth_config->getItem('token_endpoint'));
		
				if ($loginStatus->getConnect_state()== 'connected'){
					$uid = $loginStatus->getUid();
					$userLogged = $this->getDataUsers($uid, $this->getAccessToken());
						
				}
					
			} catch ( Exception $e ) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
			return $userLogged;
		}
		
		/**
		 * Returns the User PII trough the Coke ID personal identifier.
		 *
		 * @param int $uid Coke ID personal identifier
		 * @param String access_token
		 *
		 * @return CokeIdUser instance
		 */
		public function getDataUsers($uid){
			$cokeIdUser = array();
			$access_token = $this->cokeIdThings->getClientToken();
			try {
				/**
				 *
				 Parameters:
				 oauth_token: client token
				 s (select): dynamic user data to be returned
				 f (from): User
				 w (where): param with OR w.param1&w.param2...
				 */
				$params = array();
				$params['oauth_token'] = $access_token->getValue();
				$params['s'] = "*";
				$params['f'] = "User";
				$params['w.id'] = $uid;
		
				$response = $this->oauth_client->executeRequest($this->oauth_config->getItem('api_query'), $params, "POST");
		
				/**
				 * response['result']: cokeId users array
				 * response['count']: cokeId users count
				 */
				if (!isset($response['result']['data']) || ($response['result']['count'] == '0')) {
					throw new Exception('The data retrieved is empty');
				}
				$cokeIdUser = $this->parseQueryUser($response['result']['data']);
			} catch (Exception $e) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
			return $cokeIdUser;
		}
		
		/**
		 * @deprecated
		 * método provisional para notificar a cocacola.es de un nuevo registro que se ha dado
		 * de alta en otra web diferente a cocacola.es
		 * Es necesario para aquellas webs que utilizan el sistema de registro central y además
		 * utilizan los servicios de cocacola.es como los propios de comunidad o el cabecero.
		 *
		 * Esta clase quedará obsoleta cuando se implemente el servicio de notificación en Coke ID y
		 * cocacola.es se subscriba a la misma
		 * @author Alejandro Sánchez
		 */
		public function notifyCocacolaEs() {
			try {
				$params = array ();
				$params['access_token'] = $this->getAccessToken()->getValue();
				$response = $this->oauth_client->executeRequest ( $this->oauth_config->getItem ( 'url_cocacola_es_postlogin' ), $params, "POST" );
				// posibles respuestas del notificador: 403 para token invalido, 500 error general, 200 OK
				if (! isset ( $response ['result'] ) || ($response ['code'] != '200')) {
					throw new Exception ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.'] The result is invalid: response code <> 200 ' );
				}
				if ($response ['result'] != "") {
					Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.'] The result is valid: response code == 200 ' );
				}
			} catch ( Exception $e ) {
				Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']  ' . $e );
			}
		}	
		/**
		 * Comprobar el estado de un usuario, si está logado o no
		 *
		 * @return boolean si el usuario está logado, o no
		 *
		 */
		private function checkLoginStatus(){
			$loginStatus = null;
			try {
				Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']' );
				$loginStatus = $this->oauth_client->doLoginStatus($this->oauth_config->getItem('token_endpoint'));
		
				$this->cokeIdThings->loginStatus = $loginStatus;
		
			} catch ( Exception $e ) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
				
			return $loginStatus;
		}
		/**
		 * Check if user is logged via single-sign on. The method obtain the access_token of the logged user in
		 * *.cocacola.es through the cookie
		 */
		private function checkLoginConnect(){
			try {
				if (($this->cokeIdThings->clientToken != null)&&($this->cokeIdThings->ssoCookie=='')&&!$this->isConnected()){
					Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']' );
					//$this->cokeIdThings->userToken = null;
						
					if (isset($_COOKIE['datr']) && ($_COOKIE['datr'] != '')) {
						$this->cokeIdThings->ssoCookie = $_COOKIE['datr'];
		
						$this->cokeIdThings->userToken = $this->oauth_client->doCheckLoginConnect($this->oauth_config->getItem('token_endpoint'), $this->cokeIdThings->ssoCookie);
		
						$this->checkAndRefreshAccessToken();
					}
				}
		
			} catch ( Exception $e ) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
		}			
		/**
		 * Elimina datos de session
		 * 
		 */
		private function clearLocalSessionData(){
			try {
				$this->cokeIdThings->userToken = null;			
				$this->cokeIdThings->refreshToken = null;
				$this->cokeIdThings->ssoCookie = null;
			} catch ( Exception $e ) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}	
		}
		
		/**
		 * Recupera el "client_token" Almacenado.
		 * 
		 * Se comprueba si existe o si está caducado, almacenando un client_token válido en storedToken
		 * 
		 * @return ClientToken Devuelve un client_token válido
		 * 		 
		 */
		private function checkAndUpdateClientToken(){			
			try {				
				Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']' );
				$client_token = null;
				
				# Si no tengo client_token o está espirado, obtengo un cliet token y lo almaceno
				if ((!$this->oauth_client->hasToken(iTokenTypes::CLIENT_TOKEN))||($this->oauth_client->tokenExpired(iTokenTypes::CLIENT_TOKEN))) {
					$client_token = $this->oauth_client->doGetClientToken($this->oauth_config->getItem('token_endpoint'));
					Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.'] no tengo client token, lo pido' );
				} else {
					$client_token = $this->oauth_client->getStoredToken(iTokenTypes::CLIENT_TOKEN);	
					Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.'] tengo un client token, lo utilizo' );
				}					
				$this->cokeIdThings->clientToken = $client_token;
				
				return $client_token;
				
			} catch ( Exception $e ) {					
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
				throw $e;
			}	
			
		}
		
		private function loadUserTokenFromEventPersistence(){
			try {								
				if (is_null($this->cokeIdThings->userToken)){						
					Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']' );
					$this->cokeIdThings->userToken = $this->getAccessToken();				
				}

			} catch (Exception $e) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
		}
		
		
		private function checkAndRefreshAccessToken(){
			try {
				
				if ((!is_null($this->cokeIdThings->userToken))&&($this->isExpired($this->cokeIdThings->userToken->getExpiresAt()))){
					Console::log ( '['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']' );
					
					if (!$this->oauth_client->doRefreshToken($this->oauth_config->getItem('token_endpoint'))) {										
						throw new Exception('access token can not be refreshed');
					}														
				} else {
					$this->cokeIdThings->userToken = $this->getAccessToken();
				}
				
				if (is_null($this->cokeIdThings->refreshToken)){
					$this->cokeIdThings->refreshToken = $this->oauth_client->getStoredToken(iTokenTypes::REFRESH_TOKEN);
				}	
			
			} catch (Exception $e) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}					
		}
		
		private function isExpired($expiresAt){
			if (!is_null($expiresAt)){
				return (time() > $expiresAt);
			}
			return true;
		}
		
		/**
		 * Se obtiene el AccessToken del usuario
		 * 
		 * Obtiene el access_token de la cookie local
		 * 
		 * @return AccessToken Devuelve el access_token obtenido
		 */
		private function getAccessToken(){
			try {								
				$access_token = null;								
					
				if ($this->oauth_client->hasToken(iTokenTypes::ACCESS_TOKEN)) {															
					$access_token = $this->oauth_client->getStoredToken(iTokenTypes::ACCESS_TOKEN);	
				} 
			} catch (Exception $e) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
			
			return $access_token;
		}
		
		
		private function parseQueryUser($usersJson){
			$arrayUsers = array();
				
			foreach($usersJson as $queryUser){
				$user = new CokeIdUser();
				$user->setId($queryUser['user']['id']);
				$user->setArcc($queryUser['user']['arcc']);
				$user->setCw($queryUser['user']['cw']);
				$user->setSection($queryUser['user']['section']);
				if (isset($queryUser['user']['user_id'])){
					$user->setNick($queryUser['user']['user_id']['screenName']['value']);				
					$user->setBirthday($queryUser['user']['user_data']['nacimiento']['value']);
					$user->setEmail($queryUser['user']['user_id']['email']['value']);
					$user->setUserId($queryUser['user']['user_id']);
				} else {
                    $user->setNick($queryUser['user']['nick']);               
                    $user->setBirthday($queryUser['user']['birthday']);
                    $user->setEmail($queryUser['user']['email']);
                    $user->setUserId($queryUser['user']['id']);
				}
							
				$user->setDataUser($queryUser['user']['user_data']);
				
				array_push($arrayUsers,$user);
			}
			return $arrayUsers[0];
			
		}			
		
		/**
		 * Devuelve el token necesario para el header
		 * 
		 * @return StoredToken en caso de estar logado devuelve un AccessToken, y si no hay usuario logado, un ClientToken
		 */
		public function getTokenForHeader(){
			$token = null;
			try {
				if (!is_null($this->cokeIdThings)){
					if (!is_null($this->cokeIdThings->userToken)){
						$token = $this->cokeIdThings->userToken;
						Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.'] enviamos petición de cabecera de usuario SI logado (accessToken)');
					} else {
						$token = $this->cokeIdThings->clientToken;
						Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.'] enviamos petición de cabecera de usuario NO logado (clientToken)');
					}
				}
				
			} catch (Exception $e) {
				if (LOG_ERRORS_APIS) {
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getMessage());
					Console::log ('['.__CLASS__.']['.__FUNCTION__.']['.__LINE__.']'.$e->getTraceAsString());
				}
			}
			return $token;
		}
	
	
		/**
		 * Construye la URL para apuntar al usuario en una promo los datos de una sección.
		 *
		 * @param string $endpoint_url A donde apuntará el enlace, normalmente es el 'edit_account_endpoint'
		 * @param string $next_url Dónde se redirige al usuario cuando termine el proceso de edición de datos
		 * @param string $cancel_url Dónde se redirige al usuario si cancela el proceso de edición.
		 * @param string $scope Section sección en la que faltan por completar datos
		 *
		 * @return string La URL generada.
		 *
		 * @throws Exception Si alguno de los parámetros no es válido.
		 */
		public function buildSignupPromotionUrl($scope) {
			try {
				
				if (($scope = trim ((string) $scope)) == '') {
					throw new Exception ( 'Scope section is empty' );
				}
				$urlBuilder = new CokeIdUrlBuilder($this->oauth_client, $this->oauth_config);
								
				if (!$this->isConnected()) {
					//El usuario no está logado
					$urlSignupPromotion = $urlBuilder->getUrlLogin($scope);
				} else {
					//Comprobamos si el usuario tiene completa las sección de la promo
					$userCompletePromo = $this->checkUserComplete($scope);
					if (!$userCompletePromo){
						$urlSignupPromotion = $urlBuilder->getUrlCompleteAccount($scope);
					}
				}
				
				
				return $urlSignupPromotion;
		
			} catch ( Exception $e ) {
				throw $e;
			}
		}
	}