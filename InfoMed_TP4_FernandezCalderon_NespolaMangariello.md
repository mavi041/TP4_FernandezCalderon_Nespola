# TP5 - Informática Médica

## Parte 1: Bases de Datos

### 1. ¿Qué tipo de base de datos es?

Según la estructura, es una base de datos relacional ya que se estructura en tablas con filas y columnas, con relaciones entre entidades (como pacientes, médicos, consultas, recetas, etc).

Según la función, es una base de datos transaccional u operativa debido a que su objetivo principal es registrar y gestionar datos operativos del día a día en un centro médico (pacientes atendidos, recetas, enfermedades, etc).


### 2. Diagrama entidad-relación

(Insertá la imagen del diagrama que creaste)


### 3. Modelo lógico entidad-relación

![Modelo lógico.png]


### 4. ¿Está normalizada la base de datos?

La base de datos presentada se encuentra **parcialmente normalizada**. 

1.  La *Primera Forma Normal(1FN)* se cumple ya que todas las tablas tienen dominios atómicos (no hay campos multivaluados o repetidos)
), y poseen claves primarias bien definidas. 
2. La *Segunda Forma Normal (2FN)* también se cumple debido a que no existe dependencias parciales (todas las tablas con claves compuestas tienen sus atributos dependientes completamente de la clave).
3.  En la *Tercera Forma Normal (3FN)* se debe mejorar:
3.1 En la tabla pacientes, los campos ciudad, calle y número generan **redundancia y riesgo de inconsistencias**. Esto se puede ver en "Buenos Aires", "buenos aires", y " Buenos Aires" (están escritas de diferentes formas). Para solucionar esto, se debería crear una tabla "Direcciones" con id_direccion, calle, numero, ciudad y luego relacionarla con "Pacientes".
3.2 En la tabla médicos, el campo especialidad_id está bien normalizado, pero algunos teléfonos o correos podrían repetirse, auqneu eso ya no está muy vinculado con la normalización estricta. 
3.3 En la tabla consultas, el campo diagnóstico aparece ser un texto libre, pero el campo snomed_codigo parece tener un identificador estandarizado. Para solucionar esto, se debe crear una tabla Diagnosticos que tenga snomed_codigo, descripcion, etc, para evitar duplicación de conceptos con nombres distintos (ejemplo: "Depresión" vs "Depresión severa"). <img width="1164" alt="Captura de pantalla 2025-05-24 a la(s) 20 57 10" src="https://github.com/user-attachments/assets/f1df1786-d5d1-4559-80f5-d73f16b765e5" />
