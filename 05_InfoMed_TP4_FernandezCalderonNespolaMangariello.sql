-- Ejercicio 5
SELECT DISTINCT ciudad FROM pacientes;

-- Para limpieza de datos (puede requerir adaptaciones)
UPDATE pacientes SET ciudad = TRIM(BOTH ' ' FROM LOWER(ciudad));

UPDATE pacientes SET ciudad = 'Buenos Aires' WHERE ciudad IN ('buenos aiers', 'buenos   aires', 'buenos aires');
UPDATE pacientes SET ciudad = 'Mendoza' WHERE ciudad IN ('mendoza', 'mendzoa');
UPDATE pacientes SET ciudad = 'Córdoba' WHERE ciudad IN ('córdoba', 'cordoba', 'córodba');
UPDATE pacientes SET ciudad = 'Santa Fe' WHERE ciudad = 'santa fe';
UPDATE pacientes SET ciudad = 'Rosario' WHERE ciudad = 'rosario';
