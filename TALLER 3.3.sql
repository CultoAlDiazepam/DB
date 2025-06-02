-- Asegúrate de que estás en el contexto de la base de datos master o ninguna para crearla
-- USE master;
-- GO
-- DROP DATABASE IF EXISTS baseTramites; -- Opcional: si quieres empezar de cero cada vez
-- GO

CREATE DATABASE baseTramites;
GO

USE baseTramites;
GO

CREATE TABLE tSolicitante
(
    idS VARCHAR(4) NOT NULL,
    tipoS VARCHAR(7),
    tipoDocumS VARCHAR(7),
    nroDocumS VARCHAR(15),
    paternoS VARCHAR(50),
    maternoS VARCHAR(50),
    nombresS VARCHAR(50),
    razonSocialS VARCHAR(50),
    celularS VARCHAR(15),
    telefonoS VARCHAR(15),
    dirElectronS VARCHAR(50),
    PRIMARY KEY (idS)
);
GO

INSERT INTO tSolicitante
VALUES('S001','EST', 'carnet','123016101J', 'Torres', 'Loza','Boris', NULL, '911111111','51-84-221111','123016101J@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S002','EST','carnet','123015100A', 'Pérez','Sánchez','José', NULL, '922222222','51-84-222222','123015100A@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S003','EST','carnet','123014200D', 'Arenas','Campos','Raul', NULL, '933333333','51-84-223333','123014200D@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S004','EST','carnet','123015300F', 'Maldonado', 'Rojas','Jorge', NULL, '944444444','51-84-224444','123015300F@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S005','EST', 'carnet','123015300B', 'Salinas','Valle','Daniel',NULL, '955555555','51-84-225555','123015300B@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S006', 'PROF', 'DNI', '01111110', 'Palomino','Cahuaya', 'Ariadna', NULL, '966666666','51-84-226666', 'apalominoc@uandina.edu');
INSERT INTO tSolicitante
VALUES('S007', 'PROF', 'DNI', '02222220', 'Espetia','Humanga', 'Hugo', NULL, '977777777','51-84-227777', 'hespetia@uandina.edu.pe'); -- Asumo que querías un número de celular diferente y correo con .pe para este
GO


CREATE TABLE tOficina
(
    idO VARCHAR(4) NOT NULL,
    denominacionO VARCHAR(50),
    ubicacionO VARCHAR(50),
    responsableO VARCHAR(50),
    PRIMARY KEY (idO)
);
GO

INSERT INTO tOficina
VALUES('O001','Rectorado', 'AG-101 Larapa','Zambrano Ramos, Juan');
INSERT INTO tOficina
VALUES('O002','Dirección de Tecnologías de Información', 'ING-205 Larapa', 'Torres Campos, César');
INSERT INTO tOficina
VALUES('O003','Dirección del D.A. de Ingeniería de Sistemas', 'ING-211 Larapa', 'Zamalloa Campos, Gino');
INSERT INTO tOficina
VALUES('O004','Tesorería', 'E-301 Módulo de entrada - Larapa','Ramírez Tapia, Nohelia');
INSERT INTO tOficina
VALUES('O005','RRHH', 'Sótano del Paraninfo - Larapa','Martínez Salazar, Dante');
INSERT INTO tOficina
VALUES('O006', 'Decanatura de Ingeniería', 'ING-214 - Larapa', 'Gamarra Miranda, Javier');
GO


CREATE TABLE tConcepto
(
    idC VARCHAR(4) NOT NULL,
    denominacionC VARCHAR(50),
    costoC DECIMAL(10,2),
    PRIMARY KEY (idC)
);
GO

INSERT INTO tConcepto
VALUES('C001','Convalidación de sílabos',9);
INSERT INTO tConcepto
VALUES('C002','Constancia de seguimiento de estudios',20);
INSERT INTO tConcepto
VALUES('C003','Certificado de estudios',30);
INSERT INTO tConcepto
VALUES('C004', 'Bachillerato I.S.',750);
INSERT INTO tConcepto
VALUES('C005', 'Trámite',10);
INSERT INTO tConcepto
VALUES('C006', 'Carta de presentación para prácticas',12);
INSERT INTO tConcepto
VALUES('C007', 'Título de Ingeniero de Sistemas',900);
GO

CREATE TABLE tRecibo
(
    idR VARCHAR(4) NOT NULL,
    fechaHoraR DATETIME,
    cantidadR INT,
    totalR DECIMAL(10,2),
    idC VARCHAR(4),
    PRIMARY KEY (idR),
    FOREIGN KEY (idC) REFERENCES tConcepto(idC),
    idS VARCHAR(4),
    FOREIGN KEY (idS) REFERENCES tSolicitante(idS)
);
GO

-- Fechas cambiadas a formato YYYY-MM-DD HH:MM:SS
INSERT INTO tRecibo
VALUES('R002','2017-06-27 11:30:00',9,NULL, 'C001', 'S001');
INSERT INTO tRecibo
VALUES('R003', '2017-07-25 12:30:00',1,NULL, 'C002', 'S002');
INSERT INTO tRecibo
VALUES('R004', '2017-07-26 09:45:00',1,NULL, 'C003', 'S003');
INSERT INTO tRecibo
VALUES('R005', '2017-08-01 09:55:00',1,NULL, 'C004', 'S004');
INSERT INTO tRecibo
VALUES('R006','2017-08-03 09:56:00',1,NULL, 'C005', 'S004');
INSERT INTO tRecibo
VALUES('R007', '2017-08-04 12:00:00',1,NULL, 'C006', 'S005');
GO

CREATE TABLE tTramite
(
    idT VARCHAR(4) NOT NULL,
    fechaHoraT DATETIME,
    nombreT VARCHAR(70),
    cantidadFoliosT INT,
    idS VARCHAR(4),
    PRIMARY KEY (idT),
    FOREIGN KEY (idS) REFERENCES tSolicitante(idS),
    idO VARCHAR(4),
    FOREIGN KEY (idO) REFERENCES tOficina(idO)
);
GO

CREATE TABLE tRecibo_Tramite
(
    idRT VARCHAR(4) NOT NULL,
    PRIMARY KEY (idRT),
    idT VARCHAR(4),
    FOREIGN KEY (idT) REFERENCES tTramite(idT),
    idR VARCHAR(4),
    FOREIGN KEY (idR) REFERENCES tRecibo(idR)
);
GO

-- Fechas cambiadas a formato YYYY-MM-DD HH:MM:SS
INSERT INTO tTramite
VALUES('T001','2027-06-25 10:15:00', 'Licencia por 2 días',2,'S006','O005');
INSERT INTO tTramite
VALUES('T002','2017-06-27 12:00:00', 'Convalidación de sílabos de I.S.',2,'S001','O006');
INSERT INTO tTramite
VALUES('T003','2017-07-25 12:50:00', 'Constancia de seg. estudios',2,'S002','O006');
INSERT INTO tTramite
VALUES('T004','2017-07-26 10:00:00', 'Certificado de estudios del 2017-I',2,'S003','O006');
INSERT INTO tTramite
VALUES('T005','2017-08-01 10:05:00', 'Bachillerato',11,'S004','O006');
INSERT INTO tTramite
VALUES('T006','2017-08-03 12:30:00', 'Carta presentación práct EGEMSA 1-sep al 1 mar 2017', 2,'S005','O006');
INSERT INTO tTramite
VALUES('T007','2017-08-04 08:30:00', 'Permiso por salud 5 días',2,'S007','O005');
GO

INSERT INTO tRecibo_Tramite
VALUES('RT01','T002','R002');
INSERT INTO tRecibo_Tramite
VALUES('RT02','T003','R003');
INSERT INTO tRecibo_Tramite
VALUES('RT03','T004','R004');
INSERT INTO tRecibo_Tramite
VALUES('RT04','T005','R005');
INSERT INTO tRecibo_Tramite
VALUES('RT05','T005','R006');
INSERT INTO tRecibo_Tramite
VALUES('RT06','T006','R007');
GO

SELECT * FROM tRecibo;
GO
------------------------------------------------------Crear un trigger para calcular automáticamente el totalR en tRecibo.
CREATE TRIGGER d_calcular_total_recibo
ON tRecibo
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tRecibo (idR, fechaHoraR, cantidadR, totalR, idC, idS)
    SELECT
        i.idR,
        i.fechaHoraR,
        i.cantidadR,
        i.cantidadR * c.costoC AS totalR, -- Cálculo del total
        i.idC,
        i.idS
    FROM
        inserted i
    INNER JOIN
        tConcepto c ON i.idC = c.idC;
END;
GO

-- Prueba del trigger (ya no se pasa totalR, se calcula automáticamente)
INSERT INTO tRecibo (idR, fechaHoraR, cantidadR, idC, idS)
VALUES('R010', '2025-03-17 10:00:00', 5, 'C001','S005'); -- Fecha y hora completas
GO
SELECT * FROM tRecibo WHERE idR = 'R010';
GO
-------------------------------------------------------Crear un trigger para validar el formato de correo electrónico en tSolicitante
CREATE TRIGGER d_validar_email_solicitante
ON tSolicitante
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE tipoS = 'EST' AND dirElectronS NOT LIKE '%@uandina.edu.pe'
    )
    BEGIN
        RAISERROR('Los estudiantes deben tener un correo institucional (@uandina.edu.pe)', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE tipoS = 'PROF' AND dirElectronS NOT LIKE '%@uandina.edu%' -- Más genérico para profesores, puede ser @uandina.edu o @uandina.edu.pe
    )
    BEGIN
        RAISERROR('Los profesores deben tener un correo institucional que contenga (@uandina.edu)', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

-- Prueba de validación de correo (debería fallar)
-- INSERT INTO tSolicitante
-- VALUES('S020', 'EST', 'carnet','120202020E', 'Zamalloa','Cárdenas', 'Aldo', NULL, '920202020', '51-84-222020', '120202020E@edu.pe');
-- GO
-- Prueba de validación de correo (debería pasar)
INSERT INTO tSolicitante
VALUES('S021', 'EST', 'carnet','120202021F', 'Gomez','Paz', 'Luis', NULL, '920202021', '51-84-222021', '120202021F@uandina.edu.pe');
GO
SELECT * FROM tSolicitante WHERE idS = 'S021';
GO

----------------------------------------------------------------------------Crear un trigger para detectar cambios en tTramite.
CREATE TABLE tAuditoriaTramite (
    idAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    idT VARCHAR(4),
    fechaHoraCambio DATETIME,
    usuario VARCHAR(128), -- SUSER_NAME() puede devolver hasta 128 caracteres
    accion VARCHAR(10),
    detalles VARCHAR(MAX)
);
GO

CREATE TRIGGER d_auditar_cambios_tramite
ON tTramite
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO tAuditoriaTramite (idT, fechaHoraCambio, usuario, accion, detalles)
    SELECT
        i.idT,
        GETDATE(),
        SUSER_SNAME(), -- Usar SUSER_SNAME() es más común que SUSER_NAME()
        'UPDATE',
        'Cambios: ' +
        CASE WHEN ISNULL(CONVERT(VARCHAR, d.fechaHoraT, 120), '') <> ISNULL(CONVERT(VARCHAR, i.fechaHoraT, 120), '') THEN 'fechaHoraT: ' + ISNULL(CONVERT(VARCHAR, d.fechaHoraT, 120),'NULL') + ' -> ' + ISNULL(CONVERT(VARCHAR, i.fechaHoraT, 120),'NULL') + '; ' ELSE '' END +
        CASE WHEN ISNULL(d.nombreT, '') <> ISNULL(i.nombreT, '') THEN 'nombreT: ' + ISNULL(d.nombreT,'NULL') + ' -> ' + ISNULL(i.nombreT,'NULL') + '; ' ELSE '' END +
        CASE WHEN ISNULL(d.cantidadFoliosT, -1) <> ISNULL(i.cantidadFoliosT, -1) THEN 'cantidadFoliosT: ' + ISNULL(CAST(d.cantidadFoliosT AS VARCHAR),'NULL') + ' -> ' + ISNULL(CAST(i.cantidadFoliosT AS VARCHAR),'NULL') + '; ' ELSE '' END +
        CASE WHEN ISNULL(d.idS, '') <> ISNULL(i.idS, '') THEN 'idS: ' + ISNULL(d.idS,'NULL') + ' -> ' + ISNULL(i.idS,'NULL') + '; ' ELSE '' END +
        CASE WHEN ISNULL(d.idO, '') <> ISNULL(i.idO, '') THEN 'idO: ' + ISNULL(d.idO,'NULL') + ' -> ' + ISNULL(i.idO,'NULL') + '; ' ELSE '' END
    FROM
        inserted i
    JOIN
        deleted d ON i.idT = d.idT
    WHERE -- Solo insertar si hubo algún cambio real para evitar filas vacías de 'Cambios: '
        ISNULL(CONVERT(VARCHAR, d.fechaHoraT, 120), '') <> ISNULL(CONVERT(VARCHAR, i.fechaHoraT, 120), '') OR
        ISNULL(d.nombreT, '') <> ISNULL(i.nombreT, '') OR
        ISNULL(d.cantidadFoliosT, -1) <> ISNULL(i.cantidadFoliosT, -1) OR
        ISNULL(d.idS, '') <> ISNULL(i.idS, '') OR
        ISNULL(d.idO, '') <> ISNULL(i.idO, '');
END;
GO

-- Prueba del trigger de auditoría
UPDATE tTramite
SET fechaHoraT = '2017-08-02 10:05:00', nombreT = 'Bachillerato Automático' -- Fecha completa
WHERE idT = 'T005'; -- Usar = en lugar de LIKE si es una PK exacta
GO
SELECT * FROM tTramite WHERE idT = 'T005';
GO
SELECT * FROM tAuditoriaTramite;
GO

--------------------------------------------------------------. Crear un trigger para evitar la eliminación de trámites con recibos asociados.
CREATE TRIGGER d_prevenir_eliminacion_tramite
ON tTramite
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN tRecibo_Tramite rt ON d.idT = rt.idT
    )
    BEGIN
        RAISERROR('No se puede eliminar el trámite porque tiene recibos asociados.', 16, 1);
        ROLLBACK TRANSACTION; -- Asegúrate de rollback si la operación falla
        RETURN;
    END;

    -- Si no hay recibos asociados, proceder con la eliminación
    DELETE FROM tTramite
    WHERE idT IN (SELECT idT FROM deleted);
END;
GO

-- Prueba de eliminación (debería fallar porque T006 tiene recibo RT06)
-- DELETE FROM tTramite WHERE idT = 'T006';
-- GO
-- SELECT * FROM tTramite WHERE idT = 'T006';
-- GO
-- Prueba de eliminación (debería pasar porque T001 no tiene recibos asociados)
DELETE FROM tTramite WHERE idT = 'T001';
GO
SELECT * FROM tTramite WHERE idT = 'T001'; -- Debería estar vacío
GO

-------------------------------------------------------------------------------------TAREA

-- ============================================================================
-- TRIGGER 1: Validar que no se dupliquen números de documento en tSolicitante
-- ============================================================================
CREATE TRIGGER tr_validar_documento_unico
ON tSolicitante
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM tSolicitante s
        JOIN inserted i ON s.nroDocumS = i.nroDocumS AND s.tipoDocumS = i.tipoDocumS
        WHERE s.idS <> i.idS -- Asegurar que no es el mismo registro (importante en UPDATE)
    )
    BEGIN
        RAISERROR('Ya existe un solicitante con el mismo tipo y número de documento.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

-- Prueba de duplicado (debería fallar)
-- INSERT INTO tSolicitante
-- VALUES('S008','EST', 'carnet','123016101J', 'García', 'López','Ana', NULL, '977777777','51-84-227777','123016101J_ana@uandina.edu.pe');
-- GO
-- Prueba de no duplicado (debería pasar)
INSERT INTO tSolicitante
VALUES('S009','EST', 'carnet','999999999Z', 'Kent', 'Clark','Super', NULL, '988888888','51-84-228888','999999999Z@uandina.edu.pe');
GO
SELECT * FROM tSolicitante WHERE idS = 'S009';
GO

---------------------------------------------------------TRIGGER 2: Validar que cantidadFoliosT sea mayor que cero en tTramite
CREATE TRIGGER trg_validar_folios_tramite -- Nombre corregido
ON tTramite
INSTEAD OF INSERT -- También podría ser AFTER INSERT y hacer ROLLBACK si falla
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE ISNULL(cantidadFoliosT, 0) <= 0 -- Considerar NULL como inválido también
    )
    BEGIN
        RAISERROR('La cantidad de folios debe ser un número entero mayor a cero.', 16, 1);
        ROLLBACK TRANSACTION; -- Importante si es INSTEAD OF y falla la condición
        RETURN;
    END;

    -- Si la validación pasa, insertar los datos
    INSERT INTO tTramite (idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO)
    SELECT idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO
    FROM inserted;
END;
GO

-- Pruebas del trigger de folios
-- Inserción válida
INSERT INTO tTramite (idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO)
VALUES ('T008','2025-06-01 09:00:00','Solicitud de vacaciones 10 días',2,'S006','O005');
GO
-- Inserción inválida (cantidadFoliosT = 0) - Debería fallar
-- INSERT INTO tTramite (idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO)
-- VALUES ('T013','2025-07-01 13:30:00','Certificación de prácticas preprofesionales',0,'S005','O006');
-- GO
-- Inserción inválida (cantidadFoliosT = NULL) - Debería fallar
-- INSERT INTO tTramite (idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO)
-- VALUES ('T014','2025-07-02 14:00:00','Otro trámite',NULL,'S005','O006');
-- GO
SELECT * FROM tTramite WHERE idT = 'T008';
GO

-------------------------------------------------------------------------- TRIGGER 3: Actualizar fechaHoraT en tTramite cuando se inserta en tRecibo_Tramite
CREATE TRIGGER trg_actualizar_fecha_tramite_por_recibo
ON dbo.tRecibo_Tramite -- Nombre completo con schema
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE T
    SET T.fechaHoraT = GETDATE() -- Actualiza a la fecha y hora actual del sistema
    FROM dbo.tTramite AS T
    INNER JOIN inserted AS I ON T.idT = I.idT;
END;
GO

-- Prueba del trigger de actualización de fecha
-- Primero, un trámite para asociar un nuevo recibo
INSERT INTO tTramite (idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO)
VALUES ('T020','2024-01-01 08:00:00', 'Trámite de prueba para fecha', 1, 'S001', 'O001');
GO
-- Un recibo para asociar
INSERT INTO tRecibo (idR, fechaHoraR, cantidadR, idC, idS)
VALUES('R020', '2024-01-01 07:00:00', 1, 'C005', 'S001');
GO
-- Verificar la fecha original de T020
SELECT idT, fechaHoraT FROM tTramite WHERE idT = 'T020';
GO
-- Insertar en tRecibo_Tramite, lo que debería disparar el trigger y actualizar fechaHoraT de T020
INSERT INTO dbo.tRecibo_Tramite (idRT,idT, idR) VALUES ('RT07','T020','R020');
GO
-- Verificar la fecha actualizada de T020
SELECT idT, fechaHoraT FROM tTramite WHERE idT = 'T020';
GO
