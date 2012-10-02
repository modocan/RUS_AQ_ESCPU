<?php
/******************************* KO_HOSTING_INFO ******************************

NOTA: dado que los nombres de columna se crearon entre comillas dobles "", y son minúsculas, siempre tendrán que ir entre comillas dobles. Los nombres de tabla, sin embargo, serán accesibles ya sea en mayúsculas o minúsculas, pero si se hace referencia a ellas entre comillas dobles, sólo se puede usar en mayúsculas .

CREATE TABLE animales
(
	"id" NUMBER(5) NOT NULL PRIMARY KEY,
	"nombre" VARCHAR2(40),
	"valor" NUMBER(2)
);*/

//CAMBIAR ESTRUCTURA DE TABLA

include_once('ChromePhp.php');

class ContactService
{
	
	var $myconnection = null;
    var $statement = null;
	
	function ContactService()
	{
		// CONEXIÓN DE ENTORNO TEST
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
		//mysql_select_db( "KONAT" );
	}
	
	

/**************************************************************************************
------------------------------------ FASE I -------------------------------------------   
***************************************************************************************/
	
	public function verElementos(){
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					$db = oci_parse($conn,'SELECT * FROM elem_avatar ORDER BY "id"');
			
					$result = oci_execute($db);
					
					$array = array();
					while ($row=oci_fetch_array($db,OCI_ASSOC+OCI_RETURN_LOBS))
					{	
					
						array_push($array, $row);
											
					}

                    ChromePhp::log($array);
					
					return(json_encode($array));
			}
	}
		
	public function insertaElemento($tipo, $nombre, $sexo){
		
	   $tipo = "'".$tipo."'";
	   $nombre = "'".$nombre."'";
	   $sexo = "'".$sexo."'";
	   
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					//TIPOS DE ELEM (9 en total): pantalon, boca, ojos, camisa, gafas, zapatos, pelo, top, falda
					//Nombre: Pantalon_1, Camisa_1, Ojos_1, Ojos_2, Falda_1...
					//Sexo: 0 mujer, 1 hombre, 2 unisex
					$db = oci_parse($conn,'INSERT INTO elem_avatar ("id","tipo","nombre","sexo") VALUES (seq_id.nextval, '.$tipo.', '.$nombre.', '.$sexo.')');
			
					$result = oci_execute($db);
					
					if ($result) {
								return('SI NENA... ;) ');
					//SI NO QUERY MUESTRO ERROR
					}else{
							$e = oci_error($db);  // For oci_execute errors pass the statement handle
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
			}
	}
	
	
	
	public function borraElemento($nombre){
		
	   $nombre = "'".$nombre."'";
	   //$nombre = "'Pantalon_1'";
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					//Nombre: Pantalon_1, Camisa_1, Ojos_1, Ojos_2, Falda_1...
					$db = oci_parse($conn,'DELETE FROM elem_avatar WHERE "nombre" = '.$nombre.' ');
					$result = oci_execute($db);
					
					if ($result) {
								return('SI NENA... ;) ');
					//SI NO QUERY MUESTRO ERROR
					}else{
							$e = oci_error($db);  // For oci_execute errors pass the statement handle
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
			}
	}
	
	
	
	public function borraTodosElementos(){
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					$db = oci_parse($conn,'DELETE FROM elem_avatar');
					$result = oci_execute($db);
					
					if ($result) {
								return('SI NENA... ;) ');
					//SI NO QUERY MUESTRO ERROR
					}else{
							$e = oci_error($db);  // For oci_execute errors pass the statement handle
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
			}
	}
	
	
		
	
	public function comboAvatar($sexo){
		
			$sexo = "'".$sexo."'";
		
			// CONECTO
			$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
				
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
				$pantalon = "'pantalon'";
				$boca = "'boca'";
				$ojos = "'ojos'";
				$camisa = "'camisa'";
				$gafas = "'gafas'";
				$zapatos = "'zapatos'";
				$pelo = "'pelo'";
				$top = "'top'";
				$falda = "'falda'";
	
					$tipos = array(
									'pantalon' => array(), 
									'boca' => array(), 
									"ojos" =>  array(), 
									"camisa" => array(), 
									"gafas" => array(), 
									"zapatos" => array(), 
									"pelo" =>  array(),
									"top" => array(),
									"falda" => array()
					);
					
			
					
					function array_push_assoc($array, $key, $value){
						$array[$key] = $value;
						return $array;
					}
					
					function arrayToObject($d) {
					if (is_array($d)) {
						/*
						* Return array converted to object
						* Using __FUNCTION__ (Magic constant)
						* for recursive call
						*/
						return( object) array_map(__FUNCTION__, $d);
					}
					else {
							// Return object
							return( $d );
						}
					}
					
					
					/* ************************************ PANTALONES ************************************  */						
					$db = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$pantalon.' AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result = oci_execute($db);
					
					if ($result) {
								$pantalones = array();
							
								while ($row=oci_fetch_array($db,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number = explode('_', $row['nombre']);
										$pantalones = array_push_assoc($pantalones, $number[1], array('nombre' => $row['nombre'], 'id' => $row['id'], 'sexo' => $row['sexo']));
											
								}
	
					//SI NO QUERY MUESTRO ERROR
					}else{
							$e = oci_error($db);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					
					/* ************************************ BOCA ************************************  */					
					$db2 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$boca.'  AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result2 = oci_execute($db2);
					
					if ($result2) {
								$bocas = array();
							
								while ($row2=oci_fetch_array($db2,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number2 = explode('_', $row2['nombre']);
										$bocas = array_push_assoc($bocas, $number2[1], array('nombre' => $row2['nombre'], 'id' => $row2['id'], 'sexo' => $row2['sexo']));
											
								}

					}else{
							$e = oci_error($db2);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					
				
					/* ************************************ OJOS ************************************  */					
					$db3 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$ojos.'  AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result3 = oci_execute($db3);
					
					if ($result3) {
								$ojitos = array();
							
								while ($row3=oci_fetch_array($db3,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number3 = explode('_', $row3['nombre']);
										$ojitos = array_push_assoc($ojitos, $number3[1], array('nombre' => $row3['nombre'], 'id' => $row3['id'], 'sexo' => $row3['sexo']));
											
								}
	
					}else{
							$e = oci_error($db3);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					
					
					
					/* ************************************ CAMISA ************************************  */					
					$db4 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$camisa.' AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result4 = oci_execute($db4);
					
					if ($result4) {
								$camisas = array();
							
								while ($row4=oci_fetch_array($db4,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number4 = explode('_', $row4['nombre']);
										$camisas = array_push_assoc($camisas, $number4[1], array('nombre' => $row4['nombre'], 'id' => $row4['id'], 'sexo' => $row4['sexo']));
											
								}
	
					}else{
							$e = oci_error($db4);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					
					
					
					
					/* ************************************ GAFAS ************************************  */					
					$db5 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$gafas.' AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result5 = oci_execute($db5);
					
					if ($result5) {
								$anteojos = array();
							
								while ($row5=oci_fetch_array($db5,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number5 = explode('_', $row5['nombre']);
										$anteojos = array_push_assoc($anteojos, $number5[1], array('nombre' => $row5['nombre'], 'id' => $row5['id'], 'sexo' => $row5['sexo']));
											
								}
		
					}else{
							$e = oci_error($db5);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					

					
					
					/* ************************************ ZAPATOS ************************************  */					
					$db6 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$zapatos.' AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result6 = oci_execute($db6);
					
					if ($result6) {
								$zapatillas = array();
							
								while ($row6=oci_fetch_array($db6,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number6 = explode('_', $row6['nombre']);
										$zapatillas = array_push_assoc($zapatillas, $number6[1], array('nombre' => $row6['nombre'], 'id' => $row6['id'], 'sexo' => $row6['sexo']));
											
								}
		
					}else{
							$e = oci_error($db6);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					
					
					
					
					/* ************************************ PELO ************************************  */					
					$db7 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$pelo.' AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result7 = oci_execute($db7);
					
					if ($result7) {
								$pelos = array();
							
								while ($row7=oci_fetch_array($db7,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number7 = explode('_', $row7['nombre']);
										$pelos = array_push_assoc($pelos, $number7[1], array('nombre' => $row7['nombre'], 'id' => $row7['id'], 'sexo' => $row7['sexo']));
											
								}
							
					}else{
							$e = oci_error($db7);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					
					
					
					
					/* ************************************ TOP ************************************  */					
					$db8 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$top.' AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result8 = oci_execute($db8);
					
					if ($result8) {
								$tops = array();
							
								while ($row8=oci_fetch_array($db8,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number8 = explode('_', $row8['nombre']);
										$tops = array_push_assoc($tops, $number8[1], array('nombre' => $row8['nombre'], 'id' => $row8['id'], 'sexo' => $row8['sexo']));
											
								}
							
					}else{
							$e = oci_error($db8);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					
					
					
					/* ************************************ FALDA ************************************  */					
					$db9 = oci_parse($conn,'SELECT elem_avatar."id", elem_avatar."tipo", elem_avatar."nombre", elem_avatar."sexo" FROM elem_avatar WHERE elem_avatar."tipo" = '.$falda.' AND (elem_avatar."sexo" = '.$sexo.' OR elem_avatar."sexo"= 2) ORDER BY elem_avatar."id"');
			
					$result9 = oci_execute($db9);
					
					if ($result9) {
								$faldas = array();
							
								while ($row9=oci_fetch_array($db9,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
										$number9 = explode('_', $row9['nombre']);
										$faldas = array_push_assoc($faldas, $number9[1], array('nombre' => $row9['nombre'], 'id' => $row9['id'], 'sexo' => $row9['sexo']));
											
								}
							
					}else{
							$e = oci_error($db9);  // For oci_execute errors pass the statement handle
							return($e);
					}
					
					$data = array();
					$data = array_push_assoc($data, 'pantalon', $pantalones);
					$data = array_push_assoc($data, 'boca', $bocas);
					$data = array_push_assoc($data, 'ojos', $ojitos);
					$data = array_push_assoc($data, 'camisa', $camisas);
					$data = array_push_assoc($data, 'gafas', $anteojos);
					$data = array_push_assoc($data, 'zapatos', $zapatillas);
					$data = array_push_assoc($data, 'pelo', $pelos);
					$data = array_push_assoc($data, 'top', $tops);
					$data = array_push_assoc($data, 'falda', $faldas);
					
					oci_close($conn);
					
					$array = (array)$data;
					//$array = arrayToObject($data);
					//return($array);
					return(json_encode($array));

			}
	
	}
	
	
	
	public function insertaGanadorCompartir($id){
		//COMPRUEBO QUE NO ESTE A 1
		//ACTUALIZO A 1
		//INSERT EN GANADORES
	
	}
	
	//ACTUALIZAR NOTA E INSERTAR SI PROCEDE
	public function insertaGanadorMatricula($id, $nota, $juego, $matricula){
		//ACTUALIZO NOTA
		////COMPRUEBO QUE NO ESTE INSERTADO 4 VECES si es matricula
		//INSERT EN GANADORES 
	}
	
	
	
	
	public function updateCokeId($id_fb, $id_coke){
		//ACTUALIZO REGISTRO CON ID COCACOLA VÁLIDO
	}
	
	
	public function probando($jugador)
    {
        $id_fb = "'".$jugador['id_fb']."'";
        $nombre = "'".$jugador['nombre']."'";
        $sexo = "'".$jugador['sexo']."'";

        $id_coke = '';

        $ptos1 = "'0'";
        $ptos2 = "'0'";
        $ptos3 = "'0'";
        $compartido = "'0'";

        $id_avatar = "'1'";

        $avatar = $jugador['avatar'];
        $pelo = "'".$avatar['pelo']."'";
        $ojos  = "'".$avatar['ojos']."'";
        $boca = "'".$avatar['boca']."'";
        $gafas = "'".$avatar['gafas']."'";
        $sombrero = "'".$avatar['sombrero']."'";
        $camisa = "'".$avatar['camisa']."'";
        $pantalon = "'".$avatar['pantalon']."'";
        $zapatos = "'".$avatar['zapatos']."'";
        $top = "'".$avatar['top']."'";
        $falda = "'".$avatar['falda']."'";


        // CONECTO
        $conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');

        /*$db3 = oci_parse($conn,'INSERT INTO jugadores ("id", "id_fb", "nombre", "sexo", "id_coke", "id_avatar", "registro", ptos1, ptos2, ptos3, compartido) VALUES(seq_id.nextval, '.$id_fb.', '.$nombre.', '.$sexo.', '.$id_coke.', '.$id_avatar.', current_timestamp, '.$ptos1.', '.$ptos2.', '.$ptos3.', '.$compartido.' )');

        if(oci_execute($db3))
        {*/
            $db = oci_parse($conn,'SELECT * FROM jugadores');
            $res =  oci_execute($db);
            $respuesta = array();
            $val = array();

            if($res)
            {
                while($row = oci_fetch_array($res))
                {
                    array_push($val, $row);
                }

                array_push($respuesta, $val);

                //return json_encode($val);
               /* $db = oci_parse($conn,'SELECT * FROM avatar');
                $res =  oci_execute($db);
                $val = array();

                while($row = oci_fetch_array($res))
                {
                    array_push($val, $row);
                }

                array_push($respuesta, $val);*/

                return json_encode($respuesta);
            }
            else
            {
                return json_encode('[KO - SELECT]');
            }

       /* }
        else
        {
            return json_encode('[KO - INSERT]');
        }*/



        //return $respuesta;
    }

	
	public function guardaAvatar($jugador){
		//ESPERO DATOS USUARIO
		$id_fb = "'".$jugador['id_fb']."'";
		$nombre = "'".$jugador['nombre']."'";
		$sexo = "'".$jugador['sexo']."'";
		
		$id_coke = '';
		
		$ptos1 = "'0'";
		$ptos2 = "'0'";
		$ptos3 = "'0'";
		$compartido = "'0'";			
	
		$avatar = $jugador['avatar'];

        $pelo = "'".$avatar['pelo']."'";
		$ojos  = "'".$avatar['ojos']."'";
		$boca = "'".$avatar['boca']."'";
		$gafas = "'".$avatar['gafas']."'";
		$sombrero = "'".$avatar['sombrero']."'";
		$camisa = "'".$avatar['camisa']."'";
		$pantalon = "'".$avatar['pantalon']."'";
		$zapatos = "'".$avatar['zapatos']."'";
		$top = "'".$avatar['top']."'";
		$falda = "'".$avatar['falda']."'";


        ChromePhp::log('****VARS++++++');
        ChromePhp::log($id_fb);
        ChromePhp::log($nombre);
        ChromePhp::log($sexo);
        ChromePhp::log($avatar);
        ChromePhp::log($pelo);






		
			// CONECTO
			$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			
			if (!$conn) { //SI NO HAY MUESTRO ERROR
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
			}else{	// SI HAY CONN, LANZO QUERY

                    ChromePhp::log('[Conecta]');

					$db = oci_parse($conn,'SELECT * FROM jugadores WHERE "id_fb" = '.$id_fb.' ');
					oci_execute($db);
	
					oci_fetch_all($db, $array);
					unset($array);
					$num_rows = oci_num_rows($db);
					
					//echo $num_rows;
					
					if($num_rows < 1){
                                 ChromePhp::log('[Usuario NO existe]');
								//$db = oci_parse($conn,'INSERTO TABLA AVATAR');
								$db1 = oci_parse($conn,'INSERT INTO avatar ("id", "id_fb", "sexo", "pelo", "ojos", "boca", "gafas", "sombrero", "camisa", "pantalon", "zapatos", "top", "falda") VALUES(seq_id.nextval, '.$id_fb.', '.$sexo.', '.$pelo.', '.$ojos.', '.$boca.', '.$gafas.', '.$sombrero.', '.$camisa.', '.$pantalon.', '.$zapatos.', '.$top.', '.$falda.')');
								
								$result = oci_execute($db1);
								
								if ($result) {
                                    ChromePhp::log('[Inserta Avatar]');
										$db2 = oci_parse($conn,'SELECT avatar."id", avatar."id_fb" FROM avatar WHERE avatar."id_fb"='.$id_fb.'');
										$result2 = oci_execute($db2);
										
										$array = array();
										while ($row2 = oci_fetch_array($db2,OCI_ASSOC+OCI_RETURN_LOBS))
										{	
											array_push($array, $row2);
										}
										
										$id_avatar = "'".$array[0]['id']."'";
																	
											if ( $result2 ) {
                                                ChromePhp::log('[Inserta jugador]');
												$db3 = oci_parse($conn,'INSERT INTO jugadores ("id", "id_fb", "nombre", "sexo", "id_coke", "id_avatar", "registro", ptos1, ptos2, ptos3, compartido) VALUES(seq_id.nextval, '.$id_fb.', '.$nombre.', '.$sexo.', '.$id_coke.', '.$id_avatar.', current_timestamp, '.$ptos1.', '.$ptos2.', '.$ptos3.', '.$compartido.' )');
												$result3 = oci_execute($db3);
												
													if( $result3 ){
														oci_close($conn) ;
														return ('OK');
													}else{
														$e = oci_error($db3);  // For oci_execute errors pass the statement handle
                                                        ChromePhp::log(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
													}
											
											}else{
												$e = oci_error($db2);  // For oci_execute errors pass the statement handle

                                                ChromePhp::log(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
											}
				
								}else{ //SI NO QUERY MUESTRO ERROR
                                        $e = oci_error($db1);  // For oci_execute errors pass the statement handle

                                    ChromePhp::log(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
								}
					}else{
                        $e = oci_error($db);  // For oci_execute errors pass the statement handle
                        ChromePhp::log(htmlentities($e['message']));
                        ChromePhp::log("\n<pre>\n");
                        ChromePhp::log( htmlentities($e['sqltext']));
                        ChromePhp::log("\n%".($e['offset']+1)."s", "^");
                        ChromePhp::log(  "\n</pre>\n" );

                        ChromePhp::log('[Usuario YA existe]');
						oci_close($conn) ;
						return('YA_INSERTADO');
					}
			}
			oci_close($conn) ;
			
	}
	





/**************************************************************************************
------------------------------------ FASE II -------------------------------------------   
***************************************************************************************/


public function dameJugador($id_fb){
			$id_fb = "'".$id_fb."'";
			//$id_fb = "'812657877'";
			
			// CONECTO
			$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
				
					$e = oci_error();
					trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
					return('KO_CONEXION');
					die;
				
			// SI HAY, LANZO QUERY	
			}else{
					$db = oci_parse($conn,'SELECT * FROM jugadores WHERE "id_fb" = '.$id_fb.' ');
					oci_execute($db);
	
					oci_fetch_all($db, $array);
					unset($array);
					$num_rows = oci_num_rows($db);
	
					if($num_rows > 0){
						
						//id id_fb sexo id_avatar
							
							$db2 = oci_parse($conn,'SELECT * FROM jugadores WHERE "id_fb" = '.$id_fb.' ');
							$result2 = oci_execute($db2);
							
							if($result2){
								$data = array();
								while ($row2=oci_fetch_array($db2,OCI_ASSOC+OCI_RETURN_LOBS))
								{	
									array_push($data, $row2);
								}
								
								$id_avatar = "'".$data[0]['id_avatar']."'";
								
								$db3 = oci_parse($conn,'SELECT * FROM avatar WHERE "id" = '.$id_avatar.'');
								$result3 = oci_execute($db3);
								
									if($result3){
										while ($row3=oci_fetch_array($db3,OCI_ASSOC+OCI_RETURN_LOBS))
										{	
											array_push($data, $row3);
										}
										
										return(json_encode($data));
									
									}else{
										$e = oci_error($db3);  // For oci_execute errors pass the statement handle
										return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
									}
								
							}else{
								$e = oci_error($db2);  // For oci_execute errors pass the statement handle
								return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
							}
							
					//SI PETA QUERY MUESTRO ERROR
					}else{
							//$e = oci_error($db);  // For oci_execute errors pass the statement handle
							//return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
							return('KO');
					}
					
					oci_close($conn) ;
			}
	}


	
}

	
?>