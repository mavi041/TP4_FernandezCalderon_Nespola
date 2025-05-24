-- Query 11
SELECT pac.nombre, con.fecha, con.diagnostico 
FROM pacientes pac 
JOIN consultas con ON pac.id_paciente = con.id_paciente 
WHERE con.fecha BETWEEN '2024-08-01' AND '2024-08-31';