-- BD Shalom
-- Autor: Fernando Eliomar
-- Fecha: 19/02/2025 
-- Cusco - Peru

use master
go

if DB_ID('BDSHalom') is not null
	drop database BDShalom
go

create database BDShalom
go

use BDShalom
go

-- Creación de tablas
if OBJECT_ID('Cliente','U') is not null
	drop table Cliente
go

create table Cliente
(
	idCliente char(9) primary key,
	tipoDocumentoC varchar(10) not null,
	nroDocumC char(8) not null,
	nombresC varchar(50) not null,
	paternoC varchar(50) not null,
	maternoC varchar(50) not null,
	celularC char(9) not null,
	foreign key (idCliente) references Cliente(idCliente)
)
go

if OBJECT_ID('Paquete','U') is not null
	drop table Paquete
go

create table Paquete
(
	idP int primary key,
	descripcionP varchar(50),
	pesoP nvarchar(50) -- Tipo UNICODE multi-idioma
)
go

if OBJECT_ID('Comprobante','U') is not null
	drop table Comprobante
go

create table Comprobante
(
	idComp int primary key,
	fechaHoraComp datetime,
	totalComp decimal(8,2),
	OrigenComp varchar(50),
	DestinoComp varchar(50),
	idCliente char(9),
	idP int,
	foreign key (idCliente) references Cliente(idCliente)
)
go

if OBJECT_ID('Detalle','U') is not null
	drop table Detalle
go

create table Detalle
(
	idDet int primary key,
	precioPorKiloDet decimal(8,2),
	subtotalDet decimal (8,2),
	idComp int,
	idP int,
	foreign key(idComp) references Comprobante(idComp),
	foreign key (idP) references Paquete(idP)
)
go
