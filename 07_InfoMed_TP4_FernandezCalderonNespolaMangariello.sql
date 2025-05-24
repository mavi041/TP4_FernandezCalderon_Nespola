-- Ejercicio 7
SELECT ciudad, COUNT(*) AS cantidad_pacientes 
FROM pacientes
GROUP BY ciudad;
