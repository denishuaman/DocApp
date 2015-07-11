
var dniUsuario=12345678;
var SelectCancelar;


$('#registrarCitaMedica').click(function(event) {

	archivoValidacion = "http://docapp.esy.es/registrarCita.php?jsoncallback=?";

			var campoturnoCita = document.getElementById( "turnoCita" ).value;
			var campofecha = document.getElementById( "fecha" ).value;
			var campocodDoctor = document.getElementById( "codDoctor" ).value;
 
     		$.getJSON(archivoValidacion,{medico:campocodDoctor,fecha:campofecha,turno:campoturnoCita,paciente:dniUsuario}).done(function(respuestaServer){

     				if(respuestaServer.ok==1){
     					$.mobile.changePage('#pageCorrecto', 'pop',true,true);
     				}else{ 
     					$.mobile.changePage('#pageIncorrecto', 'pop',true,true);
     				}
					
    		}).fail(function() {
		    	alert( "Ocurrio un error en la conexion" );
		 	 });

});

 $('#botonRegistrarCM').click(function(event) {

	archivoValidacion = "http://docapp.esy.es/cantidad_doctores_turno.php?jsoncallback=?";

			var yourSelectDia = document.getElementById( "selectDia" );
			var selectDia = yourSelectDia.selectedIndex+1;
 			var valDia = yourSelectDia.options[ yourSelectDia.selectedIndex ].value;

			var yourSelectDoc = document.getElementById( "selectDoctor");
			var selectDoc = yourSelectDoc.options[ yourSelectDoc.selectedIndex ].value;
			var d = new Date();
 

 			var yourSelectEspec = document.getElementById( "selectEspecialidad" );
			var selectEspec = yourSelectEspec.options[ yourSelectEspec.selectedIndex ].value;

			if (selectDia >= d.getDay()) {
				d.setDate(d.getDate() + (selectDia-d.getDay()));
			} else {

				d.setDate(d.getDate() + ((6-d.getDay()))+selectDia+1);
			}
    		var n = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();

     		$.getJSON(archivoValidacion,{medico:selectDoc,fecha:n,dia:valDia}).done(function(respuestaServer){
 					var campoCita = document.getElementById( "turnoCita");
					campoCita.value = parseInt(respuestaServer.cantidad)+1;
					codDoctor.value = selectDoc;
					doctor.value = respuestaServer.nombre;
					hora.value = respuestaServer.horaini;
					fecha.value = n;
					especialidad.value = selectEspec;
					$.mobile.changePage("#registroFinalMedico");
    		}).fail(function() {
		    	alert( "Ocurrio un error en la conexion" );
		 	 });

});
$('#enviarFormularioDoc').click(function(event) {
 
	archivoValidacion = "http://docapp.esy.es/obtenerMedicoEspecialidadDia.php?jsoncallback=?";

 
			var yourSelectEspec = document.getElementById( "selectEspecialidad" );
			var selectEspec = yourSelectEspec.options[ yourSelectEspec.selectedIndex ].value;

			var yourSelectDia = document.getElementById( "selectDia" );
			var selectDia = yourSelectDia.options[ yourSelectDia.selectedIndex].value;

 
			$.getJSON(archivoValidacion,{especialidad:selectEspec,dia:selectDia}).done(function(respuestaServer){

				var selectdoc = "Escoja un medico: <div id=\"seleccionMedico\" ><select id=\"selectDoctor\">";
				for (var i = 0; i < respuestaServer.length; i++) {
					selectdoc = selectdoc + "<option value=\""+ respuestaServer[i].Codigo+"\">"+respuestaServer[i].Nombre+"</option>";
				};
 				selectdoc =selectdoc + "</select></div>";
 				$("#seleccionMedico").html(selectdoc);

				$("#seleccionMedico").trigger("create");

				$("#botonRegistrarCM").css("display","block");
			}).fail(function() {
		    	alert( "error" );
		 	 });
 
});


 

$('#botonReservarCitaMedica').click(function(event) { 

			archivoValidacion = "http://docapp.esy.es/obtenerEspecialidad.php?jsoncallback=?";

			$.getJSON(archivoValidacion).done(function(respuestaServer){
		 	 var $espec = "<div id=\"labEspecialidad\"><select id=\"selectEspecialidad\">";

		 	 for (var i = 0; i < respuestaServer.length; i++) {
		 	 	$espec = $espec + "<option value=\""+ respuestaServer[i].nombre+"\">"+ respuestaServer[i].nombre+" </option>";
		 	 };

		 	 
		 	 $espec = $espec + "</select></div>";


			$("#labEspecialidad").html($espec);
			$.mobile.changePage("#reservarcitaMedica");
			$("#labEspecialidad").trigger("create");


		});
});


$('#botonCitaMedica').click(function(event) { 
 $.mobile.changePage("#citaMedica");
});


restaFechas = function(f2,f1)
 {
	 var aFecha1 = f1.split('-'); 
	 var aFecha2 = f2.split('-'); 
	 var fFecha1 = Date.UTC(aFecha1[0],aFecha1[1]-1,aFecha1[2]); 
	 var fFecha2 = Date.UTC(aFecha2[0],aFecha2[1]-1,aFecha2[2]); 
	 var dif = fFecha2 - fFecha1;
	 var dias = Math.floor(dif / (1000 * 60 * 60 * 24));

	 return dias;
 }

$('#botonLogin').click(function(event) { 



 	var datosUsuario = $("#nombredeusuario").val();
	var datosPassword = $("#clave").val();
	
  	archivoValidacion = "http://docapp.esy.es/Login.php?jsoncallback=?";

	$.getJSON( archivoValidacion, { usuario:datosUsuario ,password:datosPassword})
	.done(function(respuestaServer) {
 		if(respuestaServer.validacion == "ok"){
		 	/// si la validacion es correcta
		 	dniUsuario = respuestaServer.dni;
		 	alert(dniUsuario);
		 	$.getJSON( "http://docapp.esy.es/visualizacion_citas.php?jsoncallback=?",{paciente:dniUsuario}).done(function(respuestaServer){
		 		var dif;
		 		var citUlt;
		 		for (var i = 0; i < respuestaServer.length; i++) {
		 			var fechaActual = new Date().getFullYear()+"-"+(new Date().getMonth()+1) + "-"+(new Date().getDate());
		 			var diferenciaFecha = restaFechas(respuestaServer[i].Fecha,fechaActual);
		 			if (diferenciaFecha<=1 && diferenciaFecha>=0) {
		 				citUlt=respuestaServer[i];
		 				dif=true;
		 			};
		 		};

		 		if (dif==true) {
		 			$("#citaPendiente").html("<p id=\"citaPendiente\">Recuerde! Usted tiene una cita para el "+citUlt.Fecha+" en "+citUlt.Especialidad+".</p>")
					$.mobile.changePage("#pageCorrectoY", 'pop',true,true);
		 		};



		 	});
			$.mobile.changePage("#tareas");
		}else{
			alert('Contraseña o usuario incorrecto'); 
 		}
  
	}).fail(function() {
    	alert( "error" );
 	 });

 });


