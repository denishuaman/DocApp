<?php
 
$server = "localhost";
$username = "u894483028_docap";
$password = "docapp";
$database = "u894483028_docap";
 
$con = mysqli_connect($server, $username,$password,$database) or die ("No se conecto: " . mysql_error());


$paciente =$_GET['paciente'];

$sql = "SELECT codigo_examen \"Codigo\", fecha_prog \"Fecha\", tipo_analisis \"Tipo\"
		FROM ExamenMedico
		WHERE HistoriaClinica_Paciente_dni='$paciente'";


$resultados = array();
$resultado = mysqli_query($con,$sql);
$num = mysqli_num_rows($resultado);

$i = 0;
// $resultados['res'] = "<select name=\"cars\">";

while ($fila = mysqli_fetch_assoc($resultado)) {
	// $resultados['res'] = $resultados['res']."<option value=\"audi\">".$fila['nombre']."</option>";
	$resultados[$i]=$fila;
	$i++;
}

// $resultados['res'] = $resultados['res']."</select>";
/*convierte los resultados a formato json*/
$resultadosJson = json_encode($resultados);

/*muestra el resultado en un formato que no da problemas de seguridad en browsers */
echo $_GET['jsoncallback'] . '(' . $resultadosJson . ');';

?>