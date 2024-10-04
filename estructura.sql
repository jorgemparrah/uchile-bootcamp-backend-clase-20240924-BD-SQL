CREATE DATABASE `ejemplo`;

USE `ejemplo`;

CREATE TABLE `departamentos` (
  `id` INTEGER PRIMARY KEY,
  `area` VARCHAR(40)
);

CREATE TABLE `cursos` (
  `id` INTEGER PRIMARY KEY,
  `nombre` VARCHAR(40),
  `id_departamento` INTEGER
);

CREATE TABLE `estudiantes` (
  `rut` VARCHAR(10) PRIMARY KEY,
  `nombre_completo` VARCHAR(100),
  `fecha_nacimiento` TIMESTAMP,
  `direccion` VARCHAR(100),
  `telefonos` VARCHAR(50)
);

CREATE TABLE `calificaciones` (
  `rut_estudiante` VARCHAR(10),
  `id_curso` INTEGER,
  `semestre` VARCHAR(6),
  `calificacion` INTEGER,
  PRIMARY KEY (`rut_estudiante`, `id_curso`, `semestre`)
);

CREATE TABLE `profesores` (
  `rut` VARCHAR(10) PRIMARY KEY,
  `nombres` VARCHAR(30),
  `apellidos` VARCHAR(30),
  `direccion` VARCHAR(100),
  `telefonos` VARCHAR(50),
  `id_departamento` INTEGER
);

CREATE TABLE `profesor_curso` (
  `rut_profesor` VARCHAR(10),
  `id_curso` INTEGER,
  `semestre` VARCHAR(6) COMMENT 'El semestre estaba en otra entidad',
  PRIMARY KEY (`rut_profesor`, `id_curso`, `semestre`)
);

ALTER TABLE `cursos` ADD FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id`);

ALTER TABLE `calificaciones` ADD FOREIGN KEY (`rut_estudiante`) REFERENCES `estudiantes` (`rut`);

ALTER TABLE `calificaciones` ADD FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`);

ALTER TABLE `profesor_curso` ADD FOREIGN KEY (`rut_profesor`) REFERENCES `profesores` (`rut`);

ALTER TABLE `profesor_curso` ADD FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`);

ALTER TABLE `profesores` ADD FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id`);
