
-- VISTAS
use universidad;

CREATE OR REPLACE VIEW vw_ResumenInscripcion AS
SELECT
    e.nombre AS NombreEstudiante,
    e.apellido AS ApellidoEstudiante,
    m.nombre AS Materia,
    g.semestre,
    g.año,
    p.nombre AS NombreProfesor,
    p.apellido AS ApellidoProfesor,
    i.calificacion
FROM inscripcion i
JOIN estudiante e ON i.id_estudiante = e.id_estudiante
JOIN grupo g ON i.id_grupo = g.id_grupo
JOIN profesor p ON g.id_profesor = p.id_profesor
JOIN materia m ON g.id_materia = m.id_materia;

CREATE OR REPLACE VIEW vw_PromediosPorEstudiante AS
SELECT
    e.id_estudiante,
    e.nombre,
    e.apellido,
    AVG(i.calificacion) AS Promedio
FROM inscripcion i
JOIN estudiante e ON i.id_estudiante = e.id_estudiante
GROUP BY e.id_estudiante, e.nombre, e.apellido;

CREATE OR REPLACE VIEW vw_CargaDocente AS
SELECT
    p.id_profesor,
    p.nombre,
    p.apellido,
    m.nombre AS Materia,
    g.semestre,
    g.año
FROM grupo g
JOIN profesor p ON g.id_profesor = p.id_profesor
JOIN materia m ON g.id_materia = m.id_materia;

-- CAMBIAR DELIMITER PARA FUNCIONES Y PROCEDIMIENTOS

DELIMITER //

-- FUNCIONES
DELIMITER //

CREATE FUNCTION fn_PromedioEstudiante(estudiante_id INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(4,2);

    SELECT AVG(calificacion)
    INTO promedio
    FROM inscripcion
    WHERE id_estudiante = estudiante_id;

    RETURN promedio;
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION fn_TotalMateriasProfesor(profesor_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(DISTINCT id_materia)
    INTO total
    FROM grupo
    WHERE id_profesor = profesor_id;

    RETURN total;
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION fn_EstaReprobado(estudiante_id INT, grupo_id INT)
RETURNS TINYINT(1)
DETERMINISTIC
BEGIN
    DECLARE cal DECIMAL(4,2);

    SELECT calificacion
    INTO cal
    FROM inscripcion
    WHERE id_estudiante = estudiante_id AND id_grupo = grupo_id;

    RETURN cal < 6;
END //

DELIMITER ;


-- PROCEDIMIENTOS

DELIMITER //

CREATE PROCEDURE sp_RegistrarInscripcion(
    IN estudiante_id INT,
    IN grupo_id INT,
    IN nota DECIMAL(4,2)
)
BEGIN
    INSERT INTO inscripcion(id_estudiante, id_grupo, calificacion)
    VALUES (estudiante_id, grupo_id, nota);
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_ActualizarCalificacion(
    IN estudiante_id INT,
    IN grupo_id INT,
    IN nueva_calificacion DECIMAL(4,2)
)
BEGIN
    UPDATE inscripcion
    SET calificacion = nueva_calificacion
    WHERE id_estudiante = estudiante_id AND id_grupo = grupo_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_ReportarPromedios()
BEGIN
    SELECT e.carrera, AVG(i.calificacion) AS Promedio
    FROM inscripcion i
    JOIN estudiante e ON i.id_estudiante = e.id_estudiante
    GROUP BY e.carrera;
END //
DELIMITER ;
-- TRIGGERS

DELIMITER //
CREATE TRIGGER tr_ValidarCalificacionAntesDeInsertar
BEFORE INSERT ON inscripcion
FOR EACH ROW
BEGIN
    IF NEW.calificacion < 0 OR NEW.calificacion > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Calificación fuera de rango permitido (0-10)';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_ValidarCalificacionAntesDeActualizar
BEFORE UPDATE ON inscripcion
FOR EACH ROW
BEGIN
    IF NEW.calificacion < 0 OR NEW.calificacion > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Calificación fuera de rango permitido (0-10)';
    END IF;
END /
DELIMITER ;

