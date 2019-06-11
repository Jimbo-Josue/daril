-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 11-06-2019 a las 23:08:14
-- Versión del servidor: 10.3.15-MariaDB
-- Versión de PHP: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cq`
--

CREATE DATABASE cq
USE cq

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Contact`
--

CREATE TABLE `Contact` (
  `idContact` int(11) NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `idUserContact` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Contact`
--

INSERT INTO `Contact` (`idContact`, `idUser`, `idUserContact`) VALUES
(1, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Email`
--

CREATE TABLE `Email` (
  `idEmail` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Email`
--

INSERT INTO `Email` (`idEmail`, `email`) VALUES
(1, 'deltainit@gmail.com'),
(2, 'netwide.net@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Groups`
--

CREATE TABLE `Groups` (
  `idGroup` int(11) NOT NULL,
  `idContact` int(11) DEFAULT NULL,
  `idRoom` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Groups`
--

INSERT INTO `Groups` (`idGroup`, `idContact`, `idRoom`) VALUES
(5, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Message`
--

CREATE TABLE `Message` (
  `idMessage` int(11) NOT NULL,
  `message` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idRoom` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Room`
--

CREATE TABLE `Room` (
  `idRoom` int(11) NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Room`
--

INSERT INTO `Room` (`idRoom`, `idUser`, `name`) VALUES
(1, 1, 'FRIENDS'),
(2, 1, 'HELLO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

CREATE TABLE `User` (
  `idUser` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idEmail` int(11) DEFAULT NULL,
  `claveApi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `User`
--

INSERT INTO `User` (`idUser`, `name`, `password`, `idEmail`, `claveApi`) VALUES
(1, 'Jimmy Josue', '$2y$10$Js88YC0M6UFzbIRBUmaj7OGeRgHRYyR.NMT9NMu7TJTLE8/rulBP6', 1, 'a1ae417f299eda24368d457cdb56068b'),
(2, 'Jasmin Ephifania', '$2y$10$QJcqKqJwMtl/xCYvH/r16.5Lm.DYniT5avRT/ptD0r/TrHiAKpOx.', 2, '30411f0b7ec1d601a6c1857976b3f146');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Contact`
--
ALTER TABLE `Contact`
  ADD PRIMARY KEY (`idContact`),
  ADD KEY `fk_contact01` (`idUser`),
  ADD KEY `fk_contact02` (`idUserContact`);

--
-- Indices de la tabla `Email`
--
ALTER TABLE `Email`
  ADD PRIMARY KEY (`idEmail`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `Groups`
--
ALTER TABLE `Groups`
  ADD PRIMARY KEY (`idGroup`),
  ADD KEY `idContact` (`idContact`),
  ADD KEY `idRoom` (`idRoom`);

--
-- Indices de la tabla `Message`
--
ALTER TABLE `Message`
  ADD PRIMARY KEY (`idMessage`),
  ADD KEY `fk_message01` (`idRoom`),
  ADD KEY `fk_message02` (`idUser`);

--
-- Indices de la tabla `Room`
--
ALTER TABLE `Room`
  ADD PRIMARY KEY (`idRoom`),
  ADD KEY `fk_room01` (`idUser`);

--
-- Indices de la tabla `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`idUser`),
  ADD KEY `fk_user01` (`idEmail`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Contact`
--
ALTER TABLE `Contact`
  MODIFY `idContact` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `Email`
--
ALTER TABLE `Email`
  MODIFY `idEmail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Groups`
--
ALTER TABLE `Groups`
  MODIFY `idGroup` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `Message`
--
ALTER TABLE `Message`
  MODIFY `idMessage` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Room`
--
ALTER TABLE `Room`
  MODIFY `idRoom` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `User`
--
ALTER TABLE `User`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Contact`
--
ALTER TABLE `Contact`
  ADD CONSTRAINT `fk_contact01` FOREIGN KEY (`idUser`) REFERENCES `User` (`idUser`),
  ADD CONSTRAINT `fk_contact02` FOREIGN KEY (`idUserContact`) REFERENCES `User` (`idUser`);

--
-- Filtros para la tabla `Groups`
--
ALTER TABLE `Groups`
  ADD CONSTRAINT `Groups_ibfk_1` FOREIGN KEY (`idContact`) REFERENCES `Contact` (`idContact`),
  ADD CONSTRAINT `Groups_ibfk_2` FOREIGN KEY (`idRoom`) REFERENCES `Room` (`idRoom`);

--
-- Filtros para la tabla `Message`
--
ALTER TABLE `Message`
  ADD CONSTRAINT `fk_message01` FOREIGN KEY (`idRoom`) REFERENCES `Room` (`idRoom`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_message02` FOREIGN KEY (`idUser`) REFERENCES `User` (`idUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Room`
--
ALTER TABLE `Room`
  ADD CONSTRAINT `fk_room01` FOREIGN KEY (`idUser`) REFERENCES `User` (`idUser`);

--
-- Filtros para la tabla `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `fk_user01` FOREIGN KEY (`idEmail`) REFERENCES `Email` (`idEmail`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
