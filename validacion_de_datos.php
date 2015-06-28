<?php
 
$server = "localhost";
$username = "u894483028_docap";
$password = "docapp";
$database = "u894483028_docap";
 
$con = mysqli_connect($server, $username,$password,$database) or die ("No se conecto: " . mysql_error());

$sql = "SELECT username FROM usuario WHERE username='$usuarioEnviado' AND password='$passwordEnviado'";
 $usuarioEnviado = $_GET['usuario'];
$passwordEnviado = $_GET['password'];

 $resultados = array();
$resultados["hora"] = date("F j, Y, g:i a"); 
$resultados["generador"] = "Enviado desde revolucion.mobi" ;
$resultado = mysqli_query($con,$sql);
$num = mysqli_num_rows($resultado);

 if( 0 < $num)
 {

 	$resultados["mensaje"] = "Validacion Correcta";
	$resultados["validacion"] = "ok";

}else{
	/*esta informacion se envia si la validacion falla */
	$resultados["mensaje"] = "Usuario y password incorrectos";
	$resultados["validacion"] = "error";
}


/*convierte los resultados a formato json*/
$resultadosJson = json_encode($resultados);

/*muestra el resultado en un formato que no da problemas de seguridad en browsers */
echo $_GET['jsoncallback'] . '(' . $resultadosJson . ');';

?>