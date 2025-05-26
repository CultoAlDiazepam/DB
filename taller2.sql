------------------NORTHWIND---------------
use Northwind
go

select * from Categories
select * from Products
select * from Customers
select * from Suppliers
GO
-- =====================================================
-- SCRIPT DE FUNCIONES PARA BASE DE DATOS NORTHWIND
-- Este script contiene 4 funciones para diferentes consultas
-- Cada función incluye DROP IF EXISTS para permitir recreación
-- =====================================================

-- =====================================================
-- FUNCIÓN 1: GetTokyoSuppliers
-- PROPÓSITO: Selecciona todos los proveedores (suppliers) que están
--           ubicados en Tokyo, Japan. Útil para filtrar proveedores
--           por ubicación geográfica específica.
-- RETORNA: Tabla con información completa de suppliers de Tokyo
-- =====================================================
DROP FUNCTION IF EXISTS dbo.GetTokyoSuppliers;
GO

CREATE FUNCTION GetTokyoSuppliers()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        SupplierID,
        CompanyName,
        ContactName,
        ContactTitle,
        Address,
        City,
        Region,
        PostalCode,
        Country,
        Phone,
        Fax,
        HomePage
    FROM Suppliers
    WHERE Country = 'Japan'
        AND City = 'Tokyo'
);
GO

-- =====================================================
-- FUNCIÓN 2: GetProductsByPriceRange
-- PROPÓSITO: Obtiene productos que tienen un precio unitario entre $10 y $20.
--           Esta función es útil para análisis de productos de rango
--           medio de precios y control de inventario por categoría de precio.
-- RETORNA: Tabla con productos activos (no descontinuados) en el rango de precio especificado
-- =====================================================
DROP FUNCTION IF EXISTS dbo.GetProductsByPriceRange;
GO

CREATE FUNCTION GetProductsByPriceRange()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        ProductID,
        ProductName,
        UnitPrice,
        UnitsInStock,
        CategoryID,
        SupplierID,
        Discontinued
    FROM Products
    WHERE UnitPrice BETWEEN 10 AND 20
        AND Discontinued = 0  -- Solo productos activos
);
GO

-- =====================================================
-- FUNCIÓN 3: GetDairyProductsFromSupplier15
-- PROPÓSITO: Selecciona productos de la categoría "Dairy Products" 
--           que son suministrados por el proveedor con ID 15.
--           Útil para análisis específico de productos lácteos de un proveedor particular.
-- RETORNA: Tabla con productos lácteos del supplier 15, incluyendo información
--          del proveedor y categoría mediante JOINs
-- =====================================================
DROP FUNCTION IF EXISTS dbo.GetDairyProductsFromSupplier15;
GO

CREATE FUNCTION GetDairyProductsFromSupplier15()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductID,
        p.ProductName,
        p.UnitPrice,
        p.UnitsInStock,
        p.SupplierID,
        c.CategoryName,
        s.CompanyName AS SupplierName
    FROM Products p
    INNER JOIN Categories c ON p.CategoryID = c.CategoryID
    INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
    WHERE c.CategoryName = 'Dairy Products'
        AND p.SupplierID = 15
        AND p.Discontinued = 0  -- Solo productos activos
);
GO

-- =====================================================
-- FUNCIÓN 4: GetEmployeeSalesAnalysis
-- PROPÓSITO: Realiza un análisis completo del rendimiento de ventas por empleado.
--           Utiliza múltiples JOINs entre las tablas principales para generar
--           métricas de rendimiento comercial. Es fundamental para evaluación
--           de desempeño y toma de decisiones gerenciales.
-- TABLAS INVOLUCRADAS: Employees, Orders, Order Details, Products
-- RETORNA: Tabla con estadísticas completas de ventas por empleado incluyendo:
--          - Total de órdenes procesadas
--          - Cantidad total de productos vendidos
--          - Monto total de ventas (considerando descuentos)
--          - Promedio de venta por artículo
--          - Fechas de primera y última venta
-- =====================================================
DROP FUNCTION IF EXISTS dbo.GetEmployeeSalesAnalysis;
GO

CREATE FUNCTION GetEmployeeSalesAnalysis()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        e.Title,
        COUNT(DISTINCT o.OrderID) AS TotalOrders,
        COUNT(od.ProductID) AS TotalProductsSold,
        SUM(od.Quantity) AS TotalQuantitySold,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSalesAmount,
        AVG(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS AverageSalePerItem,
        MIN(o.OrderDate) AS FirstSaleDate,
        MAX(o.OrderDate) AS LastSaleDate
    FROM Employees e
    INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
    INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    INNER JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.OrderDate IS NOT NULL
    GROUP BY 
        e.EmployeeID, 
        e.FirstName, 
        e.LastName, 
        e.Title
);
GO

-- =====================================================
-- EJEMPLOS DE USO Y TESTING
-- =====================================================


-- FUNCIÓN 1: Obtener suppliers de Tokyo, Japan
-- Útil para: Análisis de proveedores por región geográfica
SELECT * FROM dbo.GetTokyoSuppliers();

-- FUNCIÓN 2: Productos con precio entre $10 y $20
-- Útil para: Análisis de productos de rango medio, control de inventario
SELECT * FROM dbo.GetProductsByPriceRange() 
ORDER BY UnitPrice DESC;

-- FUNCIÓN 3: Productos lácteos del supplier 15
-- Útil para: Análisis específico de categoría y proveedor
SELECT * FROM dbo.GetDairyProductsFromSupplier15();

-- FUNCIÓN 4: Análisis de rendimiento de ventas por empleado
-- Útil para: Evaluaciones de desempeño, reportes gerenciales
SELECT * FROM dbo.GetEmployeeSalesAnalysis() 
ORDER BY TotalSalesAmount DESC;


-- ------------------------- PUBS

IF OBJECT_ID('fn_CalculoBeneficioAutor') IS NOT NULL
    DROP FUNCTION fn_CalculoBeneficioAutor;
GO
CREATE FUNCTION fn_CalculoBeneficioAutor
(
    @precio_libro DECIMAL(10, 2),
    @ventas_totales INT,
    @porcentaje_regalias DECIMAL(5, 2) -- Ej: 0.10 para 10%
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @beneficio_bruto DECIMAL(18, 2);
    DECLARE @descuento DECIMAL(18, 2);
    DECLARE @beneficio_neto DECIMAL(18, 2);
    DECLARE @moneda NVARCHAR(10) = '$';
    IF @precio_libro <= 0 OR @ventas_totales <= 0 OR @porcentaje_regalias < 0 OR @porcentaje_regalias > 1
    BEGIN
        RETURN ' Datos de entrada invalidos';
    END
    SET @beneficio_bruto = @precio_libro * @ventas_totales * @porcentaje_regalias;
    IF @beneficio_bruto > 5000 AND @ventas_totales > 1000
    BEGIN
        SET @descuento = @beneficio_bruto * 0.05;
    END
    ELSE IF @beneficio_bruto BETWEEN 1000 AND 5000 AND @ventas_totales > 500
    BEGIN
        SET @descuento = @beneficio_bruto * 0.02;
    END
    ELSE
    BEGIN
        SET @descuento = 0;
    END;
    SET @beneficio_neto = @beneficio_bruto - @descuento;
    RETURN @moneda + FORMAT(@beneficio_neto, 'N2');
END;
GO

SELECT dbo.fn_CalculoBeneficioAutor(15.99, 1200, 0.10) AS BeneficioAutor1;
SELECT dbo.fn_CalculoBeneficioAutor(25.00, 500, 0.08) AS BeneficioAutor2;
SELECT dbo.fn_CalculoBeneficioAutor(10.00, 50, 0.05) AS BeneficioAutor3;
SELECT dbo.fn_CalculoBeneficioAutor(0, 100, 0.10) AS BeneficioAutorError;

if OBJECT_ID('filtracion_de_city')is not null
	drop function filtracion_de_city
go
create function filtracion_de_city(@ID varchar(11),  @Apellidos varchar(40) ,@Nombre varchar(20), @telefono char(12), @citys varchar(20))
RETURNS TABLE
AS
RETURN
(
    SELECT
        au_id AS ID_Autor,
        au_lname AS Apellido,
        au_fname AS Nombre,
        phone AS Telefono,
        city AS Ciudad,
        state AS Estado,
        zip AS CodigoPostal
    FROM
        authors
    WHERE
        city = @Citys 
);
GO
SELECT * FROM dbo.filtracion_de_city(NULL, NULL, NULL, NULL, 'Oakland');

GO

IF OBJECT_ID('convertir_en_M', 'FN') IS NOT NULL
    DROP FUNCTION convertir_en_M;
GO

CREATE FUNCTION convertir_en_M (@Autor varchar(20), @Apellido varchar(80))
RETURNS varchar(100)
AS
BEGIN
    RETURN UPPER(@Apellido + ', ' + @Autor);
END;
GO

SELECT dbo.convertir_en_M('White', 'Johnson') AS Nombre_Completo;

GO

IF OBJECT_ID('calcular_precio_con_iva', 'FN') IS NOT NULL
    DROP FUNCTION calcular_precio_con_iva;
GO
CREATE FUNCTION calcular_precio_con_iva (@Precio float)
RETURNS float
AS
BEGIN
    DECLARE @IVA float = 0.18;  
    RETURN @Precio * (1 + @IVA); 
END;
GO

-- Prueba de la función
SELECT dbo.calcular_precio_con_iva(100) AS Precio_Con_IVA;




------------ADVENTUREWORKS---------------------
-- Calcula la edad de una persona según su fecha de nacimiento.
GO
CREATE FUNCTION dbo.ufn_Calcularedad (@BirthDate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @BirthDate, GETDATE()) 
         - CASE 
             WHEN MONTH(@BirthDate) > MONTH(GETDATE()) 
               OR (MONTH(@BirthDate) = MONTH(GETDATE()) AND DAY(@BirthDate) > DAY(GETDATE()))
             THEN 1 
             ELSE 0 
           END;
END;
GO

SELECT 
    e.BusinessEntityID,
    p.FirstName,
    p.LastName,
    e.BirthDate,
    dbo.ufn_Calcularedad(e.BirthDate) AS Edad
FROM HumanResources.Employee e
JOIN Person.Person p
    ON e.BusinessEntityID = p.BusinessEntityID;


CREATE FUNCTION dbo.ufn_ProductMargin (
    @ProductID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Cost MONEY, @Price MONEY;

    SELECT @Cost = StandardCost, @Price = ListPrice
    FROM Production.Product
    WHERE ProductID = @ProductID;

    IF @Price = 0 RETURN 0;
    RETURN ((@Price - @Cost) / @Price) * 100;
END;

SELECT 
    ProductID,
    Name,
    StandardCost,
    ListPrice,
    dbo.ufn_ProductMargin(ProductID) AS MargenPorcentual
FROM Production.Product;

