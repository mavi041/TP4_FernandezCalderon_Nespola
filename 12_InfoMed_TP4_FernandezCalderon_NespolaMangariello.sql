-- Query 12
SELECT med.nombre 
FROM recetas rec 
JOIN medicamentos med ON rec.id_medicamento = med.id_medicamento 
WHERE rec.id_medico = 2 
GROUP BY med.nombre 
HAVING COUNT(*) > 1;