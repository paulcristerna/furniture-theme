-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-04-2016 a las 05:06:34
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `tienda_muebles`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE IF NOT EXISTS `carrito` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `usuario` int(11) unsigned NOT NULL,
  `producto` int(11) unsigned NOT NULL,
  `cantidad` decimal(7,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario` (`usuario`),
  KEY `producto` (`producto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id`, `usuario`, `producto`, `cantidad`) VALUES
(1, 2, 2, '1.00'),
(2, 2, 1, '1.00'),
(3, 2, 3, '1.00'),
(4, 3, 1, '1.00'),
(5, 3, 2, '2.00'),
(6, 3, 2, '1.00'),
(7, 3, 2, '1.00'),
(8, 9, 2, '1.00'),
(9, 9, 1, '1.00'),
(10, 3, 2, '1.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `imagen` varchar(15) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `marca` varchar(25) NOT NULL,
  `precio` decimal(7,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `imagen`, `titulo`, `marca`, `precio`) VALUES
(1, 'img/1.jpg', 'Desayunador Alicante', 'HOME NATURE', '6499.00'),
(2, 'img/2.jpg', 'Recamara de 3 Piezas Biko Tabaco', 'HOME NATURE', '6299.00'),
(3, 'img/3.jpg', 'Loveseat Cute-Button', 'HOME NATURE', '5999.00'),
(4, 'img/4.jpg', 'Comoda Estandar Biko Color Nogal', 'HOME NATURE', '5759.00'),
(5, 'img/5.jpg', 'Mesa Antecomedor Anabela', 'HOME NATURE', '5399.00'),
(6, 'img/6.jpg', 'Esquinero', 'HOME NATURE', '5399.00'),
(7, 'img/7.jpg', 'Escritorio Tabaco Dublin 3 Cajones Blancos', 'HOME NATURE', '5399.00'),
(8, 'img/8.jpg', 'Sillon Brazo Derecho', 'HOME NATURE', '4949.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  `apellidoPaterno` varchar(25) NOT NULL,
  `apellidoMaterno` varchar(25) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `rfc` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `direccion`, `rfc`, `email`, `password`) VALUES
(2, 'olivier paul', 'cristerna', 'leyva', 'fraccionamiento san carlos, calle sierra madre del carmen, numero 1068, culiacan, sinaloa.', 'sffdfg544', 'olivierpaulcristerna@gmail.com', 'olg1PL0ZE2wgY'),
(3, 'maria', 'lopez', 'perez', 'colonia las quintas, calle isla del tiburon, 455, centro, culiacan, sinaloa.', 'fdfdd556789', 'maria@gmail.com', 'ma8fBxxUOY2RY'),
(4, 'gloria', 'lopez', 'perez', 'colonia centro, calle miguel hidalgo, numero 467, culiacan, sinaloa.', 'gldgsfd43x', 'gloria@hotmail.com', 'glfktD844Dq/U'),
(5, 'andrea', 'lopez', 'perez', 'colonia centro, calle benito juarez, numero 658, culiacan, sinaloa.', 'trdnjgy643e', 'andrea@hotmail.com', 'an1Jk7au2nUgA'),
(6, 'juan', 'lopez', 'perez', 'colonia independencia, calle 8, culiacan, sinaloa.', 'abndgrjt563r', 'juan@gmail.com', 'juMGf0mCJhnvc'),
(7, 'miguel', 'lopez', 'perez', 'colonia san miguel, calle primera, culiacan, sinaloa.', 'agssert4re3', 'miguel@hotmail.com', 'miTF5KM/1uCw2'),
(9, 'sergio', 'lopez', 'perez', 'colonia san rafael, calle conocida 5677, culiacan, sinaloa.', 'cdfgbet5436', 'sergio@gmail.com', 'seu.8HpuOxyTU');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
