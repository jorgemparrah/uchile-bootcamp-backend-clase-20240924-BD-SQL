/*
En una universidad, existen diversos departamentos encargados de áreas específicas del conocimiento,
como Matemáticas, Física, Informática, Historia, entre otros.
Cada departamento ofrece varios cursos que los estudiantes pueden tomar para avanzar ensus estudios.
Los profesores forman parte de estos departamentos y son los responsables de impartir los cursos.
Un profesor puede enseñar varios cursos y, a su vez, un curso puede ser impartido por
más de un profesor en diferentes semestres.
Los estudiantes se matriculan en la universidad y se inscriben en los cursos que les interesan
o que necesitan para completar su programa académico.
A medida que completan los cursos, reciben calificaciones que reflejan su desempeño.
Además, la universidad mantiene registros detallados de la información personal de los estudiantes
y profesores, como datos de contacto y antecedentes académicos.
Esto permite una gestión eficiente y un seguimiento adecuado del progreso académico y
profesional dentro de la institución.
*/

-- Crear la base de datos
CREATE DATABASE Universidad;
-- CREATE SCHEMA universidad; PARA POSTGRES
USE Universidad; -- NO FUNCIONA EN POSTGRES

-- Crear la tabla de Departamentos
CREATE TABLE Departamentos (
    departamento_id INT AUTO_INCREMENT PRIMARY KEY, -- INT AUTO_INCREMENT NO FUNCIONA EN POSTGRES CAMBIAR POR SERIAL
    nombre VARCHAR(100) NOT NULL,
    edificio VARCHAR(100)
);

-- Insertar datos en Departamentos
INSERT INTO Departamentos (nombre, edificio) VALUES
('Matemáticas', 'Edificio A'),
('Física', 'Edificio B'),
('Informática', 'Edificio C'),
('Química', 'Edificio D'),
('Biología', 'Edificio E'),
('Historia', 'Edificio F'),
('Literatura', 'Edificio G'),
('Economía', 'Edificio H');

-- Crear la tabla de Profesores
CREATE TABLE Profesores (
    profesor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    departamento_id INT,
    salario DECIMAL(10,2),
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(departamento_id)
);

-- Insertar datos en Profesores
INSERT INTO Profesores (nombre, apellido, email, departamento_id, salario) VALUES
('Juan', 'Pérez', 'jperez@example.com', 1, 50000),
('María', 'García', 'mgarcia@example.com', 2, 55000),
('Carlos', 'López', 'clopez@example.com', 3, 60000),
('Laura', 'Sánchez', 'lsanchez@example.com', 4, 52000),
('Miguel', 'Torres', 'mtorres@example.com', 5, 51000),
('Lucía', 'Ramírez', 'lramirez@example.com', 6, 48000),
('Antonio', 'Flores', 'aflores@example.com', 7, 47000),
('Elena', 'Moreno', 'emoreno@example.com', 8, 53000),
('David', 'Gil', 'dgil@example.com', 3, 62000),
('Sofía', 'Hernández', 'shernandez@example.com', 2, 58000);

-- Crear la tabla de Cursos
CREATE TABLE Cursos (
    curso_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    departamento_id INT,
    créditos INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(departamento_id)
);

-- Insertar datos en Cursos
INSERT INTO Cursos (nombre, departamento_id, créditos) VALUES
('Álgebra Lineal', 1, 5),
('Cálculo Diferencial', 1, 4),
('Física Cuántica', 2, 6),
('Termodinámica', 2, 5),
('Programación', 3, 5),
('Bases de Datos', 3, 4),
('Química Orgánica', 4, 5),
('Biología Molecular', 5, 6),
('Historia Moderna', 6, 4),
('Literatura Clásica', 7, 3),
('Macroeconomía', 8, 5),
('Microeconomía', 8, 5);

-- Crear la tabla intermedia Curso_Profesores (muchos a muchos entre Cursos y Profesores)
CREATE TABLE Curso_Profesores (
    curso_id INT,
    profesor_id INT,
    semestre VARCHAR(20),
    PRIMARY KEY (curso_id, profesor_id, semestre),
    FOREIGN KEY (curso_id) REFERENCES Cursos(curso_id),
    FOREIGN KEY (profesor_id) REFERENCES Profesores(profesor_id)
);

-- Insertar datos en Curso_Profesores
INSERT INTO Curso_Profesores (curso_id, profesor_id, semestre) VALUES
(1, 1, '2023-1'),
(2, 1, '2023-2'),
(3, 2, '2023-1'),
(4, 2, '2023-2'),
(5, 3, '2023-1'),
(6, 9, '2023-1'),
(7, 4, '2023-1'),
(8, 5, '2023-2'),
(9, 6, '2023-1'),
(10, 7, '2023-2'),
(11, 8, '2023-1'),
(12, 8, '2023-2'),
(5, 9, '2023-2'),
(3, 10, '2023-2'),
(2, 10, '2023-1');

-- Crear la tabla de Estudiantes
CREATE TABLE Estudiantes (
    estudiante_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    fecha_ingreso DATE
);

-- Insertar datos en Estudiantes
INSERT INTO Estudiantes (nombre, apellido, email, fecha_ingreso) VALUES
('Ana', 'Martínez', 'amartinez@example.com', '2020-08-15'),
('Luis', 'Rodríguez', 'lrodriguez@example.com', '2019-08-20'),
('Elena', 'Gómez', 'egomez@example.com', '2021-01-10'),
('Jorge', 'Díaz', 'jdiaz@example.com', '2020-08-15'),
('Sara', 'Fernández', 'sfernandez@example.com', '2019-08-20'),
('Diego', 'Vargas', 'dvargas@example.com', '2021-01-10'),
('Marta', 'Cruz', 'mcruz@example.com', '2018-08-15'),
('Raúl', 'Herrera', 'rherrera@example.com', '2017-08-20'),
('Laura', 'Ruiz', 'lruiz@example.com', '2021-01-10'),
('Andrés', 'Molina', 'amolina@example.com', '2018-08-15');

-- Crear la tabla de Detalles_Estudiantes (uno a uno con Estudiantes)
CREATE TABLE Detalles_Estudiantes (
    estudiante_id INT PRIMARY KEY,
    fecha_nacimiento DATE,
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    FOREIGN KEY (estudiante_id) REFERENCES Estudiantes(estudiante_id)
);

-- Insertar datos en Detalles_Estudiantes
INSERT INTO Detalles_Estudiantes (estudiante_id, fecha_nacimiento, direccion, ciudad) VALUES
(1, '2000-05-15', 'Calle Falsa 123', 'Madrid'),
(2, '1999-08-22', 'Avenida Siempre Viva 742', 'Barcelona'),
(3, '2001-12-02', 'Boulevard de los Sueños Rotos 456', 'Valencia'),
(4, '2000-03-30', 'Calle Luna 789', 'Sevilla'),
(5, '2001-07-14', 'Calle Sol 321', 'Bilbao'),
(6, '1998-11-25', 'Calle Estrella 654', 'Granada'),
(7, '1997-09-18', 'Calle Nube 987', 'Zaragoza'),
(8, '1996-02-28', 'Avenida Mar 135', 'Málaga'),
(9, '2002-06-05', 'Paseo del Río 246', 'Murcia'),
(10, '1998-10-12', 'Plaza Mayor 369', 'Valladolid');

-- Crear la tabla de Inscripciones (muchos a muchos entre Estudiantes y Cursos, con clave compuesta)
CREATE TABLE Inscripciones (
    estudiante_id INT,
    curso_id INT,
    fecha_inscripcion DATE,
    nota DECIMAL(4,2),
    PRIMARY KEY (estudiante_id, curso_id),
    FOREIGN KEY (estudiante_id) REFERENCES Estudiantes(estudiante_id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(curso_id)
);

-- Insertar datos en Inscripciones
INSERT INTO Inscripciones (estudiante_id, curso_id, fecha_inscripcion, nota) VALUES
(1, 1, '2023-01-10', 8.5),
(1, 3, '2023-01-10', 7.0),
(1, 5, '2023-01-10', 9.0),
(2, 1, '2023-01-11', 6.5),
(2, 2, '2023-01-11', 7.5),
(2, 6, '2023-01-11', 8.0),
(3, 5, '2023-01-12', 7.5),
(3, 6, '2023-01-12', 9.0),
(4, 4, '2023-01-13', 6.0),
(4, 7, '2023-01-13', 7.0),
(5, 7, '2023-01-14', 8.0),
(5, 8, '2023-01-14', 8.5),
(6, 2, '2023-01-15', 9.0),
(6, 9, '2023-01-15', 7.5),
(7, 9, '2023-01-16', 8.0),
(7, 10, '2023-01-16', 6.5),
(8, 11, '2023-01-17', 7.0),
(8, 12, '2023-01-17', 7.5),
(9, 3, '2023-01-18', 8.5),
(9, 4, '2023-01-18', 9.0),
(10, 5, '2023-01-19', 6.0),
(10, 12, '2023-01-19', 7.0);

-- Fin del script

-- EJEMPLO GROUP BY

-- CUANTOS PROFESORES DICTAN CADA CURSO
SELECT curso_id, COUNT(profesor_id) as nro_profesores
FROM Curso_Profesores cp
GROUP BY curso_id;

-- CUANTOS CURSOS DICTA CADA PROFESOR
SELECT profesor_id, COUNT(curso_id)
FROM Curso_Profesores cp
GROUP BY profesor_id;


-- JOIN

-- INNER JOIN
SELECT * FROM Departamentos d
INNER JOIN Profesores p
ON d.departamento_id = p.departamento_id
ORDER BY d.departamento_id;

-- LEFT JOIN
SELECT * FROM Departamentos d
LEFT JOIN Profesores p
ON d.departamento_id = p.departamento_id
ORDER BY d.departamento_id;

-- RIGHT JOIN
SELECT * FROM Departamentos d
RIGHT JOIN Profesores p
ON d.departamento_id = p.departamento_id
ORDER BY d.departamento_id;

-- IS NULL o IS NOT NULL
SELECT * FROM Profesores p
WHERE p.departamento_id IS NOT NULL;

SELECT * FROM Profesores p
WHERE p.departamento_id IS NULL;

-- Cuanto paga cada departamento a los profesores por los cursos
SELECT d.departamento_id, d.nombre, SUM(p.salario) FROM Departamentos d
INNER JOIN Profesores p
ON d.departamento_id = p.departamento_id
INNER JOIN Curso_Profesores cp
ON cp.profesor_id = p.profesor_id
INNER JOIN Cursos c
ON cp.curso_id = c.curso_id
GROUP BY d.departamento_id, d.nombre
ORDER BY d.departamento_id;

-- SUBCONSULTAS
SELECT MAX(salario) FROM Profesores p; -- VALOR
SELECT profesor_id FROM Profesores p; -- LISTA
SELECT * FROM Profesores p; -- TABLA

-- SUBCONSULTA COMO VALOR
SELECT * FROM Profesores p 
WHERE p.salario = (SELECT MAX(salario) FROM Profesores p);

-- SUBCONSULTA COMO LISTA
SELECT * FROM Departamentos d 
WHERE d.departamento_id IN (SELECT departamento_id FROM Profesores p WHERE salario < 50000);

-- SUBCONSULTA COMO TABLA
SELECT * FROM (SELECT * FROM Profesores p WHERE salario > (SELECT AVG(salario) FROM Profesores p)) ps
INNER JOIN Departamentos d
ON d.departamento_id = ps.departamento_id;

-- Seleccionar todos los registros de la tabla Estudiantes.
SELECT * FROM Estudiantes;

-- Mostrar los nombre y apellido de todos los profesores.
SELECT nombre, apellido FROM Profesores;

-- Listar los cursos que tienen más de 4 créditos.
-- Obtener los estudiantes que ingresaron en 2020 y viven en "Madrid".
SELECT * FROM Estudiantes e
INNER JOIN Detalles_Estudiantes de
ON e.estudiante_id = de.estudiante_id
WHERE ciudad = 'Madrid'
AND DATE_FORMAT(e.fecha_ingreso, '%Y') = '2020';

-- Mostrar los departamentos que están en el "Edificio A" o "Edificio B".
-- Seleccionar profesores con un salario mayor o igual a 55000.
-- Encontrar el curso con el nombre "Programación".
-- Listar los cursos con créditos entre 4 y 6.
SELECT * FROM Cursos WHERE créditos >= 4 AND créditos <= 6;

-- Mostrar estudiantes que no tienen email registrado.
-- Ordenar los estudiantes por apellido ascendente.
-- Encontrar profesores cuyos nombres comienzan con 'L'.
-- Listar cursos que contienen la palabra "Economía" en su nombre.
-- Seleccionar estudiantes que viven en las ciudades "Madrid", "Barcelona" o "Valencia".
-- Mostrar profesores ordenados por departamento_id y luego por salario descendente.
-- Obtener los primeros 5 estudiantes más recientes según fecha_ingreso.
SELECT * FROM Estudiantes e ORDER BY fecha_ingreso DESC LIMIT 10;

-- Listar las ciudades únicas donde residen los estudiantes.
-- Mostrar cursos que son del departamento de Informática o Matemáticas y tienen más de 5 créditos.
-- Usar alias de columna y tabla para seleccionar e.nombre y e.apellido de la tabla Estudiantes con alias 'e'.
-- Mostrar el nombre, apellido y el salario anual incrementado en un 10% de los profesores.
SELECT p.*, (p.salario * 12) as salario_anual, (p.salario * 12 * 1.10) as salario_anual_incrementado FROM Profesores p;

-- Obtener el año de ingreso de todos los estudiantes.
-- Contar el número total de cursos ofrecidos.
-- Obtener el salario promedio de los profesores.
-- Determinar el salario máximo y mínimo entre los profesores.
-- Calcular el total de créditos de todos los cursos.
-- Mostrar el número de profesores por departamento.
-- Mostrar departamentos con más de 2 profesores.
-- Listar los cursos agrupados por departamento y ordenados por número de créditos descendente.
-- Calcular el promedio de notas en el curso de "Álgebra Lineal".
-- Contar cuántas ciudades distintas hay en la tabla Detalles_Estudiantes.
-- Obtener el número de inscripciones por curso y semestre.
-- Seleccionar profesores que pertenecen al departamento con nombre "Física".
-- CON SUBCONSULTA
SELECT * FROM Profesores p
WHERE p.departamento_id IN (SELECT departamento_id as id FROM Departamentos d
WHERE d.nombre = 'Física');

-- CON JOIN
SELECT p.* FROM Profesores p 
INNER JOIN Departamentos d 
ON p.departamento_id = d.departamento_id
WHERE d.nombre = 'Física';

-- Mostrar el nombre de cada curso y el número de estudiantes inscritos en él.
-- Listar estudiantes cuya nota es superior al promedio de notas en su curso.
-- Obtener los nombres de los estudiantes y los cursos en los que están inscritos.
-- Mostrar todos los cursos y los profesores que los imparten.
-- Listar todos los profesores y los cursos que imparten.
-- Obtener el nombre del estudiante, el curso y el profesor que imparte el curso.
-- Calcular el promedio de notas por curso y mostrar el nombre del curso.
SELECT c.curso_id as id, c.nombre, prom.promedio
FROM (SELECT curso_id, AVG(i.nota) as promedio FROM Inscripciones i  GROUP BY i.curso_id) prom
INNER JOIN Cursos c ON prom.curso_id = c.curso_id;

-- Actualizar el salario de los profesores del departamento de Física incrementándolo en un 5%.
-- Incrementar en un 5% el salario de los profesores que imparten cursos en más de un departamento.
-- Eliminar inscripciones de estudiantes que hayan reprobado más de dos cursos.
-- Listar los estudiantes que han obtenido una nota mayor a 8 en "Programación".
-- Mostrar los cursos que no tienen estudiantes inscritos.
-- Encontrar los profesores que no imparten ningún curso.
-- Listar los estudiantes y su edad calculada a partir de la fecha de nacimiento.
-- Mostrar el salario total que paga cada departamento a sus profesores.
-- Encontrar los estudiantes que están inscritos en todos los cursos del departamento de Matemáticas.
-- Listar los cursos que son impartidos por más de un profesor.
-- Obtener los profesores que imparten el mayor número de cursos.
-- Calcular la nota promedio de cada estudiante en todos los cursos que ha tomado.