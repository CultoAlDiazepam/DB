-- Crear el TABLESPACE
CREATE TABLESPACE BDHualmarket
DATAFILE 'D:\oracle\BDHualmarket.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

-- Eliminar y crear la tabla Cliente
DROP TABLE Cliente;
CREATE TABLE Cliente (
    CodCLI VARCHAR2(50) PRIMARY KEY,
    nombreCLI VARCHAR2(50),
    paternoCLI VARCHAR2(50),
    maternoCLI VARCHAR2(50),
    celularCLI VARCHAR2(9),
    direccionCLI VARCHAR2(50),
    tipoDocCLI VARCHAR2(50),
    nroDocCLI VARCHAR2(8)
) TABLESPACE BDHualmarket;

-- Eliminar y crear la tabla Proveedor
DROP TABLE Proveedor;
CREATE TABLE Proveedor (
    CodProv VARCHAR2(50) PRIMARY KEY,
    nombreProv VARCHAR2(50),
    telefonoProv VARCHAR2(9),
    direccionProv VARCHAR2(50)
) TABLESPACE BDHualmarket;

-- Eliminar y crear la tabla Comprobante
DROP TABLE Comprobante;
CREATE TABLE Comprobante (
    IDCom NUMBER PRIMARY KEY,
    tipodeCom VARCHAR2(50),
    fechaCom DATE,
    totalCom NUMBER(10,2),
    CodCLI VARCHAR2(50),
    FOREIGN KEY (CodCLI) REFERENCES Cliente(CodCLI)
) TABLESPACE BDHualmarket;

-- Eliminar y crear la tabla OrdenDeCompra
DROP TABLE OrdenDeCompra;
CREATE TABLE OrdenDeCompra (
    IDOC NUMBER PRIMARY KEY,
    estadoOC VARCHAR2(50),
    descripcionOC VARCHAR2(50),
    CodProv VARCHAR2(50),
    FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv)
) TABLESPACE BDHualmarket;

-- Eliminar y crear la tabla Categoria
DROP TABLE Categoria;
CREATE TABLE Categoria (
    CodCat VARCHAR2(50) PRIMARY KEY,
    nombreCat VARCHAR2(50)
) TABLESPACE BDHualmarket;

-- Eliminar y crear la tabla Producto
DROP TABLE Producto;
CREATE TABLE Producto (
    IDProd NUMBER PRIMARY KEY,
    nombreProd VARCHAR2(50),
    marcaProd VARCHAR2(50),
    precioProd NUMBER(10,2),
    CodCat VARCHAR2(50),
    IDOC NUMBER,
    IDDet NUMBER,
    FOREIGN KEY (CodCat) REFERENCES Categoria(CodCat),
    FOREIGN KEY (IDOC) REFERENCES OrdenDeCompra(IDOC),
    FOREIGN KEY (IDDet) REFERENCES Detalle(IDDet)
) TABLESPACE BDHualmarket;

-- Eliminar y crear la tabla Detalle
DROP TABLE Detalle;
CREATE TABLE Detalle (
    IDDet NUMBER PRIMARY KEY,
    cantidadDet NUMBER,
    precioUniDet NUMBER(10,2),
    descuentoDet NUMBER(10,2),
    subtotalDet NUMBER(10,2),
    impuestoDet NUMBER(10,2),
    IDCom NUMBER,
    FOREIGN KEY (IDCom) REFERENCES Comprobante(IDCom)
) TABLESPACE BDHualmarket;
