-- Query 13
SELECT pac.nombre, COUNT(*) AS cantidad
FROM pacientes pac 
JOIN recetas rec ON pac.id_paciente = rec.id_paciente 
GROUP BY pac.nombre;