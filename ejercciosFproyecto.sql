USE BDHualmarket;
GO
-- 2.1. CREACIÓN DE TABLAS ADICIONALES (NECESARIA PARA UN TRIGGER)
-- Tabla para Auditoría de cambios de precio en productos
CREATE TABLE AuditoriaPrecios (
    IDAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    IDProd INT,
    precioAnterior DECIMAL(10,2),
    precioNuevo DECIMAL(10,2),
    usuario VARCHAR(100),
    fechaModificacion DATETIME
);
GO

-- 2.2. CREACIÓN DE VISTAS (3 VISTAS)
-- Crear una vista Vista_Reporte_Ventas para simplificar el acceso a un reporte detallado de ventas
CREATE OR ALTER VIEW Vista_Reporte_Ventas AS
SELECT
    co.IDCom,
    co.fechaCom,
    co.tipodeCom,
    c.CodCLI,
    c.nombreCLI + ' ' + c.paternoCLI AS cliente,
    p.IDProd,
    p.nombreProd,
    ca.nombreCat AS categoria,
    d.cantidadDet,
    d.precioUniDet,
    d.subtotalDet
FROM Comprobante co
JOIN Cliente c ON co.CodCLI = c.CodCLI
JOIN Detalle d ON co.IDCom = d.IDCom
JOIN Producto p ON d.IDProd = p.IDProd
JOIN Categoria ca ON p.CodCat = ca.CodCat;
GO

-- Inventario Detallado de Productos
CREATE OR ALTER VIEW Vista_Inventario_General AS
SELECT
    p.IDProd,
    p.nombreProd,
    p.marcaProd,
    ca.nombreCat AS categoria,
    p.stockProd,
    p.precioProd
FROM Producto p
JOIN Categoria ca ON p.CodCat = ca.CodCat;
GO

-- Resumen de Gasto por Cliente
CREATE OR ALTER VIEW Vista_Gasto_Total_Cliente AS
SELECT
    c.CodCLI,
    c.nombreCLI,
    c.paternoCLI,
    SUM(co.totalCom) AS gasto_total
FROM Cliente c
JOIN Comprobante co ON c.CodCLI = co.CodCLI
GROUP BY c.CodCLI, c.nombreCLI, c.paternoCLI;
GO

-- 2.3. CREACIÓN DE PROCEDIMIENTOS ALMACENADOS (3 PROCEDIMIENTOS)
-- Crear un procedimiento que, dado un CodCLI, devuelva todas las compras que ha realizado
CREATE OR ALTER PROCEDURE dbo.Obtener_Historial_Cliente
    @p_cod_cli VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        co.fechaCom AS fecha_compra,
        co.tipodeCom AS tipo_comprobante,
        co.totalCom AS total_pagado
    FROM Comprobante co
    WHERE co.CodCLI = @p_cod_cli
    ORDER BY co.fechaCom DESC;
END
GO

-- Crear un procedimiento Actualizar_Stock que reciba un ID de producto y una cantidad para actualizar el inventario
CREATE OR ALTER PROCEDURE dbo.Actualizar_Stock
    @p_id_prod INT,
    @p_cantidad_cambio INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Producto
    SET stockProd = stockProd + @p_cantidad_cambio
    WHERE IDProd = @p_id_prod;

    PRINT 'Stock del producto ' + CAST(@p_id_prod AS VARCHAR) + ' actualizado correctamente.';
END
GO

-- Crear un procedimiento que inserte un producto, verificando primero que su categoría exista.
CREATE OR ALTER PROCEDURE dbo.Registrar_Producto_Seguro
    @p_nombre VARCHAR(50),
    @p_marca VARCHAR(50),
    @p_precio DECIMAL(10,2),
    @p_stock INT,
    @p_cod_cat VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Categoria WHERE CodCat = @p_cod_cat)
    BEGIN
        RAISERROR('La categoría %s no existe. No se puede registrar el producto.', 16, 1, @p_cod_cat);
        RETURN;
    END

    INSERT INTO Producto (nombreProd, marcaProd, precioProd, stockProd, CodCat)
    VALUES (@p_nombre, @p_marca, @p_precio, @p_stock, @p_cod_cat);

    PRINT 'Producto "' + @p_nombre + '" registrado con éxito.';
END
GO

-- 2.4. CREACIÓN DE TRIGGERS (3 TRIGGERS)
-- Trigger que actualice automáticamente el stock de un producto al registrar una venta.
CREATE OR ALTER TRIGGER TRG_ActualizarStock_Venta
ON dbo.Detalle
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE p
    SET p.stockProd = p.stockProd - i.cantidadDet
    FROM Producto p
    INNER JOIN inserted i ON p.IDProd = i.IDProd;
    PRINT 'Trigger TRG_ActualizarStock_Venta ejecutado: Stock actualizado.';
END
GO

-- Trigger para auditar cambios de precio en productos
CREATE OR ALTER TRIGGER TRG_AuditarCambioDePrecio
ON dbo.Producto
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(precioProd)
    BEGIN
        INSERT INTO AuditoriaPrecios (IDProd, precioAnterior, precioNuevo, usuario, fechaModificacion)
        SELECT
            i.IDProd,
            d.precioProd,
            i.precioProd,
            SUSER_SNAME(),
            GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.IDProd = d.IDProd
        WHERE i.precioProd <> d.precioProd;
    END
END
GO

-- Trigger para prevenir la eliminación de productos con stock
CREATE OR ALTER TRIGGER TRG_PrevenirBorradoProductoConStock
ON dbo.Producto
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM deleted WHERE stockProd > 0)
    BEGIN
        RAISERROR('No se puede eliminar un producto con stock existente. Ajuste el inventario a cero primero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE p
        FROM Producto p
        INNER JOIN deleted d ON p.IDProd = d.IDProd;
    END
END
GO


-- ===================================================================
-- 3. EJECUCIÓN DE CONSULTAS Y PRUEBAS
-- ===================================================================

-- 3.1. CONSULTAS DE REPORTE (JOINS, LEFT JOINS, ANIDADAS)

-- Ejercicios de 3 JOIN
-- Generar un reporte completo para el comprobante con IDCom = 1
SELECT
    c.nombreCLI + ' ' + c.paternoCLI AS cliente,
    co.fechaCom,
    co.tipodeCom,
    p.nombreProd,
    d.cantidadDet,
    d.subtotalDet
FROM Comprobante co
JOIN Cliente c ON co.CodCLI = c.CodCLI
JOIN Detalle d ON co.IDCom = d.IDCom
JOIN Producto p ON d.IDProd = p.IDProd
WHERE co.IDCom = 1;

-- Listar todos los productos adquiridos, mostrando proveedor y fecha
SELECT
    pr.nombreProv AS proveedor,
    oc.fechaOC,
    p.nombreProd,
    p.marcaProd,
    doc.cantidadComprada,
    doc.precioCompraUnitario
FROM Proveedor pr
JOIN OrdenDeCompra oc ON pr.CodProv = oc.CodProv
JOIN DetalleOrdenDeCompra doc ON oc.IDOC = doc.IDOC
JOIN Producto p ON doc.IDProd = p.IDProd
ORDER BY pr.nombreProv, oc.fechaOC;

-- Mostrar total vendido por cada categoría
SELECT
    ca.nombreCat,
    SUM(d.subtotalDet) AS total_vendido_por_categoria
FROM Detalle d
JOIN Producto p ON d.IDProd = p.IDProd
JOIN Categoria ca ON p.CodCat = ca.CodCat
GROUP BY ca.nombreCat
ORDER BY total_vendido_por_categoria DESC;
GO

-- 3 Consultas con LEFT JOIN
-- Identificar a los clientes que aún no han realizado ninguna compra
SELECT
    c.CodCLI,
    c.nombreCLI,
    c.paternoCLI,
    c.celularCLI
FROM Cliente c
LEFT JOIN Comprobante co ON c.CodCLI = co.CodCLI
WHERE co.IDCom IS NULL;

-- Productos que nunca han sido vendidos
SELECT
    p.IDProd,
    p.nombreProd,
    p.marcaProd,
    p.stockProd
FROM Producto p
LEFT JOIN Detalle d ON p.IDProd = d.IDProd
WHERE d.IDDet IS NULL;

-- Proveedores con órdenes de compra pendientes
SELECT
    pr.nombreProv,
    oc.IDOC,
    oc.fechaOC,
    oc.estadoOC
FROM Proveedor pr
LEFT JOIN OrdenDeCompra oc ON pr.CodProv = oc.CodProv AND oc.estadoOC = 'Pendiente';
GO

-- Consultas Anidadas
-- Clientes que han comprado 'Aceite Vegetal 1L'
SELECT CodCLI, nombreCLI, paternoCLI
FROM Cliente
WHERE CodCLI IN (
    SELECT co.CodCLI
    FROM Comprobante co
    JOIN Detalle d ON co.IDCom = d.IDCom
    WHERE d.IDProd = (SELECT IDProd FROM Producto WHERE nombreProd = 'Aceite Vegetal 1L')
);

-- Productos cuyo precio de venta es superior al precio promedio
SELECT nombreProd, marcaProd, precioProd
FROM Producto
WHERE precioProd > (SELECT AVG(precioProd) FROM Producto);

-- Total gastado por el cliente que más ha comprado (Nota: Esta consulta tiene una lógica compleja, puede ser mejorada)
SELECT
    c.nombreCLI,
    c.paternoCLI,
    (SELECT TOP (1) totalCom FROM Comprobante WHERE CodCLI = c.CodCLI ORDER BY totalCom DESC) AS mayor_compra
FROM Cliente c
WHERE c.CodCLI = (
    SELECT TOP (1) CodCLI
    FROM Comprobante
    GROUP BY CodCLI
    ORDER BY SUM(totalCom) DESC
);
GO

-- 3.2. PRUEBAS DE LOS OBJETOS CREADOS

-- Uso de las Vistas
PRINT '--- USANDO VISTA: Vista_Reporte_Ventas ---';
SELECT IDCom, cliente, nombreProd, cantidadDet, subtotalDet FROM Vista_Reporte_Ventas WHERE IDCom = 1;
GO
PRINT '--- USANDO VISTA: Vista_Inventario_General ---';
SELECT * FROM Vista_Inventario_General WHERE categoria = 'Abarrotes';
GO
PRINT '--- USANDO VISTA: Vista_Gasto_Total_Cliente ---';
SELECT * FROM Vista_Gasto_Total_Cliente ORDER BY gasto_total DESC;
GO

-- Uso de los Procedimientos Almacenados
PRINT '--- USANDO PROCEDIMIENTO: Obtener_Historial_Cliente ---';
EXEC dbo.Obtener_Historial_Cliente @p_cod_cli = 'CLI002';
GO
PRINT '--- USANDO PROCEDIMIENTO: Actualizar_Stock ---';
EXEC dbo.Actualizar_Stock @p_id_prod = 1, @p_cantidad_cambio = -5;
SELECT nombreProd, stockProd FROM Producto WHERE IDProd = 1;
GO
PRINT '--- USANDO PROCEDIMIENTO: Registrar_Producto_Seguro (CASO ÉXITO) ---';
EXEC dbo.Registrar_Producto_Seguro 
    @p_nombre = 'Lejía 1L', 
    @p_marca = 'Clorox', 
    @p_precio = 3.50, 
    @p_stock = 50, 
    @p_cod_cat = 'CAT04';
GO
PRINT '--- USANDO PROCEDIMIENTO: Registrar_Producto_Seguro (CASO ERROR) ---';
EXEC dbo.Registrar_Producto_Seguro 
    @p_nombre = 'Snack de Queso', 
    @p_marca = 'Piqueo', 
    @p_precio = 2.00, 
    @p_stock = 100, 
    @p_cod_cat = 'CAT99'; -- Categoría que no existe
GO

-- Pruebas de los Triggers
PRINT '--- PROBANDO TRIGGER: TRG_ActualizarStock_Venta ---';
SELECT nombreProd, stockProd FROM Producto WHERE IDProd = 6;
INSERT INTO Detalle (cantidadDet, precioUniDet, subtotalDet, IDCom, IDProd) VALUES (2, 15.00, 30.00, 2, 6);
SELECT nombreProd, stockProd FROM Producto WHERE IDProd = 6;
GO

PRINT '--- PROBANDO TRIGGER: TRG_AuditarCambioDePrecio ---';
UPDATE Producto SET precioProd = 4.75 WHERE IDProd = 1;
SELECT * FROM AuditoriaPrecios;
GO

PRINT '--- PROBANDO TRIGGER: TRG_PrevenirBorradoProductoConStock ---';
-- Este DELETE debería fallar si el producto 4 tiene stock > 0
DELETE FROM Producto WHERE IDProd = 4;
GO
-- Este DELETE (que estaba al inicio de tu script) funcionará solo si el producto 7 tiene stock = 0
DELETE FROM Producto WHERE IDProd = 7;
GO