CREATE TABLESPACE BDHualmarkert
DATAFILE 'd:\oracle\BDHualmarkert.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

---crear la tabla cliente
DROP table CLiente;
Create TABLE Cliente(
    IDCLI number primary key,
    nombreCLI varchar2(50),
    paternoCLI varchar2(50),
    maternoCLI VARCHAR2(50),
    celularCLI  number(9),
    direccionCLI varchar2(50),
    pipoDocCLI VARCHAR2(50),
    nroDocCLI number(8)
)TABLESPACE BDHualmarkert;

---Comprobante
DROP table Comprobante;
Create TABLE Comprobante(
    IDCom number primary key,
    tipodeCom varchar(50),
    fechaCom DATE,
    totalCom number(10,2),
    IDCLI number,
    foreign Key(IDCLI) references Cliente(IDCLI)
)TABLESPACE BDHualmarkert;

--- Detalle
DROP table Detalle;
Create TABLE Detalle(
    IDDet number primary key,
    cantidadDet number,
    precioUniDet number(10,2),
    descuentoDet number(10,2),
    subtotalDet number(10,2),
    impuestoDet number(10,2),
    IDCom number,
    foreign Key(IDCom) references Comprobante(IDCom)
)TABLESPACE BDHualmarkert;

---Producto
DROP table Producto;
Create TABLE Producto(
    IDProd number primary key,
    nombreProd VARCHAR2(50),
    marcharProd VARCHAR2(50),
    precioProd number(10,2),
    IDDet number,
    IDCat varchar2(50),
    IDOC DATE,
    foreign Key(IDDet) references Detalle(IDDet),
    foreign Key(IDCat) references categoria(IDCat),
    foreign Key(IDOC) references OrdenDeCompra(IDOC)
)TABLESPACE BDHualmarkert;

---categoria
DROP table categoria;
Create TABLE categoria(
    IDCat varchar2(50) primary key,
    nombreCat varchar2(50)
)TABLESPACE BDHualmarkert;

---OrdenDeCompra
DROP table OrdenDeCompra;
Create TABLE OrdenDeCompra(
    IDOC DATE primary key,
    estadoOC VARCHAR2(50),
    descripcionOC VARCHAR2(50)
)TABLESPACE BDHualmarkert;

---Proveedor
DROP table Proveedor;
Create TABLE Proveedor(
    IDProv number primary key,
    nombreProv VARCHAR2(50),
    telefonoProv VARCHAR2(9),
    direccionProv VARCHAR2(50),
    IDOC DATE,
    foreign Key(IDOC) references OrdenDeCompra(IDOC)
)TABLESPACE BDHualmarkert;




