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

//include_once('ChromePhp.php');

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
	
	
public function parsea_cadena($parametro){
			
			$parametro = trim($parametro);
			
			if ($parametro != "") {
				
				$parametro = preg_replace("/'/","&quot;",$parametro);
				$parametro = preg_replace('/""/',"&quot;",$parametro);
				$parametro = preg_replace("/'/","&acute;",$parametro);
				$parametro = preg_replace("/</","&lt;",$parametro);
				$parametro = preg_replace("/>/","&gt;",$parametro);
				$parametro = preg_replace("/>/","&gt;",$parametro);
				$parametro = preg_replace("/select /","se1ect ",$parametro);
				$parametro = preg_replace("/update /","updale ",$parametro);
				$parametro = preg_replace("/delete /","de1ete ",$parametro);
				$parametro = preg_replace("/insert /","1nsert ",$parametro);
				$parametro = preg_replace("/from /","from",$parametro);
				$parametro = preg_replace("/having /","hav1ng",$parametro);
				$parametro = preg_replace("/group /","gr0up",$parametro);
				$parametro = preg_replace("/truncate /","trunc4t3",$parametro);
				$parametro = preg_replace("/--/","",$parametro);
				
			}else{
				$parametro="";
			}
			
			return $parametro;
}


/**************************************************************************************
------------------------------------ FASE I -------------------------------------------   
***************************************************************************************/

	public function verGanadores(){
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					$db = oci_parse($conn,'SELECT * FROM ganadores_casa ORDER BY "id"');
			
					$result = oci_execute($db);
					
					$array = array();
					while ($row=oci_fetch_array($db,OCI_ASSOC+OCI_RETURN_LOBS))
					{	
					
						array_push($array, $row);
											
					}
					oci_close($conn) ;
					return(json_encode($array));
			}
	}
	
	
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

					oci_close($conn) ;
					return(json_encode($array));
			}
	}
		
	public function insertaElemento($tipo, $nombre, $sexo){
	   
	   $tipo = $this->parsea_cadena($tipo);
	   $nombre = $this->parsea_cadena($nombre);
	   $sexo = $this->parsea_cadena($sexo);
	   	
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
							$e = oci_error($db);  
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
					oci_close($conn) ;
			}
	}
	
	
	
	public function borraElemento($nombre){
	   $nombre = $this->parsea_cadena($nombre);	
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
					oci_close($conn) ;
			}
	}
	
	
	
	public function verAvatares(){
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					$db = oci_parse($conn,'SELECT * FROM avatar ORDER BY "id"');
			
					$result = oci_execute($db);
					
					$array = array();
					while ($row=oci_fetch_array($db,OCI_ASSOC+OCI_RETURN_LOBS))
					{	
					
						array_push($array, $row);
											
					}
					oci_close($conn) ;
					return(json_encode($array));
			}
	}
	
	
	
	public function borraAvatares(){

		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					//Nombre: Pantalon_1, Camisa_1, Ojos_1, Ojos_2, Falda_1...
					$db = oci_parse($conn,'DELETE FROM avatar');
					$result = oci_execute($db);
					
					if ($result) {
								return('SI NENA... ;) ');
					//SI NO QUERY MUESTRO ERROR
					}else{
							$e = oci_error($db); 
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
					oci_close($conn) ;
			}
	}
	
	
	public function borraGanadores(){

		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					//Nombre: Pantalon_1, Camisa_1, Ojos_1, Ojos_2, Falda_1...
					$db = oci_parse($conn,'DELETE FROM ganadores_casa');
					$result = oci_execute($db);
					
					if ($result) {
								return('SI NENA... ;) ');
					//SI NO QUERY MUESTRO ERROR
					}else{
							$e = oci_error($db); 
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
					oci_close($conn) ;
			}
	}
	
	
	public function verJugadores(){
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					$db = oci_parse($conn,'SELECT * FROM jugadores ORDER BY "id"');
			
					$result = oci_execute($db);
					
					$array = array();
					while ($row=oci_fetch_array($db,OCI_ASSOC+OCI_RETURN_LOBS))
					{	
					
						array_push($array, $row);
											
					}
					oci_close($conn) ;
					return(json_encode($array));
			}
	}
	
	
	
	public function borraJugadores(){

		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
			//SI NO HAY MUESTRO ERROR
			if (!$conn) {
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					die('KO_CONEXION');
				
			// SI HAY CONN, LANZO QUERY	
			}else{
					//Nombre: Pantalon_1, Camisa_1, Ojos_1, Ojos_2, Falda_1...
					$db = oci_parse($conn,'DELETE FROM jugadores');
					$result = oci_execute($db);
					
					if ($result) {
								return('SI NENA... ;) ');
					//SI NO QUERY MUESTRO ERROR
					}else{
							$e = oci_error($db);  
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
					
					oci_close($conn) ;
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
							$e = oci_error($db);  
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
					}
					
					oci_close($conn) ;
			}
	}
	
	
		
	
	public function comboAvatar($sexo){
			$sexo = $this->parsea_cadena($sexo);	
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
							$e = oci_error($db6);  
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
							$e = oci_error($db7);  
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
							$e = oci_error($db8);  
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
							$e = oci_error($db9);  
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
	
	
	
	public function insertaGanadorCompartir($jugador){
		
		$jugador['id_fb'] = $this->parsea_cadena($jugador['id_fb']);
		$jugador['nombre'] = $this->parsea_cadena($jugador['nombre']);	
		
		$id_fb = "'".$jugador['id_fb']."'";
		$nombre = "'".$jugador['nombre']."'";
		$motivo = "'compartir'";
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
		
		if (!$conn) {
			$e = oci_error();
			return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
		}else{
			
			$sql1 = oci_parse($conn,'SELECT * FROM ganadores_casa WHERE "id_fb" = '.$id_fb.' AND "motivo"='.$motivo.' ');
			oci_execute($sql1);
		
			oci_fetch_all($sql1, $array);
			unset($array);
			$num_rows = oci_num_rows($sql1);
						
			if($num_rows <= 1){
							
				$sql2 = oci_parse($conn,'INSERT INTO ganadores_casa ("id", "id_fb", "nombre", "motivo", "fecha") VALUES(seq_id.nextval, '.$id_fb.', '.$nombre.', '.$motivo.', current_timestamp)');
									
				if(oci_execute($sql2)){
						return ('OK');
				}else{
						$e = oci_error($sql2);  
						return ('KO');
				}
							
			}else{
				return ('MAS_1');
			}
			
			oci_close($conn) ;
		
		}
	}
	


	public function insertaGanadorMatricula($jugador){
		
		$jugador['id_fb'] = $this->parsea_cadena($jugador['id_fb']);
		$jugador['nombre'] = $this->parsea_cadena($jugador['nombre']);
		$jugador['nota'] = $this->parsea_cadena($jugador['nota']);
		$jugador['juego'] = $this->parsea_cadena($jugador['juego']);
		
		$id_fb = "'".$jugador['id_fb']."'";
		$nota = "'".$jugador['nota']."'";
		$juego = '"'.$jugador['juego'].'"'; //ptos1 - ptos2 - ptos3
		$nombre = "'".$jugador['nombre']."'";
		$motivo = "'matricula'";
		
	
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
		
		if (!$conn) {
				
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
		}else{
			//ACTUALIZO NOTA
			$sql = oci_parse($conn,'UPDATE jugadores SET '.$juego.' = '.$nota.' WHERE "id_fb" = '.$id_fb.' ');
			if(oci_execute($sql)){
				
				if($nota == "'sobresaliente'"){
						$sql1 = oci_parse($conn,'SELECT * FROM ganadores_casa WHERE "id_fb" = '.$id_fb.' AND "motivo"='.$motivo.' ');
						oci_execute($sql1);
		
						oci_fetch_all($sql1, $array);
						unset($array);
						$num_rows = oci_num_rows($sql1);
						
						if($num_rows < 4){
							
							$sql2 = oci_parse($conn,'INSERT INTO ganadores_casa ("id", "id_fb", "nombre", "motivo", "fecha") VALUES(seq_id.nextval, '.$id_fb.', '.$nombre.', '.$motivo.', current_timestamp)');
									
							if(oci_execute($sql2)){
								return ('OK');
							}else{
								$e = oci_error($sql2);  // Para errores de oci_execute pase el gestor de sentencia
								return( htmlentities($e['message']. '-' . htmlentities($e['sqltext'])));
								return ('KO');
							}
							
						}else{
							$e = oci_error();
							return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
							return ('MAS_4');
						}
				}else{
					return ('OK_10');
				}
			
				
			}else{
				$e = oci_error($sql);  // Para errores de oci_execute pase el gestor de sentencia
				return( htmlentities($e['message']. '-' . htmlentities($e['sqltext'])));
				return ('KO');
			}
		
			oci_close($conn) ;
		
		}
		
	}
	
	
	
	
	
	
	public function updateCokeId($id_fb, $id_coke){
		//ACTUALIZO REGISTRO CON ID COCACOLA VÁLIDO
		$id_fb = $this->parsea_cadena($id_fb);
		$id_coke = $this->parsea_cadena($id_coke);
		
		$id_fb = "'".$id_fb."'";
		$id_coke = "'".$id_coke."'";		
		
		$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
		if (!$conn) {
				
					$e = oci_error();
					trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
					return('KO_CONEXION');
					die;
				
			// SI HAY, LANZO QUERY	
		}else{
	
			$sql = oci_parse($conn,'UPDATE jugadores SET "id_coke" = '.$id_coke.' WHERE "id_fb" = '.$id_fb.' ');
			if(oci_execute($sql)){
				return ('OK');
			}else{
				return ('KO');
			}
		
			oci_close($conn) ;
		}
	}
	
	

	
	public function guardaAvatar($jugador){
		//ESPERO DATOS USUARIO
		
		$jugador['id_fb'] = $this->parsea_cadena($jugador['id_fb']);
		$jugador['nombre'] = $this->parsea_cadena($jugador['nombre']);
		$jugador['sexo'] = $this->parsea_cadena($jugador['sexo']);
		
		
		$id_fb = "'".$jugador['id_fb']."'";
		$nombre = "'".$jugador['nombre']."'";
		$sexo = "'".$jugador['sexo']."'";
		
		$id_coke = "''";
		
		$ptos1 = "'0'";
		$ptos2 = "'0'";
		$ptos3 = "'0'";
		$compartido = "'0'";			
	
		$avatar = $jugador['avatar'];
		
		$avatar['pelo'] = $this->parsea_cadena($avatar['pelo']);
		$avatar['ojos'] = $this->parsea_cadena($avatar['ojos']);
		$avatar['boca'] = $this->parsea_cadena($avatar['boca']);
		$avatar['gafas'] = $this->parsea_cadena($avatar['gafas']);
		$avatar['sombrero'] = $this->parsea_cadena($avatar['sombrero']);
		$avatar['camisa'] = $this->parsea_cadena($avatar['camisa']);
		$avatar['pantalon'] = $this->parsea_cadena($avatar['pantalon']);
		$avatar['zapatos'] = $this->parsea_cadena($avatar['zapatos']);
		$avatar['top'] = $this->parsea_cadena($avatar['top']);
		$avatar['falda'] = $this->parsea_cadena($avatar['falda']);

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
			
			if (!$conn) { //SI NO HAY MUESTRO ERROR
					$e = oci_error();
					return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
			}else{	// SI HAY CONN, LANZO QUERY


					$db = oci_parse($conn,'SELECT * FROM jugadores WHERE "id_fb" = '.$id_fb.' ');
					oci_execute($db);
	
					oci_fetch_all($db, $array);
					unset($array);
					$num_rows = oci_num_rows($db);
					
					
					if($num_rows < 1){
								$db1 = oci_parse($conn,'INSERT INTO avatar ("id", "id_fb", "sexo", "pelo", "ojos", "boca", "gafas", "sombrero", "camisa", "pantalon", "zapatos", "top", "falda") VALUES(seq_id.nextval, '.$id_fb.', '.$sexo.', '.$pelo.', '.$ojos.', '.$boca.', '.$gafas.', '.$sombrero.', '.$camisa.', '.$pantalon.', '.$zapatos.', '.$top.', '.$falda.')');
								
								$result = oci_execute($db1);
								
								if ($result) {
										$db2 = oci_parse($conn,'SELECT avatar."id", avatar."id_fb" FROM avatar WHERE avatar."id_fb"='.$id_fb.'');
										$result2 = oci_execute($db2);
										
										$array = array();
										while ($row2 = oci_fetch_array($db2,OCI_ASSOC+OCI_RETURN_LOBS))
										{	
											array_push($array, $row2);
										}
										
										$id_avatar = "'".$array[0]['id']."'";
																	
											if ( $result2 ) {

												$db3 = oci_parse($conn,'INSERT INTO jugadores ("id", "id_fb", "nombre", "sexo", "id_coke", "id_avatar", "registro", ptos1, ptos2, ptos3, compartido) VALUES(seq_id.nextval, '.$id_fb.', '.$nombre.', '.$sexo.', '.$id_coke.', '.$id_avatar.', current_timestamp, '.$ptos1.', '.$ptos2.', '.$ptos3.', '.$compartido.' )');
												$result3 = oci_execute($db3);
												
													if( $result3 ){
														oci_close($conn) ;
														return ('OK');
													}else{
														$e = oci_error($db3);  
													}
											
											}else{
												$e = oci_error($db2);  

											}
				
								}else{ //SI NO QUERY MUESTRO ERROR
                                        $e = oci_error($db1);  

								}
					}else{
                        $e = oci_error($db);  
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
	
			$id_fb = $this->parsea_cadena($id_fb);
			
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
										$e = oci_error($db3); 
										return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
									}
								
							}else{
								$e = oci_error($db2);  
								return(trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR));
							}
							
					//SI PETA QUERY MUESTRO ERROR
					}else{
	
							return('KO');
					}
					
					oci_close($conn) ;
			}
	}


	
}

	
?>