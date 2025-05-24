-- Ejercicio 2
CREATE OR REPLACE VIEW vista_paciente_con_edad AS
SELECT
  id_paciente,
  nombre,
  fecha_nacimiento,
  EXTRACT(YEAR FROM age(current_date, fecha_nacimiento)) AS edad
FROM pacientes;
