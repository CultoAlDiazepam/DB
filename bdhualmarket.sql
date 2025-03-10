DROP DATABASE BDHualmarkert;
-- Crear la base de datos
CREATE DATABASE BDHualmarket;
USE BDHualmarket;


-- Crear la tabla Cliente
DROP TABLE IF EXISTS Cliente;
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
-- Crear la tabla Proveedor
DROP TABLE IF EXISTS Proveedor;
CREATE TABLE Proveedor (
    CodProv VARCHAR(50) PRIMARY KEY,
    nombreProv VARCHAR(50),
    telefonoProv VARCHAR(9),
    direccionProv VARCHAR(50)
);
-- Crear la tabla Comprobante
DROP TABLE IF EXISTS Comprobante;
CREATE TABLE Comprobante (
    IDCom INT PRIMARY KEY AUTO_INCREMENT,
    tipodeCom VARCHAR(50),
    fechaCom DATE,
    totalCom DECIMAL(10,2),
    CodCLI VARCHAR(50),
    FOREIGN KEY (CodCLI) REFERENCES Cliente(CodCLI)


);
-- Crear la tabla OrdenDeCompra
DROP TABLE IF EXISTS OrdenDeCompra;
CREATE TABLE OrdenDeCompra (
    IDOC INT PRIMARY KEY AUTO_INCREMENT,
    estadoOC VARCHAR(50),
    descripcionOC VARCHAR(50),
    CodProv VARCHAR(50),
    FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv)
);
-- Crear la tabla Categoria
DROP TABLE IF EXISTS Categoria;
CREATE TABLE Categoria (
    CodCat VARCHAR(50) PRIMARY KEY,
    nombreCat VARCHAR(50)
);
-- Crear la tabla Detalle
DROP TABLE IF EXISTS Detalle;
CREATE TABLE Detalle (
    IDDet INT PRIMARY KEY AUTO_INCREMENT,
    cantidadDet INT,
    precioUniDet DECIMAL(10,2),
    descuentoDet DECIMAL(10,2),
    subtotalDet DECIMAL(10,2),
    impuestoDet DECIMAL(10,2),
    IDCom INT,
    FOREIGN KEY (IDCom) REFERENCES Comprobante(IDCom)
);


-- Crear la tabla Producto
DROP TABLE IF EXISTS Producto;
CREATE TABLE Producto (
    IDProd INT PRIMARY KEY AUTO_INCREMENT,
    nombreProd VARCHAR(50),
    marcaProd VARCHAR(50),
    precioProd DECIMAL(10,2),
    CodCat VARCHAR(50),
    IDOC INT,
    FOREIGN KEY (CodCat) REFERENCES Categoria(CodCat),
    FOREIGN KEY (IDOC) REFERENCES OrdenDeCompra(IDOC),
    IDDet INT,
    FOREIGN KEY (IDDet) REFERENCES Detalle(IDDet)
);
