select c.fecha_prog "Fecha", c.num_turno "Turno", e.nombre "Especialidad", m.nombres||m.apellidos "Nombres"
from Cita c, Medico m, Especialidad e
where
	c.Paciente_dni='$paciente' and
	c.Medico_codigoMedico=m.codigoMedico and
	m.Especialidad_idEspecialidad=e.idEspecialidad;