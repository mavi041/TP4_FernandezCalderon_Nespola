-- Query 14
SELECT med.nombre, COUNT(*) AS cantidad 
FROM medicamentos med 
JOIN recetas rec ON med.id_medicamento = rec.id_medicamento 
GROUP BY med.nombre 
ORDER BY cantidad DESC 
LIMIT 1;