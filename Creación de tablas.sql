create database Universidad;
use Universidad;

CREATE TABLE estudiante (
id_estudiante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (100) NOT NULL,
apellido VARCHAR (100) NOT NULL,
correo VARCHAR (100) NOT NULL,
carrera VARCHAR (100) NOT NULL
);

CREATE TABLE profesor (
id_profesor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (100) NOT NULL,
apellido VARCHAR (100) NOT NULL,
correo VARCHAR (100) NOT NULL,
departamento VARCHAR (100) NOT NULL
);

CREATE TABLE materia (
id_materia INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (100) NOT NULL,
creditos INT NOT NULL,
departamento VARCHAR (100) NOT NULL
);


CREATE TABLE grupo (
id_grupo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_materia INT,
id_profesor INT,
semestre VARCHAR (10),
año INT,
FOREIGN KEY (id_materia) REFERENCES materia (id_materia),
FOREIGN KEY (id_profesor) REFERENCES profesor (id_profesor)
);

CREATE TABLE inscripcion (
id_inscripcion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_estudiante INT NOT NULL,
id_grupo INT NOT NULL, 
calificacion DECIMAL (4,2),
FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante),
FOREIGN KEY (id_grupo) REFERENCES grupo (id_grupo)
);