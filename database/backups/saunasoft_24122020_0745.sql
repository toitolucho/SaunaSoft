-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 24, 2020 at 12:45 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `saunasoft`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `ObtenerCodigoProducto` (`IdCategoria1` INT) RETURNS CHAR(10) CHARSET utf8mb4 BEGIN
    DECLARE CodigoCategoria CHAR(10);
	DECLARE CantidadArticulos INT;

    SELECT count(idArticulo) INTO CantidadArticulos
    FROM Articulos
    WHERE IdCategoria = IdCategoria1;

	SET CantidadArticulos = CantidadArticulos + 1;

	SET CodigoCategoria = RIGHT(CONCAT('0000000' , CAST(CantidadArticulos AS VARCHAR(10))),7);


    SELECT IF( EXISTS(
             SELECT IdCategoria
             FROM Categorias
             WHERE IdCategoria = IdCategoria1),
              CONCAT(IdCategoria1, '-',CodigoCategoria),
              CodigoCategoria) into CodigoCategoria;

    -- return the customer level
    RETURN ( CodigoCategoria);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `articulos`
--

CREATE TABLE `articulos` (
  `IdArticulo` int(11) NOT NULL,
  `CodigoArticulo` char(10) DEFAULT NULL,
  `NombreArticulo` varchar(200) DEFAULT NULL,
  `IdCategoria` int(11) DEFAULT NULL,
  `CantidadExistencia` int(11) DEFAULT NULL,
  `PrecioVigente` decimal(10,2) DEFAULT NULL,
  `TotalValorado` decimal(10,2) DEFAULT NULL,
  `TipoInventario` char(1) DEFAULT NULL,
  `Descripcion` varchar(500) DEFAULT NULL,
  `FechaVencimiento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `articulos`
--

INSERT INTO `articulos` (`IdArticulo`, `CodigoArticulo`, `NombreArticulo`, `IdCategoria`, `CantidadExistencia`, `PrecioVigente`, `TotalValorado`, `TipoInventario`, `Descripcion`, `FechaVencimiento`) VALUES
(1, '10-0000001', 'Té Dharamsala', 10, 10, '0.00', '0.00', 'P', NULL, NULL),
(2, '6-0000001', 'Cerveza tibetana Barley', 11, 10, '0.00', '0.00', 'P', NULL, NULL),
(3, '10-0000002', 'Sirope de regaliz', 14, 10, '0.00', '0.00', 'P', NULL, NULL),
(4, '9-0000001', 'Especias Cajun del chef Anton', 3, 10, '0.00', '0.00', 'P', NULL, NULL),
(5, '2-0000001', 'Mezcla Gumbo del chef Anton', 2, 10, '0.00', '0.00', 'P', NULL, NULL),
(6, '4-0000001', 'Mermelada de grosellas de la abuela', 11, 10, '0.00', '0.00', 'P', NULL, NULL),
(7, '12-0000001', 'Peras secas orgánicas del tío Bob', 12, 10, '0.00', '0.00', 'P', NULL, NULL),
(8, '9-0000001', 'Salsa de arándanos Northwoods', 8, 10, '0.00', '0.00', 'P', NULL, NULL),
(9, '12-0000002', 'Buey Mishi Kobe', 5, 10, '0.00', '0.00', 'P', NULL, NULL),
(10, '6-0000001', 'Pez espada', 13, 10, '0.00', '0.00', 'P', NULL, NULL),
(11, '1-0000001', 'Queso Cabrales', 11, 10, '0.00', '0.00', 'P', NULL, NULL),
(12, '8-0000002', 'Queso Manchego La Pastora', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(13, '5-0000002', 'Algas Konbu', 8, 10, '0.00', '0.00', 'P', NULL, NULL),
(14, '7-0000001', 'Cuajada de judías', 10, 10, '0.00', '0.00', 'P', NULL, NULL),
(15, '1-0000001', 'Salsa de soja baja en sodio', 5, 10, '0.00', '0.00', 'P', NULL, NULL),
(16, '5-0000003', 'Postre de merengue Pavlova', 11, 10, '0.00', '0.00', 'P', NULL, NULL),
(17, '7-0000001', 'Cordero Alice Springs', 3, 10, '0.00', '0.00', 'P', NULL, NULL),
(18, '9-0000001', 'Langostinos tigre Carnarvon', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(19, '2-0000002', 'Pastas de té de chocolate', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(20, '10-0000003', 'Mermelada de Sir Rodneys', 14, 10, '0.00', '0.00', 'P', NULL, NULL),
(21, '12-0000002', 'Bollos de Sir Rodneys', 2, 10, '0.00', '0.00', 'P', NULL, NULL),
(22, '1-0000001', 'Pan de centeno crujiente estilo Gustafs', 1, 10, '0.00', '0.00', 'P', NULL, NULL),
(23, '14-0000003', 'Pan fino', 8, 10, '0.00', '0.00', 'P', NULL, NULL),
(24, '14-0000003', 'Refresco Guaraná Fantástica', 13, 10, '0.00', '0.00', 'P', NULL, NULL),
(25, '8-0000004', 'Crema de chocolate y nueces NuNuCa', 2, 10, '0.00', '0.00', 'P', NULL, NULL),
(26, '15-0000001', 'Ositos de goma Gumbär', 7, 10, '0.00', '0.00', 'P', NULL, NULL),
(27, '6-0000004', 'Chocolate Schoggi', 9, 10, '0.00', '0.00', 'P', NULL, NULL),
(28, '12-0000002', 'Col fermentada Rössle', 15, 10, '0.00', '0.00', 'P', NULL, NULL),
(29, '11-0000005', 'Salchicha Thüringer', 9, 10, '0.00', '0.00', 'P', NULL, NULL),
(30, '11-0000005', 'Arenque blanco del noroeste', 14, 10, '0.00', '0.00', 'P', NULL, NULL),
(31, '6-0000004', 'Queso gorgonzola Telino', 4, 10, '0.00', '0.00', 'P', NULL, NULL),
(32, '1-0000002', 'Queso Mascarpone Fabioli', 7, 10, '0.00', '0.00', 'P', NULL, NULL),
(33, '15-0000002', 'Queso de cabra', 9, 10, '0.00', '0.00', 'P', NULL, NULL),
(34, '13-0000003', 'Cerveza Sasquatch', 9, 10, '0.00', '0.00', 'P', NULL, NULL),
(35, '5-0000003', 'Cerveza negra Steeleye', 13, 10, '0.00', '0.00', 'P', NULL, NULL),
(36, '3-0000003', 'Escabeche de arenque', 7, 10, '0.00', '0.00', 'P', NULL, NULL),
(37, '11-0000005', 'Salmón ahumado Gravad', 1, 10, '0.00', '0.00', 'P', NULL, NULL),
(38, '2-0000004', 'Vino Côte de Blaye', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(39, '9-0000005', 'Licor verde Chartreuse', 11, 10, '0.00', '0.00', 'P', NULL, NULL),
(40, '12-0000002', 'Carne de cangrejo de Boston', 11, 10, '0.00', '0.00', 'P', NULL, NULL),
(41, '3-0000003', 'Crema de almejas estilo Nueva Inglaterra', 12, 10, '0.00', '0.00', 'P', NULL, NULL),
(42, '6-0000005', 'Tallarines de Singapur', 8, 10, '0.00', '0.00', 'P', NULL, NULL),
(43, '6-0000005', 'Café de Malasia', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(44, '13-0000004', 'Azúcar negra Malacca', 1, 10, '0.00', '0.00', 'P', NULL, NULL),
(45, '11-0000007', 'Arenque ahumado', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(46, '10-0000003', 'Arenque salado', 2, 10, '0.00', '0.00', 'P', NULL, NULL),
(47, '10-0000003', 'Galletas Zaanse', 13, 10, '0.00', '0.00', 'P', NULL, NULL),
(48, '4-0000002', 'Chocolate holandés', 12, 10, '0.00', '0.00', 'P', NULL, NULL),
(49, '3-0000003', 'Regaliz', 7, 10, '0.00', '0.00', 'P', NULL, NULL),
(50, '9-0000005', 'Chocolate blanco', 10, 10, '0.00', '0.00', 'P', NULL, NULL),
(51, '9-0000005', 'Manzanas secas Manjimup', 15, 10, '0.00', '0.00', 'P', NULL, NULL),
(52, '2-0000005', 'Cereales para Filo', 10, 10, '0.00', '0.00', 'P', NULL, NULL),
(53, '14-0000004', 'Empanada de carne', 8, 10, '0.00', '0.00', 'P', NULL, NULL),
(54, '12-0000004', 'Empanada de cerdo', 5, 10, '0.00', '0.00', 'P', NULL, NULL),
(55, '4-0000002', 'Paté chino', 5, 10, '0.00', '0.00', 'P', NULL, NULL),
(56, '13-0000005', 'Gnocchi de la abuela Alicia', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(57, '4-0000002', 'Raviolis Angelo', 2, 10, '0.00', '0.00', 'P', NULL, NULL),
(58, '14-0000004', 'Caracoles de Borgoña', 3, 10, '0.00', '0.00', 'P', NULL, NULL),
(59, '4-0000002', 'Raclet de queso Courdavault', 10, 10, '0.00', '0.00', 'P', NULL, NULL),
(60, '5-0000005', 'Camembert Pierrot', 12, 10, '0.00', '0.00', 'P', NULL, NULL),
(61, '13-0000005', 'Sirope de arce', 1, 10, '0.00', '0.00', 'P', NULL, NULL),
(62, '8-0000006', 'Tarta de azúcar', 7, 10, '0.00', '0.00', 'P', NULL, NULL),
(63, '12-0000005', 'Sandwich de vegetales', 9, 10, '10.00', '0.00', 'P', NULL, NULL),
(64, '7-0000006', 'Bollos de pan de Wimmer', 10, 10, '0.00', '0.00', 'P', NULL, NULL),
(65, '11-0000007', 'Salsa de pimiento picante de Luisiana', 10, 10, '0.00', '0.00', 'P', NULL, NULL),
(66, '15-0000003', 'Especias picantes de Luisiana', 3, 10, '0.00', '0.00', 'P', NULL, NULL),
(67, '12-0000005', 'Cerveza Laughing Lumberjack', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(68, '7-0000006', 'Barras de pan de Escocia', 3, 10, '0.00', '0.00', 'P', NULL, NULL),
(69, '9-0000006', 'Queso Gudbrandsdals', 7, 10, '0.00', '0.00', 'P', NULL, NULL),
(70, '5-0000005', 'Cerveza Outback', 3, 10, '0.00', '0.00', 'P', NULL, NULL),
(71, '14-0000004', 'Crema de queso Fløtemys', 1, 10, '0.00', '0.00', 'P', NULL, NULL),
(72, '6-0000009', 'Queso Mozzarella Giovanni', 14, 10, '0.00', '0.00', 'P', NULL, NULL),
(73, '7-0000007', 'Caviar rojo', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(74, '11-0000007', 'Queso de soja Longlife', 4, 10, '0.00', '0.00', 'P', NULL, NULL),
(75, '4-0000003', 'Cerveza Klosterbier Rhönbräu', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(76, '1-0000006', 'Licor Cloudberry', 2, 10, '0.00', '0.00', 'P', NULL, NULL),
(77, '9-0000006', 'Salsa verde original Frankfurter', 6, 10, '0.00', '0.00', 'P', NULL, NULL),
(78, NULL, 'Agua Vital', 9, 0, '25.00', NULL, NULL, 'prueba de datos', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `IdCategoria` int(11) NOT NULL,
  `NombreCategoria` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`IdCategoria`, `NombreCategoria`) VALUES
(10, 'Agua del grifo'),
(9, 'Agua Mineral'),
(11, 'Arroces'),
(12, 'Base Pan'),
(1, 'Bebidas'),
(14, 'Bebidas con Azucar'),
(13, 'Bebidas Light'),
(15, 'Bolleria'),
(16, 'Café'),
(4, 'Carnes'),
(17, 'Cereales'),
(18, 'Cerveza'),
(19, 'Chocolate'),
(2, 'Condimentos'),
(46, 'Cordero'),
(20, 'Ensaladas'),
(21, 'Fritos'),
(22, 'Fruta'),
(3, 'Frutas/Verduras'),
(23, 'Frutos secos y aceitunas'),
(8, 'Granos/Cereales'),
(24, 'Helados'),
(41, 'Huevos'),
(25, 'Infusiones'),
(42, 'Jamón y Embutidos'),
(6, 'Lácteos'),
(26, 'Leche y derivados'),
(27, 'Legumbres'),
(28, 'Licores'),
(39, 'Mariscos'),
(48, 'Otras carnes'),
(29, 'Pasta'),
(30, 'Pasteleria'),
(31, 'Patatas'),
(5, 'Pescado/Marisco'),
(40, 'Pescados'),
(32, 'Pizza'),
(44, 'Pollo'),
(47, 'Porcino'),
(43, 'Queso'),
(7, 'Repostería'),
(33, 'Sidra'),
(45, 'Vacuno'),
(34, 'Variedades Internacionales'),
(38, 'Verduras'),
(36, 'Vinos Espumosos'),
(35, 'Vinos otros'),
(37, 'Zumos');

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `IdCliente` int(11) NOT NULL,
  `ci` char(10) DEFAULT NULL,
  `Nombres` varchar(100) NOT NULL,
  `Apellidos` varchar(100) DEFAULT NULL,
  `NroCelular` int(11) DEFAULT NULL,
  `CorreoElectronico` varchar(200) DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `FechaRegistro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `NroVisitas` int(11) DEFAULT NULL,
  `Sexo` char(1) DEFAULT NULL,
  `IdTipoCliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`IdCliente`, `ci`, `Nombres`, `Apellidos`, `NroCelular`, `CorreoElectronico`, `FechaNacimiento`, `FechaRegistro`, `NroVisitas`, `Sexo`, `IdTipoCliente`) VALUES
(1, NULL, 'luis', 'molina', 7357, 'jaja@gmail.com', '2020-02-11', '2020-12-15 18:11:21', 0, 'o', 1),
(2, '5680546', 'fernnado aguilar', 'quintanilla', 728546, 'asdfasf@gmail.com', '2220-03-03', '2020-12-15 18:54:18', 0, 'F', 1),
(3, '5680546', 'Cristhian', 'Vandersar', 7285498, 'Yolanda@sasa.com', '2020-05-12', '2020-12-21 13:20:41', 0, 'F', 1),
(4, '352568', 'Rosmeri', 'Lopez Rueda', 728445, 'rosmeri@gmail.com', '2000-12-31', '2020-12-23 20:32:12', 0, 'F', 2);

-- --------------------------------------------------------

--
-- Table structure for table `comprasarticulos`
--

CREATE TABLE `comprasarticulos` (
  `IdCompraArticulo` int(11) NOT NULL,
  `IdUsuario` int(11) DEFAULT NULL,
  `FechaHoraRegistro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CodigoEstadoIngreso` char(1) DEFAULT NULL,
  `IdProveedor` int(11) DEFAULT NULL,
  `Observaciones` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `comprasarticulosdetalle`
--

CREATE TABLE `comprasarticulosdetalle` (
  `IdCompraArticulo` int(11) NOT NULL,
  `IdArticulo` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `comprasarticulosdetalle`
--
DELIMITER $$
CREATE TRIGGER `t_after_compras_detalle_insert` AFTER INSERT ON `comprasarticulosdetalle` FOR EACH ROW BEGIN
    IF NEW.Cantidad > 0 THEN
        UPDATE Articulos
			set CantidadExistencia = CantidadExistencia + NEW.Cantidad,
				  TotalValorado = TotalValorado + NEW.Cantidad*NEW.Precio
        where Articulos.IdArticulo = NEW.IdArticulo;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `membresia`
--

CREATE TABLE `membresia` (
  `IdMembresia` int(11) NOT NULL,
  `IdCliente` int(11) DEFAULT NULL,
  `FechaRegistro` date DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `CodigoEstado` char(1) DEFAULT NULL,
  `CostoGeneral` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `membresia`
--

INSERT INTO `membresia` (`IdMembresia`, `IdCliente`, `FechaRegistro`, `FechaInicio`, `FechaFin`, `CodigoEstado`, `CostoGeneral`) VALUES
(2, 1, NULL, '2020-12-14', '2020-12-27', 'V', '100.00'),
(3, 2, NULL, '2020-12-14', '2020-12-20', 'V', '100.00'),
(4, 1, NULL, '2020-12-23', '2020-12-19', 'V', '150.00'),
(5, 3, NULL, '2020-01-21', '2020-12-31', 'C', '150.00'),
(6, 1, NULL, '2020-12-01', '2020-12-27', 'V', '150.00'),
(7, 3, NULL, '2020-12-01', '2020-12-31', 'V', '324.00'),
(8, 4, NULL, '2021-01-01', '2021-01-31', 'V', '300.00');

-- --------------------------------------------------------

--
-- Table structure for table `promociones`
--

CREATE TABLE `promociones` (
  `IdPromocion` int(11) NOT NULL,
  `NombrePromocion` varchar(200) DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `CodigoEstado` char(1) DEFAULT NULL,
  `TipoPromocion` char(1) DEFAULT NULL,
  `PorcentajeDescuento` decimal(10,2) DEFAULT NULL,
  `NroPersonas` int(11) DEFAULT 1,
  `Descripcion` varchar(500) DEFAULT NULL,
  `IdServicio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `promociones`
--

INSERT INTO `promociones` (`IdPromocion`, `NombrePromocion`, `FechaInicio`, `FechaFin`, `CodigoEstado`, `TipoPromocion`, `PorcentajeDescuento`, `NroPersonas`, `Descripcion`, `IdServicio`) VALUES
(1, 'nueva promocion', '2020-12-01', '2020-12-31', 'V', NULL, '70.00', 1, 'prueba de datos', 2),
(2, 'prueba de promoción', '2020-12-14', '2020-12-20', 'V', 'C', '50.00', 10, 'aplicar solo a capos modificado', 3),
(3, 'promocion para clientes sauna', '2020-12-01', '2020-12-31', 'V', 'T', '50.00', 1, 'por navidad para los clientes del sauna', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedores` (
  `IdProveedor` int(11) NOT NULL,
  `NombreRazonSocial` varchar(200) DEFAULT NULL,
  `NombreRepresentante` varchar(200) DEFAULT NULL,
  `Direccion` varchar(150) DEFAULT NULL,
  `NroCelular` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `servicios`
--

CREATE TABLE `servicios` (
  `IdServicio` int(11) NOT NULL,
  `NombreServicio` varchar(200) DEFAULT NULL,
  `CodigoEstado` char(1) DEFAULT NULL,
  `Descripcion` varchar(500) DEFAULT NULL,
  `CostoServicio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `servicios`
--

INSERT INTO `servicios` (`IdServicio`, `NombreServicio`, `CodigoEstado`, `Descripcion`, `CostoServicio`) VALUES
(1, 'prueba de servicio MODIFICADO', 'A', 'afdasdf', '58.00'),
(2, 'Servicio de Prueba estelar', 'A', 'prueba de datos', '150.00'),
(3, 'prueba 3', 'A', 'aaa', '23.00');

-- --------------------------------------------------------

--
-- Table structure for table `tipocliente`
--

CREATE TABLE `tiposclientes` (
  `IdTipoCliente` int(11) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipocliente`
--

INSERT INTO `tiposclientes` (`IdTipoCliente`, `Descripcion`) VALUES
(1, 'Cliente Sauna'),
(2, 'Cliente Institucional'),
(3, 'Cliente Sauna'),
(4, 'Cliente Institucional');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `IdUsuario` int(11) NOT NULL,
  `NombreCompleto` varchar(200) DEFAULT NULL,
  `NombreUsuario` varchar(100) DEFAULT NULL,
  `Contrasenia` varchar(100) DEFAULT NULL,
  `FechaRegistro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Direccion` varchar(100) DEFAULT NULL,
  `TipoUsuario` char(1) DEFAULT NULL,
  `CodigoEstado` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`IdUsuario`, `NombreCompleto`, `NombreUsuario`, `Contrasenia`, `FechaRegistro`, `Direccion`, `TipoUsuario`, `CodigoEstado`) VALUES
(1, 'Administrador', 'admin', 'admin', '0000-00-00 00:00:00', 'sauna soft', 'A', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `ventasservicio`
--

CREATE TABLE `ventasservicio` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdUsuario` int(11) DEFAULT NULL,
  `IdCliente` int(11) DEFAULT NULL,
  `FechaHoraVenta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CodigoEstadoVenta` char(1) DEFAULT NULL,
  `NroCasillero` int(11) DEFAULT NULL,
  `NroPersonas` int(11) DEFAULT NULL,
  `MontoTotalPago` decimal(10,2) DEFAULT NULL,
  `Observaciones` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ventasservicio`
--

INSERT INTO `ventasservicio` (`IdVentaServicio`, `IdUsuario`, `IdCliente`, `FechaHoraVenta`, `CodigoEstadoVenta`, `NroCasillero`, `NroPersonas`, `MontoTotalPago`, `Observaciones`) VALUES
(1, 1, 3, '2020-12-24 10:06:47', 'F', 3, 32, NULL, 'asdfasdf'),
(2, 1, 3, '2020-12-21 19:25:50', 'I', 34, NULL, NULL, 'prueba de datos'),
(3, NULL, 3, '2020-12-23 04:00:00', 'I', 34, NULL, NULL, 'prueba de datos');

-- --------------------------------------------------------

--
-- Table structure for table `ventasserviciodetalle`
--

CREATE TABLE `ventasserviciodetalle` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdServicio` int(11) NOT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  `NroPersonas` int(11) DEFAULT NULL,
  `IdPromocion` int(11) DEFAULT NULL,
  `PorcentajeDescuento` decimal(10,2) DEFAULT NULL,
  `CostoReal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ventasserviciodetalle`
--

INSERT INTO `ventasserviciodetalle` (`IdVentaServicio`, `IdServicio`, `Costo`, `NroPersonas`, `IdPromocion`, `PorcentajeDescuento`, `CostoReal`) VALUES
(1, 1, '58.00', 1, NULL, NULL, '58.00'),
(2, 1, '29.00', 2, 3, '50.00', '58.00'),
(2, 2, '105.00', 1, NULL, NULL, '105.00');

-- --------------------------------------------------------

--
-- Table structure for table `ventasserviciodetallearticulos`
--

CREATE TABLE `ventasserviciodetallearticulos` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdArticulo` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ventasserviciodetallearticulos`
--

INSERT INTO `ventasserviciodetallearticulos` (`IdVentaServicio`, `IdArticulo`, `Cantidad`, `Costo`) VALUES
(1, 47, 2, '3.00'),
(2, 42, 5, '2.00');

-- --------------------------------------------------------

--
-- Table structure for table `ventasserviciodetalleclientes`
--

CREATE TABLE `ventasserviciodetalleclientes` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`IdArticulo`),
  ADD KEY `IdCategoria` (`IdCategoria`);

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`IdCategoria`),
  ADD UNIQUE KEY `NombreCategoria` (`NombreCategoria`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`IdCliente`),
  ADD KEY `IdTipoCliente` (`IdTipoCliente`);

--
-- Indexes for table `comprasarticulos`
--
ALTER TABLE `comprasarticulos`
  ADD PRIMARY KEY (`IdCompraArticulo`),
  ADD KEY `IdUsuario` (`IdUsuario`),
  ADD KEY `IdProveedor` (`IdProveedor`);

--
-- Indexes for table `comprasarticulosdetalle`
--
ALTER TABLE `comprasarticulosdetalle`
  ADD PRIMARY KEY (`IdCompraArticulo`,`IdArticulo`),
  ADD KEY `IdArticulo` (`IdArticulo`);

--
-- Indexes for table `membresia`
--
ALTER TABLE `membresia`
  ADD PRIMARY KEY (`IdMembresia`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- Indexes for table `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`IdPromocion`),
  ADD KEY `IdServicio` (`IdServicio`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`IdProveedor`);

--
-- Indexes for table `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`IdServicio`),
  ADD UNIQUE KEY `NombreServicio` (`NombreServicio`);

--
-- Indexes for table `tipocliente`
--
ALTER TABLE `tiposclientes`
  ADD PRIMARY KEY (`IdTipoCliente`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`IdUsuario`);

--
-- Indexes for table `ventasservicio`
--
ALTER TABLE `ventasservicio`
  ADD PRIMARY KEY (`IdVentaServicio`),
  ADD KEY `IdUsuario` (`IdUsuario`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- Indexes for table `ventasserviciodetalle`
--
ALTER TABLE `ventasserviciodetalle`
  ADD PRIMARY KEY (`IdVentaServicio`,`IdServicio`),
  ADD KEY `IdServicio` (`IdServicio`),
  ADD KEY `IdPromocion` (`IdPromocion`);

--
-- Indexes for table `ventasserviciodetallearticulos`
--
ALTER TABLE `ventasserviciodetallearticulos`
  ADD PRIMARY KEY (`IdVentaServicio`,`IdArticulo`),
  ADD KEY `IdArticulo` (`IdArticulo`);

--
-- Indexes for table `ventasserviciodetalleclientes`
--
ALTER TABLE `ventasserviciodetalleclientes`
  ADD PRIMARY KEY (`IdVentaServicio`,`IdCliente`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulos`
--
ALTER TABLE `articulos`
  MODIFY `IdArticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `comprasarticulos`
--
ALTER TABLE `comprasarticulos`
  MODIFY `IdCompraArticulo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membresia`
--
ALTER TABLE `membresia`
  MODIFY `IdMembresia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `promociones`
--
ALTER TABLE `promociones`
  MODIFY `IdPromocion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedores`
  MODIFY `IdProveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `servicios`
--
ALTER TABLE `servicios`
  MODIFY `IdServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipocliente`
--
ALTER TABLE `tiposclientes`
  MODIFY `IdTipoCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ventasservicio`
--
ALTER TABLE `ventasservicio`
  MODIFY `IdVentaServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `categorias` (`IdCategoria`);

--
-- Constraints for table `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`IdTipoCliente`) REFERENCES `tiposclientes` (`IdTipoCliente`);

--
-- Constraints for table `comprasarticulos`
--
ALTER TABLE `comprasarticulos`
  ADD CONSTRAINT `comprasarticulos_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  ADD CONSTRAINT `comprasarticulos_ibfk_2` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedores` (`IdProveedor`);

--
-- Constraints for table `comprasarticulosdetalle`
--
ALTER TABLE `comprasarticulosdetalle`
  ADD CONSTRAINT `comprasarticulosdetalle_ibfk_1` FOREIGN KEY (`IdCompraArticulo`) REFERENCES `comprasarticulos` (`IdCompraArticulo`),
  ADD CONSTRAINT `comprasarticulosdetalle_ibfk_2` FOREIGN KEY (`IdArticulo`) REFERENCES `articulos` (`IdArticulo`);

--
-- Constraints for table `membresia`
--
ALTER TABLE `membresia`
  ADD CONSTRAINT `membresia_ibfk_1` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`);

--
-- Constraints for table `promociones`
--
ALTER TABLE `promociones`
  ADD CONSTRAINT `promociones_ibfk_1` FOREIGN KEY (`IdServicio`) REFERENCES `servicios` (`IdServicio`);

--
-- Constraints for table `ventasservicio`
--
ALTER TABLE `ventasservicio`
  ADD CONSTRAINT `ventasservicio_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  ADD CONSTRAINT `ventasservicio_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`);

--
-- Constraints for table `ventasserviciodetalle`
--
ALTER TABLE `ventasserviciodetalle`
  ADD CONSTRAINT `ventasserviciodetalle_ibfk_1` FOREIGN KEY (`IdVentaServicio`) REFERENCES `ventasservicio` (`IdVentaServicio`),
  ADD CONSTRAINT `ventasserviciodetalle_ibfk_2` FOREIGN KEY (`IdServicio`) REFERENCES `servicios` (`IdServicio`),
  ADD CONSTRAINT `ventasserviciodetalle_ibfk_3` FOREIGN KEY (`IdPromocion`) REFERENCES `promociones` (`IdPromocion`);

--
-- Constraints for table `ventasserviciodetallearticulos`
--
ALTER TABLE `ventasserviciodetallearticulos`
  ADD CONSTRAINT `ventasserviciodetallearticulos_ibfk_1` FOREIGN KEY (`IdVentaServicio`) REFERENCES `ventasservicio` (`IdVentaServicio`),
  ADD CONSTRAINT `ventasserviciodetallearticulos_ibfk_2` FOREIGN KEY (`IdArticulo`) REFERENCES `articulos` (`IdArticulo`);

--
-- Constraints for table `ventasserviciodetalleclientes`
--
ALTER TABLE `ventasserviciodetalleclientes`
  ADD CONSTRAINT `ventasserviciodetalleclientes_ibfk_1` FOREIGN KEY (`IdVentaServicio`) REFERENCES `ventasservicio` (`IdVentaServicio`),
  ADD CONSTRAINT `ventasserviciodetalleclientes_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
