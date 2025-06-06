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

-- ========= INSERCIÓN DE DATOS DE EJEMPLO =========

-- Clientes
INSERT INTO Cliente (CodCLI, nombreCLI, paternoCLI, maternoCLI, celularCLI, direccionCLI, tipoDocCLI, nroDocCLI) VALUES
('CLI001', 'Juan', 'Perez', 'Gomez', '987654321', 'Av. Sol 123', 'DNI', '12345678'),
('CLI002', 'Maria', 'Garcia', 'Lopez', '912345678', 'Jr. Luna 456', 'DNI', '87654321'),
('CLI003', 'Carlos', 'Rojas', 'Mendez', '955555555', 'Calle Estrella 789', 'DNI', '11223344'),
('CLI004', 'Ana', 'Torres', 'Silva', '944444444', 'Paseo del Mar 101', 'DNI', '55667788');

-- Proveedores
INSERT INTO Proveedor (CodProv, nombreProv, telefonoProv, direccionProv) VALUES
('PROV01', 'Alicorp S.A.A.', '014118000', 'Av. Argentina 4793, Callao'),
('PROV02', 'Gloria S.A.', '014361818', 'Av. República de Panamá 2461, Lima'),
('PROV03', 'Distribuidora Costa', '013368585', 'Jr. Huantar 234, Lima');

-- Categorías
INSERT INTO Categoria (CodCat, nombreCat) VALUES
('CAT01', 'Lácteos'),
('CAT02', 'Bebidas'),
('CAT03', 'Abarrotes'),
('CAT04', 'Limpieza');

-- Productos
INSERT INTO Producto (nombreProd, marcaProd, precioProd, stockProd, CodCat) VALUES
('Leche Evaporada', 'Gloria', 4.50, 100, 'CAT01'),
('Yogurt Fresa 1L', 'Gloria', 8.20, 50, 'CAT01'),
('Gaseosa 3L', 'Inka Kola', 11.00, 80, 'CAT02'),
('Arroz Extra 5kg', 'Costeño', 22.50, 60, 'CAT03'),
('Aceite Vegetal 1L', 'Primor', 9.80, 70, 'CAT03'),
('Detergente 1kg', 'Ariel', 15.00, 40, 'CAT04'),
('Jugo de Naranja 1L', 'Frugos', 5.50, 0, 'CAT02');

-- Comprobantes (Ventas)
INSERT INTO Comprobante (tipodeCom, fechaCom, totalCom, CodCLI) VALUES
('Boleta', '2023-10-25', 28.40, 'CLI001'),
('Factura', '2023-10-26', 42.30, 'CLI002');

-- Detalle de Comprobantes
INSERT INTO Detalle (cantidadDet, precioUniDet, subtotalDet, IDCom, IDProd) VALUES
(2, 8.20, 16.40, 1, 2),
(1, 11.00, 11.00, 1, 3),
(1, 22.50, 22.50, 2, 4),
(2, 9.80, 19.60, 2, 5);

-- Órdenes de Compra
INSERT INTO OrdenDeCompra (fechaOC, estadoOC, CodProv) VALUES
('2023-10-01', 'Completado', 'PROV02'),
('2023-10-15', 'Completado', 'PROV01'),
('2023-10-27', 'Pendiente', 'PROV03');

-- Detalle de Órdenes de Compra
INSERT INTO DetalleOrdenDeCompra (IDOC, IDProd, cantidadComprada, precioCompraUnitario) VALUES
(1, 1, 100, 3.20),
(1, 2, 50, 6.50),
(2, 4, 60, 18.00),
(2, 5, 70, 7.50);
GO