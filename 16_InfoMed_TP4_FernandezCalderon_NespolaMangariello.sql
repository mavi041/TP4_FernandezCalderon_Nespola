SELECT med.nombre, pac.nombre, COUNT(*) AS cantidad 
FROM consultas con 
JOIN pacientes pac ON con.id_paciente = pac.id_paciente 
JOIN medicos med ON con.id_medico = med.id_medico 
GROUP BY med.nombre, pac.nombre 
ORDER BY med.nombre, pac.nombre;