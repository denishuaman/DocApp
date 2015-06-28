<?php
 
$server = "localhost";
$username = "u894483028_docap";
$password = "docapp";
$database = "u894483028_docap";
 
$con = mysqli_connect($server, $username,$password,$database) or die ("No se conecto: " . mysql_error());

 $medico = $_GET['medico'];
 $fecha = $_GET['fecha'];
 $paciente = $_GET['paciente'];

$sql = "DELETE FROM Cita WHERE '$medico'=Medico_codigoMedico AND '$fecha'=fecha_prog AND '$paciente'=Paciente_dni";

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