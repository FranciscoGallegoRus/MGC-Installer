CREATE DATABASE  IF NOT EXISTS `mgc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mgc`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mgc
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `albaran`
--

DROP TABLE IF EXISTS `albaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albaran` (
  `id` int NOT NULL AUTO_INCREMENT,
  `archivo` longblob NOT NULL,
  `factura` varchar(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_albaran_factura_idx` (`factura`),
  CONSTRAINT `fk_albaran_factura` FOREIGN KEY (`factura`) REFERENCES `factura` (`n_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cif` varchar(9) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `dir_fiscal` varchar(500) NOT NULL,
  `cp_ciudad` varchar(500) NOT NULL,
  `dir_postal` varchar(500) DEFAULT NULL,
  `certificado_hacienda` longblob,
  `valoracion` int NOT NULL DEFAULT '6',
  `caducidad_certificado` date DEFAULT NULL,
  `num_transnet` varchar(45) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `correo2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `texto` varchar(500) NOT NULL,
  `cliente` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comentario_cliente_idx` (`cliente`),
  CONSTRAINT `fk_comentario_cliente` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`cif`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `n_factura` varchar(8) NOT NULL,
  `fecha_entrega` date NOT NULL,
  `importe` decimal(7,2) NOT NULL,
  `iva` decimal(7,2) NOT NULL,
  `retencion` decimal(7,2) NOT NULL,
  `cliente` varchar(9) NOT NULL,
  `fecha_cobro` date NOT NULL,
  `cobrado` tinyint NOT NULL DEFAULT '0',
  `fecha_cobrado` date DEFAULT NULL,
  `fecha_recibido` date DEFAULT NULL,
  PRIMARY KEY (`n_factura`),
  KEY `fk_factura_cliente_idx` (`cliente`),
  CONSTRAINT `fk_factura_cliente` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`cif`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gasto`
--

DROP TABLE IF EXISTS `gasto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gasto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bi` decimal(6,2) NOT NULL,
  `importe` decimal(6,2) NOT NULL,
  `iva` decimal(6,2) NOT NULL,
  `fecha` date NOT NULL,
  `proveedor` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gasto_proveedor_idx` (`proveedor`),
  CONSTRAINT `fk_gasto_proveedor` FOREIGN KEY (`proveedor`) REFERENCES `proveedor` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `nombre` varchar(150) NOT NULL,
  `cif` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `viaje`
--

DROP TABLE IF EXISTS `viaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viaje` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha_carga` date NOT NULL,
  `fecha_descarga` date NOT NULL,
  `origen` varchar(100) NOT NULL,
  `destino` varchar(100) NOT NULL,
  `precio` decimal(7,2) NOT NULL,
  `otro` varchar(50) DEFAULT NULL,
  `factura` varchar(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_viaje_factura_idx` (`factura`),
  CONSTRAINT `fk_viaje_factura` FOREIGN KEY (`factura`) REFERENCES `factura` (`n_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'mgc'
--
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDatosAnuales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDatosAnuales`(
	IN anio INT,
    OUT suma_bi DECIMAL(10, 2),
    OUT suma_importe DECIMAL(10, 2),
    OUT suma_iva DECIMAL(10, 2),
    OUT suma_retencion DECIMAL(10, 2)
)
BEGIN
	SET suma_bi = 0;
    SET suma_importe = 0;
    SET suma_iva = 0;
    SET suma_retencion = 0;

	SELECT SUM(v.precio) INTO suma_bi
    FROM viaje v
    JOIN factura f ON v.factura = f.n_factura
    WHERE YEAR(fecha_entrega) = anio;

	SELECT SUM(f.importe), SUM(f.iva), SUM(f.retencion)
    INTO suma_importe, suma_iva, suma_retencion
    FROM factura f
    WHERE YEAR(fecha_entrega) = anio;    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDatosCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDatosCliente`(
    IN cif_cliente VARCHAR(20),
    OUT suma_bi DECIMAL(10, 2),
    OUT suma_importe DECIMAL(10, 2),
    OUT suma_iva DECIMAL(10, 2),
    OUT suma_retencion DECIMAL(10, 2),
    OUT num_facturas INT
)
BEGIN
	SET suma_bi = 0;
    SET suma_importe = 0;
    SET suma_iva = 0;
    SET suma_retencion = 0;
    SET num_facturas = 0;

    
	SELECT SUM(v.precio) INTO suma_bi
    FROM viaje v
    JOIN factura f ON v.factura = f.n_factura
    WHERE f.cliente = cif_cliente;

	SELECT SUM(f.importe), SUM(f.iva), SUM(f.retencion)
    INTO suma_importe, suma_iva, suma_retencion
    FROM factura f
    WHERE f.cliente = cif_cliente;
    
    SELECT COUNT(*) INTO num_facturas
    FROM factura f
	WHERE f.cliente = cif_cliente;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDatosCostesAnuales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDatosCostesAnuales`(
	IN anio INT,
    OUT suma_bi DECIMAL(10, 2),
    OUT suma_importe DECIMAL(10, 2),
    OUT suma_iva DECIMAL(10, 2)
)
BEGIN
	SET suma_bi = 0;
    SET suma_importe = 0;
    SET suma_iva = 0;

	SELECT SUM(importe)
    INTO suma_importe
    FROM gasto
    WHERE YEAR(fecha) = anio;
    
	SELECT SUM(iva)
    INTO suma_iva
    FROM gasto
    WHERE YEAR(fecha) = anio;
	
    SELECT SUM(bi)
    INTO suma_bi
    FROM gasto
    WHERE YEAR(fecha) = anio;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDatosCostesProv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDatosCostesProv`(
	IN anio INT,
    IN prov VARCHAR(150),
    OUT suma_bi DECIMAL(10, 2),
    OUT suma_importe DECIMAL(10, 2),
    OUT suma_iva DECIMAL(10, 2)
)
BEGIN
	SET suma_bi = 0;
    SET suma_importe = 0;
    SET suma_iva = 0;

	SELECT SUM(importe)
    INTO suma_importe
    FROM gasto
    WHERE YEAR(fecha) = anio
    AND proveedor = prov;

	SELECT SUM(iva)
    INTO suma_iva
    FROM gasto
    WHERE YEAR(fecha) = anio
    AND proveedor = prov;
	
    SELECT SUM(bi)
    INTO suma_bi
    FROM gasto
    WHERE YEAR(fecha) = anio
    AND proveedor = prov;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDatosGastosAnuales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDatosGastosAnuales`(
	IN anio INT,
    OUT suma_bi DECIMAL(10, 2),
    OUT suma_importe DECIMAL(10, 2),
    OUT suma_iva DECIMAL(10, 2)
)
BEGIN
	SET suma_bi = 0;
    SET suma_importe = 0;
    SET suma_iva = 0;

	SELECT SUM(importe)
    INTO suma_importe
    FROM gasto
    WHERE YEAR(fecha) = anio;
    
	SELECT SUM(iva)
    INTO suma_iva
    FROM gasto
    WHERE YEAR(fecha) = anio;
	
    SELECT SUM(bi)
    INTO suma_bi
    FROM gasto
    WHERE YEAR(fecha) = anio;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDatosMes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDatosMes`(
	IN anio INT,
	IN mes INT,
    OUT suma_bi DECIMAL(10, 2),
    OUT suma_importe DECIMAL(10, 2),
    OUT suma_iva DECIMAL(10, 2),
    OUT suma_retencion DECIMAL(10, 2)
)
BEGIN
	SET suma_bi = 0;
    SET suma_importe = 0;
    SET suma_iva = 0;
    SET suma_retencion = 0;

	SELECT SUM(v.precio) INTO suma_bi
    FROM viaje v
    JOIN factura f ON v.factura = f.n_factura
    WHERE MONTH(fecha_entrega) = mes
    AND YEAR(fecha_entrega) = anio;

	SELECT SUM(f.importe), SUM(f.iva), SUM(f.retencion)
    INTO suma_importe, suma_iva, suma_retencion
    FROM factura f
    WHERE month(fecha_entrega) = mes
    AND YEAR(fecha_entrega) = anio;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-31 18:10:00
