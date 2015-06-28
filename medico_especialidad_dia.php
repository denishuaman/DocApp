<?php
 
$server = "localhost";
$username = "u894483028_docap";
$password = "docapp";
$database = "u894483028_docap";
 
$con = mysqli_connect($server, $username,$password,$database) or die ("No se conecto: " . mysql_error());

//$especialidad = $_GET['especialidad'];
//$dia = $_GET['dia'];

$sql = "SELECT m.nombres \"Nombre\", m.apellidos \"Apellidos\", d.hora_ini \"HoraIni\",d.hora_fin \"HoraFin\",d.capacidad \"Capacidad\"
		FROM Medico m , Disponibilidad d , Especialidad e , Disponibilidad_has_Medico dm
		WHERE e.nombre=\"Otorrinolaringologia\" and
			  e.idEspecialidad=m.Especialidad_idEspecialidad and
			  d.dia=\"LU\" and
			  d.idDisponibilidad=dm.Disponibilidad_idDisponibilidad and
			  dm.Medico_codigoMedico=m.codigoMedico";


$resultados = array();
$resultado = mysqli_query($con,$sql);
$num = mysqli_num_rows($resultado);

$i = 0;
// $resultados['res'] = "<select name=\"cars\">";

while ($fila = mysqli_fetch_assoc($resultado)) {
	// $resultados['res'] = $resultados['res']."<option value=\"audi\">".$fila['nombre']."</option>";
	$resultados[i]=$fila;
	$i++;
}

// $resultados['res'] = $resultados['res']."</select>";
/*convierte los resultados a formato json*/
$resultadosJson = json_encode($resultados);

/*muestra el resultado en un formato que no da problemas de seguridad en browsers */
echo $_GET['jsoncallback'] . '(' . $resultadosJson . ');';

?>