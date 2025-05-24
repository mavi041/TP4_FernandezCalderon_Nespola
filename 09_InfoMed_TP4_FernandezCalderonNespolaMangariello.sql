-- Ejercicio 9
SELECT med.nombre, COUNT(*) AS cantidad
FROM recetas rec JOIN medicos med ON rec.id_medico = med.id_medico
GROUP BY med.nombre;
