-- Ejercicio 8.1
SELECT ciudad, id_sexo, COUNT(*) FROM pacientes
GROUP BY ciudad, id_sexo;

-- Ejercicio 8.2
SELECT pac.ciudad, sex.descripcion, COUNT(*) AS cantidad
FROM pacientes pac JOIN sexobiologico sex ON pac.id_sexo = sex.id_sexo
GROUP BY pac.ciudad, sex.descripcion;
