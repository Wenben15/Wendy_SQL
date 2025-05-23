use universidad;

INSERT INTO Estudiante (Nombre, Apellido, Correo, Carrera) VALUES
('Ana', 'López', 'ana.lopez@example.com', 'Ingeniería'),
('Carlos', 'Pérez', 'carlos.perez@example.com', 'Derecho'),
('Lucía', 'Martínez', 'lucia.martinez@example.com', 'Psicología');

INSERT INTO Profesor (Nombre, Apellido, Correo, Departamento) VALUES
('Roberto', 'Gómez', 'roberto.gomez@example.com', 'Ciencias Exactas'),
('María', 'Fernández', 'maria.fernandez@example.com', 'Humanidades');

INSERT INTO Materia (Nombre, Creditos, Departamento) VALUES
('Matemáticas I', 5, 'Ciencias Exactas'),
('Psicología General', 4, 'Humanidades');

INSERT INTO Grupo (ID_Materia, ID_Profesor, Semestre, Año) VALUES
(1, 1, '2024A', 2024),
(2, 2, '2024A', 2024);

INSERT INTO Inscripción (ID_Estudiante, ID_Grupo, Calificación) VALUES
(1, 1, 8.5),
(2, 1, 7.0),
(3, 2, 9.0);




