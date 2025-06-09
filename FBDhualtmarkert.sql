-- ========= CREACIÓN DE LA BASE DE DATOS Y TABLAS EN SQL SERVER =========

CREATE DATABASE BDHualmarket;
GO

USE BDHualmarket;
GO

-- Tabla Cliente
IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL DROP TABLE dbo.Cliente;
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

-- Tabla Proveedor
IF OBJECT_ID('dbo.Proveedor', 'U') IS NOT NULL DROP TABLE dbo.Proveedor;
CREATE TABLE Proveedor (
    CodProv VARCHAR(50) PRIMARY KEY,
    nombreProv VARCHAR(50),
    telefonoProv VARCHAR(9),
    direccionProv VARCHAR(50)
);

-- Tabla Categoria
IF OBJECT_ID('dbo.Categoria', 'U') IS NOT NULL DROP TABLE dbo.Categoria;
CREATE TABLE Categoria (
    CodCat VARCHAR(50) PRIMARY KEY,
    nombreCat VARCHAR(50)
);

-- Tabla Producto (Corregida)
IF OBJECT_ID('dbo.DetalleOrdenDeCompra', 'U') IS NOT NULL DROP TABLE dbo.DetalleOrdenDeCompra;
IF OBJECT_ID('dbo.Detalle', 'U') IS NOT NULL DROP TABLE dbo.Detalle;
IF OBJECT_ID('dbo.Producto', 'U') IS NOT NULL DROP TABLE dbo.Producto;
CREATE TABLE Producto (
    IDProd INT IDENTITY(1,1) PRIMARY KEY,
    nombreProd VARCHAR(50),
    marcaProd VARCHAR(50),
    precioProd DECIMAL(10,2),
    stockProd INT,
    CodCat VARCHAR(50),
    FOREIGN KEY (CodCat) REFERENCES Categoria(CodCat)
);

-- Tabla Comprobante (Venta)
IF OBJECT_ID('dbo.Comprobante', 'U') IS NOT NULL DROP TABLE dbo.Comprobante;
CREATE TABLE Comprobante (
    IDCom INT IDENTITY(1,1) PRIMARY KEY,
    tipodeCom VARCHAR(50),
    fechaCom DATE,
    totalCom DECIMAL(10,2),
    CodCLI VARCHAR(50),
    FOREIGN KEY (CodCLI) REFERENCES Cliente(CodCLI)
);

-- Tabla Detalle (de Venta)
CREATE TABLE Detalle (
    IDDet INT IDENTITY(1,1) PRIMARY KEY,
    cantidadDet INT,
    precioUniDet DECIMAL(10,2),
    subtotalDet DECIMAL(10,2),
    IDCom INT,
    IDProd INT,
    FOREIGN KEY (IDCom) REFERENCES Comprobante(IDCom),
    FOREIGN KEY (IDProd) REFERENCES Producto(IDProd)
);

-- Tabla OrdenDeCompra
IF OBJECT_ID('dbo.OrdenDeCompra', 'U') IS NOT NULL DROP TABLE dbo.OrdenDeCompra;
CREATE TABLE OrdenDeCompra (
    IDOC INT IDENTITY(1,1) PRIMARY KEY,
    fechaOC DATE,
    estadoOC VARCHAR(50),
    CodProv VARCHAR(50),
    FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv)
);

-- Tabla DetalleOrdenDeCompra (Tabla de enlace)
CREATE TABLE DetalleOrdenDeCompra (
    IDDetOC INT IDENTITY(1,1) PRIMARY KEY,
    IDOC INT,
    IDProd INT,
    cantidadComprada INT,
    precioCompraUnitario DECIMAL(10,2),
    FOREIGN KEY (IDOC) REFERENCES OrdenDeCompra(IDOC),
    FOREIGN KEY (IDProd) REFERENCES Producto(IDProd)
);
GO
