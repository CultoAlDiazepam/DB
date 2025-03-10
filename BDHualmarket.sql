USE master;
go
CREATE DATABASE BDHualmarket;
GO
USE BDHualmarket;
GO

-- Eliminar y crear la tabla Cliente
IF OBJECT_ID('Cliente', 'U') IS NOT NULL
    DROP TABLE Cliente;
GO
CREATE TABLE Cliente (
    CodCLI VARCHAR(50) PRIMARY KEY,
    nombreCLI VARCHAR(50),
    paternoCLI VARCHAR(50),
    maternoCLI VARCHAR(50),
    celularCLI VARCHAR(9),
    direccionCLI VARCHAR(50),
    tipoDocCLI VARCHAR(50),
    nroDocCLI VARCHAR(8)
);
GO

-- Eliminar y crear la tabla Proveedor
IF OBJECT_ID('Proveedor', 'U') IS NOT NULL
    DROP TABLE Proveedor;
GO
CREATE TABLE Proveedor (
    CodProv VARCHAR(50) PRIMARY KEY,
    nombreProv VARCHAR(50),
    telefonoProv VARCHAR(9),
    direccionProv VARCHAR(50)
);
GO

-- Eliminar y crear la tabla Comprobante
IF OBJECT_ID('Comprobante', 'U') IS NOT NULL
    DROP TABLE Comprobante;
GO
CREATE TABLE Comprobante (
    IDCom INT IDENTITY(1,1) PRIMARY KEY,
    tipodeCom VARCHAR(50),
    fechaCom DATE,
    totalCom DECIMAL(10,2),
    CodCLI VARCHAR(50),
    FOREIGN KEY (CodCLI) REFERENCES Cliente(CodCLI)
);
GO

-- Eliminar y crear la tabla OrdenDeCompra
IF OBJECT_ID('OrdenDeCompra', 'U') IS NOT NULL
    DROP TABLE OrdenDeCompra;
GO
CREATE TABLE OrdenDeCompra (
    IDOC INT IDENTITY(1,1) PRIMARY KEY,
    estadoOC VARCHAR(50),
    descripcionOC VARCHAR(50),
    CodProv VARCHAR(50),
    FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv)
);
GO

-- Eliminar y crear la tabla Categoria
IF OBJECT_ID('Categoria', 'U') IS NOT NULL
    DROP TABLE Categoria;
GO
CREATE TABLE Categoria (
    CodCat VARCHAR(50) PRIMARY KEY,
    nombreCat VARCHAR(50)
);
GO

-- Eliminar y crear la tabla Producto
IF OBJECT_ID('Producto', 'U') IS NOT NULL
    DROP TABLE Producto;
GO
CREATE TABLE Producto (
    IDProd INT IDENTITY(1,1) PRIMARY KEY,
    nombreProd VARCHAR(50),
    marcaProd VARCHAR(50),
    precioProd DECIMAL(10,2),
    CodCat VARCHAR(50),
    IDOC INT,
	IDDet INT,
	FOREIGN KEY (IDDet) REFERENCES Detalle(IDDet),
    FOREIGN KEY (CodCat) REFERENCES Categoria(CodCat),
    FOREIGN KEY (IDOC) REFERENCES OrdenDeCompra(IDOC)
);
GO

-- Eliminar y crear la tabla Detalle
IF OBJECT_ID('Detalle', 'U') IS NOT NULL
    DROP TABLE Detalle;
GO
CREATE TABLE Detalle (
    IDDet INT IDENTITY(1,1) PRIMARY KEY,
    cantidadDet INT,
    precioUniDet DECIMAL(10,2),
    descuentoDet DECIMAL(10,2),
    subtotalDet DECIMAL(10,2),
    impuestoDet DECIMAL(10,2),
    IDCom INT,
    FOREIGN KEY (IDCom) REFERENCES Comprobante(IDCom)
);
GO
