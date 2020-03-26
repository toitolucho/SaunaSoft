-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-03-2020 a las 11:02:08
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `saunasoft`
--

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `ObtenerCodigoProducto` (`IdCategoria1` INT) RETURNS CHAR(10) CHARSET latin1 BEGIN
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
-- Estructura de tabla para la tabla `articulos`
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`IdArticulo`, `CodigoArticulo`, `NombreArticulo`, `IdCategoria`, `CantidadExistencia`, `PrecioVigente`, `TotalValorado`, `TipoInventario`, `Descripcion`, `FechaVencimiento`) VALUES
(1, '10-0000001', 'Té Dharamsala', 8, 12, '98.00', '196.00', 'P', NULL, NULL),
(2, '7-0000001', 'Cerveza tibetana Barley', 12, 10, '90.00', '0.00', 'P', NULL, NULL),
(3, '8-0000002', 'Sirope de regaliz', 2, 10, '57.00', '0.00', 'P', NULL, NULL),
(4, '2-0000002', 'Especias Cajun del chef Anton', 4, 17, '16.00', '120.00', 'P', NULL, NULL),
(5, '13-0000001', 'Mezcla Gumbo del chef Anton', 7, 10, '7.00', '0.00', 'P', NULL, NULL),
(6, '12-0000002', 'Mermelada de grosellas de la abuela', 8, 10, '86.00', '0.00', 'P', NULL, NULL),
(7, '4-0000002', 'Peras secas orgánicas del tío Bob', 11, 10, '11.00', '0.00', 'P', NULL, NULL),
(8, '11-0000002', 'Salsa de arándanos Northwoods', 5, 10, '93.00', '0.00', 'P', NULL, NULL),
(9, '9-0000001', 'Buey Mishi Kobe', 14, 10, '35.00', '0.00', 'P', NULL, NULL),
(10, '11-0000002', 'Pez espada', 13, 10, '92.00', '0.00', 'P', NULL, NULL),
(11, '3-0000001', 'Queso Cabrales', 4, 11, '58.00', '58.00', 'P', NULL, NULL),
(12, '9-0000001', 'Queso Manchego La Pastora', 4, 10, '11.00', '0.00', 'P', NULL, NULL),
(13, '8-0000003', 'Algas Konbu', 12, 10, '81.00', '0.00', 'P', NULL, NULL),
(14, '6-0000001', 'Cuajada de judías', 10, 10, '73.00', '0.00', 'P', NULL, NULL),
(15, '13-0000002', 'Salsa de soja baja en sodio', 8, 10, '22.00', '0.00', 'P', NULL, NULL),
(16, '13-0000002', 'Postre de merengue Pavlova', 11, 10, '87.00', '0.00', 'P', NULL, NULL),
(17, '15-0000001', 'Cordero Alice Springs', 12, 10, '72.00', '0.00', 'P', NULL, NULL),
(18, '12-0000004', 'Langostinos tigre Carnarvon', 12, 10, '98.00', '0.00', 'P', NULL, NULL),
(19, '7-0000002', 'Pastas de té de chocolate', 15, 10, '74.00', '0.00', 'P', NULL, NULL),
(20, '7-0000002', 'Mermelada de Sir Rodneys', 6, 10, '75.00', '0.00', 'P', NULL, NULL),
(21, '9-0000001', 'Bollos de Sir Rodneys', 11, 10, '54.00', '0.00', 'P', NULL, NULL),
(22, '10-0000002', 'Pan de centeno crujiente estilo Gustafs', 4, 10, '43.00', '0.00', 'P', NULL, NULL),
(23, '4-0000005', 'Pan fino', 6, 10, '54.00', '0.00', 'P', NULL, NULL),
(24, '3-0000001', 'Refresco Guaraná Fantástica', 12, 10, '42.00', '0.00', 'P', NULL, NULL),
(25, '4-0000005', 'Crema de chocolate y nueces NuNuCa', 13, 10, '44.00', '0.00', 'P', NULL, NULL),
(26, '10-0000002', 'Ositos de goma Gumbär', 10, 10, '94.00', '0.00', 'P', NULL, NULL),
(27, '4-0000005', 'Chocolate Schoggi', 5, 10, '37.00', '0.00', 'P', NULL, NULL),
(28, '12-0000006', 'Col fermentada Rössle', 14, 10, '5.00', '0.00', 'P', NULL, NULL),
(29, '4-0000005', 'Salchicha Thüringer', 9, 10, '10.00', '0.00', 'P', NULL, NULL),
(30, '15-0000002', 'Arenque blanco del noroeste', 4, 10, '38.00', '0.00', 'P', NULL, NULL),
(31, '4-0000006', 'Queso gorgonzola Telino', 8, 10, '59.00', '0.00', 'P', NULL, NULL),
(32, '11-0000004', 'Queso Mascarpone Fabioli', 14, 10, '80.00', '0.00', 'P', NULL, NULL),
(33, '10-0000003', 'Queso de cabra', 4, 10, '23.00', '0.00', 'P', NULL, NULL),
(34, '7-0000002', 'Cerveza Sasquatch', 5, 10, '74.00', '0.00', 'P', NULL, NULL),
(35, '3-0000001', 'Cerveza negra Steeleye', 3, 10, '1.00', '0.00', 'P', NULL, NULL),
(36, '3-0000002', 'Escabeche de arenque', 7, 10, '82.00', '0.00', 'P', NULL, NULL),
(37, '10-0000003', 'Salmón ahumado Gravad', 12, 10, '8.00', '0.00', 'P', NULL, NULL),
(38, '15-0000002', 'Vino Côte de Blaye', 10, 10, '92.00', '0.00', 'P', NULL, NULL),
(39, '4-0000007', 'Licor verde Chartreuse', 6, 10, '37.00', '0.00', 'P', NULL, NULL),
(40, '15-0000002', 'Carne de cangrejo de Boston', 14, 10, '7.00', '0.00', 'P', NULL, NULL),
(41, '8-0000005', 'Crema de almejas estilo Nueva Inglaterra', 14, 10, '26.00', '0.00', 'P', NULL, NULL),
(42, '15-0000002', 'Tallarines de Singapur', 2, 10, '5.00', '0.00', 'P', NULL, NULL),
(43, '12-0000007', 'Café de Malasia', 6, 10, '48.00', '0.00', 'P', NULL, NULL),
(44, '8-0000005', 'Azúcar negra Malacca', 7, 10, '25.00', '0.00', 'P', NULL, NULL),
(45, '10-0000004', 'Arenque ahumado', 1, 10, '80.00', '0.00', 'P', NULL, NULL),
(46, '2-0000003', 'Arenque salado', 9, 10, '24.00', '0.00', 'P', NULL, NULL),
(47, '7-0000004', 'Galletas Zaanse', 8, 10, '81.00', '0.00', 'P', NULL, NULL),
(48, '4-0000007', 'Chocolate holandés', 9, 10, '33.00', '0.00', 'P', NULL, NULL),
(49, '5-0000004', 'Regaliz', 9, 10, '22.00', '0.00', 'P', NULL, NULL),
(50, '2-0000003', 'Chocolate blanco', 12, 10, '8.00', '0.00', 'P', NULL, NULL),
(51, '10-0000004', 'Manzanas secas Manjimup', 12, 10, '75.00', '0.00', 'P', NULL, NULL),
(52, '15-0000002', 'Cereales para Filo', 10, 10, '50.00', '0.00', 'P', NULL, NULL),
(53, '3-0000002', 'Empanada de carne', 14, 10, '26.00', '0.00', 'P', NULL, NULL),
(54, '1-0000002', 'Empanada de cerdo', 9, 10, '79.00', '0.00', 'P', NULL, NULL),
(55, '10-0000005', 'Paté chino', 7, 10, '18.00', '0.00', 'P', NULL, NULL),
(56, '5-0000004', 'Gnocchi de la abuela Alicia', 4, 10, '50.00', '0.00', 'P', NULL, NULL),
(57, '3-0000002', 'Raviolis Angelo', 1, 10, '95.00', '0.00', 'P', NULL, NULL),
(58, '14-0000007', 'Caracoles de Borgoña', 5, 10, '24.00', '0.00', 'P', NULL, NULL),
(59, '13-0000003', 'Raclet de queso Courdavault', 5, 10, '35.00', '0.00', 'P', NULL, NULL),
(60, '13-0000003', 'Camembert Pierrot', 5, 10, '5.00', '0.00', 'P', NULL, NULL),
(61, '3-0000002', 'Sirope de arce', 14, 10, '17.00', '0.00', 'P', NULL, NULL),
(62, '14-0000008', 'Tarta de azúcar', 14, 10, '70.00', '0.00', 'P', NULL, NULL),
(63, '12-0000009', 'Sandwich de vegetales', 1, 10, '97.00', '0.00', 'P', NULL, NULL),
(64, '1-0000004', 'Bollos de pan de Wimmer', 13, 10, '77.00', '0.00', 'P', NULL, NULL),
(65, '5-0000007', 'Salsa de pimiento picante de Luisiana', 12, 10, '93.00', '0.00', 'P', NULL, NULL),
(66, '3-0000002', 'Especias picantes de Luisiana', 6, 10, '34.00', '0.00', 'P', NULL, NULL),
(67, '6-0000006', 'Cerveza Laughing Lumberjack', 13, 10, '92.00', '0.00', 'P', NULL, NULL),
(68, '15-0000002', 'Barras de pan de Escocia', 7, 10, '55.00', '0.00', 'P', NULL, NULL),
(69, '5-0000007', 'Queso Gudbrandsdals', 1, 10, '1.00', '0.00', 'P', NULL, NULL),
(70, '6-0000006', 'Cerveza Outback', 10, 10, '37.00', '0.00', 'P', NULL, NULL),
(71, '1-0000005', 'Crema de queso Fløtemys', 6, 10, '83.00', '0.00', 'P', NULL, NULL),
(72, '11-0000004', 'Queso Mozzarella Giovanni', 7, 10, '3.00', '0.00', 'P', NULL, NULL),
(73, '2-0000003', 'Caviar rojo', 5, 10, '67.00', '0.00', 'P', NULL, NULL),
(74, '1-0000005', 'Queso de soja Longlife', 3, 10, '23.00', '0.00', 'P', NULL, NULL),
(75, '15-0000002', 'Cerveza Klosterbier Rhönbräu', 4, 10, '16.00', '0.00', 'P', NULL, NULL),
(76, '3-0000003', 'Licor Cloudberry', 5, 10, '10.00', '0.00', 'P', NULL, NULL),
(77, '15-0000002', 'Salsa verde original Frankfurter', 1, 10, '3.00', '0.00', 'P', NULL, NULL),
(78, 'LGMYKAPE', 'Dr. Jamaal Senger', 61, 510, '4788.46', '4158.24', 'O', 'Quia magni pariatur qui et voluptatibus fuga voluptatibus eius non eveniet blanditiis quo qui deserunt quas architecto quo voluptas repellendus tempora sed quia consequatur in ut recusandae sequi laborum voluptas nihil mollitia labore vel impedit eum nisi.', NULL),
(79, 'YYYOBOQL', 'Jerel Murray DVM', 27, 875, '5195.84', '2955.40', 'U', 'Est ut minus temporibus voluptatibus hic eum consectetur quam mollitia vel unde esse quis rem odio minus est odit modi consequuntur repudiandae at eum vero alias voluptas aut aperiam et in exercitationem rem et nisi molestiae animi et maxime qui sed.', NULL),
(80, 'VEALZUC5Q', 'Carolyne Prohaska', 12, 400, '7.06', '2031.23', 'O', 'Laborum veritatis harum illo ut similique sapiente omnis amet sunt modi repudiandae qui qui numquam sed expedita dolor quia dolorem deleniti quis hic iusto natus autem ipsam dicta odit suscipit suscipit quis et molestias perspiciatis.', NULL),
(81, 'XDHXOEM9R', 'Kali Hodkiewicz I', 70, 136, '2891.35', '2330.77', 'P', 'Nihil dicta consequuntur aut enim alias soluta ea ut culpa ea quod dolorum et molestiae est possimus sint quo neque optio consequatur quidem et.', NULL),
(82, 'BUMUJUWXF', 'Elisha Dibbert', 26, 468, '107.71', '2631.62', 'O', 'Voluptatum inventore itaque aut animi ipsam temporibus quis ratione enim hic alias eligendi itaque in non rerum eum et provident et numquam temporibus sapiente sed eveniet a et.', NULL),
(83, 'TUIPFIR3M', 'Ellie Cremin', 20, 890, '5767.75', '8137.60', 'U', 'Aliquam ipsum repudiandae ea nobis illo reiciendis quia quia doloribus magni ipsum iure eum tenetur facilis magnam ad est voluptate sunt tempore veritatis sint porro sit quae nesciunt maxime cupiditate similique ad non et.', NULL),
(84, 'GVHTSAGL', 'Quentin Kuhic', 45, 797, '7564.12', '0.52', 'O', 'Qui voluptatem animi consequatur molestiae rerum blanditiis doloribus minus minima ut perferendis dolorem nostrum nobis quod saepe odio et dicta omnis.', NULL),
(85, 'JRCWYERVX', 'Rupert Krajcik DDS', 52, 675, '3786.54', '3193.06', 'O', 'Magni nihil incidunt porro ut inventore earum totam aliquid veniam illo consectetur sunt laudantium quam voluptatum corporis in quis sequi laudantium quas quidem et sed id nisi tempore facilis quibusdam dignissimos consequatur sit velit.', NULL),
(86, 'EYLUQPIDO', 'Lurline Jast', 39, 612, '9429.44', '2767.40', 'P', 'Perspiciatis qui aut vel atque ea cupiditate omnis aut quasi aut consequatur aperiam molestiae ut eligendi harum molestiae ab vero voluptate temporibus ex cupiditate qui voluptatem excepturi harum occaecati.', NULL),
(87, 'TZLEIT9I', 'Claud Emard', 20, 516, '4270.07', '1965.56', 'P', 'Reiciendis temporibus numquam officia corporis sed doloribus aspernatur soluta quaerat cum voluptas consequuntur labore et consequatur id sit dolorem rerum eum labore ullam et sint ducimus explicabo architecto a et tenetur voluptatem iste delectus illum.', NULL),
(88, 'SGQEVDHB', 'Dr. Myriam Bernhard II', 31, 344, '4930.64', '6120.43', 'O', 'Qui minima enim minima natus saepe repellendus animi ut est consequatur modi porro laboriosam quibusdam est earum est amet reprehenderit rerum accusantium aut suscipit nesciunt est vero atque id illum quo quia modi velit et dolores aspernatur ut.', NULL),
(89, 'RBYHCOKP', 'Jayda Raynor', 66, 407, '1425.61', '9065.72', 'O', 'Amet officia adipisci omnis quia nisi nobis voluptatem voluptate praesentium facere est enim consequatur voluptatem numquam expedita doloremque assumenda quisquam ut autem ipsam deserunt rem.', NULL),
(90, 'PKVJQJSO8', 'Prof. Dino Walsh MD', 46, 646, '3508.56', '235.17', 'O', 'Tenetur sunt voluptatem id omnis quia corporis dolores eaque sit fugiat harum consequatur quo ut excepturi labore velit beatae ut quo eligendi eius magni ut in tempora a id rem nemo.', NULL),
(91, 'PCGWSFSBR', 'Ezekiel Lesch', 16, 292, '1465.01', '3900.15', 'P', 'Dolorem quam non et cumque et quos soluta doloremque ullam modi sunt aut suscipit consequatur culpa id voluptatum eaque dolores necessitatibus eum autem ratione.', NULL),
(92, 'IJDWXB6LF', 'Mariela Gusikowski', 67, 825, '5019.49', '6444.38', 'O', 'Incidunt quod eum quo dolor occaecati aut sint esse et ut doloribus recusandae vel rerum nihil quia corporis quaerat qui voluptas dolores quia odit sed adipisci repellendus quibusdam harum laboriosam.', NULL),
(93, 'FJCMHMIN', 'Prof. Santino Wolff DDS', 85, 12, '1638.28', '9613.85', 'P', 'Deserunt sequi distinctio commodi architecto ullam ipsa esse ipsam ea quas expedita atque dolores unde facilis aut ullam sit nesciunt aut possimus totam harum quos sit voluptatem vel est hic.', NULL),
(94, 'NMTVMPR61', 'Desmond Thompson', 80, 271, '6000.69', '5902.92', 'U', 'Qui et cupiditate quam atque quis odit optio nihil qui assumenda optio nobis quae beatae explicabo quia illo consectetur commodi accusamus ab.', NULL),
(95, 'DCPKPA0S', 'Berenice Williamson', 72, 924, '245.93', '7538.71', 'P', 'Vel voluptate occaecati quae consequatur saepe ratione corporis rerum laboriosam sed eum explicabo omnis voluptatibus quaerat sequi veritatis sapiente rerum sint cupiditate inventore porro repudiandae inventore tempora praesentium officiis voluptates.', NULL),
(96, 'OMEGDF4C', 'Donnie Ankunding', 39, 158, '8706.77', '3633.15', 'O', 'Animi corrupti sit ipsum numquam dolores quis sed nihil harum similique id voluptas quia repudiandae tenetur quasi consequatur possimus neque sint sit quas ipsam recusandae alias tempore magnam dolores sequi voluptas dolorum sit ratione id odio ad.', NULL),
(97, 'CMHKBR8V', 'Grayce Klocko', 9, 50, '2990.42', '8646.54', 'P', 'Alias in magnam libero voluptatibus quia autem adipisci maiores dolor magnam dolorum dolores autem qui excepturi sed quam in aliquam ducimus laboriosam hic odio cupiditate maxime.', NULL),
(98, 'VBFVSVSB', 'Mr. Kareem Douglas Sr.', 35, 226, '6473.88', '8591.16', 'P', 'Maiores eos ullam ut dolores eligendi nostrum voluptatem quod mollitia ut tempora nesciunt officia harum saepe necessitatibus dolor voluptas cupiditate veniam non qui eos sed et est ullam tenetur sequi magni consequuntur sunt.', NULL),
(99, 'ACWUJFRYO', 'Lelah Keeling', 60, 533, '3700.31', '9191.86', 'P', 'Praesentium doloribus itaque et vitae et ut veniam rerum neque maxime vel maiores voluptatum deserunt iste iusto et rerum ut esse inventore voluptas sed veniam id id consectetur deserunt consectetur magnam odit laudantium molestias suscipit eaque porro nihil vitae.', NULL),
(100, 'AQLBNGI1N', 'Rita Mayer', 58, 413, '5905.67', '3853.87', 'U', 'Rem beatae sit qui exercitationem doloremque ratione iusto maiores qui culpa eveniet minus est error et est earum voluptate laudantium provident ratione necessitatibus sit repudiandae cupiditate ab eum ea veniam vel.', NULL),
(101, 'KHRROK4D', 'Raphael Miller', 4, 200, '8212.01', '8976.39', 'O', 'Labore perferendis ipsa et enim maiores rerum laudantium architecto eveniet atque provident voluptas eum eius saepe officiis ex quia blanditiis numquam quo perspiciatis nihil quos labore consequuntur tenetur repudiandae assumenda neque quis tempore facere sunt repellendus eos.', NULL),
(102, 'YCZMRD1RE', 'Prof. Vesta Howell', 37, 156, '8755.12', '1865.38', 'U', 'Voluptatibus excepturi consequatur sed quas omnis qui eaque autem quaerat ipsum nam inventore repudiandae ea facere et omnis sed qui fuga sit corrupti eos illum aut et corrupti ullam sint harum commodi quas iure sequi libero delectus in quasi laborum consequatur.', NULL),
(103, 'QQNTGIAAV', 'Felicity Gibson', 13, 83, '8096.66', '2043.70', 'P', 'Voluptatem quod ut dolores quam quasi doloremque illum ut dolor earum alias dolores dolorem id numquam illo officia eos nisi et labore repudiandae sit blanditiis quos eos sed.', NULL),
(104, 'TZAMHVIUT', 'Pearl Littel', 3, 238, '4107.97', '7433.16', 'O', 'Eos assumenda deserunt sed occaecati nostrum est ullam dignissimos vero dolor ipsum numquam voluptas sit sed et illum dolorem ipsa.', NULL),
(105, 'YSMHEG61', 'Prof. Peter Cartwright', 88, 608, '6380.50', '434.14', 'O', 'Non occaecati eveniet quidem nemo et unde eius dolor adipisci quas iste officia natus facilis architecto porro dignissimos soluta et doloribus rerum quos dignissimos.', NULL),
(106, 'VXWURSX0', 'Gerald Bernhard', 65, 839, '5837.84', '2134.57', 'O', 'Qui dolores qui nisi porro incidunt adipisci unde quos voluptatibus ut aliquid laborum aut dolor voluptas accusamus qui quae ea voluptatum eius harum aut molestiae eveniet.', NULL),
(107, 'TMAPTZ0R', 'Estefania Nader', 78, 304, '718.32', '3849.22', 'U', 'Ut ratione possimus provident sunt illo tenetur quis consequatur ut omnis amet optio natus vel quasi ut quisquam qui sunt reprehenderit at recusandae sed inventore dolore sed quisquam optio occaecati est occaecati cumque placeat aliquid ut est.', NULL),
(108, 'HMRUZOO24', 'Delaney Parisian', 14, 535, '5014.21', '7769.15', 'P', 'Laborum aut ipsam recusandae error repellat in eum aut qui neque enim voluptatem dignissimos et rem velit facere est.', NULL),
(109, 'YTUESIGQ', 'Jeff Trantow', 11, 775, '2940.45', '9597.37', 'O', 'Modi nobis reiciendis officiis unde non corrupti accusantium officiis ut rerum aspernatur nihil vero nisi repudiandae ex soluta impedit assumenda et est sapiente.', NULL),
(110, 'SFVIRPT6', 'Ms. Dawn Feest', 87, 968, '9738.93', '2974.14', 'P', 'Officia in nihil et illum eaque deleniti mollitia minus qui error minus similique beatae autem voluptas quia voluptatem nesciunt amet similique laborum id alias laborum id fugit cum culpa voluptates non unde consequatur optio.', NULL),
(111, 'RWOTPFEI', 'Coralie Lebsack', 63, 153, '1237.40', '2863.53', 'P', 'Incidunt a odio laborum ducimus qui necessitatibus sit quaerat et eligendi dolorem illum aut et fugiat impedit ut reiciendis dignissimos voluptatem voluptatem ut excepturi non modi culpa animi quis distinctio dolorum harum nostrum laborum quisquam et ea.', NULL),
(112, 'NFWDBQ70C', 'Dr. Jan Hudson', 46, 128, '4330.07', '7606.71', 'P', 'Nulla officiis illum est ad et sapiente ipsam quidem repellat voluptate ad alias dolor animi dolor rerum cum ratione cupiditate et harum adipisci quia velit deserunt esse rerum possimus molestias non ducimus.', NULL),
(113, 'KKUWVWEX', 'Miss Elena Rippin Jr.', 78, 473, '2647.58', '4008.07', 'P', 'Tempora quis porro aut eos laudantium ut veritatis dolores quidem eligendi voluptatem ea molestiae reiciendis quidem explicabo error amet nobis nisi repudiandae asperiores quo molestiae labore ut deserunt in blanditiis aliquam ratione commodi voluptatibus praesentium dolores repudiandae aut illo.', NULL),
(114, 'DCWQIZF2V', 'Dr. Philip Bednar V', 12, 767, '9068.67', '2083.73', 'O', 'Cum illum officiis non numquam perspiciatis iure ratione dolore quo laboriosam atque repellendus necessitatibus ut in quo quibusdam consequatur dolores et praesentium sint dignissimos voluptas ducimus pariatur rem omnis dignissimos quia maiores itaque voluptatum.', NULL),
(115, 'GHYOMJNB', 'Lauren Glover', 22, 478, '4727.19', '2543.98', 'O', 'Autem aliquam itaque molestiae qui reprehenderit odio dolores iusto repellendus nulla numquam velit debitis sapiente consectetur officiis ad quis officia enim sed quae occaecati in itaque velit distinctio cumque sed enim et.', NULL),
(116, 'SCTXQDNFN', 'Ervin Weissnat', 7, 636, '2778.79', '3531.39', 'O', 'Minus expedita rerum id aut aut at harum est deleniti sit in molestiae dolores voluptates ab mollitia libero vitae eius laboriosam sit qui occaecati voluptatem harum id occaecati architecto eum iure libero unde error beatae libero est labore vitae.', NULL),
(117, 'ANDOBYBND', 'Margaretta Luettgen', 69, 218, '3315.64', '6274.10', 'U', 'Dicta molestiae delectus doloremque nihil molestiae rerum aut id maxime quas est culpa pariatur facere enim quas ad ea deserunt accusamus exercitationem mollitia velit earum fugiat maiores deserunt eveniet quia omnis et non praesentium provident excepturi est quisquam.', NULL),
(118, 'DQPYGKPWX', 'Earnest Pacocha', 51, 877, '8682.17', '6727.71', 'O', 'Qui dolore incidunt quia minus qui minima id est sed repudiandae ut quis perferendis dolorem et sunt et eos voluptatum rem architecto.', NULL),
(119, 'IWSQKS2T', 'Alene Heidenreich', 47, 196, '5218.73', '3718.75', 'P', 'Earum explicabo quis est velit aut enim corporis autem dolorem eum quos aut sequi tempora veritatis aut similique aut qui eius sunt nostrum est.', NULL),
(120, 'JLQNTRN7C', 'Brody Satterfield', 15, 539, '3487.53', '9822.44', 'O', 'Sit voluptas molestias sapiente modi tenetur dicta quam quas odit sunt quas nesciunt laboriosam atque aut quibusdam et optio libero dolorem facere impedit provident aspernatur ad soluta laborum dolores quisquam dolor sapiente corporis nobis adipisci.', NULL),
(121, 'YYIECYVUY', 'Jennifer Heller IV', 71, 334, '600.50', '3528.94', 'P', 'Earum rerum voluptatibus suscipit et eius animi enim earum id doloribus sint consequatur mollitia voluptates iure culpa amet enim praesentium occaecati omnis quia atque.', NULL),
(122, 'VDBPLAHN', 'Mr. Justen Eichmann Sr.', 51, 777, '8508.81', '4262.62', 'P', 'Veritatis doloribus qui repellendus amet est culpa dicta nobis quisquam ratione et quas itaque minus et voluptatem ea aut asperiores qui sed molestiae nisi.', NULL),
(123, 'YONFZH8Y9', 'Mr. Oda Gerlach DVM', 31, 809, '4503.54', '2358.39', 'U', 'Ut quis porro excepturi alias omnis consequatur ipsam quisquam odit qui repellat eaque et odio alias ullam commodi vero blanditiis alias recusandae accusantium laboriosam autem soluta vel tenetur vero laborum laudantium magnam accusamus sequi tempora voluptatem magni.', NULL),
(124, 'KCYRGFKP', 'Ms. Gloria Grady Sr.', 17, 318, '1469.41', '4172.13', 'O', 'Repudiandae voluptatem corrupti nihil natus ab tenetur aut dolorem voluptas dicta sit qui illo accusamus quae consequatur et rerum totam alias sed.', NULL),
(125, 'XSWHAR1F', 'Frederic Strosin', 78, 6, '2304.69', '8157.50', 'U', 'Dolor corrupti laborum voluptatibus asperiores et sit fugit adipisci quaerat aut earum quia quam eos laborum excepturi repellat ullam repudiandae commodi ut quidem sint commodi quia eius est qui voluptatibus voluptatum et fuga est laborum recusandae quidem nisi totam repudiandae.', NULL),
(126, 'WKGEES92', 'Martina Ryan', 25, 921, '2221.55', '9408.58', 'U', 'Harum ut alias vero in nemo veniam corporis maiores quo architecto est sed aut et reiciendis laborum dolorum enim quibusdam recusandae repellat laborum dignissimos voluptas magni sit repellendus repudiandae ipsa voluptas.', NULL),
(127, 'KAMUCYAWJ', 'Mrs. Meggie Reilly III', 85, 448, '3085.25', '684.76', 'U', 'Excepturi quia voluptatibus qui et rerum sit dignissimos voluptates ut adipisci reprehenderit corporis distinctio suscipit aut ut magnam et maxime facilis nostrum odit.', NULL),
(128, 'PBKFYYZB', 'Amelia Lindgren', 56, 537, '4001.71', '9993.32', 'U', 'Deleniti laboriosam est non quos maxime animi quia ut distinctio nihil non praesentium doloribus et ex numquam sit nostrum.', NULL),
(129, 'ZIOLVEVZD', 'Mrs. Zoe Kemmer II', 16, 368, '902.52', '1125.67', 'O', 'Et dolorem tempore velit saepe fuga et quia sit blanditiis voluptates reiciendis architecto cumque occaecati veritatis nihil inventore accusamus nesciunt non sed et et deserunt sit eius hic dolore impedit sint libero saepe assumenda omnis quasi incidunt accusantium ipsam qui.', NULL),
(130, 'PFUZQDXEJ', 'Lavonne Balistreri PhD', 87, 396, '7640.67', '331.72', 'U', 'Illum voluptatem reprehenderit quas at corrupti aspernatur error ut amet eaque in ad totam qui voluptas error voluptatibus qui sint iste odio est mollitia sed aut ex quo quos aliquam dicta.', NULL),
(131, 'RHAVSF1LO', 'Winifred Eichmann', 18, 189, '1261.62', '7073.41', 'P', 'Qui ut ducimus vero consequatur numquam qui nesciunt ipsa voluptas ipsa qui sunt vero minima quis et voluptas reiciendis.', NULL),
(132, 'YVKFODXY', 'Jonathon Dietrich', 5, 923, '8489.62', '7451.53', 'P', 'Quia consequuntur eveniet voluptate eos suscipit deleniti fuga optio sunt provident inventore ab dolorem id et reprehenderit numquam sit maxime aliquid quaerat atque tempore quis rerum hic aut in praesentium expedita maiores a debitis quas et beatae nam praesentium quis similique.', NULL),
(133, 'SWVIDDLX', 'Serena Witting', 12, 840, '9491.65', '1041.17', 'P', 'Autem quibusdam sit aliquam repellat natus dolor sit deserunt similique sit sit magni provident totam dolor modi inventore est rerum temporibus sunt laborum sunt rem unde occaecati.', NULL),
(134, 'CYIYKSA1A', 'Kaylah Marquardt', 14, 706, '3520.81', '6698.47', 'P', 'Qui sit soluta et ut ad pariatur cumque quae repellendus in non dolores libero dignissimos alias rem quaerat iure ipsam iure est ratione ut enim voluptatum omnis quasi ex vero accusamus.', NULL),
(135, 'BTOEYG04', 'Martina Braun', 16, 532, '2523.18', '7157.85', 'O', 'Qui in nobis qui rerum ea quibusdam et quia rerum incidunt et qui dolorem non consectetur aliquid recusandae accusantium aut.', NULL),
(136, 'IGCUZU20J', 'Macie Denesik', 6, 60, '965.90', '9156.89', 'U', 'Provident in velit sed voluptas ad labore molestiae magnam amet vel voluptatem ut impedit unde est ipsum ducimus eos fuga fugit sint qui quidem enim temporibus et vero consequuntur odio eos fugiat.', NULL),
(137, 'SWNVRLZ08', 'Karson Macejkovic', 52, 183, '6093.11', '8853.56', 'U', 'Id illum et et perspiciatis enim eaque veritatis ut quos fugit ea amet reiciendis aspernatur fuga non facilis nihil harum ut.', NULL),
(138, 'JCQTLVS9', 'Haskell Schumm', 67, 715, '7819.88', '8467.74', 'P', 'Est ipsum ipsam porro libero placeat reprehenderit voluptatem et nihil vel eum maiores nihil error quis praesentium possimus ducimus dolor omnis dolorem aut corrupti aut ut ad et deserunt cum laudantium et laboriosam quibusdam.', NULL),
(139, 'TZHWKMWUI', 'Marquis Huels', 10, 687, '9929.36', '9146.49', 'U', 'Labore sit quam perspiciatis quis corrupti harum qui et voluptate eius ducimus recusandae repudiandae expedita corrupti sed adipisci et aliquam et est accusamus iste ipsa error ipsa ea nihil mollitia iste velit reprehenderit commodi hic.', NULL),
(140, 'CUANKSXCC', 'Mr. Clay Emard', 10, 445, '9782.64', '9380.90', 'U', 'Rerum consequatur nostrum explicabo autem aut quaerat dolor dolor sit doloribus sit maxime vel fugiat consequatur unde repellendus corporis dignissimos perspiciatis ullam neque atque et autem necessitatibus quam.', NULL),
(141, 'GVICIOAA', 'Myrtie Hickle', 44, 712, '4112.22', '9415.23', 'O', 'Dignissimos doloremque facilis atque unde non nostrum consequatur voluptas voluptatum occaecati nesciunt saepe rerum expedita aut et laborum ut vel qui eius facilis et vero autem molestiae accusamus facilis at qui at dolorem consequatur omnis.', NULL),
(142, 'XLNWDMITJ', 'Adah Schiller', 32, 331, '7031.86', '9558.40', 'U', 'Ut dignissimos incidunt vero et et molestias earum quia libero ex beatae ab non sint repellat nihil eos ipsam et maiores adipisci qui nobis.', NULL),
(143, 'OGSINLX2', 'Axel Goldner', 67, 972, '7607.25', '6521.31', 'O', 'Repellat commodi soluta culpa consequuntur non quo reiciendis minima est dolorum aut deleniti quis aut maxime quia tempore id qui a eos nesciunt est.', NULL),
(144, 'WLYJSUDGC', 'Dr. Sven Daugherty', 22, 878, '6175.43', '8437.01', 'U', 'Non ducimus sint iure quidem quaerat tempore perspiciatis est qui iusto quis similique blanditiis non autem placeat velit incidunt id blanditiis sequi voluptatem sint sed et reiciendis et aliquam est dignissimos explicabo vel natus quas asperiores fugit officiis sint consequuntur.', NULL),
(145, 'TFYEXVCBM', 'Newton O\'Conner Jr.', 78, 523, '7319.57', '9481.44', 'O', 'Voluptatem eum natus at est magni velit natus iusto dolore assumenda qui dolores eos provident et dolores amet in id assumenda omnis mollitia aut eveniet assumenda quia sit omnis aliquid id esse facere consequatur repudiandae distinctio fuga omnis iure et quia error rerum.', NULL),
(146, 'RPAJNM1K', 'Elda Corwin', 57, 568, '1710.22', '8769.06', 'P', 'Voluptatibus cum necessitatibus dolorem eius est perferendis alias consequatur natus aut ut rerum dolorem quibusdam quis blanditiis reiciendis officia molestiae voluptatum voluptas inventore ullam ut nostrum.', NULL),
(147, 'NQOJWMOVL', 'Mr. Ahmed Monahan', 52, 438, '9261.76', '9966.28', 'O', 'Molestias nobis atque voluptas fugit sit perferendis laborum porro nisi qui et sequi esse occaecati quis quod et velit nostrum nihil.', NULL),
(148, 'OJBGEI2X', 'Duane O\'Conner', 35, 564, '814.13', '5541.45', 'P', 'Quo tempora nam natus voluptatibus est dolorem dolores non nihil illum ut est mollitia aliquam expedita quasi vero omnis est et placeat sed et qui consequatur maiores tempore nulla in expedita praesentium officia iure voluptates nulla vel laudantium officia ipsam eos.', NULL),
(149, 'ZAOWBZ1F', 'Dr. Abe Beer', 45, 644, '3087.97', '7546.56', 'U', 'Veritatis vitae blanditiis minima enim ducimus dolor nihil magnam labore nesciunt aliquam voluptatum et dolorum suscipit molestiae sequi possimus qui qui dolor expedita praesentium natus omnis minima a adipisci earum optio ad illo voluptatem nesciunt aliquam.', NULL),
(150, 'VNKWVU510', 'Miss Melyssa Murray V', 56, 889, '1161.78', '8947.63', 'U', 'Distinctio iusto et non accusantium iste est et reiciendis vero modi consectetur sapiente non vel iusto quis doloremque amet tenetur quae pariatur aut mollitia excepturi vel excepturi impedit dolorem sed ipsam rerum beatae suscipit dicta dolorum.', NULL),
(151, 'MSAVRGLCP', 'Mrs. Juliana Mayer V', 9, 218, '6624.32', '5632.13', 'P', 'Harum est nihil officia aut vel aspernatur laboriosam minus aut dolores a est tempora laudantium nihil illo accusamus ut et est ut magni nemo dolorem error tenetur nostrum eligendi ex aut quaerat dolorem et voluptas iusto laborum.', NULL),
(152, 'OMNVAMXU', 'Braeden Cartwright Jr.', 22, 760, '2172.93', '7220.50', 'U', 'Dicta nihil assumenda sed voluptate unde quis quisquam atque eius quisquam maxime voluptas repellat excepturi aut id possimus culpa qui reiciendis porro doloribus dolore eius perspiciatis aliquid rerum necessitatibus eos eaque velit perferendis repellat est et illum adipisci eligendi.', NULL),
(153, 'QNZTGE9W', 'Keara Stehr', 52, 959, '2411.10', '7089.37', 'U', 'Neque nobis iure est doloribus aspernatur magnam qui libero pariatur rerum odio quia est quo sed dolores fugiat voluptate consequuntur autem quis aut voluptas non repellat culpa accusantium non et esse voluptatem rerum possimus sed tenetur.', NULL),
(154, 'GNFKVBUNR', 'Trisha Frami', 49, 850, '5999.97', '7538.05', 'U', 'Officia aperiam esse qui ea est corrupti et non officia iure cum ipsam cupiditate provident esse a facere quasi quo maiores libero veritatis suscipit et.', NULL),
(155, 'DIAFSI0Z', 'Mohammad Waters', 44, 309, '1339.58', '3468.63', 'P', 'Velit enim ut illum aut eveniet ea ducimus et sunt et quia voluptas et debitis voluptatum pariatur voluptates quibusdam voluptas temporibus saepe quisquam labore voluptatum ipsa numquam natus sint laboriosam.', NULL),
(156, 'ECOXZRUQ', 'Justyn Kutch', 26, 139, '6713.08', '4500.45', 'U', 'Commodi et modi nesciunt ut occaecati ad nam sunt impedit expedita ut cumque qui sed omnis sed repellat quibusdam alias iusto cumque consequatur eum facilis voluptatem error est aut ducimus iusto neque aut et ea excepturi minus facilis et in.', NULL),
(157, 'DVQHFHFE5', 'Eli Rowe III', 64, 451, '9142.17', '6249.83', 'O', 'Quis voluptas et et aut quod iste quo dolorum sit a aperiam enim quia omnis libero odio in sunt est ipsum at dolore omnis doloribus eos tempora tenetur est quis rerum amet illum veniam dolore corporis libero.', NULL),
(158, 'WZYMDJGQ', 'Mr. Makenna Kohler', 48, 103, '9346.26', '5249.03', 'U', 'Repellat ad sit sed accusantium et aliquid incidunt voluptatem autem eum error veniam ea veritatis ab corporis ut cupiditate qui delectus ducimus aperiam earum qui molestias.', NULL),
(159, 'VDHSSIZZ', 'Caitlyn Connelly I', 56, 427, '5751.15', '3134.62', 'U', 'Repudiandae quis voluptatem maxime corporis veritatis dolorem accusantium et pariatur et accusantium eius facilis perferendis ut minus veritatis non cum necessitatibus voluptatem ullam quam dolore ipsam non est.', NULL),
(160, 'QLKDNR55F', 'Oliver Kovacek', 41, 126, '9068.89', '3335.44', 'P', 'Quasi fugit qui nobis sint reiciendis est ea sequi ratione aperiam soluta quia vitae error doloribus harum est quis quia consequatur voluptatem ab minus aut repudiandae et asperiores voluptatem reprehenderit placeat.', NULL),
(161, 'XKCJEG0KW', 'Carli Rippin', 20, 911, '9769.84', '9393.66', 'O', 'Vel facilis consequatur ut hic unde soluta quibusdam itaque ipsum commodi rerum ratione doloribus illum earum dignissimos voluptate eaque qui sint.', NULL),
(162, 'OSTXVKAQ', 'Rosalia Champlin', 83, 153, '8777.59', '8438.04', 'O', 'Consequatur rem consequatur quos illo perferendis vel provident sit voluptatum ut delectus maxime quo nesciunt hic amet repudiandae et voluptas a qui omnis eum est.', NULL),
(163, 'XWNSDIPVH', 'Gordon Jones', 77, 132, '4108.99', '9945.45', 'P', 'Ad quia fuga quas consequuntur quis quasi quisquam exercitationem ex suscipit ea modi fuga possimus perspiciatis quaerat recusandae dolor reiciendis at ut doloribus.', NULL),
(164, 'LJSTVQJY', 'Brionna Gulgowski', 76, 7, '6446.04', '6055.35', 'O', 'Possimus temporibus et veritatis dolore ea ad provident ipsam est ea est assumenda repellendus voluptatem quam ut ullam et quibusdam ad quam esse nihil illo omnis corrupti molestiae porro sapiente eaque eligendi.', NULL),
(165, 'IKSVQO77I', 'Carson Kassulke', 60, 174, '6527.51', '4718.56', 'O', 'Fugit distinctio voluptatibus quo reprehenderit officia voluptatem molestiae at enim quia nisi et modi dignissimos deleniti voluptas itaque est aut omnis pariatur est corrupti doloribus sunt cumque saepe et ducimus nam autem itaque omnis architecto eos.', NULL),
(166, 'AJXMRPOC', 'Sam Stanton', 3, 874, '6780.00', '4413.09', 'P', 'In quasi eaque asperiores deleniti cumque odio eum dolores beatae corrupti sit deserunt sit dolor numquam non inventore sed qui et minima repellat dolorum quia dolores fugit voluptas temporibus architecto sint ut at omnis quaerat quos consequatur quam qui architecto et ratione.', NULL),
(167, 'UQKUVEMZ9', 'Prof. Lucious Glover', 62, 213, '653.51', '558.75', 'O', 'Ut aut dolores perferendis velit sit vitae delectus quibusdam id quam qui id commodi et explicabo et voluptas nihil natus esse eligendi ab voluptatum iste quia vero.', NULL),
(168, 'CULDLIEU', 'Mary Blick', 41, 300, '1104.73', '6789.86', 'U', 'Dolorem itaque minus est aut deleniti ab eum exercitationem eveniet impedit nihil et dolorem totam recusandae eos adipisci sit velit necessitatibus et qui aliquam veniam accusamus et distinctio molestiae facere ut distinctio.', NULL),
(169, 'EAPNRAE6', 'Ms. Lorna Wilderman', 1, 4, '4945.45', '1379.41', 'O', 'Alias odit at quod nulla iure qui maxime qui officia accusantium consectetur dolor sit praesentium numquam assumenda quia minus eos labore nemo est ut illum aperiam molestiae maiores.', NULL),
(170, 'AGKVJYAP', 'Eliane Windler', 10, 568, '3537.30', '2437.40', 'U', 'Est architecto ea repellat eius aut voluptas nihil sequi ratione repellendus in cupiditate velit molestiae pariatur fugiat nostrum suscipit praesentium voluptate optio quis odit dolores et maiores impedit eaque voluptas rem tempore laboriosam sint ut qui et.', NULL),
(171, 'TEGOHKTW', 'Dessie Halvorson', 27, 947, '9528.10', '606.10', 'P', 'Odio ex tempore aut quod perferendis qui in dolorem provident quos laborum commodi autem eos dolores qui eius amet aut fugit est cum quo ut veritatis ab et iusto qui cupiditate dicta deserunt incidunt saepe dolores.', NULL),
(172, 'XVTISW492', 'Dr. Aliya Oberbrunner', 70, 999, '6591.38', '5874.59', 'P', 'Et doloribus sint omnis et et ut et voluptatum aut et veritatis temporibus quia nisi deserunt est inventore adipisci ab dolorem blanditiis molestiae eos consequatur quia odio architecto impedit maxime itaque quo eos ipsa quis repudiandae tenetur impedit perspiciatis vitae est eius.', NULL),
(173, 'QLKRZTIEO', 'Mrs. Alisa Goodwin', 70, 57, '2071.28', '7382.70', 'O', 'Magni atque aut sed quisquam tempora inventore nobis nemo quibusdam est eligendi qui cum minus eos quam quia sit rem nam consequatur accusamus corporis dignissimos ratione ducimus quo voluptatem laudantium molestiae et natus praesentium distinctio rem.', NULL),
(174, 'JNBZQPEPI', 'Eulah Will', 17, 758, '3568.56', '7806.38', 'U', 'Dolore id repudiandae sit qui voluptas deleniti voluptatum eos et dolor similique odit est reprehenderit dolor corrupti fugit sequi nobis veritatis ut quae perferendis adipisci quidem repudiandae voluptatum voluptatem.', NULL),
(175, 'YETQNTND2', 'Mr. Maximus Deckow', 53, 151, '3427.74', '5464.53', 'O', 'Occaecati enim sapiente laborum et maxime maiores corporis nostrum error quasi omnis dolores odit debitis voluptatum voluptatum illo ratione reiciendis vitae commodi ratione.', NULL),
(176, 'MERSYX7ZW', 'Arvel Turner', 65, 384, '1269.30', '160.44', 'P', 'Nisi asperiores sed eligendi aut rerum repudiandae minima qui eaque exercitationem ea corrupti perspiciatis quis rerum commodi rerum maiores blanditiis explicabo eum consequatur vitae unde.', NULL),
(177, 'IPMPTSQSI', 'Maureen Ratke', 86, 850, '9561.74', '857.25', 'P', 'Natus et minus sequi magnam repellendus ad eveniet quas voluptatibus consequatur pariatur et nesciunt eos et aut expedita iusto quia quidem et et et delectus ipsam inventore tenetur.', NULL),
(178, 'SDVPADD8U', 'Misael VonRueden', 5, 963, '421.52', '7130.79', 'P', 'Illum sed amet ut architecto est est dolor et ea perspiciatis nulla nam voluptatem repellat quasi delectus doloribus unde sequi quam et illo est cupiditate velit nesciunt et qui consequatur quisquam sequi deleniti nihil aut sit quia.', NULL),
(179, 'OJBCHCH5H', 'Dr. Kaia Lueilwitz', 7, 421, '7570.88', '9699.06', 'P', 'Inventore necessitatibus corporis sunt aut numquam velit voluptas voluptatem qui autem quo sit et laudantium illo inventore laboriosam et possimus dolores cumque error quia est nemo quasi autem sit totam atque necessitatibus neque aut quia occaecati ipsa expedita aspernatur.', NULL),
(180, 'MCPBMGIHV', 'Dr. Josefina Hyatt', 76, 947, '9540.54', '2927.14', 'P', 'Et id perferendis quis et illo illo ut quis adipisci minima beatae minima sint unde earum error et et non quibusdam laudantium deserunt autem aperiam debitis sit quidem et voluptatem eius consequuntur rem et quia voluptas.', NULL),
(181, 'KQQOTI21X', 'Allan Ledner', 17, 447, '3035.38', '1646.96', 'U', 'Nihil voluptatum dignissimos odit vero veritatis eos saepe ut alias quas autem beatae ut omnis enim corporis sunt accusamus vero magnam maiores adipisci ut quia qui itaque veritatis voluptas aut odit.', NULL),
(182, 'CZCQNWOT', 'Enos Feil', 7, 836, '2829.41', '1950.25', 'O', 'Labore numquam totam repellat quis labore sed sunt nam et ut fuga iusto adipisci modi in iste quaerat illum ducimus sit ut magni expedita consequatur quia blanditiis vitae debitis et fugiat veritatis praesentium autem rerum doloremque quia in rerum aut repellat.', NULL),
(183, 'HHPBZEMI', 'Alberta Hettinger', 68, 434, '6275.24', '5007.10', 'O', 'Minus dolores modi consequuntur sed corporis quos enim odit ut dolorem et tempora optio illum tenetur sit et quibusdam minus amet vel et odio dicta ipsam unde illo dolorem at est molestias vitae unde sit ut distinctio omnis.', NULL),
(184, 'MTTUFDLKY', 'Prof. Kitty Jacobi I', 57, 467, '9613.15', '218.51', 'P', 'Suscipit quo et quam aut ea est ipsa vel a tempore nulla dolorem aut et dolores quam veritatis quia sint omnis aut eaque accusamus veritatis esse quia blanditiis placeat nihil possimus eaque blanditiis unde vitae illum blanditiis quasi fugiat aliquam.', NULL),
(185, 'CSWQLFI5', 'Shanon Hills MD', 14, 783, '5094.23', '8766.18', 'P', 'Quam soluta voluptates cupiditate quia dignissimos sed aut eveniet quis autem ab ex eius sed temporibus soluta tenetur id et a nihil molestiae ipsum corporis vero voluptatem veniam omnis quis voluptatem ea necessitatibus delectus illo eaque quod.', NULL),
(186, 'OMIGXULO', 'Bailee McLaughlin', 70, 921, '7385.45', '2319.17', 'P', 'Cum aut molestiae vel soluta nemo voluptatem tenetur temporibus consequuntur deserunt aliquid maiores explicabo eligendi in corrupti dolore necessitatibus in explicabo occaecati dolor debitis necessitatibus fugiat nam eveniet et voluptatem ullam ut accusantium aut eaque et vel beatae.', NULL),
(187, 'NESJFZQN', 'Mr. Daryl Kohler', 61, 658, '739.75', '1333.84', 'O', 'Qui et nesciunt perferendis laborum in deserunt quod id eos quibusdam iure et sequi cupiditate consequatur sequi deserunt cumque quaerat et nisi praesentium nulla perspiciatis sunt expedita nesciunt.', NULL),
(188, 'CKUUMM8AR', 'Jacinthe Kris', 42, 1, '420.06', '34.35', 'O', 'Error quidem corrupti eius aut voluptatem earum nobis quisquam ad fugit pariatur reiciendis expedita veniam veniam error dolorum aut delectus explicabo placeat aperiam et magnam esse voluptate rerum quis nihil eligendi neque.', NULL),
(189, 'LGGOUQQIV', 'Delbert Cremin', 32, 355, '1733.16', '3223.71', 'P', 'Nesciunt consequuntur praesentium rerum in non qui quos laboriosam sed laborum recusandae molestiae nesciunt facere exercitationem accusamus repellat quis.', NULL),
(190, 'OVOYOU5M', 'Mara Connelly', 2, 775, '7937.00', '1909.48', 'P', 'Reprehenderit id in maiores voluptas optio dolore architecto tenetur qui doloremque maxime aut quasi totam voluptate pariatur rerum laboriosam ea odit iure optio quia quae tenetur harum libero magnam quos et qui porro voluptas nemo pariatur sapiente.', NULL),
(191, 'DJDAUBCTU', 'Karolann Ritchie MD', 4, 642, '3979.94', '3592.84', 'O', 'Nihil qui quaerat est incidunt nesciunt doloribus dolore sunt tempora ab illo aut dolore est cupiditate labore architecto itaque quia et voluptas tenetur.', NULL),
(192, 'HTXLPFRN', 'Lacey Haley', 17, 304, '9673.81', '8490.07', 'O', 'Veritatis id voluptatem repellendus dolor fugiat libero quia porro at quia officiis culpa dicta alias ea molestiae dolores quo commodi aspernatur sit a eos molestiae asperiores reprehenderit quos.', NULL),
(193, 'ZETWTZJS', 'Kenton McLaughlin', 32, 637, '6889.92', '6053.26', 'O', 'Assumenda et consequatur ratione reiciendis et consequatur est fugit odit temporibus repellendus sapiente et consequatur quo quia sed quas reiciendis est dolore quae quidem.', NULL),
(194, 'KTCFPPPR0', 'Jada Klein', 23, 556, '5430.57', '482.04', 'O', 'Recusandae cumque et unde eos occaecati eveniet delectus et quo iste reprehenderit sit eveniet iste corrupti sed autem maiores veniam corporis ut sit dolore perferendis.', NULL),
(195, 'HBEROKHB8', 'Terry Bartoletti', 19, 848, '3530.52', '4925.35', 'P', 'Nam id aut et ullam qui vel iusto quia laborum sapiente et tempora amet voluptatem similique blanditiis facilis et et recusandae aut inventore voluptatum quas.', NULL),
(196, 'TVLKEIDED', 'Janiya Witting', 37, 175, '673.79', '4260.84', 'U', 'Cum et hic numquam quo consequatur eius iusto modi perspiciatis nobis dolore culpa consequatur et sed ex aspernatur doloribus adipisci itaque sed enim ex eos et eaque sint unde vitae quaerat.', NULL),
(197, 'KVINMO2P', 'Reginald Kautzer', 12, 60, '2423.00', '5275.40', 'U', 'Molestias quia quod quisquam culpa facilis reprehenderit quae suscipit et ut nesciunt facilis voluptas recusandae illum cum cumque aliquid.', NULL),
(198, 'BXDMHJSK', 'Mrs. Yesenia Abshire', 47, 383, '8382.41', '1337.14', 'O', 'Tempore aperiam perspiciatis et necessitatibus quia aut id quia est nostrum voluptates molestiae aut sunt aspernatur dolorem ipsam repudiandae aut.', NULL),
(199, 'SNLHSU31', 'Prof. Zander Bashirian I', 49, 877, '1729.98', '5164.60', 'P', 'Veniam quam accusamus exercitationem rerum dicta iste sit sed explicabo nam natus repellat cumque non sint molestias voluptatem tenetur distinctio excepturi est nisi distinctio minima aut eum ut atque quo ex est exercitationem molestiae expedita pariatur.', NULL),
(200, 'XTQSPKYHP', 'Sonny Zemlak DDS', 17, 185, '852.24', '6343.12', 'P', 'Laboriosam earum est odit quam numquam provident et sint quia delectus dolor sit assumenda et enim ut et fuga non ratione voluptas reiciendis rerum doloremque mollitia voluptas consequatur consequatur tempore ratione deleniti ad aspernatur ipsum magnam rerum ipsam est aperiam dolores.', NULL),
(201, 'GNPKIBKO', 'Dr. Brandyn Ankunding', 80, 195, '6511.67', '9965.04', 'P', 'Voluptatum quasi placeat eum in est veritatis eaque est explicabo dolorem atque culpa assumenda asperiores aspernatur in et hic cumque molestiae perferendis quod et est expedita fuga harum veniam numquam itaque voluptas debitis iure autem.', NULL),
(202, 'RKCZBC2C', 'Gabrielle Kuhlman', 66, 351, '7804.84', '2771.77', 'O', 'Est voluptas qui et deleniti sequi et soluta aut reiciendis assumenda eos quo qui ea odio labore similique nesciunt eaque eius consequuntur qui numquam saepe qui consequuntur laudantium cupiditate hic et sed.', NULL),
(203, 'ONBYUES2', 'Dr. Daija Hoeger II', 66, 724, '887.53', '782.54', 'U', 'Laborum nihil perferendis quibusdam ducimus sit provident quam facere odio veritatis minima dolorem dolores nobis sint nam occaecati autem voluptas enim et quia ex ut eaque et.', NULL),
(204, 'ARXBPQNOY', 'Claire Upton', 50, 169, '3835.38', '2478.07', 'U', 'Aliquid autem ab sit quia autem sapiente et dolorem voluptates excepturi porro earum hic et repudiandae minima est recusandae est placeat tempora dignissimos aut non.', NULL),
(205, 'ZRBKOO4VY', 'Samanta Runolfsson II', 46, 254, '4556.50', '8347.14', 'U', 'Occaecati perspiciatis quam est quaerat omnis sit quis occaecati qui odit perspiciatis optio maxime sint voluptate aperiam ut velit rerum pariatur omnis veritatis quaerat ea laboriosam voluptatibus incidunt.', NULL),
(206, 'FYLCVR35P', 'Theron Borer', 41, 535, '7613.93', '863.90', 'U', 'Quas ex nobis officia quia atque aut quaerat totam itaque nihil ab consectetur voluptas nihil magni laboriosam qui sint libero iste sed nesciunt aut quidem excepturi sed rem velit et nam totam et quibusdam rerum sit corporis explicabo.', NULL),
(207, 'WSQMKMXND', 'Madalyn Rice', 3, 656, '2831.48', '9928.07', 'O', 'Id illo qui quaerat consequatur fuga et aliquam sint qui dolorum quia atque qui cupiditate quo ut enim dolor consequuntur quis.', NULL),
(208, 'ZFFCEQ7G', 'Chandler Schimmel', 43, 920, '7370.80', '723.01', 'U', 'Qui beatae aliquid dolorum dicta amet suscipit rerum laboriosam doloremque necessitatibus enim voluptatum impedit est aut corporis dolor ab eius ducimus et amet hic suscipit magni ducimus est dolores unde architecto vitae et sunt et eos aliquam ut fugiat consequatur.', NULL),
(209, 'UZNHWA0F', 'Prof. Jason Hessel', 14, 846, '9823.13', '2152.28', 'P', 'Et dolore soluta maiores sunt saepe reprehenderit sed architecto cupiditate autem veniam provident nobis cum reprehenderit quo ipsam aut suscipit temporibus repudiandae et illum rerum porro nisi corrupti veritatis odio quibusdam velit officiis illo voluptatem recusandae corporis saepe quasi.', NULL),
(210, 'EXFRRABE', 'Billy Stehr', 89, 178, '4527.28', '3743.00', 'O', 'Et atque voluptatem ea totam aut voluptatem doloremque molestias odit voluptate nihil aperiam maxime quaerat dolores quasi dolor modi vel molestias natus magni praesentium repudiandae placeat ullam quis quia beatae fuga omnis qui impedit qui aspernatur eligendi sit.', NULL),
(211, 'RGNBNK9W', 'Roma Schiller', 33, 688, '2277.86', '3608.48', 'P', 'Aut unde et non est dignissimos rerum qui dicta ipsam blanditiis voluptatem et eligendi pariatur maxime consequatur quia rerum repudiandae qui aut ipsam incidunt qui non.', NULL),
(212, 'ZVKWHNMJC', 'Carlotta Casper', 80, 739, '7561.48', '6638.18', 'U', 'Et ut aut consequatur eum sed iste et at assumenda quia blanditiis qui at distinctio veritatis aut explicabo optio cum.', NULL),
(213, 'WRFKRRJPF', 'Nathaniel Cole', 56, 799, '5276.02', '579.15', 'P', 'Aut magni iste officia ut repellat distinctio animi explicabo delectus ratione soluta sit tempore enim consequatur veritatis quis officia at in quam iure adipisci deleniti repellendus eius accusamus rerum sapiente ratione libero soluta quo reprehenderit animi inventore dolorum eum maiores et.', NULL),
(214, 'XVRGJN89S', 'Elmer Wilderman', 1, 254, '8610.98', '2223.54', 'O', 'Sed repellat quibusdam voluptatibus et ab minima sed doloremque suscipit ab esse corporis doloribus aperiam est quaerat sit consequatur quo.', NULL),
(215, 'QOVKGTH3J', 'Edwin Zboncak', 71, 116, '3596.19', '3795.20', 'O', 'Cumque eum qui quis sit dolor culpa dolore quam accusamus ut excepturi repellendus ipsa dolores esse necessitatibus in voluptatem ut molestias molestiae.', NULL),
(216, 'ZLBMSNBA', 'Aiden Lind', 2, 369, '8652.08', '1308.84', 'P', 'Et dolores ut repellendus ab nisi aspernatur consequatur et eos quia minima nesciunt esse voluptas consequatur corporis id illum inventore sapiente inventore molestiae quod hic quia error animi autem culpa reprehenderit aliquam blanditiis sed.', NULL),
(217, 'OPANWOMV', 'Mollie Brakus', 19, 783, '6187.39', '2315.64', 'O', 'Omnis aut et laudantium atque voluptates fuga nesciunt nisi sed qui dolores repellendus dolor quia nihil id quia laborum explicabo eligendi quis eius omnis fugit asperiores sint aut harum dolores eos et delectus animi.', NULL),
(218, 'KPYISJBE6', 'Miss Damaris Murphy', 4, 256, '2036.92', '1009.47', 'P', 'Quo quibusdam velit est culpa voluptatem voluptatem ducimus quia rerum nisi quo explicabo quas eos et qui corrupti consequatur vero consequuntur ipsam aspernatur natus voluptatem qui qui eaque deleniti ullam molestias ex velit aut modi distinctio omnis iste quam rerum repellat assumenda dignissimos.', NULL),
(219, 'UINKNPZXB', 'Dr. Destini Dooley PhD', 83, 368, '7212.68', '5770.23', 'U', 'Consectetur iure maiores sit laudantium nihil porro et perspiciatis odio aut doloribus iste cum animi ut est quis perspiciatis maxime qui voluptatum earum quo temporibus sapiente eius quam occaecati saepe similique assumenda dolor ducimus sed.', NULL),
(220, 'OTGFPSK7', 'Karen Walker', 34, 129, '3821.43', '7529.99', 'P', 'Maiores ipsa exercitationem veniam quidem animi quos eligendi libero quaerat voluptas eum maiores necessitatibus odio non in reiciendis ut et voluptatibus voluptatem.', NULL),
(221, 'PUUHLSH2I', 'Faustino Graham', 38, 674, '6356.19', '3909.17', 'U', 'Nam ducimus architecto ratione quo odio ea perferendis fuga quod repudiandae non qui cupiditate temporibus cupiditate commodi est quibusdam et doloremque.', NULL),
(222, 'SJZPHKJ8V', 'Ms. Sierra Rohan V', 57, 592, '7886.55', '6744.45', 'P', 'Enim aut quia voluptatem enim enim error est voluptatibus nulla quaerat est et tempore eaque inventore numquam voluptas eum debitis perferendis nulla libero.', NULL),
(223, 'VQPKYN92', 'Dr. Bradly Lebsack PhD', 5, 385, '4530.52', '4584.96', 'U', 'Harum sit maxime omnis consequuntur non non earum repellendus et sed ut non id a quo fuga assumenda quis et quod officiis voluptas eum rerum nihil quod.', NULL),
(224, 'BIDTQIVO', 'Israel Hand', 60, 463, '2740.72', '215.14', 'O', 'Alias ratione numquam optio iste similique facere voluptatem accusamus similique fuga voluptas numquam debitis itaque quaerat quia ipsa veniam eveniet autem quam illo ea libero esse tenetur corrupti aut expedita pariatur fuga sunt et.', NULL),
(225, 'HCIDHOAC', 'Cecilia O\'Conner', 52, 173, '251.16', '9935.72', 'U', 'Cumque aut dolores adipisci dignissimos doloribus dolorem quaerat exercitationem non dicta recusandae repudiandae explicabo quia quis aut quo distinctio nisi consequatur optio placeat qui accusamus a ea optio error quia excepturi ut nesciunt nihil et reprehenderit.', NULL);
INSERT INTO `articulos` (`IdArticulo`, `CodigoArticulo`, `NombreArticulo`, `IdCategoria`, `CantidadExistencia`, `PrecioVigente`, `TotalValorado`, `TipoInventario`, `Descripcion`, `FechaVencimiento`) VALUES
(226, 'RIQDOU5P8', 'Janis Ankunding II', 36, 105, '1766.43', '9374.07', 'O', 'Sint itaque ratione itaque animi tenetur vitae quo officia excepturi iusto voluptatem amet sit rerum corrupti corrupti voluptatem voluptate dicta sit provident quos quo consequatur officiis possimus est blanditiis quis commodi reprehenderit eius alias distinctio accusamus laboriosam quidem doloribus qui quibusdam.', NULL),
(227, 'TEOAKX3Z', 'Mr. Kamren Conn', 78, 166, '7718.20', '5722.49', 'O', 'Sed dolores dolorem quam excepturi laborum qui occaecati soluta et similique inventore consequatur nesciunt iusto quo libero consectetur reprehenderit saepe quas qui sit et id.', NULL),
(228, 'EPLOFUBJF', 'Amie Stanton', 58, 799, '502.10', '1455.69', 'U', 'Voluptates alias voluptatem quo occaecati modi neque sapiente est ut accusamus et expedita labore ea iusto sit possimus repudiandae rerum qui minus qui non doloremque eos quis perferendis velit molestiae minus saepe id iure temporibus eveniet dolorem id itaque at.', NULL),
(229, 'GKSRETAS', 'Lyda O\'Conner', 45, 21, '628.33', '9617.90', 'U', 'Itaque aut tempora hic nostrum sit aut ipsam dolore maiores consequatur quibusdam recusandae id iusto provident labore facilis est non voluptatem corporis illo quaerat iure consequatur quibusdam reprehenderit dignissimos laboriosam est quam fuga consequatur sit sit cum aut est aut.', NULL),
(230, 'WFKDOGFI', 'Dameon Gerlach', 22, 831, '7376.17', '5400.48', 'P', 'Sapiente exercitationem tempore et quia dolor provident vel qui odit voluptatibus quibusdam omnis nesciunt ipsam possimus dignissimos alias dolor et est dolor eligendi sit repellat nesciunt architecto commodi quo natus eos quis at non voluptas eius enim ullam iusto.', NULL),
(231, 'CZDINASH', 'Frank Gutkowski', 2, 129, '557.27', '3151.95', 'U', 'Minima et sunt facere molestiae sapiente adipisci occaecati unde unde ad sequi et repellat id molestias est aliquid fuga id voluptate neque aut consequuntur sapiente.', NULL),
(232, 'JRQQJHVQ', 'Sebastian Kshlerin', 32, 872, '5845.73', '1169.44', 'O', 'Officiis velit qui vero aut aliquid occaecati omnis dolorum debitis impedit nisi sunt corporis aut in sed minima debitis incidunt blanditiis dolorem omnis modi delectus non non quis.', NULL),
(233, 'KEQABTCCI', 'Blanche Smith', 83, 816, '1479.53', '6978.35', 'P', 'Voluptatem et blanditiis reiciendis ut culpa repellendus commodi ducimus placeat minus ea repellendus cum consectetur numquam numquam harum voluptatem quos excepturi expedita ut qui vel sunt quia recusandae.', NULL),
(234, 'ULBTEYMZO', 'Darlene Huel II', 37, 97, '5745.38', '3850.52', 'P', 'Ea magnam beatae non a consequuntur explicabo est possimus doloribus quaerat et magnam et deserunt dolor molestiae nisi aut voluptatum eum consequuntur suscipit earum nesciunt explicabo rem in excepturi blanditiis nostrum magni odio repudiandae aperiam rerum animi nulla.', NULL),
(235, 'BWGKCWKXJ', 'Sophie Hand', 56, 362, '5180.46', '3984.97', 'P', 'Omnis est reprehenderit autem labore voluptate debitis consequuntur cumque expedita quisquam quidem et occaecati ratione delectus accusamus sunt sed qui odio fugit et officia ut quia cupiditate veritatis et quia nam aut amet facere illo et atque vel.', NULL),
(236, 'NZWHRKFZ', 'Alden Bartell', 30, 688, '8442.93', '8410.01', 'U', 'Non tenetur fuga perferendis nesciunt ea eligendi odio distinctio ut voluptatem non dicta tenetur ut dolore facere eius sunt fugiat.', NULL),
(237, 'ZJRZRMVC', 'Edmund Herzog', 1, 556, '6191.08', '9079.80', 'P', 'Aut accusantium qui dolorum excepturi ea dolores similique culpa nihil numquam consectetur fugiat laborum odio repudiandae reiciendis saepe debitis et.', NULL),
(238, 'VVCEGQZ5L', 'Ms. Willa Stiedemann', 2, 239, '828.32', '7331.20', 'U', 'Et a iure sint sunt rerum eius eveniet aut et fugiat accusantium inventore qui laudantium dicta ut animi quibusdam et qui ab.', NULL),
(239, 'NUKQFMPX', 'Prof. Ryder Morar MD', 47, 439, '5313.15', '4069.88', 'O', 'Maiores ipsam quaerat quis quae laborum voluptas accusamus consequatur rerum qui aut laborum repellat explicabo aut ipsum sunt officiis commodi provident dolores odio aut fugiat id quo nostrum saepe magni quia.', NULL),
(240, 'BACBGG6U', 'Angelina Rosenbaum', 77, 890, '4630.92', '7051.05', 'P', 'Rerum voluptas dolores beatae necessitatibus vero dicta sit molestias voluptatum optio sapiente incidunt vitae a unde quae quia quia asperiores pariatur ex maxime ducimus dolore maiores facilis sapiente voluptatum nihil natus quo atque veniam alias omnis occaecati placeat.', NULL),
(241, 'LFLISIG5H', 'Liliane King', 61, 407, '9962.94', '9430.13', 'O', 'In praesentium nisi odit corrupti sit debitis officia dolor amet consequatur qui facilis dicta dolore sapiente et adipisci sunt praesentium aut.', NULL),
(242, 'KAJXBZHQ', 'Dr. Jarret McKenzie V', 73, 790, '4759.18', '7762.08', 'P', 'Iste dolorum quia quos tempore nostrum repudiandae eos illo eos aut ipsa atque quia aut in eius distinctio sint sint est voluptatum saepe sed qui repellendus neque mollitia culpa.', NULL),
(243, 'YEADLSHD', 'Evalyn Okuneva', 43, 210, '1035.50', '383.59', 'P', 'Eum expedita qui nemo suscipit in reiciendis aut ipsum iure esse officiis voluptas voluptatem quos voluptas placeat accusamus autem odit maiores molestiae.', NULL),
(244, 'IQAULDWR', 'Sasha Padberg', 81, 381, '3854.46', '6167.82', 'O', 'Quasi eaque sint possimus porro rem laborum rem error est dicta porro quibusdam quaerat nobis et alias quis quam quisquam mollitia assumenda quasi saepe corrupti voluptatem repellat autem quia dolorem voluptas ipsa est sed ab eos porro.', NULL),
(245, 'DXANMGW2', 'Carlotta Berge', 57, 184, '9091.23', '9521.81', 'U', 'Accusantium beatae et vero dolorem vel aliquam quia doloremque culpa labore sed sunt natus eum repudiandae voluptatem minus vel eaque qui quia minima voluptatem officia quia maiores commodi enim occaecati esse laboriosam qui ut architecto totam dicta voluptatem et accusantium aut.', NULL),
(246, 'IHFRTSG2', 'Melissa Kling', 60, 334, '6881.70', '9386.87', 'O', 'Voluptatum fugiat est quae ex autem et necessitatibus architecto placeat alias laborum quaerat adipisci illum maiores ut fugit ipsa illo officia hic adipisci et omnis quam.', NULL),
(247, 'EJWLUQRSF', 'Ms. Dayna Ledner PhD', 88, 357, '989.10', '9429.53', 'U', 'Nisi rerum similique et rerum autem rem sequi sit eos quia quia rerum quod qui nulla aut veritatis expedita velit assumenda omnis corrupti omnis rerum est quos consequatur enim sunt quaerat asperiores fugiat voluptatem similique et quaerat quia doloribus.', NULL),
(248, 'UQTFNAKMC', 'Olin Armstrong', 43, 820, '2344.04', '4863.19', 'O', 'Mollitia perferendis sit quia consequatur debitis debitis laboriosam qui vel magnam aut sunt voluptatem nihil delectus rerum et et eaque.', NULL),
(249, 'RHGLKRAU', 'Dr. Brannon Abernathy', 32, 913, '7085.11', '3967.93', 'P', 'Aut occaecati doloremque beatae ab commodi iusto nostrum sed et et sit quidem a ut et perferendis quibusdam quas.', NULL),
(250, 'LSQMCX11', 'Davon Cartwright', 88, 6, '9319.61', '3415.04', 'O', 'Enim ea veritatis beatae dicta dolorum blanditiis deleniti dolorum enim ea voluptatem qui quidem nihil esse natus dolor voluptate repellat aut a eum.', NULL),
(251, 'IAZNVB19', 'Dr. Delmer Upton IV', 78, 528, '5890.71', '3683.61', 'U', 'Aliquam veritatis dolores provident necessitatibus consequatur laudantium error molestiae illo natus eos corporis quisquam vel ut quibusdam cum consequatur aliquam voluptates quia distinctio incidunt assumenda eum non ipsa officiis perspiciatis id facilis a.', NULL),
(252, 'VCJCCKKE', 'Mr. Cielo Beier V', 62, 535, '5264.61', '2424.08', 'O', 'Ullam consequuntur amet mollitia sequi aspernatur quidem officia saepe officiis et aut deleniti placeat quia sed facere magnam quas nihil maxime voluptas dolore ad et velit nihil hic doloribus dignissimos et culpa quo harum dolores aut culpa omnis ratione aspernatur.', NULL),
(253, 'ESKUZGKGG', 'Deonte Anderson', 42, 115, '740.15', '8440.32', 'O', 'Atque est delectus inventore dolorem et non accusamus ratione nesciunt sint sunt consequatur at velit doloremque ex ipsum consectetur et voluptatem necessitatibus repudiandae ducimus aperiam ea minus laudantium eaque id iure voluptatibus quasi tempore accusamus recusandae earum aut delectus voluptatem dicta est fugit.', NULL),
(254, 'YYHWAKTDO', 'Bryon Hammes', 29, 960, '5532.39', '9890.80', 'P', 'Et quam esse omnis consequuntur quasi eos magnam alias fuga cumque quidem sequi et labore doloribus veritatis deserunt rem sed accusamus nostrum est quo inventore enim odio quas et eius repellat.', NULL),
(255, 'OWQIDUDBB', 'Jasmin Schmitt', 30, 200, '8190.53', '8056.31', 'P', 'Ad et modi sed maxime aut dolores ea tenetur assumenda sit aperiam quis quos eligendi accusantium illo fugit deleniti temporibus ipsum quam et est voluptates molestiae delectus perspiciatis modi omnis consequuntur non voluptas eligendi iste error vitae voluptatem minus.', NULL),
(256, 'FNFZEC3Q', 'Easter Schneider', 38, 621, '6133.59', '9168.17', 'O', 'Voluptates quis eos quaerat est nisi quisquam accusantium excepturi quam deleniti fuga perferendis sequi dicta eius quam ut sit ut et accusamus et aspernatur dicta fugiat ut qui.', NULL),
(257, 'XWASVE6K', 'Mr. Willy Sauer Jr.', 53, 565, '9579.37', '7586.12', 'U', 'Suscipit unde ex modi amet aut blanditiis laborum sit voluptas placeat numquam vero aut aspernatur modi qui alias ea aut recusandae aliquid est mollitia ut nihil earum harum consequatur dolor iste est minima ut consectetur sint fuga.', NULL),
(258, 'JCENDXZT', 'Mrs. Edyth Bartoletti MD', 84, 692, '4326.77', '2931.03', 'U', 'Ut qui dolorum iure aut iure sit tempore deserunt quod amet provident quibusdam at doloremque debitis et et consequatur pariatur cumque recusandae dolorem est repellendus aperiam odit inventore velit ad reiciendis sint ut accusamus placeat libero error.', NULL),
(259, 'OBWSTKWX', 'Emmanuelle Harber', 88, 413, '8734.89', '4891.81', 'P', 'Eum aut aut omnis non qui vel quia quo a voluptatem dolorem vitae quo labore iste et ipsa ullam adipisci quia velit dolor eos minima repellendus qui aut optio minima vitae non sequi perspiciatis qui est.', NULL),
(260, 'OSTQIHVG', 'Osbaldo Stark', 26, 216, '590.58', '7112.70', 'U', 'Ab nesciunt excepturi animi blanditiis laboriosam eligendi reiciendis totam nisi neque fuga consequatur error voluptate nulla nemo eligendi excepturi minus deserunt.', NULL),
(261, 'XHXMZGC4B', 'Michelle Bernhard', 87, 513, '7827.59', '7241.57', 'P', 'Fugit dolor hic laborum consequatur vel nemo et sint labore magni aperiam totam facere architecto et recusandae dolorem quia nulla iusto odio neque maiores voluptas corporis officiis accusamus optio quia explicabo possimus delectus cum numquam natus voluptas illo.', NULL),
(262, 'JFGPRDL9', 'Mrs. Shany Wilkinson II', 34, 141, '620.44', '3915.68', 'U', 'Eveniet sit similique rerum numquam omnis est dolor tenetur aliquid in minima rem perspiciatis illum dolores at fugit tenetur repudiandae officiis cum quia corporis dolorum vel minima repellendus molestias fugit consequatur vel quo.', NULL),
(263, 'DZOTEB9O', 'Roslyn Schroeder DVM', 88, 54, '5030.75', '1909.67', 'O', 'Eos nesciunt cupiditate omnis enim libero est impedit quasi vel ad et minus ut quia iste vitae nobis consequatur.', NULL),
(264, 'QOJJRDUYG', 'Evangeline Labadie', 39, 178, '2804.37', '5039.23', 'U', 'Numquam sed corporis sunt minima maxime nostrum impedit non voluptates tempora temporibus placeat sit reiciendis mollitia et omnis qui et et voluptatem delectus maxime eius quo ad et repellat sint.', NULL),
(265, 'JUACIKJY', 'Fannie Will', 66, 199, '7261.32', '4130.51', 'P', 'Magni rerum quibusdam eum in blanditiis asperiores dolorem voluptas reiciendis sunt vel a quo doloribus repellat earum corporis quasi quis iusto quo magnam iure voluptatem perferendis nisi beatae eos nihil ut cumque perferendis neque fugiat fugiat soluta.', NULL),
(266, 'WCTOQLGN', 'Miss Concepcion Price Sr.', 8, 295, '5667.64', '1362.97', 'O', 'Saepe praesentium sapiente animi ipsam veniam ut similique ad autem eveniet unde sint officia expedita aut eveniet consequatur laborum aliquid voluptatibus a consequuntur optio ea reiciendis similique consequatur aperiam ipsum reprehenderit asperiores unde sapiente delectus cum perspiciatis qui fuga similique velit aut.', NULL),
(267, 'HFKGKCY7O', 'Mrs. Candida Berge I', 11, 279, '3802.18', '9850.87', 'P', 'Quia aut eligendi optio optio dolor exercitationem facere dolore ea eos optio sed ut excepturi praesentium cumque totam fugit aut voluptatem reiciendis neque porro magni qui eligendi cum veniam placeat non voluptatem tenetur est.', NULL),
(268, 'NZJJENIU', 'Adella Kassulke', 49, 610, '2422.87', '6783.30', 'O', 'Voluptatibus est fugiat aut sunt consectetur magnam sed nisi nihil quia voluptatem accusamus ut assumenda omnis at fugiat ab vero corporis temporibus voluptatem harum consequatur sequi.', NULL),
(269, 'YMWTPYTTT', 'Janick Moore III', 38, 667, '5348.07', '7183.02', 'O', 'Eum consequatur nulla asperiores et itaque sapiente accusamus quia et suscipit consequatur quaerat ad dignissimos aspernatur quidem aut sunt laboriosam velit nobis sit qui incidunt enim debitis hic eveniet possimus quisquam hic omnis unde consequatur error.', NULL),
(270, 'IZJLZHIM', 'Vito Beier', 81, 291, '8034.93', '2604.94', 'O', 'Vel deleniti voluptatem numquam maiores saepe sapiente sit fugit officiis sit ea amet voluptatem quia sed ut voluptates iure voluptas est culpa sit beatae dolore quod in in velit qui dolor rem est corrupti enim.', NULL),
(271, 'CLYODXN2', 'Francisca Abbott DVM', 10, 201, '5212.38', '9169.96', 'P', 'Ut et deleniti nihil mollitia dolores rerum commodi blanditiis accusamus est ea aut qui debitis culpa ut praesentium officia magni.', NULL),
(272, 'BDABDPFO9', 'Prof. Eudora Kreiger', 57, 419, '9752.66', '8287.22', 'P', 'Facere ut quasi fuga aut laboriosam est alias id eos id similique molestias accusamus consequatur quia ea blanditiis aliquid rerum quas dolores voluptates eos praesentium ad odit eos.', NULL),
(273, 'EFNCCHJB', 'Rhea Lind', 53, 480, '2694.03', '2195.53', 'P', 'Nemo corrupti quia beatae amet sit totam et quos ut distinctio temporibus sunt sint quam dolorem labore molestiae aperiam doloribus voluptatum recusandae libero et ut qui et earum omnis adipisci autem quis quia.', NULL),
(274, 'YHHILKD2', 'Jocelyn Murphy II', 59, 531, '2003.99', '8904.93', 'U', 'Aut fuga odit eos vel sint voluptas aut sunt sequi cumque totam eius voluptatem impedit quia veniam quos doloribus aliquam aut reiciendis dolorum maxime architecto.', NULL),
(275, 'JCVSLIR2', 'Aurelie Gleichner', 2, 606, '8049.81', '4479.69', 'U', 'Sed natus aut optio ad debitis quisquam sed necessitatibus dolorum voluptatum quo voluptatum beatae perspiciatis et enim deleniti a blanditiis veritatis corporis cum ipsum sit odit unde dolore facilis veritatis natus beatae.', NULL),
(276, 'KBELJEDB9', 'Doug Koepp', 25, 221, '1716.11', '3206.11', 'O', 'Ut dolor odit quam quibusdam qui nesciunt quibusdam laboriosam accusantium dignissimos et qui sunt rerum nesciunt consequatur temporibus voluptas cum magni aut error odit eius molestias voluptatem veritatis eos.', NULL),
(277, 'MQWNSEP3', 'Ward Sporer', 33, 279, '6286.21', '9058.87', 'O', 'Praesentium ea placeat quae rerum soluta deserunt eligendi qui sit ut eius adipisci totam velit consequatur pariatur quae eius culpa esse iste facere deserunt enim delectus fuga veritatis minima ipsa consectetur aut qui sed.', NULL),
(278, 'TYVVEJKK', 'Eveline Rice', 16, 612, '7573.34', '8752.21', 'P', 'Quod recusandae voluptatibus excepturi at illum sit accusamus sunt eligendi ipsa doloribus perspiciatis fugiat mollitia nulla fugiat inventore at temporibus molestias consequatur fugit excepturi perferendis.', NULL),
(279, 'BRYZHI5K', 'Carmen Morar', 47, 210, '7301.13', '2510.36', 'O', 'Sit voluptatum magni natus nesciunt repudiandae voluptatum eum qui nulla neque impedit rerum alias occaecati dolorem commodi iure sed dolorum ut.', NULL),
(280, NULL, 'aadfsa', 3, 0, '34.00', NULL, NULL, 'asdfasf', NULL),
(281, NULL, 'tecaldo de funcionario', 3, 3, '120.00', NULL, NULL, 'prueba', NULL),
(282, NULL, 'teclado autonomo', 3, 10, '120.00', NULL, NULL, 'una descripción breve', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `IdCategoria` int(11) NOT NULL,
  `NombreCategoria` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`IdCategoria`, `NombreCategoria`) VALUES
(3, 'Accesorios de materiales textiles 3333'),
(1, 'Aceites vegetales'),
(4, 'Alfombras y tapicería'),
(5, 'Algodón'),
(15, 'Almidón'),
(67, 'Aluminio y sus manufacturas'),
(31, 'Animales vivos'),
(62, 'Aparatos eléctricos'),
(76, 'Art. p/ el transp. o envasado, de plást.'),
(46, 'Artículos para baño de cerámica'),
(16, 'Azúcares'),
(73, 'Balanceado para animales'),
(17, 'Bebidas'),
(6, 'Calzados'),
(24, 'Carbón y leña'),
(32, 'Carne bovina congelada'),
(33, 'Carne bovina fresca o refrigerada'),
(34, 'Carne de ave'),
(35, 'Carnes procesadas'),
(77, 'Caucho en formas primarias'),
(68, 'Chapas, varillas, perfiles etc. de hierro y acero'),
(69, 'Cobre y sus manufacturas'),
(60, 'Cosmético'),
(36, 'Cueros bovinos o equinos'),
(18, 'Demás alimentos preparados'),
(7, 'Demás artículos confeccionados'),
(41, 'Demás cereales'),
(78, 'Demás manufacturas de caucho'),
(47, 'Demás manufacturas de cerámica'),
(79, 'Demás manufacturas de plástico'),
(74, 'Demás pelets y forrajes'),
(51, 'Demás productos manufacturados'),
(83, 'Demás productos químicos'),
(8, 'Demás productos textiles'),
(37, 'Despojos de carne'),
(84, 'Detergentes'),
(19, 'Esteviósido'),
(61, 'Farmacéutico'),
(9, 'Fibras sintéticas, sus hilados y tejidos'),
(56, 'Frutas'),
(2, 'Grasas animales'),
(20, 'Harinas y grañones'),
(70, 'Herramientas y utensilios de metal'),
(57, 'Hierbas medicinales, Stevia y demás hierbas'),
(71, 'Hierro y acero en formas primarias'),
(10, 'Hilados y tejidos de algodón'),
(58, 'Hortalizas'),
(85, 'Insecticidas y demás plaguicidas'),
(63, 'Instrumentos de precisión'),
(52, 'Juegos, juguetes y artículos deportivos'),
(59, 'Jugos de frutas o de hortalizas'),
(21, 'Lácteos'),
(48, 'Ladrillos, tejas y tubs de cerámica'),
(25, 'Madera aserrada'),
(26, 'Madera chapada'),
(27, 'Madera en bruto'),
(28, 'Madera para pisos'),
(42, 'Maíz'),
(72, 'Manufacturas de hierro y acero'),
(65, 'Máquinas industriales y accesorios'),
(64, 'Materiales de transporte terrestre'),
(22, 'Melaza'),
(86, 'Minerales'),
(29, 'Muebles'),
(80, 'Neumáticos'),
(43, 'Oleaginosas distintas a la soja'),
(30, 'Otros productos de madera'),
(23, 'Panadería y Pastelería'),
(53, 'Papeles y cartones'),
(75, 'Pelets y tortas de soja'),
(87, 'Piedras'),
(49, 'Placas y baldosas de cerámica'),
(81, 'Plástico en formas primarias'),
(11, 'Prendas de vestir de punto'),
(12, 'Prendas de vestir, no de punto'),
(38, 'Productos animales no comestibles'),
(39, 'Productos de cuero'),
(88, 'Productos de química anorgánica'),
(89, 'Productos de química orgánica'),
(54, 'Productos para procesamiento de papel'),
(13, 'Ropa de cama, mesa, tocador o cocina, mantas'),
(14, 'Seda'),
(44, 'Soja'),
(66, 'Soportes para la grabación'),
(45, 'Trigo'),
(50, 'Vidrios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`IdCliente`, `ci`, `Nombres`, `Apellidos`, `NroCelular`, `CorreoElectronico`, `FechaNacimiento`, `FechaRegistro`, `NroVisitas`) VALUES
(1, '7496605', 'Micaela', 'Gulgowski', 0, 'amari09@gmail.com', '1972-01-21', '2020-02-19 21:02:39', 6),
(2, '933745', 'Keagan', 'Kertzmann', 0, 'zgutkowski@bednar.com', '1970-06-05', '1970-04-15 18:44:46', 5),
(3, '1325313', 'Brandt', 'Schiller', 0, 'derrick.kunde@hoeger.com', '1976-09-14', '2000-02-02 20:54:09', 6),
(5, '8388451', 'Vincenzo', 'Pfeffer', 0, 'langosh.rudy@hotmail.com', '1977-01-05', '1998-06-12 02:42:32', 2),
(6, '5646908', 'Rodolfo', 'Escuela', 46465464, 'nstark@heaney.com', '1970-11-14', '2020-02-19 21:04:02', 2),
(7, '9649309', 'Laverne', 'Conn', 0, 'pacocha.felicity@hotmail.com', '1976-04-16', '1993-08-27 02:54:57', 9),
(8, '7172587', 'Fausto', 'Bernhard', 0, 'zechariah48@wilderman.biz', '1973-01-31', '2017-11-12 22:14:12', 5),
(9, '2977441', 'Leif', 'Ritchie', 0, 'mary98@padberg.biz', '1970-11-21', '2014-12-17 06:54:19', 4),
(10, '8004710', 'Adan', 'Turner', 0, 'rschuster@gmail.com', '1976-05-30', '1982-08-19 06:16:04', 0),
(11, '3520683', 'Mac', 'Crooks', 0, 'mclaughlin.sabina@bosco.com', '1973-08-13', '1983-04-01 04:22:13', 4),
(12, '1584186', 'Cristina', 'Anderson', 0, 'mariano.wilderman@hotmail.com', '1973-08-14', '1972-12-19 23:50:12', 9),
(13, '4957360', 'Mac', 'Walsh', 0, 'crona.brennan@yahoo.com', '1970-07-31', '1993-06-23 21:10:04', 0),
(14, '5987486', 'Orlo', 'Denesik', 0, 'kuphal.rodolfo@gmail.com', '1971-01-25', '1992-11-10 16:01:05', 1),
(15, '1555121', 'Napoleon', 'Mayert', 0, 'francesco.mayer@gmail.com', '1972-09-07', '1977-01-09 12:13:35', 5),
(16, '629450', 'Werner', 'Greenfelder', 0, 'nienow.elliott@gmail.com', '1972-11-24', '1994-05-10 19:39:22', 7),
(17, '7432522', 'Emmett', 'Ortiz', 0, 'qward@abernathy.net', '1976-07-27', '1980-04-28 08:50:30', 1),
(18, '4096573', 'Gregorio', 'Waters', 0, 'katlyn37@hyatt.com', '1970-07-12', '1986-09-15 16:32:00', 9),
(19, '503473', 'Diego', 'Leffler', 0, 'ftreutel@heidenreich.biz', '1977-04-06', '1993-10-20 10:20:06', 8),
(20, '2018396', 'Cordell', 'Weber', 0, 'charlotte.luettgen@gmail.com', '1973-10-17', '1970-01-27 17:13:13', 9),
(21, '237906', 'Trever', 'Stokes', 0, 'francisca88@gmail.com', '1971-01-01', '1996-03-22 12:11:20', 3),
(22, '1638046', 'Roosevelt', 'Bogisich', 0, 'cassie.reichert@goodwin.biz', '1973-09-10', '1985-06-14 16:13:10', 5),
(23, '4337722', 'Hilario', 'Hyatt', 0, 'kaela47@yahoo.com', '1976-01-05', '1979-06-23 12:28:32', 8),
(24, '3852251', 'Dewitt', 'O\'Kon', 0, 'edgar12@marquardt.com', '1973-08-14', '2011-04-12 03:00:58', 8),
(25, '6780460', 'Eric', 'Hoppe', 0, 'abelardo71@auer.com', '1972-12-04', '2017-01-13 05:27:41', 2),
(26, '3988527', 'Hugh', 'Walter', 0, 'ignatius80@hotmail.com', '1978-04-01', '1974-03-05 06:21:05', 8),
(27, '3545605', 'Haley', 'Zemlak', 0, 'lbartell@treutel.net', '1977-09-08', '2009-12-14 09:42:02', 0),
(28, '9564062', 'Brent', 'Blick', 0, 'akohler@yahoo.com', '1977-02-25', '1978-08-20 11:55:55', 0),
(29, '1544197', 'Ernest', 'Turner', 0, 'demarcus.prosacco@hotmail.com', '1970-10-09', '2008-05-16 23:43:20', 3),
(30, '8445826', 'Arjun', 'Stracke', 0, 'cesar.bednar@dietrich.com', '1971-10-17', '2007-06-14 18:19:02', 6),
(31, '8787282', 'Jocelyn', 'Mitchell', 0, 'thea82@gmail.com', '1972-11-26', '1987-06-12 17:03:32', 0),
(32, '6374534', 'Wyatt', 'Bradtke', 0, 'gordon.stanton@ferry.com', '1978-12-11', '2012-08-20 15:44:25', 3),
(33, '3161645', 'Kristian', 'Hayes', 0, 'cfritsch@yahoo.com', '1971-11-21', '2007-05-09 14:15:18', 6),
(34, '7198882', 'Jamie', 'Farrell', 0, 'fadel.quentin@yahoo.com', '1972-11-07', '1986-03-05 20:36:28', 6),
(35, '2876671', 'Gianni', 'Hegmann', 0, 'lois.schumm@gmail.com', '1971-11-10', '2008-02-23 21:39:06', 4),
(36, '2870283', 'Virgil', 'Huel', 0, 'fadel.alejandrin@rohan.biz', '1973-05-16', '1974-12-12 13:34:26', 6),
(37, '1623922', 'Garrick', 'Hickle', 0, 'domingo.borer@gmail.com', '1971-02-03', '1970-10-24 10:17:33', 7),
(38, '6234929', 'Jaylin', 'Crist', 0, 'hodkiewicz.juston@gmail.com', '1971-05-06', '1975-03-08 18:54:25', 3),
(39, '9647181', 'Desmond', 'Harber', 0, 'hyatt.constantin@yahoo.com', '1974-09-05', '1996-01-26 16:15:18', 6),
(40, '6549697', 'Wilbert', 'Stroman', 0, 'reilly.columbus@schmitt.com', '1977-03-23', '2015-09-18 07:56:46', 1),
(41, '9324545', 'Cristian', 'Little', 0, 'charles03@schoen.com', '1977-02-10', '2011-02-23 08:17:18', 2),
(42, '4282012', 'Torrance', 'Hammes', 0, 'bertram.baumbach@gmail.com', '1979-02-13', '2008-01-03 02:04:34', 1),
(43, '6539307', 'Tremayne', 'Smith', 0, 'jbahringer@waters.com', '1976-04-05', '1970-11-19 06:43:13', 3),
(44, '3727529', 'Judge', 'Haag', 0, 'alycia.kris@sawayn.com', '1970-08-03', '1998-11-21 07:50:02', 4),
(45, '1303368', 'Merlin', 'Feest', 0, 'darby.runolfsdottir@waters.biz', '1974-09-30', '1997-04-15 04:35:22', 4),
(46, '3316401', 'Norris', 'Blick', 0, 'ulittle@leannon.org', '1972-07-19', '2006-08-16 00:50:39', 7),
(47, '6255984', 'Martin', 'Steuber', 0, 'ibailey@jerde.com', '1971-08-05', '1978-09-23 14:53:31', 5),
(48, '1224424', 'Dwight', 'Jakubowski', 0, 'jacobs.jayden@mclaughlin.com', '1975-11-02', '1986-01-03 17:17:13', 1),
(49, '3858361', 'Raoul', 'Dooley', 0, 'savannah.rolfson@yahoo.com', '1975-12-19', '1998-04-04 04:23:42', 5),
(50, '1777973', 'Wilford', 'Okuneva', 0, 'blanche37@hotmail.com', '1977-04-30', '1989-05-21 04:55:45', 2),
(51, '23507', 'Randy', 'Larson', 0, 'gina.ernser@hessel.com', '1976-11-12', '2018-10-07 10:25:47', 8),
(52, '1512459', 'Arch', 'Lehner', 0, 'opal25@schowalter.biz', '1972-12-18', '1979-12-17 07:10:37', 1),
(53, '5495494', 'Dayne', 'Leannon', 0, 'pgrady@hotmail.com', '1977-03-23', '2009-03-05 20:35:05', 5),
(54, '3882582', 'Zander', 'Will', 0, 'logan.runte@jenkins.net', '1971-08-12', '2015-09-14 23:57:13', 4),
(55, '9293221', 'Xzavier', 'Corwin', 0, 'corwin.robbie@lesch.info', '1976-04-14', '1981-02-13 21:39:17', 7),
(56, '5561963', 'Kip', 'Kub', 0, 'wkovacek@gmail.com', '1977-02-03', '2007-05-04 05:51:44', 7),
(57, '6230350', 'Moriah', 'Hilpert', 0, 'oceane43@gmail.com', '1976-11-08', '1982-09-04 00:58:24', 0),
(58, '1302586', 'Marley', 'Brekke', 0, 'douglas.marge@cassin.com', '1978-07-23', '2008-02-19 20:51:34', 8),
(59, '6202195', 'Sanford', 'Hackett', 0, 'dcrona@gmail.com', '1979-09-18', '2004-07-17 04:09:01', 9),
(60, '8162023', 'Adonis', 'Mraz', 0, 'milford80@yahoo.com', '1973-07-08', '1976-05-21 23:09:56', 2),
(61, '7872720', 'Nels', 'Schuppe', 0, 'marcellus.stehr@gmail.com', '1970-05-02', '1990-11-27 03:14:28', 6),
(62, '2324468', 'Roman', 'Kulas', 0, 'frami.garth@yahoo.com', '1971-02-21', '1972-05-16 06:15:55', 5),
(63, '7925034', 'Kelton', 'Rodriguez', 0, 'lennie.harber@kling.com', '1979-05-19', '1977-03-07 23:57:47', 7),
(64, '6877170', 'Dell', 'White', 0, 'olangworth@hotmail.com', '1973-04-15', '2004-08-12 09:48:55', 0),
(65, '2429696', 'Pierce', 'Bosco', 0, 'tina.okeefe@hotmail.com', '1975-02-06', '1992-05-28 11:05:36', 8),
(66, '1345478', 'Vincenzo', 'Thiel', 0, 'bwyman@hotmail.com', '1978-02-28', '2003-09-16 01:54:28', 1),
(67, '4553456', 'Fletcher', 'Kshlerin', 0, 'khand@hotmail.com', '1975-06-16', '1997-11-26 16:08:08', 2),
(68, '7659299', 'Arch', 'Pacocha', 0, 'nbruen@okeefe.info', '1979-08-30', '2015-09-19 05:27:17', 1),
(69, '4083172', 'Ola', 'DuBuque', 0, 'otto.aufderhar@rippin.com', '1978-07-22', '2000-09-14 15:18:49', 0),
(70, '4997169', 'Jules', 'Denesik', 0, 'caleb.block@yahoo.com', '1979-09-07', '1981-03-04 01:37:59', 3),
(71, '7239437', 'Diamond', 'Blanda', 0, 'lorenz38@hotmail.com', '1973-07-01', '1998-10-14 06:03:16', 6),
(72, '8094667', 'Shane', 'Toy', 0, 'conner55@yahoo.com', '1970-11-20', '2011-12-22 11:52:51', 7),
(73, '6424856', 'Randy', 'Funk', 0, 'uokuneva@mclaughlin.info', '1971-02-28', '1977-04-20 17:45:03', 9),
(74, '2618302', 'Edmond', 'Koelpin', 0, 'daron65@lindgren.com', '1976-01-28', '2003-09-07 02:07:08', 6),
(75, '6835203', 'General', 'Cummings', 0, 'hackett.brandt@yahoo.com', '1979-02-07', '2003-05-24 00:56:22', 2),
(76, '6837371', 'Brenden', 'Kozey', 0, 'tremayne51@yahoo.com', '1974-08-23', '1984-08-12 19:17:59', 4),
(77, '5465048', 'Albin', 'Anderson', 0, 'torey.ratke@kunde.com', '1977-03-24', '1982-12-30 16:06:24', 3),
(78, '5573650', 'Grover', 'Rippin', 0, 'jess28@leffler.info', '1976-09-09', '2007-11-22 04:11:32', 2),
(79, '3721010', 'Tomas', 'Fay', 0, 'nadams@gmail.com', '1976-05-22', '2004-11-13 20:19:44', 4),
(80, '7703182', 'Carlos', 'Aufderhar', 0, 'furman.schumm@gmail.com', '1971-08-18', '1973-09-27 03:20:04', 4),
(81, '9712334', 'Doris', 'Wolf', 0, 'cremin.lorenza@ward.net', '1979-01-29', '1987-11-11 06:13:24', 2),
(82, '8543124', 'Brennan', 'Williamson', 0, 'eugenia87@gmail.com', '1973-12-07', '1980-03-02 00:59:15', 4),
(83, '4018009', 'Lonny', 'Nicolas', 0, 'robbie72@hartmann.com', '1973-10-13', '2010-04-20 00:56:06', 6),
(84, '7617839', 'Edward', 'Cummings', 0, 'lind.oswaldo@senger.info', '1976-05-23', '1997-05-30 01:44:12', 9),
(85, '5533571', 'Jameson', 'Ullrich', 0, 'odie17@cruickshank.com', '1978-04-15', '1982-02-11 16:51:29', 6),
(86, '4667347', 'Isom', 'Lebsack', 0, 'angela74@gusikowski.com', '1979-12-08', '1992-12-11 05:34:11', 3),
(87, '3959101', 'Jarrell', 'Heidenreich', 0, 'aurelia16@gmail.com', '1975-07-06', '1977-10-25 11:00:07', 8),
(88, '1588273', 'Tad', 'Renner', 0, 'della.krajcik@hettinger.net', '1976-04-02', '1981-03-11 15:06:08', 2),
(89, '420449', 'Griffin', 'Hettinger', 0, 'lmcglynn@gmail.com', '1972-05-20', '2002-05-12 13:34:56', 1),
(90, '4058508', 'Green', 'Heidenreich', 0, 'kessler.thaddeus@swaniawski.org', '1971-07-28', '1997-05-04 22:47:48', 0),
(91, '4747940', 'Luis', 'Bradtke', 0, 'lindsay32@christiansen.com', '1975-07-09', '2000-05-27 13:01:59', 6),
(92, '9337981', 'Curt', 'Schaden', 0, 'bret.emmerich@wehner.net', '1975-12-19', '1997-10-30 12:52:54', 9),
(93, '9019750', 'Solon', 'Doyle', 0, 'vincent.parisian@gmail.com', '1977-09-09', '1989-11-07 08:10:41', 0),
(94, '8418328', 'Norval', 'Goodwin', 0, 'alex90@yahoo.com', '1974-11-03', '2018-12-17 08:29:25', 3),
(95, '7340968', 'Ryan', 'O\'Connell', 0, 'zmayer@gmail.com', '1979-09-14', '1970-11-01 20:15:42', 7),
(96, '8997519', 'Jarrod', 'Hirthe', 0, 'xoreilly@hayes.com', '1979-12-13', '1999-11-17 23:24:41', 6),
(97, '4283438', 'Ephraim', 'Runolfsdottir', 0, 'jermaine.okon@hotmail.com', '1978-06-14', '1986-11-03 12:52:31', 9),
(98, '3617262', 'Houston', 'Hessel', 0, 'schimmel.madyson@oreilly.info', '1970-07-16', '1974-02-23 07:04:05', 7),
(99, '4736757', 'Estevan', 'Glover', 0, 'konopelski.cheyenne@balistreri.com', '1973-11-17', '1973-02-18 22:28:44', 1),
(100, '7963543', 'Jerrell', 'Gleichner', 0, 'marian93@walker.com', '1972-03-07', '1972-05-31 01:09:01', 5),
(101, '2706308', 'Joesph', 'Connelly', 0, 'mmoen@gmail.com', '1971-07-04', '2019-11-03 13:08:01', 6),
(102, '525014', 'Aiden', 'Watsica', 0, 'aufderhar.filiberto@gmail.com', '1975-04-07', '1979-02-14 08:10:37', 0),
(103, '766566', 'Edmund', 'Prosacco', 0, 'bella97@wyman.com', '1976-09-16', '1992-07-22 01:25:12', 3),
(104, '1147792', 'Claude', 'McDermott', 0, 'cbruen@gmail.com', '1976-07-08', '1997-01-30 07:34:26', 3),
(105, '1519036', 'Raul', 'Stokes', 0, 'stanley40@hotmail.com', '1976-09-03', '1973-03-21 02:39:34', 1),
(106, '1835665', 'Isaias', 'Bosco', 0, 'iveum@hotmail.com', '1974-12-10', '2010-12-02 03:21:10', 2),
(107, '4042897', 'Toni', 'Marvin', 0, 'sheaney@ullrich.com', '1977-01-12', '1984-03-16 18:10:07', 7),
(108, '5436975', 'Saul', 'Johnson', 0, 'corbin17@yahoo.com', '1979-03-24', '2004-01-14 13:32:04', 4),
(109, '5187187', 'Angus', 'Corwin', 0, 'ariel.lakin@yahoo.com', '1971-12-25', '1975-06-21 21:22:04', 3),
(110, '306400', 'Friedrich', 'Medhurst', 0, 'kunde.elda@yahoo.com', '1976-07-04', '2006-01-04 03:12:48', 7),
(111, '2263683', 'Darrel', 'Yundt', 0, 'kian.deckow@stroman.net', '1977-02-28', '1981-08-21 03:06:50', 5),
(112, '3306549', 'Dejuan', 'Kshlerin', 0, 'kessler.maiya@cole.com', '1977-05-17', '1978-09-11 03:59:05', 5),
(113, '1754307', 'Dean', 'Volkman', 0, 'ayden.williamson@tromp.info', '1972-05-08', '2016-06-10 21:04:26', 6),
(114, '7109716', 'Harrison', 'Littel', 0, 'smith.joanny@yahoo.com', '1970-03-15', '1980-05-21 09:07:54', 9),
(115, '9916482', 'Alec', 'Morar', 0, 'harley11@mante.com', '1977-12-01', '1983-10-16 04:16:05', 2),
(116, '1675492', 'Rhiannon', 'Wiegand', 0, 'lela63@yahoo.com', '1974-07-04', '1973-06-02 10:46:42', 9),
(117, '5217091', 'Ralph', 'Doyle', 0, 'ruthie22@marquardt.com', '1974-02-10', '1979-03-31 01:54:47', 6),
(118, '9779121', 'Buford', 'Weimann', 0, 'gaston.ratke@ullrich.com', '1973-11-29', '2013-06-02 16:01:56', 6),
(119, '4358323', 'Hans', 'Kessler', 0, 'conn.adaline@jaskolski.com', '1976-12-01', '1978-10-01 20:15:44', 2),
(120, '5443216', 'Marques', 'Kub', 0, 'vella12@homenick.com', '1978-01-14', '1999-11-15 18:28:13', 7),
(121, '8495562', 'Edgar', 'Terry', 0, 'magdalena.hoeger@waters.com', '1970-10-20', '1988-09-30 00:50:05', 3),
(122, '3768345', 'Everett', 'Olson', 0, 'kertzmann.drew@yahoo.com', '1974-01-20', '1999-07-07 21:23:35', 2),
(123, '1064128', 'Horace', 'Koelpin', 0, 'ryleigh79@lemke.com', '1970-08-01', '2001-10-07 04:08:40', 5),
(124, '8397010', 'Eusebio', 'Hintz', 0, 'kkassulke@hills.com', '1979-07-08', '1976-04-09 05:11:23', 0),
(125, '1162845', 'Abelardo', 'Upton', 0, 'major.friesen@yahoo.com', '1974-09-19', '1983-07-06 14:51:10', 6),
(126, '6334374', 'Demetrius', 'Parker', 0, 'dietrich.lucienne@braun.com', '1976-09-16', '1971-03-15 21:40:08', 2),
(127, '9897437', 'Jesse', 'Grady', 0, 'padberg.martin@buckridge.com', '1974-01-28', '1983-04-21 09:51:35', 0),
(128, '144623', 'Isaiah', 'Pfeffer', 0, 'bhodkiewicz@yahoo.com', '1978-02-19', '1989-04-22 03:54:04', 2),
(129, '8692874', 'Myron', 'Friesen', 0, 'schroeder.frederik@heller.com', '1975-04-15', '1972-04-11 16:02:05', 6),
(130, '7627751', 'Grayson', 'Schneider', 0, 'evie79@veum.info', '1972-12-06', '2014-06-23 12:08:27', 7),
(131, '7284791', 'Trey', 'Pouros', 0, 'dock.wuckert@marks.biz', '1970-10-07', '1995-05-31 01:35:48', 2),
(132, '1540500', 'Hayden', 'Botsford', 0, 'wellington36@hotmail.com', '1973-08-10', '1996-06-15 21:26:32', 7),
(133, '343905', 'Matteo', 'Borer', 0, 'graham.blair@gaylord.net', '1979-11-11', '1990-02-13 18:42:54', 6),
(134, '5627103', 'Cedrick', 'Breitenberg', 0, 'pollich.francesco@gmail.com', '1971-07-12', '2005-04-09 18:11:13', 9),
(135, '5795456', 'Gayle', 'Hansen', 0, 'magali.stoltenberg@farrell.com', '1978-11-27', '2014-01-12 12:53:24', 2),
(136, '2514976', 'Samson', 'Hilpert', 0, 'hilario30@yahoo.com', '1977-01-27', '1972-09-30 17:52:56', 4),
(137, '9332946', 'Xavier', 'Jenkins', 0, 'patsy.skiles@gmail.com', '1971-06-04', '2005-04-17 12:26:16', 7),
(138, '7142693', 'Monroe', 'Hauck', 0, 'josefina12@gmail.com', '1970-07-02', '1983-05-03 03:02:01', 1),
(139, '799456', 'Ted', 'Nolan', 0, 'johann95@gmail.com', '1972-12-27', '2001-01-09 17:45:01', 9),
(140, '4479041', 'Jerrold', 'Zieme', 0, 'dennis74@balistreri.com', '1973-06-30', '1977-08-08 08:00:48', 3),
(141, '3718161', 'Ransom', 'Bernier', 0, 'mrosenbaum@hotmail.com', '1974-05-06', '2016-05-29 18:38:31', 1),
(142, '9179439', 'Ronny', 'Braun', 0, 'stoltenberg.alexandrea@hotmail.com', '1975-06-06', '1978-06-17 12:35:53', 2),
(143, '2953821', 'Donato', 'Satterfield', 0, 'judd.king@yahoo.com', '1970-02-18', '1981-12-27 01:38:09', 9),
(144, '2644884', 'Elijah', 'Hettinger', 0, 'llewellyn.kilback@hotmail.com', '1975-05-11', '1982-03-02 07:41:50', 1),
(145, '2057515', 'Gussie', 'Price', 0, 'dooley.dayton@conn.com', '1975-09-25', '2013-04-24 03:24:36', 4),
(146, '4614510', 'Magnus', 'Greenholt', 0, 'gerlach.nathen@lueilwitz.com', '1970-08-15', '2009-03-15 18:45:18', 9),
(147, '6468501', 'Judson', 'Wuckert', 0, 'hill.april@hotmail.com', '1976-02-17', '1977-02-26 05:09:45', 6),
(148, '4094225', 'Gordon', 'Schoen', 0, 'witting.maximo@torp.net', '1976-02-16', '1999-12-11 02:30:15', 6),
(149, '1433081', 'Alfredo', 'Lebsack', 0, 'cconsidine@hotmail.com', '1972-03-17', '1970-11-19 08:57:21', 7),
(150, '4116832', 'Prince', 'Bogan', 0, 'schamberger.joaquin@olson.com', '1979-10-07', '1983-05-01 00:34:03', 7),
(151, '7781315', 'Saige', 'Gutmann', 0, 'aletha14@gmail.com', '1974-04-13', '2002-05-30 03:57:31', 3),
(152, '2346717', 'Emile', 'Leannon', 0, 'theodora01@gmail.com', '1975-03-10', '1999-07-30 09:31:30', 9),
(153, '7329574', 'Jerel', 'Hettinger', 0, 'amurphy@gmail.com', '1973-01-12', '1983-12-23 02:18:20', 0),
(154, '9137432', 'Lucious', 'Renner', 0, 'serdman@ortiz.org', '1976-02-22', '1994-08-30 07:38:43', 8),
(155, '4161628', 'Jerrod', 'Stark', 0, 'michaela57@gmail.com', '1979-09-13', '1988-05-23 15:50:31', 2),
(156, '2105492', 'Royce', 'Fadel', 0, 'violette53@yahoo.com', '1979-04-22', '1973-11-14 05:21:08', 0),
(157, '9462072', 'Osbaldo', 'Mertz', 0, 'kertzmann.cedrick@yahoo.com', '1977-05-31', '2000-12-17 13:25:51', 5),
(158, '1037410', 'Enid', 'Quigley', 0, 'xrau@yahoo.com', '1975-11-27', '2012-02-01 03:02:57', 1),
(159, '9592350', 'Joshuah', 'Hand', 0, 'constance40@frami.com', '1975-01-04', '2017-09-09 13:34:06', 4),
(160, '7963849', 'Keagan', 'Jast', 0, 'jamir.cronin@hotmail.com', '1977-07-19', '2017-05-04 03:19:28', 2),
(161, '6141393', 'Deondre', 'Hegmann', 0, 'wehner.stacy@hotmail.com', '1978-06-07', '2014-07-05 11:36:43', 2),
(162, '277503', 'Manuela', 'Berge', 0, 'francisco.connelly@yahoo.com', '1978-08-31', '2005-11-10 17:47:42', 7),
(163, '2453096', 'Kaleb', 'Brakus', 0, 'lveum@mcglynn.com', '1974-11-10', '2016-06-05 20:14:18', 8),
(164, '1424019', 'Jaylan', 'Fritsch', 0, 'iklocko@marks.com', '1976-10-15', '1993-06-11 23:51:03', 2),
(165, '2566564', 'Ken', 'Bogisich', 0, 'ihuel@yahoo.com', '1978-09-16', '2004-09-22 17:16:58', 4),
(166, '5678667', 'Davonte', 'Mosciski', 0, 'lila.borer@yahoo.com', '1976-10-09', '2001-06-20 15:02:20', 0),
(167, '5777739', 'Brain', 'Langworth', 0, 'bosco.ardith@hotmail.com', '1977-12-12', '1989-05-31 16:00:34', 9),
(168, '1050952', 'Gilbert', 'Bergstrom', 0, 'collin03@rogahn.com', '1979-11-06', '2012-12-23 04:40:18', 1),
(169, '2571250', 'Hayden', 'Reynolds', 0, 'cristian29@yahoo.com', '1974-05-24', '1996-10-03 10:26:23', 8),
(170, '4698322', 'Fabian', 'Wintheiser', 0, 'pzulauf@veum.com', '1976-10-08', '2015-04-19 22:33:03', 2),
(171, '8402135', 'Hardy', 'Homenick', 0, 'agustina.friesen@grant.net', '1977-08-17', '1973-03-02 09:30:59', 1),
(172, '3718804', 'Alexie', 'Kuphal', 0, 'jameson.schamberger@hotmail.com', '1970-12-04', '1989-06-12 12:36:15', 9),
(173, '5073890', 'Jameson', 'Hettinger', 0, 'price.gay@koch.com', '1974-06-15', '2012-08-10 15:29:03', 8),
(174, '7369980', 'Daron', 'Botsford', 0, 'schamberger.rubie@bode.com', '1975-03-17', '2001-11-29 00:55:34', 9),
(175, '1247130', 'Drake', 'Waelchi', 0, 'mason15@hotmail.com', '1975-10-20', '1978-06-20 15:05:51', 2),
(176, '7249011', 'Helmer', 'Price', 0, 'aosinski@lebsack.com', '1973-07-30', '1981-03-09 03:43:51', 5),
(177, '3816177', 'Ahmad', 'Dickens', 0, 'lowe.kelvin@yahoo.com', '1977-03-07', '2011-01-15 10:35:33', 5),
(178, '5329625', 'Andre', 'Gottlieb', 0, 'wilfred79@abernathy.com', '1975-06-06', '2012-04-28 05:41:03', 6),
(179, '7010647', 'Moses', 'Huel', 0, 'shemar.ledner@hotmail.com', '1976-09-30', '2010-10-30 09:54:48', 4),
(180, '9873530', 'Herminio', 'Cummings', 0, 'spinka.lorena@gottlieb.com', '1974-08-07', '1988-02-08 21:22:24', 2),
(181, '7053071', 'Ezra', 'Kuvalis', 0, 'whitney.kuhic@hotmail.com', '1978-04-13', '1984-02-25 00:12:46', 8),
(182, '6998968', 'Jaleel', 'Morissette', 0, 'henriette56@lemke.biz', '1976-03-21', '2013-05-07 21:59:13', 4),
(183, '9130059', 'Bartholome', 'Olson', 0, 'kristian55@zemlak.com', '1970-06-22', '1973-11-07 18:45:37', 6),
(184, '2101440', 'Mauricio', 'Wilderman', 0, 'lesch.beaulah@schinner.net', '1974-10-08', '1997-08-05 04:16:38', 5),
(185, '7909157', 'Pierce', 'Schaefer', 0, 'nico74@yahoo.com', '1977-10-05', '2010-05-01 04:46:57', 5),
(186, '8499558', 'Deshawn', 'O\'Reilly', 0, 'kutch.rollin@littel.com', '1978-12-09', '1999-06-05 02:27:47', 6),
(187, '6857813', 'Lennie', 'Dooley', 0, 'tstamm@dicki.com', '1976-03-25', '1997-03-10 14:40:53', 7),
(188, '3975617', 'Stanford', 'Jenkins', 0, 'dave.donnelly@gmail.com', '1976-02-26', '1991-06-04 13:27:06', 9),
(189, '6120898', 'Tate', 'Wyman', 0, 'noe06@welch.com', '1976-05-07', '1985-04-09 13:29:44', 3),
(190, '151765', 'Zachery', 'Christiansen', 0, 'ukautzer@mitchell.com', '1979-07-17', '1983-10-06 16:44:43', 5),
(191, '1221705', 'Golden', 'Turcotte', 0, 'maynard.harris@friesen.net', '1976-08-04', '1989-01-29 06:56:57', 0),
(192, '4772644', 'Zachariah', 'Frami', 0, 'runolfsson.albertha@cole.org', '1975-09-25', '2017-01-26 21:25:54', 0),
(193, '4130944', 'Casimer', 'Hintz', 0, 'clyde.buckridge@yahoo.com', '1973-08-14', '1985-10-10 00:52:22', 3),
(194, '47819', 'Cornell', 'Abbott', 0, 'pthompson@schoen.biz', '1974-07-05', '2004-02-01 11:38:23', 0),
(195, '6102726', 'Rashad', 'Considine', 0, 'rodrigo.windler@bechtelar.com', '1977-10-03', '2017-04-11 15:45:39', 6),
(196, '8928953', 'Alfonso', 'Gerlach', 0, 'ykautzer@yahoo.com', '1976-04-17', '2000-07-06 22:03:08', 0),
(197, '9744427', 'Keven', 'Mayert', 0, 'rene84@gmail.com', '1974-01-26', '2011-02-19 16:30:50', 8),
(198, '8838731', 'Caesar', 'Upton', 0, 'douglas.delmer@yahoo.com', '1973-03-08', '1998-02-06 02:41:00', 2),
(199, '4827938', 'Candelario', 'Haag', 0, 'curt69@mitchell.com', '1979-01-12', '1976-06-30 09:24:29', 5),
(200, '7659012', 'Braulio', 'O\'Kon', 0, 'wilma80@pfeffer.com', '1976-07-18', '1986-11-13 00:41:18', 8),
(201, NULL, 'luis', 'Molina', 72854863, 'asdfasf@gmail.com', NULL, '2020-02-19 02:46:07', 0),
(202, NULL, 'luis', 'yampa', 123123, 'asdfasf@gmail.com', '2020-02-10', '2020-02-19 14:45:18', 0),
(203, NULL, 'Rosmeri Lucrecia', 'Lopez Rueda', 73475843, 'rosmerli@gmail.com', '1989-12-18', '2020-02-19 14:46:36', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprasarticulos`
--

CREATE TABLE `comprasarticulos` (
  `IdCompraArticulo` int(11) NOT NULL,
  `IdUsuario` int(11) DEFAULT NULL,
  `FechaHoraRegistro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CodigoEstadoIngreso` char(1) DEFAULT NULL,
  `Observaciones` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `comprasarticulos`
--

INSERT INTO `comprasarticulos` (`IdCompraArticulo`, `IdUsuario`, `FechaHoraRegistro`, `CodigoEstadoIngreso`, `Observaciones`) VALUES
(2, 27, '1996-07-26 15:49:56', 'I', 'Velit voluptatem cumque nemo officiis sed quod reprehenderit est accusantium quasi qui qui optio reprehenderit pariatur sunt ipsa quisquam deserunt qui minima voluptatum iste repellendus ut aut quod fugit.'),
(3, 7, '2000-02-24 03:01:42', 'A', 'Voluptate est dolor enim autem numquam id aut reprehenderit dolorem maxime voluptatem et.'),
(4, 30, '1978-05-19 15:14:23', 'I', 'Quia architecto molestiae aut omnis consequatur ut voluptatem unde quisquam perspiciatis atque atque incidunt consequatur harum blanditiis excepturi.'),
(5, 49, '2016-12-10 22:53:55', 'F', 'Nam aut eum eos est placeat est nulla repellat hic architecto vitae sapiente qui nulla quia quia suscipit qui dolorem nihil ullam neque nam voluptatibus commodi est.'),
(6, 38, '1982-11-11 01:17:31', 'A', 'Ea esse maxime dolor sunt dignissimos at cumque repellat et repellat a quidem doloribus.'),
(7, 42, '2004-01-09 10:00:17', 'F', 'Soluta modi exercitationem sequi explicabo quibusdam velit blanditiis distinctio perspiciatis ipsa eaque molestias repellat aut qui consequatur sit et voluptatem id qui atque.'),
(8, 23, '1992-03-03 13:57:10', 'I', 'Et illum provident magni facere in voluptatum porro vel nemo sit dolorum libero laboriosam dolorem sunt totam sed in quos debitis.'),
(9, 38, '2006-09-18 15:04:27', 'I', 'Aperiam temporibus qui qui aut rerum aut totam quas a laborum incidunt nemo doloremque repellat quas voluptate exercitationem consequatur recusandae et repellat facere.'),
(10, 11, '2005-09-17 16:53:34', 'F', 'Cumque nihil omnis quia totam enim rem excepturi ex reiciendis natus vel quisquam dignissimos aut molestiae repudiandae rerum sunt est vero et.'),
(11, 1, '1991-06-21 03:45:24', 'F', 'Neque cum quia quaerat quam dignissimos rem suscipit at provident consequuntur id repudiandae tempora aut rem aut a numquam ipsum voluptatem doloribus at repellat ut.'),
(12, 4, '2016-02-11 22:14:31', 'F', 'Autem totam harum mollitia ad officiis corrupti provident qui et deserunt fugit et voluptate qui molestias debitis deserunt enim omnis dolor.'),
(13, 19, '1971-12-22 03:15:19', 'F', 'Sit est quis alias nemo ducimus vero velit ratione excepturi aliquam rerum dignissimos sapiente rerum vitae quae blanditiis excepturi quam neque totam non.'),
(14, 22, '2011-05-25 21:44:28', 'F', 'Dignissimos aliquid molestiae nisi assumenda dolore inventore inventore qui accusantium magni occaecati quod est.'),
(15, 7, '2008-10-22 06:38:28', 'A', 'Adipisci est officia impedit illum magnam sit similique aspernatur quam accusantium incidunt ad modi in quasi praesentium minus.'),
(16, 42, '2018-09-30 07:21:10', 'I', 'Dolorem quia sed suscipit ipsam qui quis at officiis doloribus exercitationem mollitia delectus quasi aut commodi minima eum officiis iste assumenda ab aspernatur esse explicabo mollitia.'),
(17, 28, '2013-12-02 19:25:48', 'F', 'Delectus totam repellendus atque voluptatum vero culpa enim tenetur ut sit dolorum fugiat corrupti ratione assumenda totam provident dolor voluptas nesciunt ut modi facilis mollitia nam.'),
(18, 31, '1976-06-07 06:30:23', 'A', 'Perferendis ratione consectetur alias aut consequatur optio ea beatae eaque voluptatem officiis quia eos et maiores in reiciendis sed sit doloribus id accusantium nam quod mollitia laborum.'),
(19, 5, '1981-06-25 19:37:51', 'I', 'Deleniti ipsum voluptatem reiciendis ut alias eum est est sint provident sunt maiores libero omnis ipsam nihil vitae.'),
(20, 37, '2000-03-21 21:04:36', 'F', 'Quisquam et molestiae nesciunt et doloremque et fugit accusantium itaque sit non ducimus quia dolorum.'),
(21, 27, '1982-01-03 02:23:28', 'A', 'Fuga quas dolorem ipsam expedita et sit eligendi qui eos placeat quis et nam voluptas.'),
(22, 49, '1981-01-14 16:01:53', 'A', 'Commodi accusantium hic doloremque sit beatae illo recusandae iusto explicabo rerum omnis sed iste quas sint natus odit asperiores est ut repudiandae laborum doloribus.'),
(23, 33, '1994-07-26 20:35:59', 'A', 'Harum quibusdam sapiente necessitatibus velit corrupti a voluptas id ab laudantium magni qui qui dolore alias qui omnis magnam esse tempore molestias error sunt quis repudiandae.'),
(24, 29, '2003-10-23 17:56:04', 'A', 'Molestias atque voluptatem sed sunt dolore asperiores illum accusantium voluptas nihil delectus eos sapiente voluptatum ut quis nostrum commodi enim est quia nihil.'),
(25, 21, '2006-10-17 19:46:38', 'A', 'Quisquam magni non omnis magnam et quasi aut laudantium repellendus deleniti et est rerum quibusdam molestiae laborum numquam cumque dolorem rem placeat aut aut nesciunt deleniti cupiditate esse eaque.'),
(26, 28, '2002-12-19 22:38:30', 'F', 'Est est soluta sit sed expedita ipsa aperiam architecto excepturi voluptatum ipsam expedita incidunt id blanditiis dolor.'),
(27, 17, '1978-07-21 21:53:08', 'F', 'Et eveniet nihil totam voluptatum veritatis voluptatem itaque ut itaque omnis ea sint inventore.'),
(28, 32, '1978-05-05 12:37:02', 'A', 'Eaque voluptatum illo maxime quidem quaerat reprehenderit quae nihil voluptas in voluptatem fuga.'),
(29, 2, '1985-03-25 02:49:21', 'I', 'Nam modi dignissimos vitae molestiae rerum sit sit ducimus repellendus quis exercitationem et iure rem.'),
(30, 44, '2017-06-19 07:58:30', 'F', 'Quod alias aut non dolores voluptates ex adipisci enim qui aut et quia excepturi quo consequatur aliquam assumenda mollitia provident laborum iusto.'),
(31, 39, '1999-01-16 04:29:52', 'A', 'Velit omnis et est hic earum repellendus voluptatem repudiandae et enim minus sapiente aut.'),
(32, 24, '2001-11-24 11:57:26', 'F', 'Commodi totam enim incidunt vero sit qui et illo sint atque distinctio magnam vero ad temporibus cumque soluta consequatur itaque ratione et placeat beatae nihil enim.'),
(33, 47, '1984-08-05 06:14:31', 'F', 'Ex autem et et optio facere recusandae odit voluptatem nulla in voluptas harum pariatur aut.'),
(34, 18, '2007-09-07 09:25:48', 'F', 'Odit quos ratione veniam eligendi amet maxime inventore eos sit beatae qui ipsam rerum perspiciatis ipsa.'),
(35, 16, '1999-04-30 02:02:12', 'A', 'Pariatur aliquam deleniti temporibus et magni natus occaecati dolore molestias voluptas quibusdam repudiandae.'),
(36, 1, '1987-10-03 15:08:12', 'A', 'Aliquid illo voluptatem distinctio officia neque praesentium consequatur officia temporibus nostrum possimus vel amet sit velit fugiat commodi autem expedita porro quasi consequatur nesciunt et nihil.'),
(37, 5, '2019-03-18 19:28:07', 'A', 'Molestiae tempora ut sapiente nulla facilis at sunt repellendus porro voluptates omnis minima sed laudantium perspiciatis nisi molestias nulla quae et eligendi.'),
(38, 44, '1984-04-07 00:31:06', 'F', 'Facilis mollitia dolorum et accusantium quaerat velit eum illum quisquam ut commodi molestiae.'),
(39, 49, '2001-08-25 23:04:15', 'A', 'Beatae velit facilis qui eligendi reprehenderit illum accusamus vero velit enim perferendis totam ea neque est aut non quidem reprehenderit ipsa inventore quo.'),
(40, 14, '2015-12-21 07:13:19', 'I', 'Voluptatibus eum illo porro quia rerum repellat porro et ratione voluptatem suscipit illo illo autem inventore perferendis illo temporibus esse et voluptates non repellat illum incidunt.'),
(41, 26, '1989-10-05 14:48:55', 'I', 'Eligendi qui unde aliquid et ex velit possimus natus et tenetur explicabo architecto ex ea rem aut porro asperiores consectetur quia ipsa qui ad sunt perferendis cumque nulla.'),
(42, 32, '1994-10-13 00:30:38', 'I', 'Delectus ut velit aut et autem id id voluptatibus unde ab nulla sint tempore.'),
(43, 27, '2015-09-11 01:00:12', 'A', 'Blanditiis voluptate maxime sed minus voluptatem aut enim inventore et et ea amet doloremque.'),
(44, 32, '1979-10-16 19:55:33', 'A', 'Dicta ut molestiae magni voluptate facilis ut delectus quia facere laboriosam rerum non voluptates nemo aut voluptate beatae.'),
(45, 50, '1980-10-28 21:16:58', 'F', 'Tenetur aut cum voluptatem commodi ut beatae rerum quod qui omnis voluptatem animi ea eos possimus repellat est ut nisi vero ea et libero voluptas molestias natus aliquam quae.'),
(46, 21, '1994-02-24 13:08:44', 'A', 'Eius voluptatibus cupiditate quam suscipit vel culpa dolores et dolor veritatis qui quasi est placeat adipisci est.'),
(47, 43, '1970-05-09 03:53:48', 'F', 'Et et dolorum doloribus ut quia eos alias consequatur nesciunt tenetur perspiciatis qui corporis temporibus odit ea et aperiam voluptatem nulla consectetur.'),
(48, 29, '2007-05-13 18:55:24', 'A', 'Sed et explicabo nesciunt iste nihil dolorum minus culpa saepe eos praesentium natus doloremque fugiat consequatur ab necessitatibus molestiae iusto cum eaque maiores et nam praesentium.'),
(49, 29, '2012-04-25 13:31:01', 'F', 'Dolore rerum consequatur officia earum sapiente quia explicabo eos nesciunt nisi praesentium ut sint voluptatem et laudantium eos ea eos sit veniam dolor voluptatum quam cupiditate et perspiciatis.'),
(50, 7, '1993-08-27 16:30:52', 'F', 'Debitis provident libero impedit ipsum non sunt magni voluptatem ut et modi velit rem quidem labore assumenda quae sit commodi sunt nemo cupiditate et modi.'),
(51, 45, '1984-09-16 20:05:43', 'F', 'Ullam voluptatum laboriosam fuga temporibus dolor ut necessitatibus consequatur qui molestiae aut cumque nulla illo praesentium dignissimos sapiente magnam sunt sit rerum et quis eos voluptas sit quia.'),
(52, NULL, '2020-02-13 14:42:04', NULL, NULL),
(53, NULL, '2020-02-13 14:43:27', NULL, NULL),
(54, NULL, '2020-02-13 14:43:41', NULL, NULL),
(55, NULL, '2020-02-13 14:44:06', NULL, NULL),
(56, NULL, '2020-02-13 14:49:17', NULL, NULL),
(57, NULL, '2020-02-13 14:49:39', NULL, NULL),
(58, NULL, '2020-02-13 14:49:46', NULL, NULL),
(59, NULL, '2020-02-13 14:49:54', NULL, NULL),
(60, NULL, '2020-02-13 14:53:22', NULL, NULL),
(61, NULL, '2020-02-13 14:55:34', NULL, NULL),
(62, NULL, '2020-02-13 15:00:46', NULL, NULL),
(63, NULL, '2020-02-13 15:01:08', NULL, NULL),
(64, NULL, '2020-02-13 15:07:01', NULL, NULL),
(65, NULL, '2020-02-13 15:08:09', NULL, NULL),
(66, NULL, '2020-02-13 15:42:30', NULL, NULL),
(67, NULL, '2020-02-13 16:32:46', NULL, NULL),
(68, NULL, '2020-02-13 16:33:58', NULL, NULL),
(69, NULL, '2020-02-13 16:34:19', NULL, NULL),
(70, NULL, '2020-02-13 16:38:00', NULL, NULL),
(71, 1, '2020-02-13 16:38:00', NULL, NULL),
(72, NULL, '2020-02-13 16:39:19', NULL, NULL),
(73, 1, '2020-02-13 16:39:20', NULL, NULL),
(74, NULL, '2020-02-13 16:40:46', NULL, NULL),
(75, 1, '2020-02-13 16:40:46', NULL, NULL),
(76, NULL, '2020-02-13 16:41:46', NULL, NULL),
(77, 1, '2020-02-13 16:41:46', NULL, NULL),
(78, NULL, '2020-02-13 16:43:14', NULL, NULL),
(79, 1, '2020-02-13 16:43:14', NULL, NULL),
(80, NULL, '2020-02-13 16:44:01', NULL, NULL),
(81, 1, '2020-02-13 16:44:01', NULL, NULL),
(82, NULL, '2020-02-13 16:45:41', NULL, NULL),
(83, 1, '2020-02-13 16:45:41', NULL, NULL),
(84, NULL, '2020-02-13 16:46:01', NULL, NULL),
(85, 1, '2020-02-13 16:46:01', NULL, NULL),
(86, NULL, '2020-02-13 16:46:11', NULL, NULL),
(87, 1, '2020-02-13 16:46:11', NULL, NULL),
(88, NULL, '2020-02-13 16:46:26', NULL, NULL),
(89, 1, '2020-02-13 16:46:26', NULL, NULL),
(90, NULL, '2020-02-13 16:46:47', NULL, NULL),
(91, 1, '2020-02-13 16:46:47', NULL, NULL),
(92, NULL, '2020-02-13 16:47:12', NULL, NULL),
(93, 1, '2020-02-13 16:47:12', NULL, NULL),
(94, NULL, '2020-02-13 16:47:19', NULL, NULL),
(95, 1, '2020-02-13 16:47:19', NULL, NULL),
(96, NULL, '2020-02-13 16:47:25', NULL, NULL),
(97, 1, '2020-02-13 16:47:26', NULL, NULL),
(98, NULL, '2020-02-13 16:47:32', NULL, NULL),
(99, 1, '2020-02-13 16:47:32', NULL, NULL),
(100, NULL, '2020-02-13 16:49:46', NULL, NULL),
(101, 1, '2020-02-13 20:49:46', 'I', 'Nimguna Observacion'),
(102, NULL, '2020-02-13 16:50:41', NULL, NULL),
(103, 1, '2020-02-13 20:50:41', 'I', 'Nimguna Observacion'),
(104, 1, '2020-02-13 20:54:45', 'I', 'Nimguna Observacion'),
(105, 1, '2020-02-13 21:01:23', 'I', 'Nimguna Observacion'),
(106, 1, '2020-02-13 21:01:33', 'I', 'Nimguna Observacion'),
(107, NULL, '2020-02-13 17:03:00', NULL, NULL),
(108, 1, '2020-02-14 01:01:24', 'I', 'Nimguna Observacion'),
(109, 1, '2020-02-14 01:25:56', 'I', 'Nimguna Observacion'),
(110, 1, '2020-02-14 01:29:42', 'I', 'Nimguna Observacion'),
(111, 1, '2020-02-14 01:32:10', 'I', 'Nimguna Observacion'),
(112, 1, '2020-02-14 01:33:46', 'I', 'ahora esta funcionando'),
(113, 1, '2020-02-14 01:35:08', 'I', 'ahora esta funcionando'),
(114, 1, '2020-02-17 05:07:39', 'I', 'aaaaaaaaaa'),
(115, 1, '2020-02-17 05:21:36', 'I', 'recontraeditado 10'),
(116, 1, '2020-02-17 15:11:17', 'I', 'teclado'),
(117, 1, '2020-02-17 21:07:31', 'I', 'primer movimiento de compra con triger'),
(118, 1, '2020-02-27 10:14:21', 'I', NULL),
(119, 1, '2020-02-27 20:21:51', 'I', NULL),
(120, 1, '2020-02-27 20:35:44', 'I', NULL),
(121, 1, '2020-02-28 01:12:50', 'I', NULL),
(122, 1, '2020-02-28 01:30:55', 'I', NULL),
(123, 1, '2020-02-28 01:32:43', 'I', NULL),
(124, 1, '2020-02-28 01:47:10', 'I', NULL),
(125, 1, '2020-02-28 01:47:37', 'I', NULL),
(126, 1, '2020-02-28 01:53:37', 'I', NULL),
(127, 1, '2020-02-28 01:54:36', 'I', NULL),
(128, 1, '2020-02-28 01:56:40', 'I', NULL),
(129, 1, '2020-02-28 02:08:06', 'I', NULL),
(130, 1, '2020-02-28 02:08:23', 'I', NULL),
(131, 1, '2020-02-28 02:11:07', 'I', NULL),
(132, 1, '2020-02-28 02:15:29', 'I', NULL),
(133, 1, '2020-02-28 02:53:42', 'I', NULL),
(134, 1, '2020-02-28 02:57:42', 'I', NULL),
(135, 1, '2020-02-28 02:59:45', 'I', NULL),
(136, 1, '2020-02-28 03:00:00', 'I', NULL),
(137, 1, '2020-02-28 03:21:54', 'I', NULL),
(138, 1, '2020-02-28 03:24:53', 'I', NULL),
(139, 1, '2020-02-28 03:26:41', 'I', NULL),
(140, 1, '2020-02-28 15:11:28', 'I', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprasarticulosdetalle`
--

CREATE TABLE `comprasarticulosdetalle` (
  `IdCompraArticulo` int(11) NOT NULL,
  `IdArticulo` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `comprasarticulosdetalle`
--

INSERT INTO `comprasarticulosdetalle` (`IdCompraArticulo`, `IdArticulo`, `Cantidad`, `Precio`) VALUES
(2, 14, 866, '3394.34'),
(2, 56, 672, '5940.82'),
(2, 122, 754, '4654.51'),
(2, 220, 879, '2638.07'),
(3, 25, 762, '3541.25'),
(3, 213, 350, '2158.28'),
(4, 102, 977, '3929.69'),
(5, 147, 115, '1172.27'),
(6, 142, 273, '4739.55'),
(6, 274, 100, '9636.64'),
(7, 25, 479, '9626.69'),
(7, 152, 261, '6662.77'),
(7, 263, 706, '4163.36'),
(8, 118, 622, '1146.51'),
(8, 243, 578, '3289.81'),
(9, 205, 59, '119.96'),
(10, 34, 627, '902.16'),
(10, 183, 755, '9439.64'),
(11, 67, 799, '6558.91'),
(13, 48, 104, '1037.30'),
(13, 122, 397, '7915.70'),
(15, 31, 947, '7655.47'),
(16, 205, 672, '4055.55'),
(16, 241, 689, '3993.89'),
(17, 73, 217, '6998.02'),
(18, 99, 110, '7410.25'),
(18, 159, 100, '9996.86'),
(19, 62, 26, '91.42'),
(20, 160, 90, '7567.00'),
(20, 193, 507, '9984.71'),
(20, 196, 274, '4725.11'),
(20, 234, 460, '7517.18'),
(21, 82, 987, '5997.23'),
(21, 89, 143, '619.52'),
(21, 108, 877, '7469.45'),
(22, 118, 993, '4387.95'),
(22, 203, 699, '1895.72'),
(23, 74, 572, '7263.13'),
(23, 229, 337, '8546.08'),
(23, 232, 388, '4541.25'),
(24, 26, 614, '8137.10'),
(24, 158, 217, '9624.81'),
(25, 141, 348, '794.82'),
(26, 15, 489, '8479.85'),
(26, 33, 57, '7535.26'),
(26, 79, 784, '465.83'),
(26, 179, 634, '6866.09'),
(27, 138, 822, '6195.24'),
(27, 162, 41, '9204.29'),
(27, 164, 99, '287.09'),
(28, 155, 706, '8852.88'),
(28, 203, 575, '858.95'),
(29, 49, 194, '3576.05'),
(29, 224, 403, '5246.03'),
(31, 46, 825, '4680.75'),
(31, 121, 668, '6451.33'),
(31, 128, 595, '6258.92'),
(31, 193, 49, '7459.58'),
(32, 6, 749, '9408.33'),
(32, 28, 391, '91.31'),
(32, 44, 103, '2397.32'),
(33, 19, 619, '4714.05'),
(33, 118, 540, '1229.66'),
(33, 169, 520, '2804.17'),
(34, 4, 209, '753.01'),
(34, 66, 822, '7807.70'),
(34, 101, 556, '8039.89'),
(34, 196, 697, '7654.61'),
(34, 269, 435, '3943.10'),
(35, 218, 29, '8884.08'),
(36, 208, 517, '7782.74'),
(36, 255, 380, '70.49'),
(36, 264, 126, '7559.88'),
(37, 83, 724, '7193.71'),
(37, 176, 244, '25.05'),
(38, 241, 50, '3503.07'),
(39, 31, 793, '8056.71'),
(40, 20, 243, '8286.31'),
(40, 101, 603, '3655.53'),
(41, 23, 362, '8219.94'),
(42, 126, 978, '1860.60'),
(43, 16, 790, '3350.95'),
(43, 94, 678, '6656.39'),
(44, 33, 619, '9725.04'),
(46, 2, 433, '2917.91'),
(47, 118, 737, '309.19'),
(47, 236, 36, '3353.38'),
(48, 3, 467, '5993.34'),
(48, 90, 593, '5094.37'),
(48, 102, 83, '7224.11'),
(48, 174, 872, '1804.61'),
(49, 18, 879, '1412.71'),
(49, 46, 427, '1947.86'),
(49, 83, 980, '1713.66'),
(49, 158, 328, '5162.04'),
(49, 225, 990, '1403.11'),
(50, 184, 270, '1956.80'),
(51, 132, 70, '2686.65'),
(52, 222, 820, '9193.01'),
(52, 253, 206, '953.59'),
(52, 273, 96, '6025.29'),
(53, 36, 697, '3681.23'),
(53, 37, 217, '2106.45'),
(53, 190, 232, '9634.29'),
(54, 148, 491, '1037.04'),
(54, 216, 203, '851.81'),
(55, 37, 683, '7875.63'),
(55, 146, 425, '3476.96'),
(55, 267, 99, '3534.60'),
(56, 84, 563, '4025.85'),
(56, 88, 334, '5888.80'),
(56, 167, 332, '1937.37'),
(56, 249, 957, '8090.09'),
(57, 98, 925, '1987.74'),
(57, 205, 882, '2800.69'),
(57, 207, 930, '3135.15'),
(59, 14, 377, '9773.24'),
(59, 220, 402, '3594.56'),
(60, 138, 189, '1569.24'),
(60, 181, 807, '7841.59'),
(62, 5, 696, '2344.36'),
(62, 237, 810, '3683.45'),
(63, 96, 520, '6209.78'),
(63, 154, 275, '3782.93'),
(63, 279, 632, '4036.90'),
(64, 66, 974, '4624.62'),
(64, 114, 409, '303.75'),
(64, 157, 847, '8983.89'),
(64, 208, 49, '2146.37'),
(64, 242, 876, '8888.63'),
(64, 247, 585, '4492.40'),
(65, 139, 704, '596.18'),
(65, 176, 119, '3303.23'),
(65, 253, 797, '2539.43'),
(66, 7, 146, '3945.12'),
(66, 92, 513, '2037.79'),
(66, 188, 82, '1176.61'),
(66, 196, 50, '4872.48'),
(66, 242, 474, '5427.89'),
(66, 261, 572, '4722.59'),
(73, 4, 1, '16.00'),
(73, 6, 1, '86.00'),
(73, 12, 1, '11.00'),
(75, 4, 1, '16.00'),
(75, 6, 1, '86.00'),
(75, 7, 1, '11.00'),
(77, 4, 1, '16.00'),
(77, 7, 1, '11.00'),
(77, 27, 1, '37.00'),
(79, 4, 1, '16.00'),
(79, 7, 1, '11.00'),
(81, 4, 1, '16.00'),
(81, 7, 1, '11.00'),
(81, 13, 1, '81.00'),
(83, 4, 1, '16.00'),
(85, 4, 1, '16.00'),
(87, 4, 1, '16.00'),
(89, 4, 1, '16.00'),
(91, 6, 10, '86.00'),
(93, 4, 1, '16.00'),
(95, 4, 1, '16.00'),
(97, 4, 1, '16.00'),
(99, 4, 1, '16.00'),
(103, 4, 1, '16.00'),
(103, 7, 1, '11.00'),
(104, 1, 1, '98.00'),
(104, 34, 1, '74.00'),
(105, 1, 1, '98.00'),
(105, 34, 1, '74.00'),
(106, 4, 1, '16.00'),
(106, 6, 1, '86.00'),
(108, 5, 5, '120.00'),
(109, 6, 1, '86.00'),
(109, 13, 1, '81.00'),
(110, 6, 1, '86.00'),
(110, 12, 1, '11.00'),
(110, 27, 1, '37.00'),
(111, 4, 1, '16.00'),
(111, 19, 1, '74.00'),
(111, 22, 1, '43.00'),
(113, 4, 1, '16.00'),
(113, 13, 1, '81.00'),
(114, 114, 10, '81.00'),
(115, 7, 10, '11.00'),
(115, 19, 10, '74.00'),
(116, 4, 1, '18.00'),
(116, 7, 1, '11.00'),
(117, 281, 3, '120.00'),
(117, 282, 10, '100.00'),
(118, 4, 1, '16.00'),
(118, 11, 1, '58.00'),
(121, 4, 4, '18.00'),
(123, 1, 1, '98.00'),
(123, 4, 1, '16.00'),
(139, 4, 1, '16.00'),
(140, 1, 1, '98.00');

--
-- Disparadores `comprasarticulosdetalle`
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
-- Estructura de tabla para la tabla `membresia`
--

CREATE TABLE `membresia` (
  `IdMembresia` int(11) NOT NULL,
  `IdCliente` int(11) DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `CodigoEstado` char(1) DEFAULT NULL,
  `CostoGeneral` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociondetalleclientes`
--

CREATE TABLE `promociondetalleclientes` (
  `IdPromocion` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `promociones`
--

INSERT INTO `promociones` (`IdPromocion`, `NombrePromocion`, `FechaInicio`, `FechaFin`, `CodigoEstado`, `TipoPromocion`, `PorcentajeDescuento`, `NroPersonas`, `Descripcion`) VALUES
(1, 'Dameon Osinski', '1989-04-28', '2018-10-20', 'V', 'N', '2.00', 15, 'Est ut non similique eaque a sint eum tenetur dicta nobis veritatis exercitationem sint modi dolor dolorum doloremque aliquid qui numquam blanditiis aut laborum omnis et cupiditate repellat ratione fugiat et dolore sequi est quisquam cupiditate minus earum quasi totam tenetur.'),
(2, 'Annetta Beahan', '2012-07-18', '2015-10-12', 'C', 'P', '84.00', 10, 'Id sit et velit recusandae harum et molestiae laborum odit dolorem suscipit minus ut facere repudiandae quam tempore minus quis asperiores ratione aut consequuntur sunt numquam ut ab ad illo animi eaque officiis nihil nobis.'),
(3, 'Weldon Streich', '2002-03-08', '1999-10-17', 'C', 'N', '45.00', 1, 'Aliquid fuga a quae esse aut architecto laudantium distinctio sequi repellendus voluptates ea similique a omnis et id cum et dolor sunt et id aut.'),
(4, 'Mrs. Alessandra Abbott', '1976-08-16', '1989-01-22', 'C', 'N', '97.00', 12, 'Quasi fuga atque fugiat accusamus rerum voluptate cumque sit laborum et beatae numquam hic suscipit enim eaque et architecto vero ut et eaque aut recusandae odio blanditiis non amet qui consequatur.'),
(5, 'Roger Kassulke', '1983-04-02', '1972-12-25', 'C', 'D', '7.00', 1, 'Quis dolore accusamus non nihil dolor accusamus nihil ut quo eos quia et aut ut iure perferendis voluptatem nulla et et iste molestiae occaecati ullam repellat provident.'),
(6, 'Elta Denesik II', '2009-12-14', '1994-06-09', 'V', 'P', '10.00', 13, 'Omnis culpa id ullam nihil sint aut sint saepe et iste perspiciatis optio magnam itaque dolorem pariatur ut sapiente voluptatem placeat tempore.'),
(7, 'Shaylee Fay', '2003-04-05', '1986-06-16', 'V', 'C', '75.00', 8, 'Ut est ut officiis in aut similique fuga velit eligendi recusandae dignissimos qui quos dolorem sunt ad sapiente nesciunt sequi illum eos consequatur magni assumenda nihil quibusdam in sunt.'),
(8, 'Zoe Reynolds', '2008-08-14', '2012-06-10', 'C', 'C', '81.00', 9, 'Fuga quas adipisci ut occaecati velit natus et et omnis quia velit harum quia beatae possimus nihil doloribus optio earum voluptatem sequi id sunt quia autem est autem unde voluptas.'),
(9, 'Asia Nienow', '1975-05-14', '2007-08-15', 'V', 'D', '87.00', 18, 'Tenetur tempora omnis optio consequatur a nemo quo illum nam pariatur ea eum ea eum vitae quae sequi similique culpa voluptatem et quis.'),
(10, 'Prof. Delores Wunsch', '1982-02-18', '1983-12-26', 'V', 'N', '15.00', 2, 'Et laudantium quas voluptatem culpa ut aut libero dicta animi est incidunt autem aut quaerat ea vero eveniet sunt aliquam id tenetur veniam iusto nemo.'),
(11, 'Margie Daniel II', '2003-04-02', '2008-09-01', 'V', 'D', '2.00', 9, 'Sed sed aut quos nisi dolorem ex consectetur dignissimos error nemo omnis voluptatem et cumque modi modi non exercitationem inventore.'),
(12, 'Earnest Goyette IV', '2005-01-30', '2011-02-28', 'V', 'C', '33.00', 16, 'Atque aut quibusdam et tenetur voluptatem numquam exercitationem aut aut nostrum illum ratione sed laboriosam qui eum officia voluptas voluptatibus commodi nulla dolorum impedit.'),
(13, 'Mr. Emory Weimann V', '2018-03-12', '2016-02-06', 'C', 'P', '71.00', 7, 'Possimus inventore aut sit qui vel sit assumenda ipsa quia non odit fugit laudantium ut dolorem maxime recusandae magni maiores illo aspernatur magnam labore ut aut expedita officiis.'),
(14, 'Alberta Gerhold Jr.', '2008-09-22', '2007-06-20', 'C', 'C', '61.00', 11, 'Sed officiis autem dolores velit qui et delectus modi autem corporis ut distinctio aut perspiciatis enim dolor debitis eaque corrupti aut placeat est in itaque.'),
(15, 'Hermann Nienow', '2009-04-22', '1996-04-27', 'C', 'P', '51.00', 11, 'Et voluptate asperiores autem facilis consequatur voluptate facilis aut dolore voluptatum officiis eum et ut explicabo quidem exercitationem facere veniam distinctio libero veniam exercitationem eius.'),
(16, 'Kayli Ernser', '2011-12-16', '1993-06-05', 'C', 'P', '6.00', 19, 'Ea pariatur laboriosam qui officia blanditiis beatae unde vero est itaque voluptatem optio cumque sit sapiente doloribus aliquid facilis voluptas sit.'),
(17, 'Dr. Bryana Hyatt', '2019-04-22', '2011-04-27', 'C', 'P', '2.00', 3, 'Voluptas minus mollitia accusantium facere enim quo sequi error cumque quibusdam optio quis sed recusandae aut consequatur atque enim ut qui excepturi vitae iusto ut doloremque veniam sed aut consequatur deserunt est id tenetur distinctio eaque cumque rerum soluta placeat autem.'),
(18, 'Lorena Gibson DVM', '2005-11-23', '1981-03-26', 'V', 'D', '59.00', 20, 'Mollitia dolorem harum voluptatem tempora aliquid excepturi non vero totam cumque debitis consequatur in quibusdam explicabo sit minus iure sed sed iure amet incidunt sed corrupti magni beatae repudiandae architecto nostrum delectus nulla tenetur.'),
(19, 'Andrew Bruen', '2016-06-28', '2010-07-04', 'C', 'C', '65.00', 1, 'Accusantium fuga et exercitationem dicta accusamus nostrum magnam optio sed illum sunt est occaecati dignissimos quo exercitationem saepe et officia est maiores delectus distinctio ut in blanditiis praesentium et impedit ipsa molestias et consequatur est veritatis necessitatibus quod harum soluta dolores aut.'),
(20, 'Rocky Kessler', '1971-12-02', '2001-02-04', 'C', 'P', '5.00', 14, 'Qui non fuga unde ea est rem eos explicabo sed dolor quo ut qui et sunt similique voluptatibus eum nihil eveniet et sint eos aspernatur assumenda in id omnis asperiores molestiae voluptatem asperiores non nulla natus facere magni et unde dolorem.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `IdServicio` int(11) NOT NULL,
  `NombreServicio` varchar(200) DEFAULT NULL,
  `Descripcion` varchar(500) DEFAULT NULL,
  `CostoServicio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`IdServicio`, `NombreServicio`, `Descripcion`, `CostoServicio`) VALUES
(1, 'Lester', 'Et fuga minima beatae rem est quisquam quae eaque et suscipit id et laborum ab ratione amet nobis deserunt sint quia sed aspernatur.', '7636.40'),
(2, 'Hayley', 'Neque veritatis consequatur velit architecto dolore consectetur et consectetur ut quaerat officiis aliquam ut commodi tempora harum saepe dolor magni deserunt debitis at assumenda voluptatem tempora qui aut ea tempora consequatur.', '3904.93'),
(3, 'Stanley', 'Autem dignissimos voluptatem voluptas eum reiciendis vitae nostrum sint accusamus qui quia modi porro hic quo inventore autem suscipit vitae ut.', '6861.63'),
(4, 'Edison', 'Alias quis doloremque sed non labore omnis sunt deleniti omnis laudantium et consequuntur pariatur fuga alias consectetur asperiores fugit cumque repellat distinctio velit nostrum placeat repellendus tenetur vero inventore ut quia necessitatibus libero ut ducimus optio a est et iste cumque ad maxime.', '5799.28'),
(5, 'Marcos', 'Nesciunt quia enim sequi excepturi maxime pariatur accusantium totam exercitationem itaque sunt placeat officiis placeat et eaque atque rerum aspernatur facilis et officiis perferendis eum praesentium.', '7501.98'),
(6, 'Deshaun', 'Placeat maxime quidem corrupti et consequatur dignissimos consequuntur molestias incidunt vitae eius molestiae qui ut laboriosam id consequatur ea exercitationem similique distinctio officia qui quam cumque qui rerum aut soluta sequi sunt sed ut eius magni voluptatum qui id quibusdam.', '7793.69'),
(7, 'Ephraim', 'In rem ex eligendi id assumenda ipsa reprehenderit et voluptates dolore ipsum eaque hic est sunt illo consequatur ut.', '325.13'),
(8, 'Gianni', 'Porro ab sequi et voluptas dolorem consectetur maxime in iusto cupiditate praesentium occaecati laboriosam sit sint itaque deserunt non.', '2307.04'),
(9, 'Jarod', 'Qui ea sequi cumque consequatur eveniet rem praesentium vero sed tenetur esse occaecati dolor hic deleniti natus aperiam nihil deserunt natus nihil voluptatem accusantium debitis illo soluta vero molestiae tempore eveniet non voluptates quas dolores.', '1134.98'),
(10, 'Randall', 'Quam molestiae tempora dolorem accusamus est aliquid voluptatum facere aspernatur hic sed suscipit odit iure in magnam repellat officia dolores facere accusantium maiores eius sit sit qui pariatur expedita culpa minima neque dignissimos natus aut quo.', '2150.04'),
(11, 'Grover', 'Velit eos dolores recusandae sed fugit voluptatem laudantium dolorem ullam possimus ut delectus sed illo incidunt voluptatem et non.', '7818.20'),
(12, 'Dashawn', 'Molestiae aliquid deleniti laborum ut ratione minima officia ex sit fugit id nihil eum quis ipsum harum officia dolorum perspiciatis tenetur ut magnam deleniti quia voluptatem impedit consequatur ducimus placeat distinctio et est impedit amet.', '3271.31'),
(13, 'Hillard', 'Ut sit a et quis ad ratione accusamus veritatis ut voluptas nulla aut rerum voluptas quo culpa qui et eveniet blanditiis neque est harum iste.', '5133.21'),
(14, 'Montana', 'Quod officia tempore consequatur cumque nobis nesciunt harum temporibus labore repellendus eos voluptatum est qui quia nihil aut eligendi facilis quia animi consectetur sed dicta non iste voluptatem ea et blanditiis alias eum odio in tempora nemo dolores et iste omnis est.', '921.16'),
(15, 'Berta', 'Nemo est aut vitae dolores sequi harum fugit aut natus et similique et omnis aut quo omnis consequuntur itaque.', '1361.02'),
(16, 'Wallace', 'Itaque aut aut atque ut voluptatem beatae iure reprehenderit ipsum ea voluptates in fugiat dolor voluptatem illum dolor natus omnis provident id iste ut et id earum nemo ut nihil qui ex velit doloremque velit sunt tenetur consequatur.', '8761.39'),
(17, 'Alfredo', 'Neque beatae laborum est qui ad accusantium quod recusandae sit veniam recusandae fuga accusamus dolorum voluptates ut natus repudiandae iure cumque sed nam est eligendi.', '3080.95'),
(18, 'Guido', 'Est alias libero ipsam quia reiciendis deleniti aut quaerat voluptatibus aliquam minima nulla qui doloremque ut quas voluptate autem laborum sit nihil aut quis aut incidunt repudiandae expedita necessitatibus est temporibus voluptatem sunt quo beatae itaque itaque enim reprehenderit.', '9429.42'),
(19, 'Cletus', 'Aliquam vel perspiciatis veritatis praesentium dolor modi quia corrupti voluptatem dolorum dolor similique sit ea dolore laboriosam quidem officia magnam beatae sed consequatur ratione aut vitae sunt optio reprehenderit id nihil enim voluptate officia neque ab sint eos est dolor.', '311.13'),
(20, 'Arnaldo', 'Et a est quo voluptas asperiores dolores saepe consequuntur rerum quis suscipit exercitationem unde voluptatem quis voluptatem et doloribus at qui asperiores in tempore enim saepe alias rerum consectetur odio recusandae aut sit aut vero odit harum.', '8267.66'),
(21, 'Jeremie', 'Eos quae saepe eaque sed aut nulla et beatae ab doloremque vel et porro error voluptatum maiores aspernatur porro voluptatibus voluptatem officia qui nemo officia aut dolor saepe voluptas fugit dolore dolores tempore ipsa eos omnis iusto cum in accusamus.', '8593.08'),
(22, 'Randal', 'Saepe beatae autem aliquam dolor sit enim quod explicabo omnis qui quis sint ut ea assumenda et harum nemo quasi velit voluptatem voluptas voluptate ut vitae ratione non reprehenderit beatae assumenda quibusdam corporis nostrum molestias accusamus suscipit consequatur aut error a omnis consequatur.', '1540.52'),
(23, 'Joel', 'Quaerat est quo quam accusantium corporis sed cumque hic est ipsa molestias sunt quaerat cum at tempore laudantium perspiciatis soluta doloribus quia debitis quibusdam maiores amet consequuntur ut qui non nulla vitae ut dolorem ut est qui vitae deserunt.', '8368.47'),
(24, 'Stephon', 'Voluptatem placeat quia tenetur molestiae aliquam sunt sed nisi consequuntur impedit ipsum error et nemo odit libero rerum nam corrupti nihil qui sapiente qui distinctio blanditiis impedit rem dignissimos voluptatem.', '7986.80'),
(25, 'Kamron', 'Ut accusamus molestiae laborum voluptatibus quia quae doloribus voluptate quasi nisi et doloribus tenetur non est et unde ut sunt labore eum qui.', '1306.12'),
(26, 'Lloyd', 'Eum neque in aperiam eius beatae dolorem ut perferendis incidunt voluptates error consectetur autem quia totam et unde voluptas at eos.', '4931.79'),
(27, 'Dee', 'Aspernatur quo non quo labore cumque sit non quasi culpa similique aut dicta numquam quisquam possimus et eveniet sit assumenda blanditiis architecto eum sunt suscipit omnis saepe et quas ducimus similique quo aut.', '9776.84'),
(28, 'Frederic', 'Odit molestiae voluptate optio cumque dolor ut iure et iusto animi quasi pariatur repudiandae qui id occaecati consequatur beatae dolore recusandae ut quis officiis nobis modi distinctio voluptatem atque omnis molestias veniam aut temporibus cumque et voluptatibus sapiente atque.', '8468.92'),
(29, 'Tommie', 'Nemo magnam rerum quia ut porro provident architecto quia dolores minus explicabo et qui ea quos non tenetur eos veritatis et ut nihil voluptas ab illum quaerat quam cupiditate.', '1633.03'),
(30, 'Baron', 'Expedita sequi itaque sit aut eaque ipsam totam quam soluta magni cupiditate sunt earum asperiores eos non adipisci enim architecto eius sit.', '207.95'),
(31, 'Clay', 'Illo placeat quod optio libero eum laborum inventore omnis vero dolorum quo neque voluptates consectetur et facilis quia dolore atque accusamus error enim optio aut suscipit ad rerum porro libero veritatis repudiandae minima iste et officiis expedita.', '2704.62'),
(32, 'Stuart', 'Aut id dicta temporibus sunt quos fugiat aspernatur velit explicabo laborum aperiam et eligendi non ullam et id odio hic sit pariatur et nesciunt rerum quis aut voluptatum sed qui commodi et aperiam asperiores cumque cum.', '1552.41'),
(33, 'Tod', 'Culpa rerum repudiandae et sequi molestiae necessitatibus soluta nobis nostrum doloremque est saepe fugit natus quibusdam nemo ut quibusdam dolore sed eum eius voluptas animi veritatis aperiam nihil molestiae molestiae.', '3753.30'),
(34, 'Luther', 'Ipsa quod deleniti maxime laudantium iste ut est et provident et porro alias deserunt minus dolorum quia est ea molestias tempora et illo aut illo eum modi repellat maxime expedita voluptates sunt.', '2820.55'),
(35, 'Webster', 'Non quam qui cum odit id numquam est qui possimus omnis exercitationem est velit corrupti ut sint ut libero neque.', '7915.07'),
(36, 'Rudy', 'Dolor animi et est eum dolorem quis iusto eveniet ipsa asperiores cumque hic omnis illo dolorem asperiores hic beatae ab ullam omnis porro.', '1270.47'),
(37, 'Dylan', 'Suscipit quasi doloribus numquam at saepe delectus dolorem et omnis quia non nostrum voluptas odit praesentium ab qui et repudiandae qui fuga explicabo ex eaque omnis repellendus facilis enim est quidem quibusdam dignissimos sunt.', '4755.52'),
(38, 'Jaleel', 'Architecto eaque similique doloribus ut est non et impedit excepturi quisquam officia est temporibus mollitia et aut porro et reiciendis ratione rem ex accusamus mollitia saepe voluptate libero delectus nemo harum distinctio nihil eos nostrum.', '5376.70'),
(39, 'Jeffery', 'Molestias ea rerum qui a aut voluptas eos voluptatum soluta id ratione aperiam aut rerum eos dolore quis illum consequatur quibusdam qui et blanditiis quas.', '3954.31'),
(40, 'Ervin', 'Vel cum recusandae eos praesentium sequi modi consequatur optio debitis aut quasi minima molestiae nostrum ut aut est possimus dolor deleniti cumque sit delectus culpa repudiandae earum esse ipsam esse molestiae ipsa voluptatum exercitationem quas possimus ad expedita.', '2239.15'),
(41, 'Weston', 'Officia hic est porro nobis nesciunt quas sint nobis autem unde sint nihil earum ea consequatur distinctio architecto impedit nihil delectus quia molestiae modi laborum cumque enim earum commodi incidunt nulla sunt et saepe velit nesciunt excepturi consequatur vel veritatis.', '6382.89'),
(42, 'Brandon', 'Omnis non sunt quibusdam harum inventore dolor assumenda voluptas mollitia voluptatem reiciendis non odio velit odio ut facilis laborum.', '4181.16'),
(43, 'Conner', 'Delectus velit voluptas aut nostrum cum quod voluptate laboriosam ex dolor nisi non voluptas ut est eum cupiditate cumque fugiat ipsam nemo.', '9110.93'),
(44, 'Dave', 'Vero sunt quia rem quasi animi sed ea consequatur cumque doloribus recusandae ut omnis atque commodi praesentium tenetur blanditiis quis voluptas fugiat ea voluptas mollitia autem rem magni eum sed provident earum ut dolores est eos et.', '8599.93'),
(45, 'Leopold', 'Laudantium dolores consequatur culpa libero qui voluptatem ratione ut inventore temporibus ipsum quas suscipit ullam minus aut molestiae est dolorem voluptatem consequatur nesciunt asperiores et in molestias cumque facere molestiae accusantium dignissimos facilis.', '6628.73'),
(46, 'Crawford', 'Non omnis ratione nisi voluptatum aut laborum eveniet maiores perferendis beatae et sunt voluptas qui deserunt magni quia placeat architecto excepturi.', '7034.35'),
(47, 'Sigrid', 'Sit quia et aut cum error aut qui ea a rem voluptatem provident optio velit facere non delectus illo velit quod illum deleniti aut reprehenderit neque rerum voluptas veritatis nam perspiciatis est expedita.', '3679.94'),
(48, 'Walker', 'Aut voluptatem qui odit at dolorum necessitatibus in in nemo ea perferendis ut itaque atque occaecati ducimus soluta dicta laboriosam quaerat unde sunt at officia mollitia veritatis eligendi nihil libero ut nobis aliquid ut ea eligendi.', '8375.99'),
(49, 'Ford', 'Impedit cum saepe hic voluptatibus facilis veniam at qui et in explicabo minima sit est quasi totam aspernatur debitis cum laborum ut placeat et ipsam nulla vero perferendis sit temporibus.', '7861.46'),
(50, 'Adrian', 'Corrupti quia perspiciatis molestiae et suscipit aut cum voluptatem dolor ea culpa nisi illo vel error exercitationem quo iste libero voluptatibus dolorum sed at in tenetur excepturi voluptatibus magnam unde vitae sit distinctio veritatis neque enim quia aspernatur.', '199.54'),
(51, 'Lucious', 'Incidunt suscipit molestiae ad voluptatibus et rerum praesentium sequi quo mollitia et harum dicta tempore architecto molestiae sequi et facere optio velit labore rem quia voluptatum eum est aliquid quasi odio.', '7832.84'),
(52, 'Emile', 'Omnis adipisci consequuntur id nisi qui iusto alias ipsum at omnis sit culpa praesentium excepturi sunt dolor maiores molestias facere aspernatur autem voluptatibus est voluptatem harum iure eius veniam omnis blanditiis quasi et ipsa vel.', '4327.29'),
(53, 'Trent', 'Saepe quis soluta qui dolor optio enim amet in rem minima qui amet sint porro provident alias minus animi maiores nisi eligendi recusandae officiis qui mollitia et nobis dolore ut quia repellat ducimus ut.', '6908.38'),
(54, 'Dino', 'Iure facere tempora fuga doloribus eaque error nihil aut iure quas architecto aperiam deleniti eveniet unde quam architecto laboriosam facilis odio nobis illum nam placeat molestias exercitationem laboriosam veniam suscipit alias quia quam.', '7001.48'),
(55, 'Oscar', 'Id voluptatem reprehenderit magni voluptatem blanditiis aut numquam natus aut autem minus ea consequatur architecto quis ipsa architecto dolorem quo architecto in eius natus tenetur maxime quia dolores doloribus eum mollitia aut reprehenderit.', '248.78'),
(56, 'Ward', 'Voluptatem laborum sit quis consequuntur ea culpa iure mollitia eveniet perspiciatis quibusdam odit magni aut voluptatem doloremque voluptatem et voluptatem tenetur eveniet exercitationem consequuntur quo ex ut corrupti dolor quidem suscipit molestias consequatur fugit et.', '8784.88'),
(57, 'Kian', 'Quisquam ipsam voluptas et voluptatem voluptatum rerum sequi id dolorum dolores distinctio voluptatem cumque sint quia omnis non quia ea nostrum voluptates ducimus molestias omnis vel odit eos rem sit pariatur soluta exercitationem accusamus delectus adipisci neque.', '4872.23'),
(58, 'Dale', 'Et voluptate ab fugiat officia quam sapiente et repellat nihil fugit et eveniet et inventore tempore perferendis ut enim libero odit ut vel assumenda voluptas sapiente architecto eos voluptatem quibusdam suscipit consequuntur.', '3521.69'),
(59, 'Ari', 'Consequatur modi magnam aut ipsum autem atque earum rerum amet aut ratione nisi et accusamus sed consectetur veritatis ea consequatur rerum beatae ut consectetur autem id sapiente cupiditate veniam.', '764.89'),
(60, 'Emerson', 'Rerum modi labore velit asperiores a placeat quod eligendi dolor iste facilis fugiat in deleniti neque aut animi deserunt ex odio quod minus deserunt dolorem rerum aut autem consequatur ut dolores est harum asperiores aut dolorem facilis sit est dolorem.', '7503.64');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`IdUsuario`, `NombreCompleto`, `NombreUsuario`, `Contrasenia`, `FechaRegistro`, `Direccion`, `TipoUsuario`, `CodigoEstado`) VALUES
(1, 'Heloise Leuschke', 'alexandra11', '9R%w#`Hxg', '1998-11-16 05:53:05', '6392 Malinda Rest\nSouth Mozellshire, AR 96486', 'S', 'S'),
(2, 'Lizeth O\'Conner', 'leland.oberbrunner', '<%3h)e[-KrhH[<CbVe\'n', '2003-10-21 04:26:12', '936 Devin Motorway\nNorth Ada, IA 77310-6755', 'B', 'S'),
(3, 'Myrtis Medhurst', 'howe.kyla', '}!&D},y41[V', '1991-04-07 09:39:57', '181 Iliana Pine\nSouth Jamal, FL 74548', 'S', 'V'),
(4, 'Frida Hahn', 'murazik.blaze', ':&@%i(K?U]Ou$t', '2009-03-06 06:16:01', '984 Funk Harbor Suite 748\nSouth Stephonside, ID 64228-0658', 'S', 'B'),
(5, 'Aniya Sipes', 'jarvis.gislason', 'Z?YQh!', '1983-04-12 12:52:07', '298 Predovic Lock Apt. 641\nPort Felix, OH 85392', 'A', 'S'),
(6, 'Raymundo Bogisich', 'rae40', 'bkqDA`c10ZJ^', '1991-07-13 22:45:38', '61496 Walter Point\nSouth Ethylville, AL 37029-2920', 'A', 'S'),
(7, 'Dovie Schroeder DDS', 'herbert.nader', 'edd(0s<&Fxjzs>+)WF', '1993-10-25 07:22:20', '17319 Lorenza Route\nGrantmouth, GA 87591-0893', 'A', 'V'),
(8, 'Ms. Shana Jerde', 'wehner.roma', '/H66EPXdKWFJw}^.', '1990-05-31 11:24:43', '7239 Angelina Expressway Apt. 950\nKutchmouth, AK 65953-8166', 'A', 'B'),
(9, 'Dr. Liam Haag Jr.', 'madison75', 'Z,%k\"[3bJV', '1999-08-08 11:16:25', '44544 Greenholt Points\nEast Margarettemouth, AK 55449-5104', 'S', 'V'),
(10, 'Ms. Jeanie Murazik DDS', 'tate04', '8;jeb5+`V?IM+mON=W1', '1995-12-11 13:35:55', '2032 Pacocha Cove\nMaverickhaven, FL 91460', 'S', 'S'),
(11, 'Myron Cole', 'gina45', 'ZDsB)-bVD5?0#?LfT,|', '1991-09-15 06:26:42', '5026 Homenick Fields Suite 294\nAsiahaven, AR 79219', 'S', 'V'),
(12, 'Dr. Melany Heathcote DVM', 'goldner.timothy', 'j+0*a@]Tf', '1985-08-26 10:27:13', '6878 Lowe Underpass\nBellemouth, FL 89004-8096', 'A', 'B'),
(13, 'Else McClure III', 'zboyle', '-`#qD%QT8b0f%Zd|~Sh', '1977-11-24 10:39:19', '75112 Jaylon Street\nGutkowskiside, OK 60465-4113', 'B', 'B'),
(14, 'Isabelle Lehner', 'vincent54', '<j^H2!s)WV?nlMkI', '1975-10-24 15:41:46', '491 Ashlynn Village\nMartinastad, NE 06058-6536', 'A', 'B'),
(15, 'Mrs. Abigail Goyette', 'donald63', '*nm_u*#n,F\"M9,$3Rg,>', '2014-03-31 23:28:34', '7414 Botsford Lane\nLake Shyann, NC 86181', 'S', 'B'),
(16, 'Rasheed Zulauf', 'chelsea.vandervort', 'kWb[b_|!.[\"j>rfa8g@A', '1985-11-08 13:02:58', '167 Johathan Corners\nReichertview, OH 35591', 'A', 'S'),
(17, 'Rosa Effertz', 'mills.violette', ',MCuF8y6hrw)9ufJH!+1', '1975-04-22 13:48:53', '3885 Piper Dam\nEast Chandlerton, VA 16955', 'B', 'S'),
(18, 'Elody Hermiston', 'anissa.kassulke', '>GYHKffA\")', '1989-09-28 05:29:56', '14024 Zachariah Street Apt. 945\nEast Margarettamouth, SD 33788-9993', 'A', 'V'),
(19, 'Prof. Sage Hahn Sr.', 'johnathon.nader', '.Iq_W>r', '1987-07-29 10:14:49', '32890 Hamill Passage\nNew Dallas, NM 12433', 'S', 'V'),
(20, 'Lexi Welch', 'torp.helena', '1?_*&p`Zrvy;=$v', '1986-11-23 16:38:19', '1327 Willms Turnpike\nLednerburgh, CA 31713', 'A', 'V'),
(21, 'Mr. Darrin Rath I', 'bianka62', '?O]Nh1=Rf[bmyx', '2000-07-13 20:24:26', '77052 Hegmann Fork\nSouth Erichside, HI 85809', 'B', 'S'),
(22, 'Prof. Antwon Zboncak DDS', 'koelpin.pauline', '(xw8|EsWQL}=?~1', '1990-12-11 04:33:23', '11178 Novella Lodge\nSouth Derek, MO 24160-2280', 'B', 'V'),
(23, 'Mabel Beer', 'myra93', '#Xs]]cO}9c5', '1985-10-08 17:09:17', '35711 Ezekiel Ford\nTonyton, UT 38988', 'S', 'S'),
(24, 'Clarabelle Kovacek', 'tkirlin', 'VqHXE7gp55J', '1990-08-01 20:07:13', '660 Conn Ranch Suite 784\nSouth Jamiefurt, NV 28591-3176', 'B', 'S'),
(25, 'Mr. Torrey Feil', 'wreilly', ']!0:h8p', '1983-05-14 09:08:20', '41402 Nola Rue\nGarfieldstad, DE 58295', 'A', 'S'),
(26, 'Clint Becker', 'kozey.adeline', '3F^np+=|/m]C2CdQ}[Z@', '2015-02-12 18:14:49', '860 Nellie Shore\nNorth Clarissamouth, CT 16333-8419', 'A', 'B'),
(27, 'Kristian Krajcik', 'tyrell54', '3l_~@\'kH+dlyr?', '1996-02-11 04:29:30', '241 Williamson Light Suite 382\nPort Maybelle, SD 04789', 'S', 'B'),
(28, 'Woodrow Steuber', 'adriana23', '+]*+\'ra48O', '1986-09-12 15:54:29', '8912 Bode Lane Suite 949\nNew Fae, SD 12755', 'B', 'S'),
(29, 'Prof. Carter Hickle', 'hand.deron', 'nq}`/KlIBk*8[\"+FCUq', '2000-07-02 06:06:59', '44711 Mathilde Heights\nEmoryport, TN 62656-3724', 'A', 'S'),
(30, 'Mr. Ted Rippin DVM', 'qrenner', 'z%F>7|mqgL6', '2002-06-25 13:41:35', '919 Mitchell Point\nQuitzonborough, WA 59849', 'B', 'S'),
(31, 'Prof. Martin Wyman', 'joesph.klein', '#X8@1[-7UAa/.w7PqD$', '1988-06-15 23:23:40', '90271 Pattie Club\nWest Christiana, MA 10556-8915', 'S', 'B'),
(32, 'Edward Ebert DVM', 'gerlach.amara', ')^b37>X)[', '1977-11-14 14:07:34', '8034 Woodrow Light\nLake Theresabury, WI 88757-8469', 'B', 'B'),
(33, 'Miss Taya Hoppe', 'katrina18', '\\0Y4%lS,Kqz!O50', '2012-06-30 15:54:04', '921 Reina Ridge\nSouth Austen, IN 11783-2805', 'S', 'V'),
(34, 'Mrs. Dulce Heathcote', 'lebert', '>40ae;V:|^:Q', '2013-07-14 12:24:17', '218 Carmelo Via Suite 931\nKosshaven, MO 81200', 'A', 'B'),
(35, 'Destinee Lehner', 'jeramie23', 'Hxi@H]1', '1986-08-29 22:28:35', '543 Schmitt Landing Apt. 854\nNorth Marilieport, AL 23718-7673', 'S', 'B'),
(36, 'Dedric O\'Hara', 'ejaskolski', 'U!hIL%vE~fzKrHJ', '2010-12-12 17:50:55', '463 Ibrahim Road Apt. 185\nNew Shanestad, OR 11655', 'A', 'S'),
(37, 'Osborne Hyatt', 'destin.gutkowski', 'B2@cyC2Y#phxOL|', '1983-10-31 18:38:48', '34915 D\'Amore Mission Suite 224\nPort Mafaldashire, MS 93591', 'B', 'S'),
(38, 'Mark Hyatt', 'yundt.leon', '-3jBdcV<(Mb]k>U', '2008-03-18 18:55:20', '194 Kemmer Light\nRogahnshire, KY 11188-5695', 'B', 'S'),
(39, 'Dr. Ashtyn Leffler', 'cormier.dewayne', 'Wr\'qx$Vg,B2/NGN', '1987-01-01 13:26:05', '3406 Shanahan Lights\nBergstromview, LA 48057', 'S', 'S'),
(40, 'Aleen McClure', 'janae.rodriguez', 'j|B3=u\\L]R5}_', '1972-10-02 13:39:08', '62992 Wyman Glen\nWilliamsonbury, MA 99426-4179', 'A', 'V'),
(41, 'Prof. Zora Heathcote Sr.', 'qlarson', 'sobkz==Q=)6>B?OlC&.', '1985-02-25 12:53:09', '77390 Spinka Grove Suite 823\nNorth Noemyshire, MS 90132', 'B', 'S'),
(42, 'Conrad Goldner', 'opaucek', '9toFz0|D/keY\"\\4-`', '2000-04-25 22:50:32', '105 Gerlach Neck\nAshlyhaven, ND 04229-2888', 'S', 'S'),
(43, 'Adrianna Stoltenberg', 'dlarkin', 'x7F{}-5JTkuI:}-C', '1981-01-24 07:29:41', '8205 O\'Connell Burgs\nJonatanmouth, RI 94755', 'A', 'S'),
(44, 'Ashleigh McDermott', 'heller.eliseo', '}\'\'\\H(', '1998-10-27 00:56:14', '745 Danyka Lodge Suite 286\nMateoville, LA 21627-4420', 'S', 'V'),
(45, 'Hobart Wolf', 'arne24', 'DV\"+QCYDxX;T@\"', '1990-09-19 13:19:46', '43400 Parisian Throughway Suite 485\nGerhardville, WI 59221', 'B', 'B'),
(46, 'Alvah Lowe MD', 'earnest.walsh', 'wy7{:0\'Hm}6ouDno3Wn', '1986-05-15 10:14:46', '985 Graham Union Suite 367\nReaganfurt, MI 37835-2754', 'S', 'S'),
(47, 'Buck Hilpert', 'jordy.schuster', 'DL-7wNhon-_7m', '2013-01-01 02:05:19', '6787 Kelvin Mountains\nEast Jaiden, MT 38436', 'A', 'S'),
(48, 'Zachary Kassulke', 'hettinger.raleigh', '^,V7Vm|p7HU]=8L}|yXS', '1988-01-23 08:12:43', '438 Kling Burgs Apt. 236\nPort Dayna, UT 60198-5249', 'S', 'S'),
(49, 'Aglae Kling DDS', 'trey.hilpert', 'hj8y5MP;', '2001-10-20 09:10:24', '8013 Jones Freeway Apt. 623\nNikolausburgh, MS 10265', 'S', 'B'),
(50, 'Lance Davis', 'vergie.gibson', '=daYz|myK~U', '1972-12-14 02:25:48', '50859 Gardner Mountains\nGilbertside, OR 12937', 'B', 'B');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasservicio`
--

CREATE TABLE `ventasservicio` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdUsuario` int(11) DEFAULT NULL,
  `IdCliente` int(11) DEFAULT NULL,
  `FechaHoraVenta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CodigoEstadoVenta` char(1) DEFAULT NULL,
  `IdPromocion` int(11) DEFAULT NULL,
  `NroPersonas` int(11) DEFAULT NULL,
  `NroCasillero` int(11) NOT NULL,
  `Observaciones` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventasservicio`
--

INSERT INTO `ventasservicio` (`IdVentaServicio`, `IdUsuario`, `IdCliente`, `FechaHoraVenta`, `CodigoEstadoVenta`, `IdPromocion`, `NroPersonas`, `NroCasillero`, `Observaciones`) VALUES
(1, 20, 195, '1993-11-26 13:11:27', 'I', 18, 4, 17, 'Officiis facere ipsam iste saepe molestias consequatur tempore nulla maxime aut cum reiciendis dolores.'),
(2, 19, 145, '1998-11-15 19:28:52', 'A', 12, 3, 11, 'Eveniet voluptatem iste sapiente et nihil dolorem et commodi voluptatem reprehenderit ab cum sunt dicta.'),
(3, 40, 169, '2014-06-24 13:06:27', 'F', 16, 3, 15, 'Accusantium dolores aut magni eaque voluptas dolorum est consectetur in et nulla vel.'),
(4, 15, 113, '1977-09-09 06:55:39', 'I', 6, 2, 29, 'Illum sed nemo illum tenetur ratione quia fugiat eaque qui et neque voluptatem fuga tenetur quia est.'),
(5, 22, 2, '1994-12-28 18:40:08', 'A', 14, 7, 22, 'Est debitis eos ducimus suscipit aspernatur aut possimus dolore ut sequi repellat voluptatem est enim consequatur omnis dolor tempore explicabo similique voluptate velit aliquid non corporis iusto.'),
(6, 13, 8, '2015-08-03 01:37:05', 'I', 5, 4, 5, 'Quo ea earum unde sapiente reprehenderit neque suscipit sequi quia alias totam velit voluptatibus alias odio occaecati.'),
(7, 29, 127, '1986-09-20 01:49:36', 'F', 12, 4, 7, 'Ipsum excepturi assumenda facilis et temporibus autem suscipit maxime quia quia sequi fugiat enim consequatur voluptates hic.'),
(8, 33, 120, '1987-01-09 14:11:41', 'F', 12, 3, 26, 'Ipsum iure id quisquam voluptatem amet consectetur voluptatibus distinctio sapiente aut omnis earum voluptatem non odit ut explicabo alias repellat id iusto.'),
(9, 37, 106, '1983-01-04 08:33:02', 'A', 11, 1, 5, 'Ipsa provident illum eaque omnis nihil dolorem eaque rerum aperiam id provident cumque eius ducimus eaque dolores dolor maxime iure.'),
(10, 28, 160, '1980-10-05 10:43:19', 'F', 20, 0, 29, 'Blanditiis unde odit dolorem dolorum soluta id labore aut porro et atque tempora iusto consequatur.'),
(11, 35, 113, '2007-07-11 10:31:33', 'F', 8, 3, 4, 'Sit sint ad quam quas quo non minus voluptas doloremque eum alias sed fugit odit fuga non laboriosam aut qui nemo quia minus esse.'),
(12, 31, 15, '2019-04-05 23:54:17', 'I', 19, 9, 4, 'Sapiente placeat veritatis ut commodi sint eligendi facere architecto ducimus omnis natus est quis fugit voluptas ut vero maxime minus quo iusto iste nihil.'),
(13, 49, 165, '1994-11-18 18:06:00', 'I', 7, 3, 16, 'Eum omnis qui veniam reprehenderit vel autem sunt maxime at ipsa iste ad.'),
(14, 42, 116, '1970-11-09 02:04:37', 'F', 1, 5, 6, 'Aut at dolorum accusantium iure ipsa tenetur perferendis ut minus et et ipsum id voluptatibus ratione non vel omnis ut consequatur accusamus non quibusdam.'),
(15, 42, 28, '1992-03-25 14:45:56', 'I', 16, 0, 2, 'Cum sit consequuntur aspernatur maiores fuga totam quasi et omnis aut atque consequatur et.'),
(16, 28, 10, '1998-09-15 15:18:58', 'A', 4, 2, 14, 'Eveniet ea doloribus maxime voluptatem nam voluptas accusantium ab velit vero odit fugiat.'),
(17, 30, 125, '2004-09-16 05:14:17', 'F', 4, 7, 6, 'Eos corrupti quasi labore quo ad saepe dolores doloribus qui mollitia autem sed incidunt et quaerat voluptates consequatur ullam illo error nesciunt in nihil molestias.'),
(18, 36, 119, '1980-09-21 12:47:43', 'I', 14, 8, 28, 'Assumenda et aspernatur maiores sint eum sed vero consequatur dolores architecto itaque cupiditate enim quia a enim sint possimus rerum labore minima qui fuga quae rerum modi veniam.'),
(19, 21, 82, '1974-02-18 17:16:58', 'A', 10, 4, 7, 'Provident fugit odio non qui laboriosam non odio voluptatem dolores molestiae soluta excepturi facere corrupti consequatur sequi assumenda et iusto esse et ratione ducimus ut qui accusantium quasi corrupti.'),
(20, 40, 138, '1979-01-09 02:33:36', 'I', 6, 1, 14, 'Dolor repudiandae eaque distinctio ex aliquam qui illum perspiciatis sit assumenda sint deserunt ex eveniet quaerat rerum nihil voluptas.'),
(21, 46, 161, '2014-05-28 06:55:04', 'I', 17, 7, 5, 'Fuga voluptatem sed aliquam eaque iure pariatur animi autem sit perferendis fugiat in quisquam officia natus rerum ut eum et.'),
(22, 40, 148, '1979-10-09 20:29:08', 'I', 14, 4, 20, 'Nobis sit et harum dolore eos aut qui id sed est quisquam sed rerum.'),
(23, 25, 136, '1991-06-04 19:33:40', 'A', 4, 2, 4, 'Consequuntur aliquid distinctio temporibus quis omnis facere qui totam veniam quaerat qui sunt a minima consectetur aut.'),
(24, 49, 15, '1978-04-07 14:12:38', 'F', 3, 4, 17, 'Corporis dicta dicta qui omnis id voluptatem natus tempora perspiciatis omnis temporibus eum nostrum quasi facere consectetur rerum similique ut voluptates fuga corporis.'),
(25, 3, 142, '1975-05-28 14:55:45', 'I', 3, 2, 10, 'Laboriosam voluptatem similique maiores et similique blanditiis nihil accusamus velit sunt doloribus quo sunt nihil est ipsum amet.'),
(26, 15, 118, '1979-05-01 15:11:58', 'I', 6, 8, 24, 'Blanditiis esse voluptatem cumque qui enim aperiam eos molestias nemo quisquam earum magni unde similique recusandae commodi quis reprehenderit sit consequatur dolorum molestiae tempora non voluptatem.'),
(27, 2, 56, '1984-04-02 22:30:33', 'F', 19, 1, 26, 'Iusto doloremque nostrum distinctio reprehenderit in sunt molestiae ipsa blanditiis repellendus modi praesentium voluptatibus atque odio ipsum sint reiciendis consectetur est quidem.'),
(28, 8, 142, '1986-01-05 22:39:10', 'A', 17, 0, 25, 'Qui porro deleniti et ad quasi quis repudiandae accusamus inventore quae dolores voluptatem qui eum vel.'),
(29, 20, 111, '2016-11-11 00:30:52', 'A', 19, 8, 22, 'Modi quos rem tenetur et dicta culpa qui delectus asperiores reiciendis quam quasi aliquam tempora totam tenetur ut et et in maiores.'),
(30, 40, 171, '1982-09-01 02:57:15', 'F', 13, 7, 12, 'Minima sed id vero possimus dolores dolor numquam vel possimus quas ut omnis itaque recusandae officiis illo assumenda harum aut.'),
(31, 4, 34, '2005-04-27 01:08:54', 'F', 3, 4, 30, 'Excepturi laborum occaecati cumque sint voluptatibus nam molestias eius similique excepturi sit quia velit quae delectus nihil omnis eos rerum similique sapiente.'),
(32, 44, 202, '1995-11-20 17:58:45', 'A', 2, 7, 16, 'Mollitia eum aut odio sequi et sint et quia quidem cumque laudantium harum laboriosam nihil quis est voluptas quo fugit quia temporibus dolor incidunt eaque dolores aut.'),
(33, 31, 128, '2013-06-03 02:37:19', 'I', 6, 3, 28, 'Nihil sed porro et eum est nesciunt voluptas cumque corrupti nisi voluptatem officia occaecati id fuga laboriosam.'),
(34, 39, 151, '1993-08-30 10:34:30', 'F', 6, 3, 18, 'Sunt quod magnam accusantium molestias consequatur nostrum accusamus est repellendus non nostrum nobis dolores nihil temporibus expedita numquam illum ratione consequuntur odio dicta voluptatem.'),
(35, 2, 195, '1984-06-10 15:52:27', 'F', 9, 6, 13, 'Enim sunt excepturi nisi vel ut sit quas perspiciatis animi corrupti perspiciatis ut illum sint cumque enim dignissimos tempora reiciendis molestiae iure fugit commodi.'),
(36, 4, 169, '2002-09-22 00:45:58', 'I', 7, 5, 18, 'Impedit sed repudiandae eum quia odio nam incidunt possimus aut in tempora facere.'),
(37, 5, 38, '1988-10-20 18:46:02', 'I', 2, 6, 4, 'Nesciunt exercitationem autem et et quia autem dolore magnam et sapiente temporibus adipisci quia exercitationem velit praesentium aliquid.'),
(38, 18, 92, '1986-08-23 11:51:19', 'A', 18, 0, 4, 'Sed temporibus eveniet minus non reiciendis minima nobis qui sapiente fuga adipisci quis illo sed dolor.'),
(39, 2, 64, '2017-08-15 00:26:04', 'I', 11, 2, 29, 'Fugit culpa commodi consequatur quibusdam similique sint ad aut hic numquam ipsam et voluptate rerum sint.'),
(40, 17, 20, '1995-05-05 07:39:49', 'A', 2, 9, 1, 'Tenetur quas laborum iste voluptas earum accusantium qui placeat facilis ea tenetur atque facere.'),
(41, 9, 6, '1982-12-19 19:59:05', 'A', 14, 6, 1, 'Nesciunt ut possimus sequi amet molestias vel iusto et voluptatem ea molestiae est iste eius dolor recusandae nostrum totam voluptas eum et praesentium fuga consequatur nostrum.'),
(42, 39, 27, '2006-03-22 11:52:25', 'A', 8, 6, 11, 'Et error ipsum laborum in sint minima aut dolores molestiae corporis ipsa sunt molestiae quibusdam.'),
(43, 43, 62, '2004-05-24 19:52:02', 'A', 1, 0, 9, 'Sequi animi consequatur praesentium autem nihil et ratione voluptates est iste ab delectus.'),
(44, 22, 145, '1985-02-02 17:49:59', 'F', 13, 7, 5, 'Voluptas nostrum quaerat sed repudiandae ut quia est dolor error exercitationem provident velit nesciunt similique deserunt reiciendis quas velit qui ad et maxime aut eos vel.'),
(45, 31, 12, '1982-05-16 03:09:48', 'I', 3, 6, 23, 'Et quibusdam et modi ea sit eos quia architecto unde rerum quo deleniti ipsa beatae nobis soluta culpa rerum voluptate aliquam qui.'),
(46, 48, 75, '2012-03-02 08:56:47', 'A', 16, 5, 2, 'Doloremque quidem ex deleniti qui dolor autem ea sint odit consequuntur ipsum consequuntur beatae voluptatem veniam quis eligendi quis aut quae doloribus.'),
(47, 34, 133, '2007-05-20 01:31:52', 'I', 4, 8, 10, 'Suscipit dolor natus porro sint veniam aut et ut ut possimus unde aliquid quo dolor sed est.'),
(48, 50, 23, '1981-07-03 04:05:59', 'F', 15, 6, 29, 'Accusantium autem fugit nesciunt et sed rem est voluptatem expedita mollitia temporibus vero est voluptatem optio saepe tempore quo culpa adipisci provident quo dicta.'),
(49, 42, 13, '1973-04-12 08:00:46', 'A', 9, 8, 4, 'Autem amet sint rem ipsum pariatur dolorem possimus dignissimos ea distinctio fuga aspernatur aperiam officia officia iure.'),
(50, 38, 15, '1973-09-27 04:32:18', 'A', 5, 1, 19, 'Quas aliquam doloremque sit est doloribus autem possimus ad illum autem repudiandae laboriosam quam aspernatur tempore eos sed.'),
(51, 10, 58, '1980-07-30 19:57:29', 'A', 3, 1, 22, 'Modi laboriosam officia debitis ipsam similique velit eaque aliquid non eos ipsa nobis labore nemo cupiditate.'),
(52, 21, 114, '2018-06-04 05:09:50', 'I', 17, 1, 14, 'Omnis eligendi enim voluptatibus qui excepturi similique tempore velit magnam repudiandae et modi unde in.'),
(53, 40, 83, '1995-12-10 23:02:04', 'I', 11, 0, 18, 'Recusandae temporibus et illo autem voluptatem iure quia nihil repudiandae aperiam mollitia enim quos.'),
(54, 3, 71, '1977-06-03 23:23:09', 'A', 20, 9, 22, 'Aut tempore itaque non possimus doloremque ducimus repellendus rem facere iste ad et.'),
(55, 24, 131, '1998-03-01 17:40:05', 'A', 9, 0, 17, 'Labore maxime tempore eveniet illo ea et quasi nam architecto asperiores sit nihil sint.'),
(56, 5, 143, '1996-02-27 03:40:16', 'I', 12, 9, 29, 'Qui vel ipsam tempore eveniet similique aperiam aperiam a alias consequatur magni nobis distinctio voluptatem nobis nesciunt qui molestias possimus id inventore in perspiciatis beatae voluptates quia.'),
(57, 45, 118, '1980-12-04 19:49:45', 'F', 12, 6, 23, 'Totam atque debitis consectetur sed magni nostrum alias et omnis omnis dignissimos vel numquam facere doloremque repudiandae dolores sapiente aut cupiditate sed ea qui numquam quia.'),
(58, 15, 150, '2011-05-02 16:32:55', 'A', 1, 9, 25, 'Rerum facere recusandae iste vel ut voluptates expedita adipisci qui quia incidunt eos fuga laborum natus omnis molestias magnam quidem voluptatem reprehenderit omnis eum recusandae inventore dolorum.'),
(59, 15, 154, '1975-08-14 04:35:05', 'F', 19, 2, 20, 'Sit voluptatem sed et quidem reprehenderit possimus ipsum id similique perspiciatis eum quam sint velit dolorum sunt consequuntur sunt facilis voluptas qui beatae facere ipsum.'),
(60, 29, 17, '2010-03-28 00:41:31', 'A', 8, 0, 2, 'Sit velit quae ut porro voluptas nemo quia natus autem architecto sit quasi laborum ut enim consequuntur nobis.'),
(61, 50, 50, '2007-12-02 11:53:03', 'A', 20, 1, 1, 'Consequatur asperiores ut ut eius rem sed fuga earum voluptatem et omnis itaque recusandae necessitatibus quidem voluptatum est nesciunt sed aut nisi vel dignissimos qui.'),
(62, 43, 45, '1984-06-21 03:01:19', 'I', 19, 8, 21, 'Vitae quis earum sequi ipsam quia delectus alias ad ut sed sit quo cupiditate animi.'),
(63, 33, 92, '2006-02-14 15:32:52', 'F', 15, 5, 25, 'Modi tempora odit quo dolor dolores et sed voluptates alias vitae quas facilis et sed explicabo ipsa aut est neque repellendus reiciendis quis voluptas neque.'),
(64, 37, 83, '2007-07-27 04:01:38', 'I', 18, 0, 27, 'Molestias in ab explicabo dolor numquam facere autem et enim nihil enim in architecto dolorem sit ut ducimus soluta non possimus.'),
(65, 35, 64, '1985-10-28 03:04:20', 'A', 16, 8, 30, 'Sint voluptatem nostrum est repellendus blanditiis architecto nisi earum dolore similique placeat sunt ut assumenda in.'),
(66, 18, 15, '1993-12-02 15:40:36', 'I', 1, 3, 19, 'Voluptatem assumenda occaecati error maiores minima fugiat eum ea a aut quia est aut modi nemo eum et quo consectetur modi incidunt quis non.'),
(67, 25, 178, '1979-02-12 17:18:36', 'I', 20, 7, 11, 'Blanditiis iusto minima odit cupiditate id nihil impedit possimus eaque nesciunt assumenda occaecati quibusdam quos corrupti eius est delectus.'),
(68, 37, 162, '2001-01-30 21:36:44', 'I', 20, 5, 2, 'Omnis deleniti deserunt quisquam voluptatem non pariatur illum dolore expedita possimus provident repellat natus sunt facilis assumenda quis numquam quibusdam temporibus blanditiis et aut.'),
(69, 11, 99, '1977-11-06 21:53:55', 'F', 14, 0, 16, 'Rerum consequuntur sequi error laborum rerum est id necessitatibus omnis praesentium vero aut aut aut est minima aut ipsum ad saepe qui sint eaque pariatur.'),
(70, 38, 64, '2015-02-17 16:35:48', 'F', 20, 9, 1, 'Accusamus fuga quia ut dolor autem et eius amet sunt vero sed quae provident voluptas quo eaque sit quia est neque minima totam consectetur qui aspernatur tempora.'),
(71, 12, 138, '2010-06-11 04:52:49', 'A', 6, 0, 18, 'Dolorem et ipsa ratione voluptatem doloribus in aut dolorem recusandae non voluptatem dolorum laboriosam tempora est beatae.'),
(72, 31, 7, '2011-03-17 02:12:24', 'A', 3, 0, 15, 'Quaerat qui molestiae totam neque voluptas omnis et molestiae et quia quidem aut aut quia vel et ducimus et culpa suscipit doloribus qui accusantium eligendi molestiae maiores.'),
(73, 40, 116, '1971-03-08 08:18:45', 'I', 3, 1, 29, 'Magni quae et sequi corrupti soluta rerum qui illo temporibus dolorem ut ducimus in qui blanditiis id officia ut impedit saepe maxime beatae fugiat.'),
(74, 40, 94, '2016-03-22 15:02:33', 'A', 14, 6, 25, 'Voluptatem necessitatibus deleniti saepe nemo consectetur facilis eius aut dolores consectetur quas a natus dolores explicabo sit iste sit ut laborum voluptatem sed.'),
(75, 30, 190, '1990-08-03 13:19:51', 'I', 2, 0, 2, 'Beatae non nobis laborum sit veniam modi voluptates distinctio hic quod in soluta itaque eos.'),
(76, 47, 147, '2000-05-11 16:27:19', 'I', 16, 1, 12, 'Eius natus in sunt incidunt vel animi id laboriosam distinctio eaque sed suscipit delectus.'),
(77, 48, 111, '1996-10-10 22:49:00', 'F', 4, 5, 17, 'Ut optio occaecati at odio ut libero tenetur quasi sint quibusdam sed reiciendis et aut occaecati omnis.'),
(78, 45, 50, '2020-01-09 12:49:35', 'A', 17, 3, 15, 'Est dolores nihil fuga expedita reprehenderit qui incidunt iure in repellendus accusamus laborum consequuntur minus aut voluptatum ea delectus nostrum est consequatur accusamus sed accusamus.'),
(79, 9, 144, '1998-08-09 12:31:40', 'A', 2, 0, 28, 'Quis inventore ut quia rerum sapiente dignissimos commodi alias dolor esse fuga blanditiis explicabo.'),
(80, 17, 93, '1988-04-08 21:06:12', 'F', 19, 5, 30, 'Possimus eum sed non doloremque provident fugit unde dicta aut eius nesciunt culpa sunt cupiditate commodi et adipisci vero dolores quae quas voluptatem.'),
(81, 26, 38, '1998-03-06 19:04:08', 'I', 20, 9, 13, 'Omnis quidem est et vel deserunt at aut quia ut eos autem vitae et suscipit incidunt sunt dolorum odit libero debitis sit repudiandae et temporibus nihil.'),
(82, 9, 149, '2015-07-02 02:27:31', 'A', 10, 9, 19, 'Quidem sed velit repudiandae sed similique consequatur qui est vel quia sed doloribus iure debitis voluptatum magni quaerat in.'),
(83, 38, 130, '1985-09-03 02:31:48', 'F', 9, 0, 22, 'Laboriosam voluptas a ducimus velit rerum voluptates illo earum omnis quasi qui voluptas molestiae aut non quos ut tempore eius est ratione quasi odio sint ipsa fuga rerum.'),
(84, 23, 124, '1991-10-24 11:38:13', 'A', 13, 9, 1, 'Et nemo cumque repudiandae aut similique minus possimus eveniet ut et occaecati cupiditate et recusandae magnam accusamus nam ad hic voluptas.'),
(85, 46, 51, '2010-09-24 13:03:16', 'I', 1, 4, 9, 'Et voluptatem earum necessitatibus sed qui repellendus perferendis at autem dolore eligendi non accusamus voluptate commodi.'),
(86, 35, 8, '1972-08-08 03:14:12', 'F', 14, 3, 1, 'Quis qui aspernatur ullam dolor ipsam officia rerum rem corporis assumenda ipsa voluptate rerum atque dicta nulla dolor fugit voluptatem.'),
(87, 30, 15, '1981-09-23 00:46:42', 'A', 6, 6, 28, 'Ipsa ducimus qui quae esse voluptatem aliquid corrupti enim maxime perferendis quo officiis molestiae modi similique adipisci commodi dolorem necessitatibus velit non quia eum facere repellendus magnam dolor.'),
(88, 50, 91, '2019-11-05 12:49:10', 'I', 19, 4, 6, 'Qui animi voluptas illum voluptatem asperiores autem autem et ullam enim corrupti nobis minima quam quia eligendi saepe exercitationem.'),
(89, 34, 123, '2000-09-03 00:07:09', 'I', 16, 0, 21, 'Magnam omnis nulla repudiandae et eaque laboriosam facilis vitae numquam totam provident fugiat sit magni voluptas aut consequatur et distinctio.'),
(90, 26, 54, '1977-01-19 16:42:35', 'F', 3, 9, 4, 'Similique voluptas vel ut qui omnis rem nostrum incidunt iure sunt cumque rerum eos eos quia dignissimos cum ullam commodi odit vitae ad qui enim et.'),
(91, 13, 166, '2006-12-26 05:09:45', 'A', 12, 6, 15, 'Deserunt at error perspiciatis eum eius non cupiditate cum amet dolores suscipit velit soluta neque vel sapiente est.'),
(92, 45, 144, '2010-07-17 15:07:19', 'I', 10, 4, 24, 'Consectetur aliquam odit quidem est possimus beatae autem cupiditate qui iure rerum quidem adipisci laboriosam modi ut.'),
(93, 43, 2, '1996-02-26 14:05:17', 'A', 20, 5, 28, 'Voluptas nobis commodi et molestias ducimus sed perferendis odio in dolores porro ex officiis quia nostrum.'),
(94, 39, 171, '1993-12-28 15:40:47', 'F', 5, 8, 22, 'Omnis itaque tempora repudiandae est amet delectus veniam iste sed autem non voluptate error eos eveniet voluptates sit deleniti dolor rerum blanditiis.'),
(95, 17, 110, '1975-10-19 09:58:00', 'A', 4, 2, 10, 'Quisquam explicabo odit harum fuga dolores optio rerum inventore quasi eos accusantium dolorem ea ut aut enim et.'),
(96, 24, 52, '2006-08-18 15:10:36', 'A', 17, 5, 5, 'Dolore nihil hic quo numquam sit et quia autem quod aspernatur repellendus doloribus fugiat reiciendis.'),
(97, 41, 59, '1982-11-10 00:02:08', 'A', 17, 0, 4, 'Quidem iure quia velit at enim consequatur voluptatem nostrum doloremque eum totam sed velit dolor quo reiciendis et occaecati architecto ut dolorum corporis et harum quam occaecati voluptatem.'),
(98, 41, 152, '1993-01-22 14:14:39', 'A', 3, 8, 14, 'In ducimus iusto corporis vitae ullam saepe aut voluptatem quae facilis sed deleniti dolores ut ex non.'),
(99, 5, 188, '1988-12-08 09:15:22', 'A', 17, 2, 1, 'Voluptatum id fugiat enim sint et ab eum aut nobis culpa labore cum maiores alias et inventore eum molestiae rem et incidunt illum maxime rerum enim vel consequuntur sed.'),
(100, 48, 128, '1989-09-30 00:12:59', 'A', 17, 7, 27, 'Occaecati nulla aspernatur accusamus illum ut quo nisi iste corporis adipisci qui nihil repudiandae harum.'),
(101, NULL, 62, '2020-02-28 04:00:00', NULL, 1, 12, 23, 'asdf'),
(102, 1, 62, '2020-02-28 15:37:11', 'I', 1, 12, 23, 'asdf'),
(103, 1, 62, '2020-02-28 15:38:04', 'I', 1, 12, 23, 'asdf'),
(104, 1, 62, '2020-02-28 15:38:32', 'I', 2, 213, 23, 'asdfasfsaf asdfsaf ad fa s'),
(105, 1, 62, '2020-02-28 15:39:30', 'I', 2, 12, 3, 'teclado'),
(106, 1, 62, '2020-02-28 15:40:08', 'I', 2, 12, 3, 'teclado'),
(107, 1, 62, '2020-02-28 15:40:39', 'I', 2, 12, 23, 'asdfasd asdfsafa asdfsaf'),
(108, 1, 79, '2020-02-28 15:49:33', 'I', 1, 23, 23, 'asdfasdf asdfasdf asdfa s'),
(109, NULL, 62, '2020-02-28 04:00:00', NULL, 2, 23, 12, 'asdfas'),
(110, 1, NULL, '2020-02-28 15:56:13', 'I', 2, 23, 12, 'asdfas'),
(111, 1, 62, '2020-02-28 15:57:10', 'I', 2, 12, 23, 'asdfasdfsa'),
(112, 1, 16, '2020-02-28 16:10:24', 'I', 1, 23, 23, 'observaciones'),
(113, 1, 5, '2020-02-28 16:21:10', 'I', 1, 12, 12, 'venta completa'),
(114, NULL, 79, '2020-02-28 04:00:00', NULL, 2, 1, 23, 'asdfsa'),
(115, NULL, 62, '2020-02-28 04:00:00', NULL, 2, 23, 23, 'sadf'),
(116, 1, 62, '2020-02-28 19:54:31', 'I', 3, 23, 23, 'asdf'),
(117, 1, 59, '2020-02-28 20:03:42', 'I', 1, 10, 20, 'na na na nana'),
(118, 1, 62, '2020-02-28 21:07:59', 'I', 2, 1, 2, 'asdf asdf asdf'),
(119, 1, 62, '2020-03-17 07:55:33', 'I', 4, 12, 12, 'asafsad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasserviciodetalle`
--

CREATE TABLE `ventasserviciodetalle` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdServicio` int(11) NOT NULL,
  `Costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventasserviciodetalle`
--

INSERT INTO `ventasserviciodetalle` (`IdVentaServicio`, `IdServicio`, `Costo`) VALUES
(1, 46, '6389.94'),
(2, 24, '650.95'),
(3, 25, '2631.22'),
(3, 41, '8696.45'),
(3, 60, '1947.58'),
(6, 33, '9392.61'),
(9, 6, '5215.98'),
(9, 51, '3408.31'),
(10, 32, '5225.42'),
(10, 48, '6285.66'),
(11, 25, '8657.45'),
(13, 6, '4943.42'),
(13, 36, '3510.27'),
(13, 42, '7132.01'),
(14, 35, '9247.44'),
(15, 15, '1872.88'),
(15, 34, '2594.70'),
(16, 21, '7896.91'),
(16, 28, '9517.30'),
(19, 28, '6042.72'),
(19, 59, '3519.67'),
(20, 14, '2820.54'),
(21, 56, '1718.80'),
(24, 33, '9537.38'),
(26, 35, '8540.03'),
(27, 21, '7012.09'),
(28, 23, '5965.35'),
(31, 27, '6662.12'),
(31, 46, '5050.83'),
(32, 42, '6497.41'),
(32, 56, '8132.10'),
(33, 11, '7828.06'),
(33, 12, '7565.03'),
(33, 21, '9609.21'),
(34, 17, '1790.54'),
(34, 27, '3332.70'),
(36, 52, '9173.30'),
(38, 2, '5979.76'),
(38, 49, '5801.62'),
(39, 7, '5681.58'),
(39, 57, '1524.15'),
(40, 12, '7890.59'),
(40, 36, '258.94'),
(41, 31, '5485.58'),
(42, 5, '7816.33'),
(42, 13, '2431.82'),
(44, 9, '5828.62'),
(44, 16, '9882.92'),
(45, 34, '8679.72'),
(46, 37, '1790.29'),
(48, 16, '6610.25'),
(48, 28, '5135.74'),
(48, 46, '844.91'),
(49, 17, '962.74'),
(49, 35, '4058.03'),
(50, 24, '4666.74'),
(50, 56, '1973.86'),
(51, 47, '7104.05'),
(52, 60, '3071.96'),
(53, 59, '9645.00'),
(54, 1, '3295.71'),
(55, 33, '2696.89'),
(56, 54, '9338.97'),
(58, 45, '1048.22'),
(58, 52, '9746.19'),
(60, 35, '8211.25'),
(62, 3, '8449.64'),
(63, 16, '3611.19'),
(64, 38, '7585.36'),
(66, 22, '7887.42'),
(67, 50, '4517.08'),
(71, 52, '8430.24'),
(72, 35, '4215.94'),
(72, 36, '3947.00'),
(74, 21, '1778.95'),
(74, 46, '9894.65'),
(76, 25, '4979.51'),
(76, 37, '2179.18'),
(78, 33, '9480.25'),
(78, 39, '9722.23'),
(78, 42, '8953.80'),
(82, 18, '9381.02'),
(82, 38, '2725.64'),
(83, 46, '4919.00'),
(83, 56, '5842.81'),
(85, 35, '6123.99'),
(89, 9, '4821.36'),
(94, 28, '3372.19'),
(96, 19, '5792.91'),
(98, 26, '866.28'),
(99, 4, '3665.57'),
(99, 13, '4735.89'),
(100, 13, '4135.02'),
(100, 58, '6977.69'),
(112, 12, '3271.31'),
(113, 12, '3271.31'),
(113, 35, '7915.07'),
(116, 12, '3271.31'),
(117, 12, '3271.31'),
(118, 12, '3271.31'),
(119, 12, '3271.31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasserviciodetallearticulos`
--

CREATE TABLE `ventasserviciodetallearticulos` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdArticulo` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventasserviciodetallearticulos`
--

INSERT INTO `ventasserviciodetallearticulos` (`IdVentaServicio`, `IdArticulo`, `Cantidad`, `Costo`) VALUES
(1, 180, 769, '2756.47'),
(2, 228, 607, '1818.49'),
(3, 182, 921, '9734.84'),
(3, 263, 758, '821.57'),
(6, 98, 170, '3222.42'),
(6, 267, 20, '317.59'),
(8, 29, 790, '3244.20'),
(8, 246, 923, '1497.86'),
(8, 271, 515, '2998.40'),
(9, 147, 979, '525.11'),
(10, 205, 231, '8747.49'),
(13, 190, 671, '5847.54'),
(13, 211, 832, '6519.21'),
(14, 269, 122, '3496.42'),
(16, 179, 689, '2493.37'),
(18, 252, 17, '1090.18'),
(19, 38, 907, '4728.26'),
(20, 270, 466, '2848.97'),
(21, 232, 598, '3248.79'),
(21, 273, 623, '6032.40'),
(23, 136, 289, '9352.54'),
(23, 190, 198, '7928.75'),
(24, 251, 48, '1261.50'),
(25, 257, 204, '6859.39'),
(27, 87, 215, '6313.93'),
(27, 162, 947, '6275.94'),
(27, 186, 841, '1892.90'),
(27, 227, 483, '8706.82'),
(28, 153, 521, '3844.41'),
(29, 98, 989, '7844.76'),
(30, 211, 425, '5770.99'),
(34, 39, 144, '4411.85'),
(35, 168, 54, '9601.82'),
(37, 241, 545, '2812.26'),
(38, 64, 465, '5331.36'),
(38, 234, 71, '3144.40'),
(38, 261, 414, '2437.60'),
(40, 278, 564, '5582.73'),
(41, 36, 36, '3679.57'),
(41, 170, 162, '2658.32'),
(42, 164, 249, '4700.56'),
(42, 186, 199, '6589.87'),
(42, 213, 226, '1088.29'),
(43, 178, 242, '4332.51'),
(44, 23, 69, '6851.89'),
(44, 149, 783, '9501.23'),
(45, 99, 614, '361.55'),
(46, 171, 618, '7145.95'),
(47, 67, 343, '3196.62'),
(49, 99, 862, '7627.87'),
(55, 97, 243, '3169.09'),
(55, 238, 472, '4763.96'),
(56, 210, 453, '9025.04'),
(59, 196, 789, '6996.04'),
(59, 212, 328, '7849.02'),
(60, 51, 329, '6700.09'),
(60, 141, 992, '9341.91'),
(62, 43, 563, '252.79'),
(62, 60, 583, '8903.64'),
(62, 82, 778, '8006.71'),
(62, 259, 856, '9773.75'),
(62, 274, 830, '2920.95'),
(64, 224, 54, '8073.58'),
(67, 59, 798, '3796.36'),
(67, 157, 825, '6869.46'),
(68, 6, 491, '7497.95'),
(69, 9, 170, '2621.66'),
(71, 92, 882, '5516.25'),
(71, 98, 326, '6124.01'),
(73, 261, 167, '5369.25'),
(74, 177, 132, '457.08'),
(74, 238, 356, '9443.57'),
(75, 96, 485, '2241.75'),
(76, 75, 33, '9535.96'),
(77, 258, 767, '9244.92'),
(78, 216, 130, '1585.42'),
(79, 51, 390, '1532.32'),
(80, 184, 742, '1013.96'),
(82, 204, 35, '522.88'),
(84, 183, 680, '4012.11'),
(84, 282, 445, '3978.95'),
(85, 23, 264, '1815.58'),
(86, 51, 929, '4514.73'),
(87, 134, 324, '3495.37'),
(88, 149, 98, '4237.01'),
(89, 182, 302, '2722.15'),
(89, 270, 3, '1890.43'),
(90, 61, 329, '3034.51'),
(90, 93, 221, '2918.27'),
(91, 171, 395, '9795.99'),
(92, 105, 527, '2030.16'),
(92, 214, 253, '187.33'),
(94, 82, 169, '5929.52'),
(94, 257, 996, '9170.54'),
(96, 128, 741, '8457.86'),
(100, 5, 550, '389.35'),
(100, 28, 30, '2969.69'),
(100, 127, 878, '2960.93'),
(100, 137, 318, '66.87'),
(100, 146, 660, '7882.99'),
(111, 1, 1, '98.00'),
(111, 4, 1, '16.00'),
(112, 4, 1, '16.00'),
(112, 7, 1, '11.00'),
(113, 15, 1, '22.00'),
(113, 47, 1, '81.00'),
(116, 1, 1, '98.00'),
(119, 1, 2, '98.00'),
(119, 19, 1, '74.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasserviciodetalleclientes`
--

CREATE TABLE `ventasserviciodetalleclientes` (
  `IdVentaServicio` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventasserviciodetalleclientes`
--

INSERT INTO `ventasserviciodetalleclientes` (`IdVentaServicio`, `IdCliente`) VALUES
(1, 51),
(2, 113),
(8, 27),
(8, 77),
(8, 99),
(8, 104),
(9, 187),
(9, 196),
(10, 197),
(11, 51),
(12, 163),
(13, 126),
(14, 115),
(18, 159),
(21, 23),
(21, 30),
(21, 81),
(23, 196),
(25, 154),
(26, 67),
(26, 178),
(26, 202),
(27, 69),
(27, 98),
(28, 6),
(28, 162),
(30, 61),
(30, 168),
(33, 79),
(33, 167),
(35, 91),
(37, 110),
(37, 177),
(41, 89),
(43, 28),
(43, 35),
(44, 69),
(44, 76),
(44, 134),
(46, 16),
(49, 194),
(50, 50),
(53, 88),
(53, 142),
(54, 78),
(54, 114),
(54, 162),
(55, 141),
(56, 46),
(57, 46),
(57, 68),
(57, 189),
(60, 76),
(61, 45),
(62, 109),
(64, 1),
(64, 172),
(65, 167),
(68, 86),
(69, 15),
(69, 128),
(71, 52),
(71, 106),
(71, 180),
(73, 97),
(74, 51),
(76, 102),
(76, 106),
(76, 111),
(77, 11),
(79, 124),
(81, 76),
(82, 6),
(84, 8),
(84, 149),
(84, 152),
(85, 42),
(86, 104),
(86, 176),
(87, 159),
(88, 72),
(88, 190),
(89, 84),
(90, 180),
(91, 16),
(92, 117),
(93, 119),
(94, 201),
(95, 57),
(95, 133),
(96, 151),
(97, 14),
(97, 69),
(97, 99),
(99, 13),
(99, 138),
(99, 148),
(99, 169),
(100, 3),
(100, 106),
(113, 128);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`IdArticulo`),
  ADD KEY `IdCategoria` (`IdCategoria`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`IdCategoria`),
  ADD UNIQUE KEY `NombreCategoria` (`NombreCategoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `comprasarticulos`
--
ALTER TABLE `comprasarticulos`
  ADD PRIMARY KEY (`IdCompraArticulo`),
  ADD KEY `IdUsuario` (`IdUsuario`);

--
-- Indices de la tabla `comprasarticulosdetalle`
--
ALTER TABLE `comprasarticulosdetalle`
  ADD PRIMARY KEY (`IdCompraArticulo`,`IdArticulo`),
  ADD KEY `IdArticulo` (`IdArticulo`);

--
-- Indices de la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD PRIMARY KEY (`IdMembresia`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- Indices de la tabla `promociondetalleclientes`
--
ALTER TABLE `promociondetalleclientes`
  ADD PRIMARY KEY (`IdPromocion`,`IdCliente`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`IdPromocion`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`IdServicio`),
  ADD UNIQUE KEY `NombreServicio` (`NombreServicio`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`IdUsuario`);

--
-- Indices de la tabla `ventasservicio`
--
ALTER TABLE `ventasservicio`
  ADD PRIMARY KEY (`IdVentaServicio`),
  ADD KEY `IdUsuario` (`IdUsuario`),
  ADD KEY `IdCliente` (`IdCliente`),
  ADD KEY `IdPromocion` (`IdPromocion`);

--
-- Indices de la tabla `ventasserviciodetalle`
--
ALTER TABLE `ventasserviciodetalle`
  ADD PRIMARY KEY (`IdVentaServicio`,`IdServicio`),
  ADD KEY `IdServicio` (`IdServicio`);

--
-- Indices de la tabla `ventasserviciodetallearticulos`
--
ALTER TABLE `ventasserviciodetallearticulos`
  ADD PRIMARY KEY (`IdVentaServicio`,`IdArticulo`),
  ADD KEY `IdArticulo` (`IdArticulo`);

--
-- Indices de la tabla `ventasserviciodetalleclientes`
--
ALTER TABLE `ventasserviciodetalleclientes`
  ADD PRIMARY KEY (`IdVentaServicio`,`IdCliente`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `IdArticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=283;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT de la tabla `comprasarticulos`
--
ALTER TABLE `comprasarticulos`
  MODIFY `IdCompraArticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT de la tabla `membresia`
--
ALTER TABLE `membresia`
  MODIFY `IdMembresia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `IdPromocion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `IdServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `ventasservicio`
--
ALTER TABLE `ventasservicio`
  MODIFY `IdVentaServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `categorias` (`IdCategoria`);

--
-- Filtros para la tabla `comprasarticulos`
--
ALTER TABLE `comprasarticulos`
  ADD CONSTRAINT `comprasarticulos_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`);

--
-- Filtros para la tabla `comprasarticulosdetalle`
--
ALTER TABLE `comprasarticulosdetalle`
  ADD CONSTRAINT `comprasarticulosdetalle_ibfk_1` FOREIGN KEY (`IdCompraArticulo`) REFERENCES `comprasarticulos` (`IdCompraArticulo`),
  ADD CONSTRAINT `comprasarticulosdetalle_ibfk_2` FOREIGN KEY (`IdArticulo`) REFERENCES `articulos` (`IdArticulo`);

--
-- Filtros para la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD CONSTRAINT `membresia_ibfk_1` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`);

--
-- Filtros para la tabla `promociondetalleclientes`
--
ALTER TABLE `promociondetalleclientes`
  ADD CONSTRAINT `promociondetalleclientes_ibfk_1` FOREIGN KEY (`IdPromocion`) REFERENCES `promociones` (`IdPromocion`),
  ADD CONSTRAINT `promociondetalleclientes_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`);

--
-- Filtros para la tabla `ventasservicio`
--
ALTER TABLE `ventasservicio`
  ADD CONSTRAINT `ventasservicio_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  ADD CONSTRAINT `ventasservicio_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`),
  ADD CONSTRAINT `ventasservicio_ibfk_3` FOREIGN KEY (`IdPromocion`) REFERENCES `promociones` (`IdPromocion`);

--
-- Filtros para la tabla `ventasserviciodetalle`
--
ALTER TABLE `ventasserviciodetalle`
  ADD CONSTRAINT `ventasserviciodetalle_ibfk_1` FOREIGN KEY (`IdVentaServicio`) REFERENCES `ventasservicio` (`IdVentaServicio`),
  ADD CONSTRAINT `ventasserviciodetalle_ibfk_2` FOREIGN KEY (`IdServicio`) REFERENCES `servicios` (`IdServicio`);

--
-- Filtros para la tabla `ventasserviciodetallearticulos`
--
ALTER TABLE `ventasserviciodetallearticulos`
  ADD CONSTRAINT `ventasserviciodetallearticulos_ibfk_1` FOREIGN KEY (`IdVentaServicio`) REFERENCES `ventasservicio` (`IdVentaServicio`),
  ADD CONSTRAINT `ventasserviciodetallearticulos_ibfk_2` FOREIGN KEY (`IdArticulo`) REFERENCES `articulos` (`IdArticulo`);

--
-- Filtros para la tabla `ventasserviciodetalleclientes`
--
ALTER TABLE `ventasserviciodetalleclientes`
  ADD CONSTRAINT `ventasserviciodetalleclientes_ibfk_1` FOREIGN KEY (`IdVentaServicio`) REFERENCES `ventasservicio` (`IdVentaServicio`),
  ADD CONSTRAINT `ventasserviciodetalleclientes_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
