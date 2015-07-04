<?php
 
$server = "localhost";
$username = "u894483028_docap";
$password = "docapp";
$database = "u894483028_docap";
 
$con = mysqli_connect($server, $username,$password,$database) or die ("No se conecto: " . mysql_error());

$fechaNueva = $_GET['fechaNueva'];
$fechaAntigua = $_GET['fechaAntigua'];
$paciente = $_GET['paciente'];
$medico = $_GET['medico'];

$sql = "UPDATE Cita 
		SET fecha_prog='$fechaNueva'
		WHERE Medico_codigoMedico='$medico' 
		AND Paciente_dni='$paciente' 
		AND fecha_prog='$fechaAntigua'";

$resultados = array();

if(mysqli_query($con,$sql))
{
	$resultados['ok'] = 1;
}else{
	$resultados['ok'] = 0;
}


$resultadosJson = json_encode($resultados);

/*muestra el resultado en un formato que no da problemas de seguridad en browsers */
echo $_GET['jsoncallback'] . '(' . $resultadosJson . ');';

?>