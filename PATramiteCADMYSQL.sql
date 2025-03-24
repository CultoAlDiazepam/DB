USE BDTramitesCultoAlDiazepam;
DELIMITER $$

CREATE PROCEDURE ObtenerSolicitantes()
BEGIN
    SELECT DISTINCT s.idS, s.nombresS
    FROM tSolicitante s
    JOIN tTramite t ON s.idS = t.idS
    JOIN tRecibo_Tramite r ON t.idT = r.idT;
END$$

DELIMITER ;
CALL ObtenerSolicitantes();

-- ----------------------
DELIMITER $$

CREATE PROCEDURE ObtenerConceptos()
BEGIN
    SELECT DISTINCT c.idC, c.denominacionC
    FROM tconcepto c
    JOIN trecibo r ON c.idC = r.idC;
END$$

DELIMITER ;
CALL ObtenerConceptos();
-- -------------------------
DELIMITER $$

CREATE PROCEDURE ObtenerOficinas()
BEGIN
    SELECT DISTINCT o.idO, o.denominacionO
    FROM toficina o
    JOIN ttramite t ON o.idO = t.idO;
END$$

DELIMITER ;
CALL ObtenerOficinas();
-- ------------------------------
DELIMITER $$

CREATE PROCEDURE ObtenerOficinasConTramites()
BEGIN
    SELECT DISTINCT o.idO, o.denominacionO
    FROM toficina o
    JOIN ttramite t ON o.idO = t.idO
    JOIN tRecibo_Tramite r ON t.idT = r.idT;
END$$

DELIMITER ;
CALL ObtenerOficinasConTramites();
-- -------------------------------------
DELIMITER $$

CREATE PROCEDURE ObtenerConceptosSinRecibo()
BEGIN
    SELECT c.idC, c.denominacionC
    FROM tconcepto c
    LEFT JOIN trecibo r ON c.idC = r.idC
    WHERE r.idC IS NULL;
END$$

DELIMITER ;
CALL ObtenerConceptosSinRecibo()