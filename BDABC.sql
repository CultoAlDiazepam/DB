---:Grupo culto al diazepan
---#######################
--Autores: 
--Camacho Cruz Fernando Eliomar 
--Suárez Condori Juan Gabriel 
--Sutta Atayupanqui Anthony   
--Yabar Latorre Gonzalo Eduardo
--########################
---Fecha: 21/02/2025
use master
go

if DB_ID('BDABC') is not null
	drop database BDABC
go
create database BDABC
go
use BDABC
go
--Tabla cliente
if OBJECT_ID('Cliente','U') is not null
	drop table Cliente
go
create table Cliente
(
	IDC int primary key,
	nompcC varchar(50),
	telefonoC char(9),
	correoC varchar(50),
	direccionC varchar(50)
)
go

--Tabla conprobante 

if OBJECT_ID('Comprobante','U') is not null
	drop table Comprobante
go
create table Comprobante
(
	IDCom int primary key,
	detalleCom varchar(50),
	horaCom datetime,
	fechaCom datetime,
	totalCom decimal(10,2),
	IDC int,
	foreign key (IDC) references Cliente(IDC)
)
go

--Tabla proveedor
if OBJECT_ID('Proveedor','U') is not null
	drop table Proveedor
go
create table Proveedor
(
	IDP int primary key,
	nombreP varchar(50),
	telefonoP char(9),
	correoP varchar(50),
	direccionP varchar(50)

)
go

--Tabla Orden de compra
if OBJECT_ID('OrdenCompra','U') is not null
	drop table OrdenCompra
go
create table OrdenCompra
(
	IDOC int primary key,
	fechaOC datetime,
	horaOC datetime,
	montototalOC decimal(10,2),
	IDP int,
	foreign key (IDP) references Proveedor(IDP)

)
go


--Tabla Electrodomestico
if OBJECT_ID('Electrodomestico','U') is not null
	drop table Electrodomestico
go
create table Electrodomestico
(
	IdE int primary key,
	nombreE varchar(50),
	descripcionE varchar(50),
	marcaE varchar(50),
	precioE decimal(8,2)
) 
go


--Tabla Detalles de Entraga 
if OBJECT_ID('DetallesDeEntrega','U') is not null
	drop table DetallesDeEntrega
go
create table DetallesDeEntrega
(
	IDDE varchar(50) primary key,
	cantidadD int,
	subtotalD decimal(10,2),
	montototal decimal(10,2),
	IDOC int,
	foreign key (IDOC) references OrdenCompra(IDOC),
	IdE int,
	foreign key (IdE) references Electrodomestico(IdE),
	IDCom int,
	foreign key (IDCom) references Comprobante(IDCom)

)
go







