-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 14, 2020 at 06:06 PM
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
(4, '8-0000001', 'Té Dharamsala', 2, 0, '0.00', '0.00', 'P', NULL, NULL),
(5, '1-0000001', 'Cerveza tibetana Barley', 12, 0, '0.00', '0.00', 'P', NULL, NULL),
(6, '13-0000001', 'Sirope de regaliz', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(7, '12-0000002', 'Especias Cajun del chef Anton', 3, 0, '0.00', '0.00', 'P', NULL, NULL),
(8, '12-0000002', 'Mezcla Gumbo del chef Anton', 2, 0, '0.00', '0.00', 'P', NULL, NULL),
(9, '7-0000001', 'Mermelada de grosellas de la abuela', 10, 0, '0.00', '0.00', 'P', NULL, NULL),
(10, '1-0000001', 'Peras secas orgánicas del tío Bob', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(11, '4-0000001', 'Salsa de arándanos Northwoods', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(12, '14-0000001', 'Buey Mishi Kobe', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(13, '10-0000002', 'Pez espada', 11, 0, '0.00', '0.00', 'P', NULL, NULL),
(14, '9-0000001', 'Queso Cabrales', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(15, '7-0000002', 'Queso Manchego La Pastora', 11, 0, '0.00', '0.00', 'P', NULL, NULL),
(16, '4-0000001', 'Algas Konbu', 3, 0, '0.00', '0.00', 'P', NULL, NULL),
(17, '15-0000001', 'Cuajada de judías', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(18, '5-0000003', 'Salsa de soja baja en sodio', 4, 0, '0.00', '0.00', 'P', NULL, NULL),
(19, '5-0000003', 'Postre de merengue Pavlova', 11, 0, '0.00', '0.00', 'P', NULL, NULL),
(20, '9-0000001', 'Cordero Alice Springs', 11, 0, '0.00', '0.00', 'P', NULL, NULL),
(21, '14-0000001', 'Langostinos tigre Carnarvon', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(22, '8-0000001', 'Pastas de té de chocolate', 2, 0, '0.00', '0.00', 'P', NULL, NULL),
(23, '3-0000003', 'Mermelada de Sir Rodneys', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(24, '12-0000002', 'Bollos de Sir Rodneys', 9, 0, '0.00', '0.00', 'P', NULL, NULL),
(25, '9-0000002', 'Pan de centeno crujiente estilo Gustafs', 2, 0, '0.00', '0.00', 'P', NULL, NULL),
(26, '12-0000002', 'Pan fino', 10, 40, '0.00', '60.00', 'P', NULL, NULL),
(27, '13-0000003', 'Refresco Guaraná Fantástica', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(28, '14-0000001', 'Crema de chocolate y nueces NuNuCa', 12, 0, '0.00', '0.00', 'P', NULL, NULL),
(29, '1-0000001', 'Ositos de goma Gumbär', 1, 0, '0.00', '0.00', 'P', NULL, NULL),
(30, '14-0000001', 'Chocolate Schoggi', 6, 0, '0.00', '0.00', 'P', NULL, NULL),
(31, '2-0000005', 'Col fermentada Rössle', 8, 0, '0.00', '0.00', 'P', NULL, NULL),
(32, '2-0000005', 'Salchicha Thüringer', 14, 0, '0.00', '0.00', 'P', NULL, NULL),
(33, '6-0000002', 'Arenque blanco del noroeste', 4, 0, '0.00', '0.00', 'P', NULL, NULL),
(34, '14-0000002', 'Queso gorgonzola Telino', 14, 0, '0.00', '0.00', 'P', NULL, NULL),
(35, '11-0000005', 'Queso Mascarpone Fabioli', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(36, '2-0000005', 'Queso de cabra', 1, 0, '0.00', '0.00', 'P', NULL, NULL),
(37, '14-0000003', 'Cerveza Sasquatch', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(38, '12-0000003', 'Cerveza negra Steeleye', 14, 0, '0.00', '0.00', 'P', NULL, NULL),
(39, '3-0000003', 'Escabeche de arenque', 4, 0, '0.00', '0.00', 'P', NULL, NULL),
(40, '11-0000005', 'Salmón ahumado Gravad', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(41, '14-0000004', 'Vino Côte de Blaye', 4, 0, '0.00', '0.00', 'P', NULL, NULL),
(42, '4-0000005', 'Licor verde Chartreuse', 10, 0, '0.00', '0.00', 'P', NULL, NULL),
(43, '6-0000002', 'Carne de cangrejo de Boston', 14, 0, '0.00', '0.00', 'P', NULL, NULL),
(44, '6-0000002', 'Crema de almejas estilo Nueva Inglaterra', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(45, '7-0000005', 'Tallarines de Singapur', 1, 0, '0.00', '0.00', 'P', NULL, NULL),
(46, '2-0000005', 'Café de Malasia', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(47, '4-0000005', 'Azúcar negra Malacca', 6, 0, '0.00', '0.00', 'P', NULL, NULL),
(48, '2-0000005', 'Arenque ahumado', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(49, '14-0000005', 'Arenque salado', 2, 0, '0.00', '0.00', 'P', NULL, NULL),
(50, '13-0000005', 'Galletas Zaanse', 14, 60, '0.00', '270.00', 'P', NULL, NULL),
(51, '14-0000006', 'Chocolate holandés', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(52, '6-0000003', 'Regaliz', 9, 0, '0.00', '0.00', 'P', NULL, NULL),
(53, '8-0000002', 'Chocolate blanco', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(54, '12-0000003', 'Manzanas secas Manjimup', 6, 0, '0.00', '0.00', 'P', NULL, NULL),
(55, '10-0000004', 'Cereales para Filo', 14, 0, '0.00', '0.00', 'P', NULL, NULL),
(56, '9-0000003', 'Empanada de carne', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(57, '10-0000004', 'Empanada de cerdo', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(58, '8-0000002', 'Paté chino', 11, 0, '0.00', '0.00', 'P', NULL, NULL),
(59, '13-0000007', 'Gnocchi de la abuela Alicia', 4, 0, '0.00', '0.00', 'P', NULL, NULL),
(60, '11-0000006', 'Raviolis Angelo', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(61, '2-0000006', 'Caracoles de Borgoña', 15, 0, '0.00', '0.00', 'P', NULL, NULL),
(62, '8-0000002', 'Raclet de queso Courdavault', 9, 0, '0.00', '0.00', 'P', NULL, NULL),
(63, '8-0000002', 'Camembert Pierrot', 10, 0, '0.00', '0.00', 'P', NULL, NULL),
(64, '10-0000005', 'Sirope de arce', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(65, '11-0000006', 'Tarta de azúcar', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(66, '1-0000004', 'Sandwich de vegetales', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(67, '3-0000003', 'Bollos de pan de Wimmer', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(68, '10-0000005', 'Salsa de pimiento picante de Luisiana', 12, 0, '0.00', '0.00', 'P', NULL, NULL),
(69, '14-0000007', 'Especias picantes de Luisiana', 3, 0, '0.00', '0.00', 'P', NULL, NULL),
(70, '5-0000010', 'Cerveza Laughing Lumberjack', 2, 0, '0.00', '0.00', 'P', NULL, NULL),
(71, '6-0000004', 'Barras de pan de Escocia', 8, 0, '0.00', '0.00', 'P', NULL, NULL),
(72, '9-0000004', 'Queso Gudbrandsdals', 5, 0, '0.00', '0.00', 'P', NULL, NULL),
(73, '11-0000006', 'Cerveza Outback', 10, 0, '0.00', '0.00', 'P', NULL, NULL),
(74, '4-0000006', 'Crema de queso Fløtemys', 2, 0, '0.00', '0.00', 'P', NULL, NULL),
(75, '11-0000006', 'Queso Mozzarella Giovanni', 7, 0, '0.00', '0.00', 'P', NULL, NULL),
(76, '13-0000009', 'Caviar rojo', 15, 0, '0.00', '0.00', 'P', NULL, NULL),
(77, '7-0000009', 'Queso de soja Longlife', 3, 0, '0.00', '0.00', 'P', NULL, NULL),
(78, '11-0000006', 'Cerveza Klosterbier Rhönbräu', 13, 0, '0.00', '0.00', 'P', NULL, NULL),
(79, '3-0000005', 'Licor Cloudberry', 4, 0, '0.00', '0.00', 'P', NULL, NULL),
(80, '9-0000004', 'Salsa verde original Frankfurter', 5, 0, '0.00', '0.00', 'P', NULL, NULL);

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
  `NroVisitas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`IdCliente`, `ci`, `Nombres`, `Apellidos`, `NroCelular`, `CorreoElectronico`, `FechaNacimiento`, `FechaRegistro`, `NroVisitas`) VALUES
(1, NULL, 'Fernando', 'Camacho', 73475846, 'camachin@yotambien.com', '2020-02-11', '2020-12-14 02:44:48', 0),
(2, NULL, 'Rosmeri Lucrecia', 'Lopez Rueda', 73475863, 'rosmerli@gmail.com', '2020-12-12', '2020-12-14 15:14:57', 0),
(3, NULL, 'Catillo', 'Lorenzo', 7246, 'castillo@gmail.com', '1986-12-23', '2020-12-14 15:15:18', 0);

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

--
-- Dumping data for table `comprasarticulos`
--

INSERT INTO `comprasarticulos` (`IdCompraArticulo`, `IdUsuario`, `FechaHoraRegistro`, `CodigoEstadoIngreso`, `IdProveedor`, `Observaciones`) VALUES
(1, 1, '2020-12-14 15:12:56', 'I', NULL, 'prueba de datos'),
(2, 1, '2020-12-14 15:20:46', 'I', NULL, NULL),
(3, 1, '2020-12-14 19:22:23', 'I', NULL, 'Galletas de ambasado cremositas'),
(4, 1, '2020-12-14 21:01:01', 'I', NULL, 'Nueva Venta');

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
-- Dumping data for table `comprasarticulosdetalle`
--

INSERT INTO `comprasarticulosdetalle` (`IdCompraArticulo`, `IdArticulo`, `Cantidad`, `Precio`) VALUES
(1, 4, 1, '15.00'),
(1, 32, 1, '15.00'),
(1, 37, 1, '30.00'),
(2, 26, 20, '1.00'),
(2, 50, 30, '2.00'),
(3, 26, 10, '2.00'),
(3, 50, 10, '15.00'),
(4, 26, 10, '2.00'),
(4, 50, 20, '3.00');

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
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `CodigoEstado` char(1) DEFAULT NULL,
  `CostoGeneral` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `membresia`
--

INSERT INTO `membresia` (`IdMembresia`, `IdCliente`, `FechaInicio`, `FechaFin`, `CodigoEstado`, `CostoGeneral`) VALUES
(1, 1, '2020-12-15', '2020-12-26', 'V', '120.00');

-- --------------------------------------------------------

--
-- Table structure for table `promociondetalleclientes`
--

CREATE TABLE `promociondetalleclientes` (
  `IdPromocion` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `Descripcion` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `proveedores`
--

CREATE TABLE `proveedores` (
  `IdProveedor` int(11) NOT NULL,
  `NombreRazonSocial` varchar(200) DEFAULT NULL,
  `NombreRepresentante` varchar(200) DEFAULT NULL,
  `Direccion` varchar(150) DEFAULT NULL,
  `NroCelular` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `proveedores`
--

INSERT INTO `proveedores` (`IdProveedor`, `NombreRazonSocial`, `NombreRepresentante`, `Direccion`, `NroCelular`) VALUES
(1, 'Sin Proveedor', 'Sin Proveedor', '', ''),
(2, 'Galletas Fagal', 'Fernando Ayala', '', ''),
(3, 'Cobolde', 'Valeria Rocabado', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `servicios`
--

CREATE TABLE `servicios` (
  `IdServicio` int(11) NOT NULL,
  `NombreServicio` varchar(200) DEFAULT NULL,
  `Descripcion` varchar(500) DEFAULT NULL,
  `CostoServicio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `servicios`
--

INSERT INTO `servicios` (`IdServicio`, `NombreServicio`, `Descripcion`, `CostoServicio`) VALUES
(1, 'Sauna a Vapor', 'prueba de sauna', '150.00');

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
  `IdPromocion` int(11) DEFAULT NULL,
  `NroPersonas` int(11) DEFAULT NULL,
  `NroCasillero` int(11) DEFAULT NULL,
  `Observaciones` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ventasservicio`
--

INSERT INTO `ventasservicio` (`IdVentaServicio`, `IdUsuario`, `IdCliente`, `FechaHoraVenta`, `CodigoEstadoVenta`, `IdPromocion`, `NroPersonas`, `NroCasillero`, `Observaciones`) VALUES
(1, 1, 3, '2020-12-14 15:21:36', 'I', NULL, 1, 12, 'Venta de datos Iniciales'),
(2, 1, 3, '2020-12-14 19:24:16', 'I', NULL, 1, 1, 'prueba de datos');

-- --------------------------------------------------------

--
-- Table structure for table `ventasserviciodetalle`
--

CREATE TABLE `ventasserviciodetalle` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdServicio` int(11) NOT NULL,
  `Costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ventasserviciodetalle`
--

INSERT INTO `ventasserviciodetalle` (`IdVentaServicio`, `IdServicio`, `Costo`) VALUES
(1, 1, '150.00'),
(2, 1, '150.00');

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
(1, 50, 50, '0.00'),
(2, 50, 5, '3.00');

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
  ADD PRIMARY KEY (`IdCliente`);

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
-- Indexes for table `promociondetalleclientes`
--
ALTER TABLE `promociondetalleclientes`
  ADD PRIMARY KEY (`IdPromocion`,`IdCliente`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- Indexes for table `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`IdPromocion`);

--
-- Indexes for table `proveedores`
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
  ADD KEY `IdCliente` (`IdCliente`),
  ADD KEY `IdPromocion` (`IdPromocion`);

--
-- Indexes for table `ventasserviciodetalle`
--
ALTER TABLE `ventasserviciodetalle`
  ADD PRIMARY KEY (`IdVentaServicio`,`IdServicio`),
  ADD KEY `IdServicio` (`IdServicio`);

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
  MODIFY `IdArticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comprasarticulos`
--
ALTER TABLE `comprasarticulos`
  MODIFY `IdCompraArticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `membresia`
--
ALTER TABLE `membresia`
  MODIFY `IdMembresia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `promociones`
--
ALTER TABLE `promociones`
  MODIFY `IdPromocion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `IdProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `servicios`
--
ALTER TABLE `servicios`
  MODIFY `IdServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ventasservicio`
--
ALTER TABLE `ventasservicio`
  MODIFY `IdVentaServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `categorias` (`IdCategoria`);

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
-- Constraints for table `promociondetalleclientes`
--
ALTER TABLE `promociondetalleclientes`
  ADD CONSTRAINT `promociondetalleclientes_ibfk_1` FOREIGN KEY (`IdPromocion`) REFERENCES `promociones` (`IdPromocion`),
  ADD CONSTRAINT `promociondetalleclientes_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`);

--
-- Constraints for table `ventasservicio`
--
ALTER TABLE `ventasservicio`
  ADD CONSTRAINT `ventasservicio_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  ADD CONSTRAINT `ventasservicio_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`),
  ADD CONSTRAINT `ventasservicio_ibfk_3` FOREIGN KEY (`IdPromocion`) REFERENCES `promociones` (`IdPromocion`);

--
-- Constraints for table `ventasserviciodetalle`
--
ALTER TABLE `ventasserviciodetalle`
  ADD CONSTRAINT `ventasserviciodetalle_ibfk_1` FOREIGN KEY (`IdVentaServicio`) REFERENCES `ventasservicio` (`IdVentaServicio`),
  ADD CONSTRAINT `ventasserviciodetalle_ibfk_2` FOREIGN KEY (`IdServicio`) REFERENCES `servicios` (`IdServicio`);

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
