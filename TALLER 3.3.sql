
CREATE DATABASE baseTramites;
USE baseTramites;
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

INSERT INTO tSolicitante
VALUES('S001','EST', 'carnet','123016101J',
'Torres', 'Loza','Boris', NULL,
'911111111','51-84-221111','123016101J@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S002','EST','carnet','123015100A',
'Pérez','Sánchez','José', NULL,
'922222222','51-84-222222','123015100A@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S003','EST','carnet','123014200D',
'Arenas','Campos','Raul', NULL,
'933333333','51-84-223333','123014200D@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S004','EST','carnet','123015300F',
'Maldonado', 'Rojas','Jorge', NULL,
'944444444','51-84-224444','123015300F@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S005','EST', 'carnet','123015300B',
'Salinas','Valle','Daniel',NULL,
'955555555','51-84-225555','123015300B@uandina.edu.pe');


INSERT INTO tSolicitante
VALUES('S006', 'PROF', 'DNI', '01111110',
'Palomino','Cahuaya', 'Ariadna', NULL,
'966666666','51-84-226666', 'apalominoc@uandina.edu');
INSERT INTO tSolicitante
VALUES('S007', 'PROF', 'DNI', '02222220',
'Espetia','Humanga', 'Hugo', NULL,
'966666666','51-84-226666', 'hespetia@uandina.edu.pe');




CREATE TABLE tOficina
(
idO VARCHAR(4) NOT NULL,
denominacionO VARCHAR(50),
ubicacionO VARCHAR(50),
responsableO VARCHAR(50),
PRIMARY KEY (idO)
);

INSERT INTO tOficina
VALUES('O001','Rectorado',
'AG-101 Larapa','Zambrano Ramos, Juan');
INSERT INTO tOficina
VALUES('O002','Dirección de Tecnologías de Información',
'ING-205 Larapa', 'Torres Campos, César');
INSERT INTO tOficina
VALUES('O003','Dirección del D.A. de Ingeniería de Sistemas',
'ING-211 Larapa', 'Zamalloa Campos, Gino');
INSERT INTO tOficina
VALUES('O004','Tesorería',
'E-301 Módulo de entrada - Larapa','Ramírez Tapia, Nohelia');
INSERT INTO tOficina
VALUES('O005','RRHH',
'Sótano del Paraninfo - Larapa','Martínez Salazar, Dante');
INSERT INTO tOficina
VALUES('O006', 'Decanatura de Ingeniería',
'ING-214 - Larapa', 'Gamarra Miranda, Javier');



CREATE TABLE tConcepto
(
idC VARCHAR(4) NOT NULL,
denominacionC VARCHAR(50),
costoC DECIMAL(10,2),
PRIMARY KEY (idC)
);


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



INSERT INTO tRecibo
VALUES('R002','06-27-2017 11:30:00',9,NULL, 'C001', 'S001');

INSERT INTO tRecibo
VALUES('R003', '07-25-2017 12:30:00',1,NULL, 'C002', 'S002');
INSERT INTO tRecibo
VALUES('R004', '07-26-2017 09:45:00',1,NULL, 'C003', 'S003');
INSERT INTO tRecibo
VALUES('R005', '08-01-2017 09:55:00',1,NULL, 'C004', 'S004');
INSERT INTO tRecibo
VALUES('R006','08-03-2017 09:56:00',1,NULL, 'C005', 'S004');
INSERT INTO tRecibo
VALUES('R007', '08-04-2017 12:00:00',1,NULL, 'C006', 'S005');

CREATE TABLE tTramite
( idT VARCHAR(4) NOT NULL, 
fechaHoraT DATETIME,
nombreT VARCHAR(70),
cantidadFoliosT INT,
idS VARCHAR(4),
PRIMARY KEY (idT),
FOREIGN KEY (idS) REFERENCES tSolicitante(idS),
idO VARCHAR(4),
FOREIGN KEY (idO) REFERENCES tOficina(idO));

CREATE TABLE tRecibo_Tramite
(idRT VARCHAR(4) NOT NULL,
PRIMARY KEY (idRT),
idT VARCHAR(4),
FOREIGN KEY (idT) REFERENCES tTramite(idT),
idR VARCHAR(4),
FOREIGN KEY (idR) REFERENCES tRecibo(idR));



INSERT INTO tTramite
VALUES('T001','06-25-2027 10:15:00',
'Licencia por 2 días',2,'S006','O005');
INSERT INTO tTramite
VALUES('T002','06-27-2017 12:00:00',
'Convalidación de sílabos de I.S.',2,'S001','O006');
INSERT INTO tTramite
VALUES('T003','07-25-2017 12:50:00',
'Constancia de seg. estudios',2,'S002','O006');
INSERT INTO tTramite
VALUES('T004','07-26-2017 10:00:00',
'Certificado de estudios del 2017-I',2,'S003','O006');
INSERT INTO tTramite
VALUES('T005','08-01-2017 10:05:00',
'Bachillerato',11,'S004','O006');
INSERT INTO tTramite
VALUES('T006','08-03-2017 12:30:00',
'Carta presentación práct EGEMSA 1-sep al 1 mar 2017',
2,'S005','O006');
INSERT INTO tTramite
VALUES('T007','08-04-2017 08:30:00',
'Permiso por salud 5 días',2,'S007','O005');


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

 


select * from tRecibo
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
 i.cantidadR * c.costoC AS totalR,
 i.idC,
 i.idS
 FROM
 inserted i
 INNER JOIN
 tConcepto c ON i.idC = c.idC;
END
GOINSERT INTO tRecibo (idR, fechaHoraR, cantidadR, idC, idS)
 VALUES('R010', '2025-03-17', 5, 'C001','S005')-------------------------------------------------------Crear un trigger para validar el formato de correo electrónico en tSolicitanteCREATE TRIGGER d_validar_email_solicitante
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
 RAISERROR('Los estudiantes deben tener un correo institucional
(@uandina.edu.pe)', 16, 1);
 ROLLBACK TRANSACTION;
 RETURN;
END;
IF EXISTS (
 SELECT 1 FROM inserted
 WHERE tipoS = 'PROF' AND dirElectronS NOT LIKE '%@uandina.edu%'
 )
 BEGIN
 RAISERROR('Los profesores deben tener un correo institucional (@uandina.edu)',
16, 1);
 ROLLBACK TRANSACTION;
 RETURN;
 END;
END;



INSERT INTO tSolicitante
 VALUES('S020', 'EST', 'carnet','120202020E', 'Zamalloa','Cárdenas', 'Aldo', NULL,
'920202020', '51-84-222020', '120202020E@edu.pe')


----------------------------------------------------------------------------Crear un trigger para detectar cambios en tTramite.

CREATE TABLE tAuditoriaTramite (
 idAuditoria INT IDENTITY(1,1) PRIMARY KEY,
 idT VARCHAR(4),
 fechaHoraCambio DATETIME,
 usuario VARCHAR(50),
 accion VARCHAR(10),
 detalles VARCHAR(MAX)
);---------CREATE TRIGGER d_auditar_cambios_tramite
ON tTramite
AFTER UPDATE
AS
BEGIN
 SET NOCOUNT ON;
	INSERT INTO tAuditoriaTramite (idT, fechaHoraCambio, usuario, accion, detalles)
 SELECT
i.idT,
 GETDATE(),
 SUSER_NAME(),
 'UPDATE',
 'Cambios: ' +
 CASE WHEN d.fechaHoraT <> i.fechaHoraT THEN 'fechaHoraT: ' +
CONVERT(VARCHAR, d.fechaHoraT, 120) + ' -> ' + CONVERT(VARCHAR, i.fechaHoraT,
120) + '; ' ELSE '' END +
 CASE WHEN d.nombreT <> i.nombreT THEN 'nombreT: ' + d.nombreT + ' -> ' +
i.nombreT + '; ' ELSE '' END +
CASE WHEN d.cantidadFoliosT <> i.cantidadFoliosT THEN 'cantidadFoliosT: ' +
CAST(d.cantidadFoliosT AS VARCHAR) + ' -> ' + CAST(i.cantidadFoliosT AS VARCHAR) + ';
' ELSE '' END +
 CASE WHEN d.idS <> i.idS THEN 'idS: ' + d.idS + ' -> ' + i.idS + '; ' ELSE '' END +
 CASE WHEN d.idO <> i.idO THEN 'idO: ' + d.idO + ' -> ' + i.idO + '; ' ELSE '' END
 FROM
 inserted i
 JOIN
 deleted d ON i.idT = d.idT;
END;



UPDATE tTramite
 SET fechaHoraT = '2017-08-02'
 WHERE idT LIKE 'T005'

 select * from tTramite

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
 RAISERROR('No se puede eliminar el trámite porque tiene recibos asociados', 16,
1);
 RETURN;
 END;

 DELETE FROM tTramite
 WHERE idT IN (SELECT idT FROM deleted);
END;



DELETE FROM tTramite
 WHERE idT LIKE 'T006'select * from tTramite -------------------------------------------------------------------------------------TAREA -- ============================================================================
-- TRIGGER 1: Validar que no se dupliquen números de documento en tSolicitante
-- ============================================================================
CREATE TRIGGER tr_validar_documento_unico
ON tSolicitante
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si existe duplicación de números de documento
    IF EXISTS (
        SELECT nroDocumS, tipoDocumS
        FROM tSolicitante s1
        WHERE EXISTS (
            SELECT 1 FROM tSolicitante s2 
            WHERE s1.nroDocumS = s2.nroDocumS 
            AND s1.tipoDocumS = s2.tipoDocumS 
            AND s1.idS <> s2.idS
        )
        AND s1.idS IN (SELECT idS FROM inserted)
    )
    BEGIN
        RAISERROR('Ya existe un solicitante con el mismo tipo y número de documento', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;


INSERT INTO tSolicitante
VALUES('S008','EST', 'carnet','123016101J',  -- Documento duplicado
'García', 'López','Ana', NULL,
'977777777','51-84-227777','123016101J@uandina.edu.pe');

select * from tSolicitante


---------------------------------------------------------TRIGGER 2
CREATE TRIGGER trgvalidarfoliostramite
ON tTramite
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE cantidadFoliosT <= 0
    )
    BEGIN
        RAISERROR('La cantidad de folios debe ser mayor a cero.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO tTramite (
        idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO
    )
    SELECT 
        idT, fechaHoraT, nombreT, cantidadFoliosT, idS, idO
    FROM inserted;
END;

INSERT INTO tTramite
VALUES 
('T008','2025-06-01 09:00:00','Solicitud de vacaciones 10 días',2,'S006','O005'),
('T009','2025-06-01 10:15:00','Renovación de contrato académico',3,'S007','O005'),
('T010','2025-06-01 11:30:00','Constancia de no adeudo',1,'S001','O004'),
('T011','2025-06-01 12:45:00','Solicitud de beca 2025-I',4,'S002','O006'),
('T012','2025-06-01 13:30:00','Certificación de prácticas preprofesionales',5,'S005','O006'),
('T013','2025-07-01 13:30:00','Certificación de prácticas preprofesionales',0,'S005','O006');

select * from tTramite;

-------------------------------------------------------------------------- TRIGGER 3
CREATE TRIGGER trg_actualizar_fecha_tramite_por_recibo_tsql
ON dbo.tRecibo_Tramite
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE T
    SET T.fechaHoraT = GETDATE()
    FROM dbo.tTramite AS T
    INNER JOIN inserted AS I ON T.idT = I.idT;
END
GO

INSERT INTO dbo.tRecibo_Tramite (idRT,idT, idR) VALUES ('RT07','T007','R007');

select * from tTramite;
