SELECT med.nombre, COUNT(*) AS cantidad, doc.nombre, pac.nombre 
FROM medicamentos med 
JOIN recetas rec ON med.id_medicamento = rec.id_medicamento 
JOIN medicos doc ON rec.id_medico = doc.id_medico 
JOIN pacientes pac ON rec.id_paciente = pac.id_paciente 
GROUP BY med.nombre, doc.nombre, pac.nombre 
ORDER BY cantidad DESC;