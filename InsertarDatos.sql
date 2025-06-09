-- ========= INSERCIÓN MASIVA DE 200 ELEMENTOS POR TABLA =========
-- Nota: Para tablas como 'Categoria', se ha generado una cantidad menor y más lógica.
-- Para las tablas de detalle, se han generado múltiples registros por cada registro maestro
-- para mantener la coherencia de los datos.

-- ===============================================================
--                       CATÁLOGOS
-- ===============================================================

-- Clientes (200 registros)
PRINT 'Insertando 200 Clientes...';
GO
INSERT INTO Cliente (CodCLI, nombreCLI, paternoCLI, maternoCLI, celularCLI, direccionCLI, tipoDocCLI, nroDocCLI) VALUES
('CLI001', 'Alejandro', 'García', 'Martínez', '987654321', 'Av. Arequipa 101', 'DNI', '70123456'),
('CLI002', 'Beatriz', 'Rodríguez', 'López', '912345678', 'Jr. de la Unión 202', 'DNI', '71234567'),
('CLI003', 'Carlos', 'González', 'Pérez', '923456789', 'Calle Las Begonias 303', 'DNI', '72345678'),
('CLI004', 'Diana', 'Fernández', 'Gómez', '934567890', 'Av. Javier Prado 404', 'DNI', '73456789'),
('CLI005', 'Eduardo', 'Martín', 'Sánchez', '945678901', 'Paseo de la República 505', 'DNI', '74567890'),
('CLI006', 'Fernanda', 'Jiménez', 'Romero', '956789012', 'Av. Angamos 606', 'DNI', '75678901'),
('CLI007', 'Gabriel', 'Ruiz', 'Alonso', '967890123', 'Calle Schell 707', 'DNI', '76789012'),
('CLI008', 'Hugo', 'Díaz', 'Navarro', '978901234', 'Av. Benavides 808', 'DNI', '77890123'),
('CLI009', 'Irene', 'Moreno', 'Torres', '989012345', 'Jr. Ocoña 909', 'DNI', '78901234'),
('CLI010', 'Javier', 'Álvarez', 'Gutiérrez', '990123456', 'Av. La Marina 1010', 'DNI', '79012345');
-- Insertando el resto hasta 200
DECLARE @i_cli INT = 11;
WHILE @i_cli <= 200
BEGIN
    INSERT INTO Cliente (CodCLI, nombreCLI, paternoCLI, maternoCLI, celularCLI, direccionCLI, tipoDocCLI, nroDocCLI)
    VALUES (
        'CLI' + RIGHT('00' + CAST(@i_cli AS VARCHAR(3)), 3),
        'Nombre' + CAST(@i_cli AS VARCHAR(3)),
        'Paterno' + CAST(@i_cli AS VARCHAR(3)),
        'Materno' + CAST(@i_cli AS VARCHAR(3)),
        '9' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS VARCHAR(8)),
        'Dirección Ficticia ' + CAST(@i_cli AS VARCHAR(3)),
        'DNI',
        CAST(70000000 + @i_cli AS VARCHAR(8))
    );
    SET @i_cli = @i_cli + 1;
END;
GO

-- Proveedores (200 registros)
PRINT 'Insertando 200 Proveedores...';
GO
INSERT INTO Proveedor (CodProv, nombreProv, telefonoProv, direccionProv) VALUES
('PROV001', 'Distribuidora del Norte S.A.C.', '015551001', 'Av. Industrial 123, Independencia'),
('PROV002', 'Comercial del Sur S.R.L.', '015551002', 'Calle Los Artesanos 456, Villa El Salvador'),
('PROV003', 'Importaciones Central E.I.R.L.', '015551003', 'Jr. Paruro 789, Cercado de Lima'),
('PROV004', 'Alimentos Andinos S.A.', '015551004', 'Carretera Central Km 15, Ate'),
('PROV005', 'Bebidas Nacionales S.A.A.', '015551005', 'Av. Néstor Gambetta 101, Callao');
-- Insertando el resto hasta 200
DECLARE @i_prov INT = 6;
WHILE @i_prov <= 200
BEGIN
    INSERT INTO Proveedor (CodProv, nombreProv, telefonoProv, direccionProv)
    VALUES (
        'PROV' + RIGHT('00' + CAST(@i_prov AS VARCHAR(3)), 3),
        'Proveedor ' + CAST(@i_prov AS VARCHAR(10)) + ' S.A.C.',
        '9' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS VARCHAR(8)),
        'Dirección de Proveedor ' + CAST(@i_prov AS VARCHAR(10))
    );
    SET @i_prov = @i_prov + 1;
END;
GO

-- Categorías (20 registros, es más realista)
PRINT 'Insertando 20 Categorías...';
GO
INSERT INTO Categoria (CodCat, nombreCat) VALUES
('CAT001', 'Lácteos y Derivados'),
('CAT002', 'Bebidas y Gaseosas'),
('CAT003', 'Abarrotes y Conservas'),
('CAT004', 'Limpieza del Hogar'),
('CAT005', 'Cuidado Personal'),
('CAT006', 'Carnes y Aves'),
('CAT007', 'Pescados y Mariscos'),
('CAT008', 'Frutas y Verduras'),
('CAT009', 'Panadería y Pastelería'),
('CAT010', 'Golosinas y Snacks'),
('CAT011', 'Congelados'),
('CAT012', 'Comida para Mascotas'),
('CAT013', 'Licores y Vinos'),
('CAT014', 'Artículos de Oficina'),
('CAT015', 'Menaje y Cocina'),
('CAT016', 'Salud y Farmacia'),
('CAT017', 'Juguetería'),
('CAT018', 'Electrónicos Pequeños'),
('CAT019', 'Ropa y Accesorios'),
('CAT020', 'Libros y Revistas');
GO

-- Productos (200 registros)
PRINT 'Insertando 200 Productos...';
GO
INSERT INTO Producto (nombreProd, marcaProd, precioProd, stockProd, CodCat) VALUES
('Leche Evaporada Entera 400g', 'Gloria', 4.50, 150, 'CAT001'),
('Yogurt de Fresa 1L', 'Laive', 8.20, 80, 'CAT001'),
('Gaseosa 3L', 'Inka Kola', 11.50, 120, 'CAT002'),
('Agua sin Gas 2.5L', 'San Mateo', 4.00, 200, 'CAT002'),
('Arroz Extra Añejo 5kg', 'Costeño', 23.50, 90, 'CAT003'),
('Atún en Aceite Vegetal 170g', 'Florida', 6.80, 250, 'CAT003'),
('Aceite Vegetal 1L', 'Primor', 10.20, 110, 'CAT003'),
('Detergente en Polvo 2kg', 'Ariel', 25.00, 60, 'CAT004'),
('Lavavajillas Líquido 500ml', 'Ayudín', 7.50, 75, 'CAT004'),
('Jabón de Tocador 3-pack', 'Neko', 9.90, 130, 'CAT005'),
('Shampoo Anticaspa 400ml', 'Head & Shoulders', 18.50, 55, 'CAT005'),
('Pechuga de Pollo Fresca (kg)', 'San Fernando', 15.00, 40, 'CAT006'),
('Filete de Tilapia (kg)', 'Genérico', 22.00, 30, 'CAT007'),
('Manzana Fuji (kg)', 'Genérico', 5.50, 100, 'CAT008'),
('Pan de Molde Blanco', 'Bimbo', 8.00, 80, 'CAT009'),
('Papas Fritas Onduladas 150g', 'Lays', 6.50, 150, 'CAT010'),
('Hamburguesas de Carne 4-pack', 'Redondos', 14.00, 60, 'CAT011'),
('Comida para Perro Adulto 3kg', 'Ricocan', 35.00, 45, 'CAT012'),
('Vino Tinto Malbec 750ml', 'Tabernero', 28.00, 50, 'CAT013'),
('Cuaderno Cuadriculado A4', 'Standford', 7.00, 90, 'CAT014');
-- Insertando el resto hasta 200
DECLARE @i_prod INT = 21;
WHILE @i_prod <= 200
BEGIN
    DECLARE @cat_num INT = 1 + (ABS(CHECKSUM(NEWID())) % 20); -- Elige una categoría del 1 al 20
    INSERT INTO Producto (nombreProd, marcaProd, precioProd, stockProd, CodCat)
    VALUES (
        'Producto ' + CAST(@i_prod AS VARCHAR(3)),
        'Marca ' + CHAR(65 + (ABS(CHECKSUM(NEWID())) % 26)), -- Marca A, B, C...
        ROUND(10 + (RAND() * 190), 2), -- Precio entre 10.00 y 200.00
        ABS(CHECKSUM(NEWID())) % 201, -- Stock entre 0 y 200
        'CAT' + RIGHT('00' + CAST(@cat_num AS VARCHAR(2)), 3)
    );
    SET @i_prod = @i_prod + 1;
END;
GO

-- ===============================================================
--                       TRANSACCIONES
-- ===============================================================

-- Comprobantes (200 registros)
-- NOTA: El total se calculará después de insertar los detalles.
-- Por ahora se inserta con total 0 y luego se actualiza.
PRINT 'Insertando 200 Comprobantes (con total temporal en 0)...';
GO
DECLARE @i_com INT = 1;
WHILE @i_com <= 200
BEGIN
    DECLARE @cli_num INT = 1 + (ABS(CHECKSUM(NEWID())) % 200);
    INSERT INTO Comprobante (tipodeCom, fechaCom, totalCom, CodCLI)
    VALUES (
        CASE WHEN RAND() > 0.5 THEN 'Boleta' ELSE 'Factura' END,
        DATEADD(day, - (ABS(CHECKSUM(NEWID())) % 365), GETDATE()), -- Fecha aleatoria en el último año
        0.00, -- Total temporal
        'CLI' + RIGHT('00' + CAST(@cli_num AS VARCHAR(3)), 3)
    );
    SET @i_com = @i_com + 1;
END;
GO

-- Detalle de Comprobantes (aprox. 3-5 detalles por comprobante)
PRINT 'Insertando Detalles de Comprobante (múltiples por comprobante)...';
GO
DECLARE @id_com_det INT = 1;
WHILE @id_com_det <= 200
BEGIN
    DECLARE @num_detalles INT = 2 + (ABS(CHECKSUM(NEWID())) % 4); -- Entre 2 y 5 detalles
    DECLARE @j_det INT = 1;
    WHILE @j_det <= @num_detalles
    BEGIN
        DECLARE @id_prod_det INT = 1 + (ABS(CHECKSUM(NEWID())) % 200);
        DECLARE @cantidad_det INT = 1 + (ABS(CHECKSUM(NEWID())) % 5);
        DECLARE @precio_det DECIMAL(10, 2);

        SELECT @precio_det = precioProd FROM Producto WHERE IDProd = @id_prod_det;

        INSERT INTO Detalle (cantidadDet, precioUniDet, subtotalDet, IDCom, IDProd)
        VALUES (
            @cantidad_det,
            @precio_det,
            @cantidad_det * @precio_det,
            @id_com_det,
            @id_prod_det
        );

        -- Reducir stock (lógica de negocio importante)
        UPDATE Producto SET stockProd = stockProd - @cantidad_det WHERE IDProd = @id_prod_det;

        SET @j_det = @j_det + 1;
    END;
    SET @id_com_det = @id_com_det + 1;
END;
GO

-- Actualizar Totales de Comprobantes
PRINT 'Actualizando los totales de los Comprobantes...';
GO
UPDATE C
SET C.totalCom = ISNULL(DS.SumaSubtotales, 0)
FROM Comprobante C
LEFT JOIN (
    SELECT IDCom, SUM(subtotalDet) AS SumaSubtotales
    FROM Detalle
    GROUP BY IDCom
) AS DS ON C.IDCom = DS.IDCom;
GO


-- Órdenes de Compra (200 registros)
PRINT 'Insertando 200 Órdenes de Compra...';
GO
DECLARE @i_oc INT = 1;
WHILE @i_oc <= 200
BEGIN
    DECLARE @prov_num_oc INT = 1 + (ABS(CHECKSUM(NEWID())) % 200);
    INSERT INTO OrdenDeCompra (fechaOC, estadoOC, CodProv)
    VALUES (
        DATEADD(day, - (ABS(CHECKSUM(NEWID())) % 365), GETDATE()), -- Fecha aleatoria en el último año
        CASE CAST(RAND() * 3 AS INT)
            WHEN 0 THEN 'Pendiente'
            WHEN 1 THEN 'Completado'
            ELSE 'Cancelado'
        END,
        'PROV' + RIGHT('00' + CAST(@prov_num_oc AS VARCHAR(3)), 3)
    );
    SET @i_oc = @i_oc + 1;
END;
GO

-- Detalle de Órdenes de Compra (aprox. 5-10 detalles por orden)
PRINT 'Insertando Detalles de Órden de Compra (múltiples por orden)...';
GO
DECLARE @id_oc_det INT = 1;
WHILE @id_oc_det <= 200
BEGIN
    DECLARE @estado_oc VARCHAR(20);
    SELECT @estado_oc = estadoOC FROM OrdenDeCompra WHERE IDOC = @id_oc_det;

    -- Solo añadir detalles a órdenes que no estén canceladas
    IF @estado_oc <> 'Cancelado'
    BEGIN
        DECLARE @num_detalles_oc INT = 5 + (ABS(CHECKSUM(NEWID())) % 6); -- Entre 5 y 10 detalles
        DECLARE @j_det_oc INT = 1;
        WHILE @j_det_oc <= @num_detalles_oc
        BEGIN
            DECLARE @id_prod_oc INT = 1 + (ABS(CHECKSUM(NEWID())) % 200);
            DECLARE @cantidad_oc INT = 10 + (ABS(CHECKSUM(NEWID())) % 91); -- Comprar entre 10 y 100 unidades
            DECLARE @precio_venta_oc DECIMAL(10, 2);
            DECLARE @precio_compra_oc DECIMAL(10, 2);

            SELECT @precio_venta_oc = precioProd FROM Producto WHERE IDProd = @id_prod_oc;
            
            -- El precio de compra es un 60%-80% del precio de venta
            SET @precio_compra_oc = ROUND(@precio_venta_oc * (0.6 + RAND() * 0.2), 2);

            INSERT INTO DetalleOrdenDeCompra (IDOC, IDProd, cantidadComprada, precioCompraUnitario)
            VALUES (
                @id_oc_det,
                @id_prod_oc,
                @cantidad_oc,
                @precio_compra_oc
            );

            -- Si la orden está completada, actualizar el stock del producto
            IF @estado_oc = 'Completado'
            BEGIN
                UPDATE Producto SET stockProd = stockProd + @cantidad_oc WHERE IDProd = @id_prod_oc;
            END;

            SET @j_det_oc = @j_det_oc + 1;
        END;
    END;
    SET @id_oc_det = @id_oc_det + 1;
END;
GO

PRINT '======== PROCESO DE INSERCIÓN MASIVA COMPLETADO ========';
GO