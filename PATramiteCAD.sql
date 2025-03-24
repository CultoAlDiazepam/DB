if OBJECT_ID('spListarIdNombre','P') is not null
	drop proc spListarIdNombre
go
create proc spListarIdNombre
as
begin
	SELECT idS as ID, nombresS
		FROM tSolicitante
			WHERE idS IN (SELECT idS
				FROM tTramite
					WHERE idT IN (SELECT idT
						FROM tRecibo_Tramite));
end
go

if OBJECT_ID('spListarConceptos','P') is not null
	drop proc spListarConceptos
go
create proc spListarConceptos
as
begin
 SELECT idC, denominacionC
 FROM tconcepto
 WHERE idC IN (SELECT idC FROM trecibo);
end
go

if OBJECT_ID('spListarOficinasTramites','P') is not null
	drop proc spListarOficinasTramites
go
create proc spListarOficinasTramites
as
begin
 SELECT idO, denominacionO
 FROM toficina
 WHERE idO IN (SELECT idO
 FROM ttramite);
end
go

if OBJECT_ID('splistarOficinaDinero','P') is not null
	drop proc splistarOficinaDinero
go
create proc splistarOficinaDinero
as
begin
 SELECT idO, denominacionO
FROM toficina
 WHERE idO IN (SELECT idO
 FROM ttramite
 WHERE idT IN (SELECT idT
 FROM tRecibo_Tramite));
end
go

if OBJECT_ID('spListarConceptoNoG','P') is not null
	drop proc spListarConceptoNoG
go
create proc spListarConceptoNoG
as
begin
 SELECT idC, denominacionC
 FROM tconcepto
 WHERE idC NOT IN (SELECT idC
 FROM trecibo);
end
go

exec spListarIdNombre
go

exec spListarConceptos
go

exec spListarOficinasTramites
go

exec splistarOficinaDinero
go

exec spListarConceptoNoG
go