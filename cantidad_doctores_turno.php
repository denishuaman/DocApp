<?php
 
$server = "localhost";
$username = "u894483028_docap";
$password = "docapp";
$database = "u894483028_docap";
 
$con = mysqli_connect($server, $username,$password,$database) or die ("No se conecto: " . mysql_error());

 $medico = $_GET['medico'];
 $fecha = $_GET['fecha'];

$sql = "SELECT count(*) \"cantidad\", m.nombres \"nombre\"
		FROM Cita c , Medico m
		WHERE m.codigoMedico='$medico' and  c.fecha_prog='$fecha' and c.Medico_codigoMedico='$medico'";


$resultados = 0;
$resultado = mysqli_query($con,$sql);
$num = mysqli_num_rows($resultado);

$i = 0;
// $resultados['res'] = "<select name=\"cars\">";

while ($fila = mysqli_fetch_assoc($resultado)) {
	// $resultados['res'] = $resultados['res']."<option value=\"audi\">".$fila['nombre']."</option>";
	$resultados=$fila;

}

// $resultados['res'] = $resultados['res']."</select>";
/*convierte los resultados a formato json*/
$resultadosJson = json_encode($resultados);

/*muestra el resultado en un formato que no da problemas de seguridad en browsers */
echo $_GET['jsoncallback'] . '(' . $resultadosJson . ');';

?>