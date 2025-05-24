SELECT med.nombre, COUNT(*) AS cantidad 
FROM medicos med 
JOIN consultas con ON med.id_medico = con.id_medico 
GROUP BY med.nombre 
ORDER BY cantidad DESC;