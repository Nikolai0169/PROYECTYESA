-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-12-2025 a las 17:58:53
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `yesa_nosql`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artista`
--

CREATE TABLE `artista` (
  `idUsuario` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fechaContratacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `artista`
--

INSERT INTO `artista` (`idUsuario`, `activo`, `fechaContratacion`) VALUES
(2, 1, '2022-03-15'),
(4, 1, '2021-07-20'),
(6, 1, '2023-01-10'),
(9, 1, '2022-11-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacionartista`
--

CREATE TABLE `asignacionartista` (
  `idAsignacion` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `idArtista` int(11) NOT NULL,
  `fechaAsignacion` datetime NOT NULL DEFAULT current_timestamp(),
  `prioridad` enum('baja','normal','alta','urgente') NOT NULL DEFAULT 'normal'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `asignacionartista`
--

INSERT INTO `asignacionartista` (`idAsignacion`, `idSolicitud`, `idArtista`, `fechaAsignacion`, `prioridad`) VALUES
(1, 1, 2, '2025-11-14 10:45:00', 'normal'),
(2, 2, 4, '2025-11-13 15:30:00', 'alta'),
(3, 3, 6, '2025-11-12 09:15:00', 'normal'),
(4, 4, 9, '2025-11-14 09:45:00', 'urgente'),
(5, 5, 2, '2025-11-14 11:15:00', 'baja'),
(6, 6, 4, '2025-11-13 11:30:00', 'normal'),
(7, 7, 6, '2025-11-14 09:00:00', 'alta'),
(8, 8, 9, '2025-11-10 09:30:00', 'urgente'),
(9, 9, 2, '2025-11-13 12:15:00', 'normal'),
(10, 10, 4, '2025-11-14 10:15:00', 'alta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barrio`
--

CREATE TABLE `barrio` (
  `idBarrio` int(11) NOT NULL,
  `idLocalidad` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `barrio`
--

INSERT INTO `barrio` (`idBarrio`, `idLocalidad`, `nombre`) VALUES
(1, 1, 'Barrio Usaquén Centro'),
(2, 2, 'Barrio Chapinero Alto'),
(3, 3, 'Barrio La Macarena'),
(4, 4, 'Barrio 20 de Julio'),
(5, 5, 'Barrio Danubio'),
(6, 6, 'Barrio Tunal'),
(7, 7, 'Barrio Bosa Centro'),
(8, 8, 'Barrio Kennedy Central'),
(9, 9, 'Barrio Fontibón Centro'),
(10, 10, 'Barrio Engativá Centro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagenURL` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `nombre`, `descripcion`, `imagenURL`, `activo`) VALUES
(10, 'Accesorios', 'Accesorios variados artesanales', 'https://yesa.com/img/accesorios.jpg', 1),
(2, 'Cerámica', 'Piezas de cerámica pintada y decorada', 'https://yesa.com/img/ceramica.jpg', 1),
(7, 'Cuero', 'Artículos de cuero grabado', 'https://yesa.com/img/cuero.jpg', 1),
(1, 'Joyas', 'Joyas artesanales de diseño exclusivo', 'https://yesa.com/img/joyas.jpg', 1),
(5, 'Madera', 'Artículos tallados en madera', 'https://yesa.com/img/madera.jpg', 1),
(3, 'Orfebrería', 'Trabajo en metales preciosos', 'https://yesa.com/img/orfebreria.jpg', 1),
(9, 'Papel', 'Papel artesanal y papelería decorativa', 'https://yesa.com/img/papel.jpg', 1),
(8, 'Resina', 'Piezas decorativas en resina epóxica', 'https://yesa.com/img/resina.jpg', 1),
(4, 'Tejidos', 'Textiles artesanales tejidos a mano', 'https://yesa.com/img/tejidos.jpg', 1),
(6, 'Vidrio', 'Piezas de vidrio soplado y decorado', 'https://yesa.com/img/vidrio.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idUsuario` int(11) NOT NULL,
  `tipo_via` enum('Calle','Carrera','Diagonal','Transversal','Avenida','Circular','Circunvalar') NOT NULL,
  `numero_via_principal` varchar(10) NOT NULL,
  `sufijo_via` varchar(5) DEFAULT NULL,
  `letra_via` varchar(2) DEFAULT NULL,
  `numero_cruce` varchar(10) NOT NULL,
  `distancia_cruce` varchar(10) DEFAULT NULL,
  `idBarrio` int(11) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `preferencias` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`preferencias`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idUsuario`, `tipo_via`, `numero_via_principal`, `sufijo_via`, `letra_via`, `numero_cruce`, `distancia_cruce`, `idBarrio`, `telefono`, `fechaNacimiento`, `preferencias`) VALUES
(1, 'Calle', '6', 'A', NULL, '88', 'D', 1, '3015554421', '1990-05-12', '{\"color_preferido\":\"azul\",\"material\":\"cerámica\"}'),
(3, 'Carrera', '7', NULL, 'A', '45', '12', 3, '3024556789', '1992-08-23', '{\"color_preferido\":\"rojo\",\"material\":\"metal\"}'),
(5, 'Diagonal', '8', 'Sur', 'B', '50', '15', 5, '3035559876', '1988-03-15', '{\"color_preferido\":\"verde\",\"material\":\"resina\"}'),
(8, 'Avenida', '9', 'Este', NULL, '60', '20', 6, '3045552341', '1995-11-08', '{\"color_preferido\":\"amarillo\",\"material\":\"cerámica\"}'),
(10, 'Transversal', '10', 'Oeste', 'C', '70', '10', 7, '3055556789', '1998-07-20', '{\"color_preferido\":\"naranja\",\"material\":\"metal\"}'),
(11, 'Calle', '5', 'Sur', 'A', '55', '14', 5, '3018745245', '1999-10-20', '{\"color_preferido\":\"negro\", \"material\":\"arcila\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunicacionsolicitud`
--

CREATE TABLE `comunicacionsolicitud` (
  `idComunicacion` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `idRemitente` int(11) NOT NULL,
  `idDestinatario` int(11) NOT NULL,
  `canal` enum('Web','WhatsApp','Email','Telefono') NOT NULL DEFAULT 'Web',
  `tipo` enum('consulta','revision_diseno','aprobacion','progreso','problema') DEFAULT NULL,
  `mensaje` text NOT NULL,
  `archivosAdjuntos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`archivosAdjuntos`)),
  `fechaEnvio` datetime NOT NULL DEFAULT current_timestamp(),
  `leido` tinyint(1) NOT NULL DEFAULT 0,
  `fechaLectura` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `comunicacionsolicitud`
--

INSERT INTO `comunicacionsolicitud` (`idComunicacion`, `idSolicitud`, `idRemitente`, `idDestinatario`, `canal`, `tipo`, `mensaje`, `archivosAdjuntos`, `fechaEnvio`, `leido`, `fechaLectura`) VALUES
(1, 1, 1, 2, 'Web', 'consulta', 'Hola, ¿cuándo estará listo mi anillo personalizado?', '{}', '2025-11-14 12:00:00', 1, '2025-11-14 12:15:00'),
(2, 1, 2, 1, 'Web', 'progreso', 'Tu pedido está en proceso de grabado', '{\"imagen\":\"progreso.jpg\"}', '2025-11-14 14:30:00', 1, '2025-11-14 15:00:00'),
(3, 2, 3, 4, 'WhatsApp', 'revision_diseno', 'Recibí tu solicitud, revisaré las especificaciones', '{}', '2025-11-13 16:00:00', 0, NULL),
(4, 2, 4, 3, 'WhatsApp', 'aprobacion', 'Se necesitan ajustes en la piedra, te envío propuesta', '{\"documento\":\"propuesta.pdf\"}', '2025-11-13 17:30:00', 1, '2025-11-13 18:00:00'),
(5, 3, 5, 6, 'Email', 'progreso', 'Tu plato está casi listo, será enviado mañana', '{}', '2025-11-12 16:45:00', 1, '2025-11-12 17:00:00'),
(6, 4, 8, 9, 'Web', 'problema', 'La jarra tiene un pequeño defecto, se rehace', '{\"foto\":\"defecto.jpg\"}', '2025-11-14 13:00:00', 1, '2025-11-14 14:15:00'),
(7, 5, 10, 2, 'Telefono', 'consulta', 'Llamada para confirmar detalles de la foto', '{}', '2025-11-14 11:30:00', 1, '2025-11-14 11:45:00'),
(8, 6, 1, 4, 'Email', 'revision_diseno', 'Envío diseño preliminar para revisión', '{\"imagen\":\"diseno-v1.png\"}', '2025-11-13 10:00:00', 1, '2025-11-13 10:30:00'),
(9, 9, 8, 2, 'Web', 'aprobacion', 'Acepto el tejido, procede con la producción', '{}', '2025-11-13 13:15:00', 1, '2025-11-13 14:00:00'),
(10, 10, 10, 4, 'Web', 'consulta', 'Necesito que sea entregado antes del 20 de noviembre', '{}', '2025-11-14 07:45:00', 1, '2025-11-14 08:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historialsolicitud`
--

CREATE TABLE `historialsolicitud` (
  `idHistorial` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `estadoAnterior` varchar(30) NOT NULL,
  `estadoNuevo` varchar(30) NOT NULL,
  `cambiosRealizados` text NOT NULL,
  `fechaCambio` datetime NOT NULL DEFAULT current_timestamp(),
  `motivo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historialsolicitud`
--

INSERT INTO `historialsolicitud` (`idHistorial`, `idSolicitud`, `idUsuario`, `estadoAnterior`, `estadoNuevo`, `cambiosRealizados`, `fechaCambio`, `motivo`) VALUES
(1, 1, 7, 'pendiente', 'revision', 'Asignado a artista', '2025-11-14 10:45:00', 'Revision inicial'),
(2, 1, 7, 'revision', 'aprobado', 'Aprobado por artista', '2025-11-14 10:30:00', 'Cumple especificaciones'),
(3, 2, 7, 'pendiente', 'revision', 'Enviado a revisión', '2025-11-13 15:30:00', 'Evaluación técnica'),
(4, 3, 7, 'aprobado', 'en_produccion', 'Iniciada producción', '2025-11-12 09:15:00', 'Aprobación completada'),
(5, 3, 7, 'en_produccion', 'completado', 'Producción terminada', '2025-11-12 18:00:00', 'Producto listo'),
(6, 4, 7, 'pendiente', 'revision', 'Asignado para revisión', '2025-11-14 09:45:00', 'Evaluación'),
(7, 4, 7, 'revision', 'en_produccion', 'Iniciada producción', '2025-11-14 11:00:00', 'Aprobado técnicamente'),
(8, 6, 7, 'revision', 'aprobado', 'Aprobado por cliente', '2025-11-13 11:15:00', 'Cliente satisfecho'),
(9, 8, 7, 'en_produccion', 'completado', 'Producto completado y enviado', '2025-11-11 14:30:00', 'Entrega realizada'),
(10, 10, 7, 'pendiente', 'aprobado', 'Aprobación directa', '2025-11-14 10:00:00', 'Diseño preaprobado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `idInventario` int(11) NOT NULL,
  `idMaterial` int(11) DEFAULT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `cantidadActual` int(11) NOT NULL DEFAULT 0,
  `cantidadMinima` int(11) NOT NULL DEFAULT 5,
  `cantidadMaxima` int(11) NOT NULL DEFAULT 100,
  `ubicacion` varchar(50) DEFAULT NULL,
  `fechaUltimaActualizacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`idInventario`, `idMaterial`, `idProducto`, `cantidadActual`, `cantidadMinima`, `cantidadMaxima`, `ubicacion`, `fechaUltimaActualizacion`) VALUES
(1, 1, NULL, 45, 5, 100, 'Almacén A - Estante 1', '2025-11-14 09:00:00'),
(2, 2, NULL, 67, 5, 100, 'Almacén A - Estante 2', '2025-11-14 09:15:00'),
(3, 3, NULL, 120, 5, 150, 'Almacén B - Estante 1', '2025-11-14 09:30:00'),
(4, 4, NULL, 85, 5, 100, 'Almacén B - Estante 2', '2025-11-14 09:45:00'),
(5, 5, NULL, 150, 10, 200, 'Almacén C - Estante 1', '2025-11-14 10:00:00'),
(6, NULL, 1, 15, 2, 30, 'Almacén D - Vitrina 1', '2025-11-14 10:15:00'),
(7, NULL, 2, 8, 2, 20, 'Almacén D - Vitrina 2', '2025-11-14 10:30:00'),
(8, NULL, 3, 22, 5, 40, 'Almacén E - Estante 1', '2025-11-14 10:45:00'),
(9, NULL, 4, 12, 3, 25, 'Almacén E - Estante 2', '2025-11-14 11:00:00'),
(10, NULL, 5, 34, 10, 50, 'Almacén F - Estante 1', '2025-11-14 11:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidad`
--

CREATE TABLE `localidad` (
  `idLocalidad` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `zona` enum('Norte','Sur','Oriente','Occidente','Centro','CentroOriente','SurOriente','SurOccidente','NorOccidente') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `localidad`
--

INSERT INTO `localidad` (`idLocalidad`, `nombre`, `zona`) VALUES
(7, 'Bosa', 'SurOccidente'),
(2, 'Chapinero', 'Norte'),
(10, 'Engativá', 'NorOccidente'),
(9, 'Fontibón', 'Occidente'),
(8, 'Kennedy', 'SurOccidente'),
(4, 'San Cristóbal', 'Oriente'),
(3, 'Santa Fe', 'CentroOriente'),
(6, 'Tunjuelito', 'Sur'),
(1, 'Usaquén', 'Norte'),
(5, 'Usme', 'SurOriente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material`
--

CREATE TABLE `material` (
  `idMaterial` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `color` varchar(30) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `caracteristicas` text DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `material`
--

INSERT INTO `material` (`idMaterial`, `nombre`, `tipo`, `color`, `stock`, `caracteristicas`, `activo`) VALUES
(9, 'Algodón Tejido', 'textil', 'blanco', 200, 'Algodón 100% orgánico', 1),
(3, 'Cerámica Blanca', 'cerámica', 'blanco', 120, 'Arcilla blanca de primera calidad', 1),
(4, 'Cerámica Negra', 'cerámica', 'negro', 85, 'Arcilla negra pulida', 1),
(10, 'Cobre', 'metal', 'cobre', 55, 'Cobre puro recubierto de óxido', 1),
(8, 'Cuero Natural', 'cuero', 'marrón', 60, 'Cuero de vaca curtido naturalmente', 1),
(6, 'Madera Cedro', 'madera', 'marrón', 75, 'Madera de cedro aroma, resistente', 1),
(1, 'Oro', 'metal', 'amarillo', 45, 'Oro de 18 kilates, maleable y resistente', 1),
(2, 'Plata', 'metal', 'plateado', 67, 'Plata esterlina 925, excelente brillo', 1),
(5, 'Resina Epóxica', 'resina', 'transparente', 150, 'Resina de dos componentes de alta calidad', 1),
(7, 'Vidrio Soplado', 'vidrio', 'incoloro', 40, 'Vidrio borosilicato soplado a mano', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientoinventario`
--

CREATE TABLE `movimientoinventario` (
  `idMovimiento` int(11) NOT NULL,
  `idInventario` int(11) NOT NULL,
  `tipoMovimiento` enum('Entrada','Salida','Ajuste') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `cantidadAnterior` int(11) NOT NULL,
  `cantidadPosterior` int(11) NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `idSolicitud` int(11) DEFAULT NULL,
  `idArtista` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `movimientoinventario`
--

INSERT INTO `movimientoinventario` (`idMovimiento`, `idInventario`, `tipoMovimiento`, `cantidad`, `cantidadAnterior`, `cantidadPosterior`, `motivo`, `idSolicitud`, `idArtista`, `fecha`, `observaciones`) VALUES
(1, 1, 'Entrada', 20, 25, 45, 'Compra de materia prima', NULL, 2, '2025-11-14 08:30:00', 'Provedor: Minas de Oro S.A.'),
(2, 2, 'Entrada', 15, 52, 67, 'Compra de materia prima', NULL, 4, '2025-11-14 08:45:00', 'Proveedor: Plata Fina Ltd.'),
(3, 3, 'Salida', 12, 132, 120, 'Uso en producción', 3, 6, '2025-11-12 09:00:00', 'Producción de platos personalizados'),
(4, 4, 'Salida', 8, 93, 85, 'Uso en producción', 4, 9, '2025-11-14 09:15:00', 'Producción de jarra personalizada'),
(5, 5, 'Entrada', 30, 120, 150, 'Compra de resina', NULL, 2, '2025-11-14 09:30:00', 'Proveedor: Químicos Industriales Inc.'),
(6, 6, 'Salida', 2, 17, 15, 'Venta de producto', NULL, 2, '2025-11-14 10:00:00', 'Cliente: María García'),
(7, 7, 'Salida', 1, 9, 8, 'Venta de producto', NULL, 4, '2025-11-14 10:15:00', 'Cliente: Carlos López'),
(8, 8, 'Ajuste', 2, 20, 22, 'Corrección de inventario', NULL, 6, '2025-11-14 10:30:00', 'Reconteo de existencias'),
(9, 9, 'Salida', 3, 15, 12, 'Producción de jarras', 4, 9, '2025-11-14 10:45:00', 'Solicitud personalizada'),
(10, 10, 'Entrada', 10, 24, 34, 'Reabastecimiento', NULL, 2, '2025-11-14 11:00:00', 'Compra a proveedor autorizado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pantillapersonalizacion`
--

CREATE TABLE `pantillapersonalizacion` (
  `idPlantilla` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagenPreviewURL` varchar(255) DEFAULT NULL,
  `elementosPersonalizables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`elementosPersonalizables`)),
  `dificultad` enum('baja','media','alta') NOT NULL DEFAULT 'media',
  `modelo3DBaseURL` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pantillapersonalizacion`
--

INSERT INTO `pantillapersonalizacion` (`idPlantilla`, `nombre`, `idProducto`, `descripcion`, `imagenPreviewURL`, `elementosPersonalizables`, `dificultad`, `modelo3DBaseURL`, `activo`) VALUES
(1, 'Anillo Personalizado Básico', 1, 'Personalización básica de anillo con grabado', 'https://yesa.com/preview/anillo-basico.jpg', '{\"elementos\":[\"grabado\",\"tamaño\"]}', 'baja', 'https://modelo3d.yesa.com/anillo-1.obj', 1),
(2, 'Pulsera Personalizada Avanzada', 2, 'Personalización avanzada con múltiples opciones de diseño', 'https://yesa.com/preview/pulsera-avanzada.jpg', '{\"elementos\":[\"largo\",\"ancho\",\"grabado\",\"piedra\"]}', 'alta', 'https://modelo3d.yesa.com/pulsera-2.obj', 1),
(3, 'Plato de Cerámica Estándar', 3, 'Personalización con pintura y detalles básicos', 'https://yesa.com/preview/plato-estandar.jpg', '{\"elementos\":[\"diseño\",\"pintura\",\"borde\"]}', 'media', 'https://modelo3d.yesa.com/plato-3.obj', 1),
(4, 'Jarra Cerámica Premium', 4, 'Personalización premium con técnicas avanzadas', 'https://yesa.com/preview/jarra-premium.jpg', '{\"elementos\":[\"relieve\",\"decoración\",\"grabado\",\"esmalte\"]}', 'alta', 'https://modelo3d.yesa.com/jarra-4.obj', 1),
(5, 'Llavero Resina Simple', 5, 'Personalización simple con foto interior', 'https://yesa.com/preview/llavero-simple.jpg', '{\"elementos\":[\"foto\",\"color base\"]}', 'baja', 'https://modelo3d.yesa.com/llavero-5.obj', 1),
(6, 'Caja Madera Grabado Personalizado', 6, 'Grabado láser personalizado en madera', 'https://yesa.com/preview/caja-grabado.jpg', '{\"elementos\":[\"texto\",\"imagen\",\"diseño\"]}', 'media', 'https://modelo3d.yesa.com/caja-6.obj', 1),
(7, 'Vaso Vidrio Soplado Decorativo', 7, 'Decoración del vaso con técnica de pintura', 'https://yesa.com/preview/vaso-decorativo.jpg', '{\"elementos\":[\"patrón\",\"color\",\"espesor\"]}', 'alta', 'https://modelo3d.yesa.com/vaso-7.obj', 1),
(8, 'Cinturón Cuero Grabado Premium', 8, 'Grabado y personalización premium en cuero', 'https://yesa.com/preview/cinturon-premium.jpg', '{\"elementos\":[\"patrón grabado\",\"nombre\",\"fecha\"]}', 'alta', 'https://modelo3d.yesa.com/cinturon-8.obj', 1),
(9, 'Tapestry Tejido Personalizado', 9, 'Personalización de patrón y colores en tejido', 'https://yesa.com/preview/tapestry-personal.jpg', '{\"elementos\":[\"patrón\",\"colores\",\"tamaño\"]}', 'alta', 'https://modelo3d.yesa.com/tapestry-9.obj', 1),
(10, 'Colgante Cobre Simple', 10, 'Personalización simple de colgante', 'https://yesa.com/preview/colgante-simple.jpg', '{\"elementos\":[\"forma\",\"grabado\"]}', 'baja', 'https://modelo3d.yesa.com/colgante-10.obj', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `idMaterial` int(11) NOT NULL,
  `dimenciones` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `imagenURL` varchar(255) DEFAULT NULL,
  `tiempoFabricacion` int(11) NOT NULL DEFAULT 7,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `nombre`, `idCategoria`, `idMaterial`, `dimenciones`, `modelo`, `descripcion`, `imagenURL`, `tiempoFabricacion`, `activo`) VALUES
(1, 'Anillo de Oro Personalizado', 1, 1, '2cm diámetro', 'A-001', 'Anillo de oro de 18 quilates con personalización', 'https://yesa.com/img/anillo-oro.jpg', 7, 1),
(2, 'Pulsera de Plata Elegante', 1, 2, '20cm largo', 'P-002', 'Pulsera de plata esterlina con diseño moderno', 'https://yesa.com/img/pulsera-plata.jpg', 5, 1),
(3, 'Plato de Cerámica Decorativo', 2, 3, '30cm diámetro', 'C-003', 'Plato de cerámica blanca pintado a mano', 'https://yesa.com/img/plato-ceramica.jpg', 10, 1),
(4, 'Jarra de Cerámica Negra', 2, 4, '25cm alto', 'J-004', 'Jarra artesanal de cerámica negra', 'https://yesa.com/img/jarra-ceramica.jpg', 8, 1),
(5, 'Llavero de Resina Epóxica', 8, 5, '5cm', 'L-005', 'Llavero personalizable con fotos en resina', 'https://yesa.com/img/llavero-resina.jpg', 3, 1),
(6, 'Caja de Madera Cedro', 5, 6, '20x15x10cm', 'CJ-006', 'Caja de cedro con grabado personalizado', 'https://yesa.com/img/caja-madera.jpg', 6, 1),
(7, 'Vaso de Vidrio Soplado', 6, 7, '10cm alto', 'V-007', 'Vaso artesanal de vidrio soplado', 'https://yesa.com/img/vaso-vidrio.jpg', 4, 1),
(8, 'Cinturón de Cuero Grabado', 7, 8, '110cm largo', 'CIN-008', 'Cinturón de cuero con grabado personalizado', 'https://yesa.com/img/cinturon-cuero.jpg', 5, 1),
(9, 'Tapestry Tejido a Mano', 4, 9, '100x80cm', 'TP-009', 'Tapete tejido en algodón 100% orgánico', 'https://yesa.com/img/tapete-tejido.jpg', 12, 1),
(10, 'Colgante de Cobre', 3, 10, '4cm', 'CG-010', 'Colgante artesanal de cobre pulido', 'https://yesa.com/img/colgante-cobre.jpg', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `revisionartista`
--

CREATE TABLE `revisionartista` (
  `idRevision` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `idArtista` int(11) NOT NULL,
  `fechaRevision` datetime NOT NULL DEFAULT current_timestamp(),
  `tiempoEstimado` int(11) DEFAULT NULL,
  `factibilidad` enum('factible','modificaciones','no_factible') NOT NULL,
  `modificacionesSugeridas` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `revisionartista`
--

INSERT INTO `revisionartista` (`idRevision`, `idSolicitud`, `idArtista`, `fechaRevision`, `tiempoEstimado`, `factibilidad`, `modificacionesSugeridas`, `observaciones`) VALUES
(1, 1, 2, '2025-11-14 11:00:00', 7, 'factible', NULL, 'Diseño simple, se puede ejecutar sin problemas'),
(2, 2, 4, '2025-11-13 16:00:00', 8, 'modificaciones', 'Reducir tamaño de piedra un 20%', 'Piedra muy grande para el ancho solicitado'),
(3, 3, 6, '2025-11-12 10:30:00', 10, 'factible', NULL, 'Cliente requiere envío urgente'),
(4, 4, 9, '2025-11-14 10:15:00', 12, 'factible', NULL, 'Requiere técnica de vidriado especial'),
(5, 5, 2, '2025-11-14 11:30:00', 3, 'factible', NULL, 'Foto está en buen tamaño'),
(6, 6, 4, '2025-11-13 12:00:00', 6, 'factible', NULL, 'Grabado láser disponible'),
(7, 7, 6, '2025-11-14 09:30:00', 5, 'modificaciones', 'Usar pintura resistente al agua', 'Color rojo puede desteñirse'),
(8, 8, 9, '2025-11-10 10:15:00', 5, 'factible', NULL, 'Grabado simple, entrega rápida posible'),
(9, 9, 2, '2025-11-13 13:00:00', 14, 'factible', NULL, 'Tejido requiere más tiempo'),
(10, 10, 4, '2025-11-14 10:30:00', 4, 'factible', NULL, 'Colgante simple de ejecutar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudpersonalizacion`
--

CREATE TABLE `solicitudpersonalizacion` (
  `idSolicitud` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `idPlantilla` int(11) NOT NULL,
  `archivoClienteURL` varchar(255) DEFAULT NULL,
  `especificaciones` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`especificaciones`)),
  `modelo3DPersonalizadoURL` varchar(255) DEFAULT NULL,
  `estado` enum('pendiente','revision','aprobado','en_produccion','completado','cancelado') NOT NULL DEFAULT 'pendiente',
  `fechaAprobacion` datetime DEFAULT NULL,
  `instruccionesEspeciales` text DEFAULT NULL,
  `fechaSolicitud` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `solicitudpersonalizacion`
--

INSERT INTO `solicitudpersonalizacion` (`idSolicitud`, `idCliente`, `idProducto`, `idPlantilla`, `archivoClienteURL`, `especificaciones`, `modelo3DPersonalizadoURL`, `estado`, `fechaAprobacion`, `instruccionesEspeciales`, `fechaSolicitud`) VALUES
(1, 1, 1, 1, 'https://archivos.yesa.com/cliente1-solicitud1.pdf', '{\"grabado\":\"Juan P.\",\"tamaño\":\"7\"}', 'https://modelo3d.yesa.com/personal-1-1.obj', 'aprobado', '2025-11-14 10:30:00', 'Grabar iniciales en interior', '2025-11-14 08:15:00'),
(2, 3, 2, 2, 'https://archivos.yesa.com/cliente3-solicitud2.pdf', '{\"largo\":\"20\",\"ancho\":\"1.5\",\"piedra\":\"diamante\"}', 'https://modelo3d.yesa.com/personal-2-1.obj', 'revision', NULL, 'Incluir bolsa de satén', '2025-11-13 14:20:00'),
(3, 5, 3, 3, 'https://archivos.yesa.com/cliente5-solicitud3.pdf', '{\"diseño\":\"floral\",\"pintura\":\"azul\"}', 'https://modelo3d.yesa.com/personal-3-1.obj', 'completado', '2025-11-12 09:00:00', 'Frágil', '2025-11-11 10:45:00'),
(4, 8, 4, 4, 'https://archivos.yesa.com/cliente8-solicitud4.pdf', '{\"relieve\":\"profundo\",\"esmalte\":\"brillante\"}', 'https://modelo3d.yesa.com/personal-4-1.obj', 'en_produccion', NULL, 'Vidriado especial', '2025-11-14 09:30:00'),
(5, 10, 5, 5, 'https://archivos.yesa.com/cliente10-solicitud5.pdf', '{\"foto\":\"familia.jpg\",\"color\":\"azul cielo\"}', 'https://modelo3d.yesa.com/personal-5-1.obj', 'pendiente', NULL, 'Foto de 2x2cm', '2025-11-14 11:00:00'),
(6, 1, 6, 6, 'https://archivos.yesa.com/cliente1-solicitud6.pdf', '{\"texto\":\"Mi nombre\",\"imagen\":\"logo.png\"}', 'https://modelo3d.yesa.com/personal-6-1.obj', 'aprobado', '2025-11-13 11:15:00', 'Grabado láser', '2025-11-12 16:20:00'),
(7, 3, 7, 7, 'https://archivos.yesa.com/cliente3-solicitud7.pdf', '{\"patrón\":\"geométrico\",\"color\":\"rojo\"}', 'https://modelo3d.yesa.com/personal-7-1.obj', 'revision', NULL, 'Pintura especial', '2025-11-14 08:45:00'),
(8, 5, 8, 8, 'https://archivos.yesa.com/cliente5-solicitud8.pdf', '{\"patrón\":\"iniciales\",\"nombre\":\"Carlos\"}', 'https://modelo3d.yesa.com/personal-8-1.obj', 'completado', '2025-11-11 14:30:00', 'Entrega urgente', '2025-11-10 09:00:00'),
(9, 8, 9, 9, 'https://archivos.yesa.com/cliente8-solicitud9.pdf', '{\"patrón\":\"nativo\",\"colores\":[\"azul\",\"blanco\"]}', 'https://modelo3d.yesa.com/personal-9-1.obj', 'en_produccion', NULL, 'Empacar con cuidado', '2025-11-13 12:00:00'),
(10, 10, 10, 10, 'https://archivos.yesa.com/cliente10-solicitud10.pdf', '{\"forma\":\"redonda\",\"grabado\":\"SOS\"}', 'https://modelo3d.yesa.com/personal-10-1.obj', 'aprobado', '2025-11-14 10:00:00', 'Regalo especial', '2025-11-14 07:30:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(64) NOT NULL,
  `rol` enum('Cliente','Artista','Administrador') NOT NULL,
  `fechaRegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombre`, `correo`, `contraseña`, `rol`, `fechaRegistro`, `activo`) VALUES
(4, 'Ana Rodríguez', 'ana.rodriguez@yesa.com', 'sha256hash4', 'Artista', '2025-11-13 11:20:00', 1),
(3, 'Carlos López', 'carlos.lopez@yesa.com', 'sha256hash3', 'Cliente', '2025-11-12 10:45:00', 1),
(8, 'Carmen Díaz', 'carmen.diaz@yesa.com', 'sha256hash8', 'Cliente', '2025-11-11 14:15:00', 1),
(7, 'Fernando Torres', 'fernando.torres@yesa.com', 'sha256hash7', 'Administrador', '2025-11-09 07:00:00', 1),
(10, 'Gabriela Flores', 'gabriela.flores@yesa.com', 'sha256hash10', 'Cliente', '2025-11-13 16:30:00', 1),
(1, 'Juan Pérez', 'juan.perez@yesa.com', 'sha256hash1', 'Cliente', '2025-11-10 08:30:00', 1),
(5, 'Luis Martínez', 'luis.martinez@yesa.com', 'sha256hash5', 'Cliente', '2025-11-14 08:00:00', 1),
(2, 'María García', 'maria.garcia@yesa.com', 'sha256hash2', 'Artista', '2025-11-11 09:15:00', 1),
(6, 'Patricia Sánchez', 'patricia.sanchez@yesa.com', 'sha256hash6', 'Artista', '2025-11-10 12:30:00', 1),
(11, 'pepe ', 'ppeppe@gmail.com', 'elpepe311', 'Cliente', '2025-11-27 11:47:01', 1),
(9, 'Roberto Gómez', 'roberto.gomez@yesa.com', 'sha256hash9', 'Artista', '2025-11-12 09:45:00', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
