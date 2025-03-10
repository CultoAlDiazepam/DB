SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de datos: `bdhualmarket`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `CodCat` varchar(50) NOT NULL,
  `nombreCat` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `CodCLI` varchar(50) NOT NULL,
  `nombreCLI` varchar(50) DEFAULT NULL,
  `paternoCLI` varchar(50) DEFAULT NULL,
  `maternoCLI` varchar(50) DEFAULT NULL,
  `celularCLI` varchar(9) DEFAULT NULL,
  `direccionCLI` varchar(50) DEFAULT NULL,
  `tipoDocCLI` varchar(50) DEFAULT NULL,
  `nroDocCLI` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobante`
--

CREATE TABLE `comprobante` (
  `IDCom` int(11) NOT NULL,
  `tipodeCom` varchar(50) DEFAULT NULL,
  `fechaCom` date DEFAULT NULL,
  `totalCom` decimal(10,2) DEFAULT NULL,
  `CodCLI` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle`
--

CREATE TABLE `detalle` (
  `IDDet` int(11) NOT NULL,
  `cantidadDet` int(11) DEFAULT NULL,
  `precioUniDet` decimal(10,2) DEFAULT NULL,
  `descuentoDet` decimal(10,2) DEFAULT NULL,
  `subtotalDet` decimal(10,2) DEFAULT NULL,
  `impuestoDet` decimal(10,2) DEFAULT NULL,
  `IDCom` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordendecompra`
--

CREATE TABLE `ordendecompra` (
  `IDOC` int(11) NOT NULL,
  `estadoOC` varchar(50) DEFAULT NULL,
  `descripcionOC` varchar(50) DEFAULT NULL,
  `CodProv` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `IDProd` int(11) NOT NULL,
  `nombreProd` varchar(50) DEFAULT NULL,
  `marcaProd` varchar(50) DEFAULT NULL,
  `precioProd` decimal(10,2) DEFAULT NULL,
  `CodCat` varchar(50) DEFAULT NULL,
  `IDOC` int(11) DEFAULT NULL,
  `IDDet` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `CodProv` varchar(50) NOT NULL,
  `nombreProv` varchar(50) DEFAULT NULL,
  `telefonoProv` varchar(9) DEFAULT NULL,
  `direccionProv` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`CodCat`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`CodCLI`);

--
-- Indices de la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD PRIMARY KEY (`IDCom`),
  ADD KEY `CodCLI` (`CodCLI`);

--
-- Indices de la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD PRIMARY KEY (`IDDet`),
  ADD KEY `IDCom` (`IDCom`);

--
-- Indices de la tabla `ordendecompra`
--
ALTER TABLE `ordendecompra`
  ADD PRIMARY KEY (`IDOC`),
  ADD KEY `CodProv` (`CodProv`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IDProd`),
  ADD KEY `CodCat` (`CodCat`),
  ADD KEY `IDOC` (`IDOC`),
  ADD KEY `IDDet` (`IDDet`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`CodProv`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comprobante`
--
ALTER TABLE `comprobante`
  MODIFY `IDCom` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle`
--
ALTER TABLE `detalle`
  MODIFY `IDDet` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ordendecompra`
--
ALTER TABLE `ordendecompra`
  MODIFY `IDOC` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IDProd` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD CONSTRAINT `comprobante_ibfk_1` FOREIGN KEY (`CodCLI`) REFERENCES `cliente` (`CodCLI`);

--
-- Filtros para la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD CONSTRAINT `detalle_ibfk_1` FOREIGN KEY (`IDCom`) REFERENCES `comprobante` (`IDCom`);

--
-- Filtros para la tabla `ordendecompra`
--
ALTER TABLE `ordendecompra`
  ADD CONSTRAINT `ordendecompra_ibfk_1` FOREIGN KEY (`CodProv`) REFERENCES `proveedor` (`CodProv`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`CodCat`) REFERENCES `categoria` (`CodCat`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`IDOC`) REFERENCES `ordendecompra` (`IDOC`),
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`IDDet`) REFERENCES `detalle` (`IDDet`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
