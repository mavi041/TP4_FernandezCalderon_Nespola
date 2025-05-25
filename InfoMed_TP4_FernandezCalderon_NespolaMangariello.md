# TP5 - Informática Médica

## Parte 1: Bases de Datos

### 1. ¿Qué tipo de base de datos es?

Según la estructura, es una base de datos relacional ya que se estructura en tablas con filas y columnas, con relaciones entre entidades (como pacientes, médicos, consultas, recetas, etc).

Según la función, es una base de datos transaccional u operativa debido a que su objetivo principal es registrar y gestionar datos operativos del día a día en un centro médico (pacientes atendidos, recetas, enfermedades, etc).


### 2. Diagrama entidad-relación

![Imagenes TP4/Modelo Lógico Diagrama.png](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Modelo%20Lo%CC%81gico%20Diagrama%20.png)



### 3. Modelo lógico entidad-relación

 <img width="1164" alt="Captura de pantalla 2025-05-24 a la(s) 20 57 10" src="https://github.com/user-attachments/assets/f1df1786-d5d1-4559-80f5-d73f16b765e5" />


### 4. ¿Está normalizada la base de datos?

La base de datos presentada se encuentra **parcialmente normalizada**. 

1.  La *Primera Forma Normal(1FN)* se cumple ya que todas las tablas tienen dominios atómicos (no hay campos multivaluados o repetidos)
), y poseen claves primarias bien definidas. 
2. La *Segunda Forma Normal (2FN)* también se cumple debido a que no existe dependencias parciales (todas las tablas con claves compuestas tienen sus atributos dependientes completamente de la clave).
3.  En la *Tercera Forma Normal (3FN)* se debe mejorar:
3.1 En la tabla pacientes, los campos ciudad, calle y número generan **redundancia y riesgo de inconsistencias**. Esto se puede ver en "Buenos Aires", "buenos aires", y " Buenos Aires" (están escritas de diferentes formas). Para solucionar esto, se debería crear una tabla "Direcciones" con id_direccion, calle, numero, ciudad y luego relacionarla con "Pacientes".
3.2 En la tabla médicos, el campo especialidad_id está bien normalizado, pero algunos teléfonos o correos podrían repetirse, auqneu eso ya no está muy vinculado con la normalización estricta. 
3.3 En la tabla consultas, el campo diagnóstico aparece ser un texto libre, pero el campo snomed_codigo parece tener un identificador estandarizado. Para solucionar esto, se debe crear una tabla Diagnosticos que tenga snomed_codigo, descripcion, etc, para evitar duplicación de conceptos con nombres distintos (ejemplo: "Depresión" vs "Depresión severa").

---

## Parte 2: SQL
### 1. Optimizar consultas por ciudad

```sql
CREATE INDEX idx_ciudad ON paciente(ciudad);
```

### 2. Calculo de la edad de los pacientes 
```sql
CREATE OR REPLACE VIEW vista_paciente_con_edad AS
SELECT
  id_paciente,
  nombre,
  fecha_nacimiento,
  EXTRACT(YEAR FROM age(current_date, fecha_nacimiento)) AS edad
FROM pacientes;
```
![Imagenes TP4/Query 2.png](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%202.png)

### 3. Actualización de la dirección de la paciente Luciana Gómez

```sql
UPDATE pacientes SET numero = '500', calle = 'Calle Corrientes', ciudad = 'Buenos Aires' WHERE nombre = 'Luciana Gómez' AND numero = '121' AND calle = 'Avenida Las Heras';
```
![Imagenes TP4/Query 3](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%203.png)

### 4. Seleccionar el nombre y la matrícula de cada médico cuya especialidad sea identificada por el id 4

```sql 
SELECT nombre, matricula FROM medicos WHERE especialidad_id = 4;
```
![Imagenes TP4/Query 4] (https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%204.png)


### 5. Query que arregle las inconsistencias en la forma en la que están escritos los nombres de las ciudades

```sql
SELECT DISTINCT ciudad FROM pacientes;
SET ciudad = TRIM(BOTH ' ' FROM LOWER(ciudad));

UPDATE pacientes SET ciudad = 'Buenos Aires' WHERE ciudad IN ('buenos aiers', 'buenos   aires', 'buenos aires');
UPDATE pacientes SET ciudad = 'Mendoza' WHERE ciudad IN ('mendoza', 'mendzoa');
UPDATE pacientes SET ciudad = 'Córdoba' WHERE ciudad IN ('córdoba', 'cordoba', 'córodba');
UPDATE pacientes SET ciudad = 'Santa Fe' WHERE ciudad = 'santa fe';
UPDATE pacientes SET ciudad = 'Rosario' WHERE ciudad = 'rosario';
```


### 6. Obtener nombre y dirección de los pacientes que viven en Buenos Aires

```sql 
SELECT nombre, calle, numero FROM pacientes WHERE ciudad = ‘Buenos Aires’;
```
![Imagenes TP4/Query 6.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%206.1.png)

### 7. Cantidad de pacientes que viven en cada ciudad
```sql
SELECT ciudad, COUNT(*) AS cantidad_pacientes 
FROM pacientes
GROUP BY ciudad;
```
![Imagenes TP4/Query 7.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%207.1.png) 

### 8. Cantidad de pacientes por sexo que viven en cada ciudad
``` sql
SELECT ciudad, id_sexo, COUNT(*) FROM pacientes
GROUP BY ciudad, id_sexo;
``` 
![Imagenes TP4/Query 8.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%208.1.png)
![Imagenes TP4/Query 8.2](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%208.2.png) 

### 9. Obtener la cantidad de recetas emitidas por cada médico
``` sql
SELECT med.nombre, COUNT(*) AS cantidad
FROM recetas rec JOIN medicos med ON rec.id_medico = med.id_medico
GROUP BY med.nombre;
```
![Imagenes TP4/Query 9.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%209.1.png)

### 10. Obtener todas las consultas médicas realizadas por el médico con ID igual a 3 durante el mes de agosto de 2024

```sql 
SELECT * FROM consultas
WHERE id_medico = 3 AND fecha BETWEEN ‘2024-08-01’ AND ‘2024-08-31’;
```

![Imagenes TP4/Query 10.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2010.1.png)

### 11. Obener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en agosto del 2024

``` sql 
SELECT pac.nombre, con.fecha, con.diagnostico 
FROM pacientes pac JOIN consultas con ON pac.id_paciente = con.id_paciente 
WHERE con.fecha BETWEEN '2024-08-01' AND '2024-08-31';
```
![Imagenes TP4/Query 11.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2011.1.png) 

### 12. Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2

``` sql 
SELECT med.nombre 
FROM recetas rec JOIN medicamentos med ON rec.id_medicamento = med.id_medicamento 
WHERE rec.id_medico = 2 
GROUP BY med.nombre 
HAVING COUNT(*) > 1;
```
![Imagenes TP4/Query 12.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2012.1.png)


### 13. Obtener el nombre de los pacientes junto con la cantidad total de recetas que han recibido

``` sql 
SELECT pac.nombre, COUNT(*) AS cantidad
FROM pacientes pac JOIN recetas rec ON pac.id_paciente = rec.id_paciente 
GROUP BY pac.nombre;
```
![Imagenes TP4/Query 13.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2013.1.png)

### 14. Obtener el nombre del medicamento más recetado junto con la cantidad de recetas emitidas para ese medicamento

``` sql
SELECT med.nombre, COUNT(*) AS cantidad 
FROM medicamentos med JOIN recetas rec ON med.id_medicamento = rec.id_medicamento 
GROUP BY med.nombre 
ORDER BY cantidad DESC 
LIMIT 1;
```
![Imagenes TP4/Query 14](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2014.png)

### 15. Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado

``` sql 
SELECT pac.nombre, con.fecha, con.diagnostico 
FROM pacientes pac JOIN consultas con ON pac.id_paciente = con.id_paciente 
GROUP BY pac.nombre, con.fecha, con.diagnostico 
ORDER BY con.fecha DESC 
LIMIT 1;
```
![Imagenes TP4/Query 15] (https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2015.png) 

### 16. Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente

```sql 
SELECT med.nombre, pac.nombre, COUNT(*) AS cantidad 
FROM consultas con JOIN pacientes pac ON con.id_paciente = pac.id_paciente JOIN medicos med ON con.id_medico = med.id_medico 
GROUP BY med.nombre, pac.nombre 
ORDER BY med.nombre, pac.nombre; 
```
![Imagenes TP4/Query 16.1](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2016.1.png)
![Imagenes TP4/Query 16.2](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2016.2.png)

### 17. Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente.

``` sql 
SELECT med.nombre, COUNT(*) AS cantidad, doc.nombre, pac.nombre 
FROM medicamentos med JOIN recetas rec ON med.id_medicamento = rec.id_medicamento JOIN medicos doc ON rec.id_medico = doc.id_medico JOIN pacientes pac ON rec.id_paciente = pac.id_paciente 
GROUP BY med.nombre, doc.nombre, pac.nombre 
ORDER BY cantidad DESC;
```
![Imagenes TP4/Query 17](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2017.png)

### 18. Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente.

``` sql 
SELECT med.nombre, COUNT(*) AS cantidad 
FROM medicos med JOIN consultas con ON med.id_medico = con.id_medico 
GROUP BY med.nombre 
ORDER BY cantidad DESC;
```
![Imagenes TP4/Query 18](https://github.com/mavi041/TP4_FernandezCalderon_Nespola/blob/main/Imagenes%20TP4/Query%2018.png)


