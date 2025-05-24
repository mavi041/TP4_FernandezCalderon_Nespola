-- Query 15
SELECT pac.nombre, con.fecha, con.diagnostico 
FROM pacientes pac 
JOIN consultas con ON pac.id_paciente = con.id_paciente 
GROUP BY pac.nombre, con.fecha, con.diagnostico 
ORDER BY con.fecha DESC 
LIMIT 1;