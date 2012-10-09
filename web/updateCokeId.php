<?php
/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 05/10/12
 * Time: 21:31
 * To change this template use File | Settings | File Templates.
 */



$id_fb = $_POST['id_fb'];
$id_coke = $_POST['id_coke'];

//ACTUALIZO REGISTRO CON ID COCACOLA VÁLIDO
$id_fb = "'".$id_fb."'";
$id_coke = "'".$id_coke."'";

$conn = oci_connect('ACDNWEB','pmf45cdn','KONAT','WE8ISO8859P1');
if (!$conn) {

    $e = oci_error();
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    echo('KO_CONEXION');
    die;

    // SI HAY, LANZO QUERY
}else{

    $sql = oci_parse($conn,'UPDATE jugadores SET "id_coke" = '.$id_coke.' WHERE "id_fb" = '.$id_fb.' ');
    if(oci_execute($sql)){
        echo ('OK');
    }else{
        echo ('KO');
    }

    oci_close($conn) ;
}

?>