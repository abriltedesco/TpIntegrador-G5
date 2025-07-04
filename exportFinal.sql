-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: TPintegrador
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.1

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idCategoria` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Electrónica'),(2,'Ropa'),(3,'Hogar'),(4,'Deportes'),(5,'Libros'),(6,'Automotriz'),(7,'Salud y Belleza'),(8,'Jardinería'),(9,'Arte'),(10,'Mascotas');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentario` (
  `idComentario` int NOT NULL,
  `idPublicacion` int NOT NULL,
  `pregunta` longtext,
  `idUsuarioPregunta` int DEFAULT NULL,
  `respuesta` longtext,
  `fecha` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idComentario`),
  KEY `fk_comentario_publicacion1_idx` (`idPublicacion`),
  KEY `fk_comentario_usuario_idx` (`idUsuarioPregunta`),
  CONSTRAINT `fk_comentario_publicacion1` FOREIGN KEY (`idPublicacion`) REFERENCES `publicacion` (`idPublicacion`),
  CONSTRAINT `fk_comentario_usuario` FOREIGN KEY (`idUsuarioPregunta`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentario`
--

LOCK TABLES `comentario` WRITE;
/*!40000 ALTER TABLE `comentario` DISABLE KEYS */;
INSERT INTO `comentario` VALUES (1,1,'¿El producto es nuevo y sellado?',2,'Sí, completamente nuevo y sellado.','2024-01-02'),(2,2,'¿Qué tallas están disponibles?',3,'Tenemos M, L y XL.','2025-06-18'),(3,3,'¿Realizan envíos a todo el país?',4,'Sí, enviamos a todo el país.','2024-01-11'),(4,4,'¿El precio es negociable?',5,'El precio publicado es el final.','2024-01-13'),(5,5,'¿Tienen stock para entrega inmediata?',6,'Sí, tenemos stock para envío inmediato.','2024-01-16'),(6,6,'¿El producto es compatible con Android?',1,'Sí, es compatible con Android 10 o superior.','2024-01-19'),(7,7,'¿La tela es transpirable?',2,'Sí, es un tejido técnico muy transpirable.','2024-01-21'),(8,8,'¿Qué tipo de algodón es?',3,'Algodón Pima de alta calidad.','2024-01-23'),(9,9,'¿Es apta para uso en exteriores?',4,'Sí, es resistente al agua y al desgaste.','2024-01-26'),(10,10,'¿Es una edición de bolsillo?',5,'No, es la edición de tapa dura.','2024-01-29'),(11,11,'¿Cuál es la autonomía de la batería?',6,'Aproximadamente 8 horas de uso continuo.','2024-02-02'),(12,12,'¿El buzo tiene bolsillos laterales?',7,'Sí, tiene dos bolsillos frontales.','2024-02-04'),(13,13,'¿Las toallas sueltan pelusa?',8,'Es de acero inoxidable reini','2024-02-06'),(14,14,'¿Es original o réplica?',9,'Es un producto 100% original con licencia oficial.','2024-02-08'),(15,15,'¿El libro incluye separador?',10,'Sí, incluye un separador de diseño exclusivo.','2024-02-10'),(16,16,'¿La correa es apta para perros grandes?',11,'No, es para perros pequeños y medianos.','2024-02-13'),(17,17,'¿Viene con estuche de carga?',12,'Sí, incluye un estuche de carga portátil.','2024-02-16'),(18,18,'¿Qué juegos incluye?',13,'No incluye juegos, se venden por separado.','2024-02-19'),(19,19,'¿Es café molido o en grano?',14,'Viene en grano para moler en casa.','2024-02-21'),(20,20,'¿Las teclas son silenciosas?',15,'No, es un teclado mecánico con sonido de click.','2024-02-23'),(21,21,'¿El drone incluye batería extra?',22,'No, la batería extra se vende por separado.','2024-03-02'),(22,21,'¿Es fácil de volar para principiantes?',23,'Sí, tiene modos de vuelo asistidos para principiantes.','2024-03-03'),(23,22,'¿Qué tipo de pisada es recomendable?',24,'Es ideal para pisada neutra.','2024-03-06'),(24,23,'¿Tiene función de autovaciado?',25,'Este modelo no, pero otros de la marca sí.','2024-03-09'),(25,24,'¿El precio es por una o por el par?',26,'El precio es por el par de mancuernas.','2024-03-11'),(26,25,'¿Las hojas son a color o blanco y negro?',27,'Son a color, con ilustraciones de alta calidad.','2024-03-13'),(27,25,'¿Viene con garantía?',28,'Sí, garantía de un año directamente con el fabricante.','2024-03-16'),(28,22,'¿Es un libro de bolsillo o tapa dura?',21,'Es un libro de bolsillo.','2024-04-19'),(29,1,'¿Incluye control remoto?',3,'Sí, se entrega con control y batería.','2024-06-02'),(30,2,'¿Está disponible en otros colores?',5,'Sí, tenemos azul y gris.','2024-06-03'),(31,3,'¿La app es compatible con iOS?',7,'Sí, funciona con iOS y Android.','2024-06-04'),(32,4,'¿Cuál es el peso total del set?',6,'Aproximadamente 15kg.','2024-06-05'),(33,5,'¿La colección está completa?',8,'Sí, son los 10 tomos originales.','2024-06-06'),(34,6,'¿Qué garantía tiene?',9,'6 meses directamente con el fabricante.','2024-06-07'),(35,7,'¿Se puede retirar en persona?',10,'Sí, coordinamos por mensaje privado.','2024-06-08'),(36,8,'¿Vienen con tapas de vidrio?',12,'Sí, cada olla tiene su tapa.','2024-06-09'),(37,9,'¿Qué rodado tiene la bicicleta?',13,'Es rodado 29.','2024-06-10'),(38,10,'¿Son inalámbricos?',14,'Sí, y tienen cancelación activa de ruido.','2024-06-11'),(39,11,'¿Qué herramientas incluye?',15,'Desde martillo hasta destornilladores de precisión.','2024-06-12'),(40,12,'¿Se hacen envíos al interior?',16,'Sí, usamos Correo Argentino y OCA.','2024-06-13'),(41,13,'¿Es de cerámica o acero inoxidable?',17,'Es de acero inoxidable reini','2024-06-14'),(42,14,'¿Qué cantidad de semillas trae?',18,NULL,'2024-06-15'),(43,15,'¿Se pueden lavar los pinceles?',19,'Sí, son reutilizables y fáciles de limpiar.','2024-06-16'),(44,42,'dfffsf',9,'ddsf','2025-06-19'),(45,45,'¡holA?',14,'chau','2025-04-01');
/*!40000 ALTER TABLE `comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `idPublicacion` int NOT NULL,
  `idVentaDirecta` int NOT NULL,
  `idComprador` int NOT NULL,
  `satisfaccionC` int DEFAULT NULL,
  `satisfaccionV` int DEFAULT NULL,
  PRIMARY KEY (`idPublicacion`),
  KEY `fk_usuario_has_publicacion_publicacion1_idx` (`idPublicacion`),
  KEY `fk_usuario_has_publicacion_usuario1_idx` (`idComprador`),
  KEY `fk_compra_ventaDirecta1_idx` (`idVentaDirecta`),
  CONSTRAINT `fk_compra_ventaDirecta1` FOREIGN KEY (`idVentaDirecta`) REFERENCES `ventaDirecta` (`idVentaDirecta`),
  CONSTRAINT `fk_usuario_has_publicacion_publicacion1` FOREIGN KEY (`idPublicacion`) REFERENCES `publicacion` (`idPublicacion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_usuario_has_publicacion_usuario1` FOREIGN KEY (`idComprador`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (9,1,2,5,4),(10,2,3,4,5),(11,3,4,3,3),(12,4,5,2,2),(13,5,6,5,5),(14,6,7,4,2),(15,7,8,5,4),(16,8,9,3,3),(17,9,10,2,5),(18,10,11,5,4),(19,11,12,4,4),(20,12,13,5,5),(21,13,14,3,2),(22,14,15,2,3),(23,15,16,5,4),(24,16,17,4,5),(25,17,18,5,3),(30,18,5,4,2),(31,19,1,3,2),(32,20,33,5,1),(33,21,16,1,2),(34,22,18,2,1),(35,23,28,3,2),(36,24,3,1,2),(37,25,9,3,2),(38,26,9,5,5),(39,27,11,4,3),(42,28,11,5,4),(43,29,20,3,4),(45,30,13,2,1);
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado` (
  `idEstado` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'Pendiente de Pago'),(2,'Procesando'),(3,'Enviado'),(4,'Entregado'),(5,'Cancelado'),(6,'Reembolsado'),(7,'Devuelto'),(8,'En Espera'),(9,'Fallido'),(10,'Completado'),(11,'Finalizada'),(12,'Pausada');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial`
--

DROP TABLE IF EXISTS `historial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial` (
  `idHistorial` int NOT NULL,
  `montoOfertado` float DEFAULT NULL,
  `idOfertante` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `idSubasta` int NOT NULL,
  PRIMARY KEY (`idHistorial`),
  KEY `fk_historial_subasta1_idx` (`idSubasta`),
  KEY `fk_historial_usuario` (`idOfertante`),
  CONSTRAINT `fk_historial_subasta1` FOREIGN KEY (`idSubasta`) REFERENCES `subasta` (`idSubasta`),
  CONSTRAINT `fk_historial_usuario` FOREIGN KEY (`idOfertante`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial`
--

LOCK TABLES `historial` WRITE;
/*!40000 ALTER TABLE `historial` DISABLE KEYS */;
INSERT INTO `historial` VALUES (1,900,1,'2024-05-30',1),(2,120,2,'2024-06-04',2),(3,400,3,'2024-06-05',3),(4,290,4,'2024-06-05',4),(5,500,5,'2024-06-07',5),(6,170,6,'2024-06-08',6),(7,650,7,'2024-06-09',7),(8,480,8,'2024-06-27',8),(9,45,9,'2024-06-28',9),(10,850,10,'2024-06-30',10),(11,600,11,'2024-06-30',11),(12,905,2,'2024-06-02',1),(13,910,3,'2024-06-03',1),(14,915,5,'2024-06-03',1),(15,920,7,'2024-06-04',1),(16,590,9,'2024-06-30',8),(17,630,10,'2024-06-04',8),(18,735,12,'2024-07-05',8),(19,740,13,'2024-07-03',8),(20,945,14,'2024-06-29',10),(21,950,15,'2024-06-30',10);
/*!40000 ALTER TABLE `historial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodoEnvio`
--

DROP TABLE IF EXISTS `metodoEnvio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodoEnvio` (
  `idMetodoEnvio` int NOT NULL,
  `empresa` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMetodoEnvio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodoEnvio`
--

LOCK TABLES `metodoEnvio` WRITE;
/*!40000 ALTER TABLE `metodoEnvio` DISABLE KEYS */;
INSERT INTO `metodoEnvio` VALUES (1,'Correo Argentino'),(2,'OCA');
/*!40000 ALTER TABLE `metodoEnvio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodoPago`
--

DROP TABLE IF EXISTS `metodoPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodoPago` (
  `idMetodoPago` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMetodoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodoPago`
--

LOCK TABLES `metodoPago` WRITE;
/*!40000 ALTER TABLE `metodoPago` DISABLE KEYS */;
INSERT INTO `metodoPago` VALUES (1,'Tarjeta de Credito'),(2,'Tarjeta de Debito'),(3,'Pago Facil'),(4,'Rapipago');
/*!40000 ALTER TABLE `metodoPago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `preguntasSinRespuesta`
--

DROP TABLE IF EXISTS `preguntasSinRespuesta`;
/*!50001 DROP VIEW IF EXISTS `preguntasSinRespuesta`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `preguntasSinRespuesta` AS SELECT 
 1 AS `idComentario`,
 1 AS `idPublicacion`,
 1 AS `pregunta`,
 1 AS `idUsuarioPregunta`,
 1 AS `respuesta`,
 1 AS `fecha`,
 1 AS `idProducto`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `idProducto` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` longtext,
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Smartphone Samsung S22','Teléfono inteligente de alta gama con cámara mejorada'),(2,'Remera Deportiva Nike','Remera de algodón para ejercicio transpirable'),(3,'Set de Sábanas King Size','Juego de sábanas de algodón egipcio de 600 hilos'),(4,'Pelota de Fútbol Adidas','Balón de fútbol oficial AFA, talla 5'),(5,'Novela \"Cien Años de Soledad\"','Clásico de la literatura latinoamericana de Gabriel García Márquez'),(6,'Smartphone Xiaomi Redmi','Teléfono inteligente de gama media con batería de larga duración'),(7,'Buzo con Capucha Adidas','Buzo de algodón con capucha y bolsillo canguro'),(8,'Toallas de Mano Algodón','Set de toallas pequeñas de algodón 100% orgánico'),(9,'Pelota de Baloncesto Spalding','Balón de baloncesto oficial NBA, talla 7'),(10,'Libro \"Hábitos Atómicos\"','Best-seller de autoayuda para construir buenos hábitos'),(11,'Coche de Juguete Hot Wheels','Miniatura de coche de colección, escala 1:64'),(12,'Aceite de Motor Castrol','Aceite sintético 5W-30 para motores modernos'),(13,'Crema Antiarrugas Nivea','Crema facial para piel madura con Q10 y protección solar'),(14,'Kit de Jardinería Básico','Set de herramientas de mano para jardín, incluye pala y rastrillo'),(15,'Pintura Acuarela Winsor & Newton','Set de acuarelas profesionales, 12 colores vibrantes'),(16,'Correa Extensible para Perro','Correa retráctil de 5 metros para perros de hasta 20kg'),(17,'Auriculares Bluetooth Sony','Auriculares supraaurales con Bluetooth y cancelación de ruido'),(18,'Consola PlayStation 5','Consola de última generación de Sony con gráficos 4K'),(19,'Café Tostado en Grano','Granos de café 100% arábica, tueste medio'),(20,'Teclado Mecánico Redragon','Teclado gamer con switches rojos e iluminación RGB'),(21,'Drone DJI Mini 3 Pro','Drone compacto con cámara 4K y 34 minutos de vuelo'),(22,'Zapatillas Running Asics','Zapatillas de running con amortiguación GEL para hombre'),(23,'Robot Aspirador Roomba i3','Aspiradora inteligente con mapeo y control por app'),(24,'Mancuernas Ajustables','Set de mancuernas de 2.5kg a 24kg, ajustables'),(25,'Enciclopedia Larousse','Colección de enciclopedias ilustradas, 10 volúmenes'),(26,'Monitor Curvo Samsung','Monitor gaming de 27 pulgadas, 144Hz, 1ms'),(27,'Billetera de Cuero Genuino','Billetera minimalista de cuero, para tarjetas y billetes'),(28,'Set de Ollas Antiadherentes','Juego de 5 ollas con tapa de vidrio y recubrimiento antiadherente'),(29,'Bicicleta de Montaña Rodado 29','Bicicleta MTB con suspensión delantera y 21 velocidades'),(30,'Audífonos Inalámbricos Bose','Auriculares con cancelación de ruido y sonido premium'),(31,'Kit de Herramientas Completas','Maletín con herramientas para el hogar, 100 piezas'),(32,'Neumáticos Michelin Primacy','Neumáticos de alta performance para autos, bajo ruido'),(33,'Serum Vitamina C La Roche-Posay','Serum antioxidante para iluminar y unificar el tono de la piel'),(34,'Semillas de Tomate Orgánico','Paquete de semillas de tomate cherry, aptas para huerta'),(35,'Set de Pinceles para Pintura','Set de 15 pinceles de diferentes tamaños para acrílico y óleo'),(36,'Rascador para Gatos Grande','Rascador con múltiples niveles y cuevas para gatos'),(37,'Proyector Portátil Epson','Proyector mini HD para cine en casa y presentaciones'),(38,'Smart TV LG 55 Pulgadas','Televisor inteligente 4K UHD con ThinQ AI'),(39,'Libro \"El Poder del Ahora\"','Best-seller de autoayuda y espiritualidad de Eckhart Tolle'),(40,'Silla Gamer Ergonómica','Silla de escritorio con soporte lumbar y reposacabezas ajustable'),(41,'Acrilico Eterna Violeta','pintura acrilica de la marca eterna, color violeta'),(42,'Acrilico Eterna Violeta','pintura acrilica de la marca eterna, color violeta'),(43,'Cintas strap powerlifting','fsfjkdjffjf'),(44,'Libro Orgullo y prejuicio','novela romantica clasica'),(45,'Pantalon Jean Cargo','cargo talle 36 negro con bolsillos');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacion`
--

DROP TABLE IF EXISTS `publicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacion` (
  `idPublicacion` int NOT NULL,
  `idUsuarioV` int DEFAULT NULL,
  `idCategoria` int NOT NULL,
  `idProducto` int NOT NULL,
  `precio` float DEFAULT NULL,
  `estaActiva` tinyint DEFAULT NULL,
  `fechaPublicacion` date DEFAULT NULL,
  `idEstado` int NOT NULL,
  `nivelVistas` varchar(45) DEFAULT NULL,
  `subastaId` int DEFAULT NULL,
  PRIMARY KEY (`idPublicacion`),
  KEY `fk_publicacion_categoria_idx` (`idCategoria`),
  KEY `fk_publicacion_producto1_idx` (`idProducto`),
  KEY `fk_publicacion_estado1_idx` (`idEstado`),
  KEY `fk_publicacion_usuario_idx` (`idUsuarioV`),
  KEY `fk_publicacion_subasta` (`subastaId`),
  CONSTRAINT `fk_publicacion_categoria` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`),
  CONSTRAINT `fk_publicacion_estado1` FOREIGN KEY (`idEstado`) REFERENCES `estado` (`idEstado`),
  CONSTRAINT `fk_publicacion_producto1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`),
  CONSTRAINT `fk_publicacion_subasta` FOREIGN KEY (`subastaId`) REFERENCES `subasta` (`idSubasta`),
  CONSTRAINT `fk_publicacion_usuario` FOREIGN KEY (`idUsuarioV`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion`
--

LOCK TABLES `publicacion` WRITE;
/*!40000 ALTER TABLE `publicacion` DISABLE KEYS */;
INSERT INTO `publicacion` VALUES (1,4,1,21,990,1,'2025-06-18',1,'Oro',1),(2,5,2,22,150,1,'2024-06-02',3,'Platino',2),(3,6,3,23,430,1,'2024-06-03',8,'Bronce',3),(4,7,4,24,320,1,'2024-06-04',2,'Oro',4),(5,8,5,25,520,1,'2024-06-05',1,'Plata',5),(6,9,6,26,180,1,'2024-06-06',4,'Bronce',6),(7,10,7,27,690,1,'2024-06-07',6,'Platino',7),(8,11,8,28,75,1,'2024-06-08',1,'Plata',NULL),(9,12,9,29,470,1,'2024-06-09',10,'Oro',NULL),(10,13,10,30,255,1,'2024-06-10',11,'Bronce',NULL),(11,14,1,31,85,1,'2024-06-11',3,'Plata',NULL),(12,15,2,32,95,1,'2024-06-12',2,'Oro',NULL),(13,16,3,33,40,1,'2024-06-13',4,'Platino',NULL),(14,17,4,34,15,1,'2024-06-14',6,'Bronce',NULL),(15,18,5,35,28,1,'2024-06-15',8,'Oro',NULL),(16,19,6,36,60,1,'2024-06-16',1,'Bronce',NULL),(17,20,7,37,310,1,'2024-06-17',10,'Platino',NULL),(18,21,8,38,705,1,'2024-06-18',11,'Plata',NULL),(19,22,9,39,14,1,'2024-06-19',3,'Bronce',NULL),(20,23,10,40,185,1,'2024-06-20',2,'Oro',NULL),(21,24,1,1,770,1,'2024-06-21',4,'Platino',NULL),(22,25,2,2,33,1,'2024-06-22',6,'Plata',NULL),(23,26,3,3,69,1,'2024-06-23',8,'Oro',NULL),(24,27,4,4,39,1,'2024-06-24',10,'Bronce',NULL),(25,28,5,5,23,1,'2024-06-25',11,'Platino',NULL),(26,37,2,15,261.97,1,'2024-06-26',2,'Oro',8),(27,10,6,22,49.46,1,'2024-06-27',4,'Bronce',9),(28,32,8,1,907.8,1,'2024-06-28',7,'Plata',10),(29,3,1,12,618.15,1,'2024-06-29',12,'Oro',11),(30,28,10,25,780.5,1,'2024-06-30',3,'Bronce',NULL),(31,24,8,2,366.95,1,'2024-07-01',11,'Bronce',NULL),(32,9,7,13,690.05,1,'2024-07-02',1,'Bronce',NULL),(33,15,9,4,643.03,1,'2024-07-03',8,'Oro',NULL),(34,31,6,8,46.45,1,'2024-07-04',4,'Platino',NULL),(35,20,10,20,787.73,1,'2024-07-05',3,'Oro',NULL),(36,16,3,20,158.05,1,'2024-07-06',11,'Bronce',NULL),(37,18,4,1,725.06,1,'2024-07-07',2,'Oro',NULL),(38,6,7,26,807.04,1,'2024-07-08',10,'Bronce',NULL),(39,24,1,32,605.85,1,'2024-07-09',5,'Bronce',NULL),(40,6,6,38,115.11,1,'2024-07-10',4,'Oro',NULL),(41,3,9,41,500.5,1,'2025-06-12',10,'Bronce',NULL),(42,27,4,43,300.5,1,'2025-06-19',10,'Bronce',NULL),(43,27,5,44,8699.99,1,'2025-06-19',10,'Oro',NULL),(44,34,2,45,23657.5,1,'2025-06-19',10,'Bronce',NULL),(45,34,2,45,23657.5,1,'2025-06-19',10,'Bronce',NULL);
/*!40000 ALTER TABLE `publicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `publicacionesTendenciaHoy`
--

DROP TABLE IF EXISTS `publicacionesTendenciaHoy`;
/*!50001 DROP VIEW IF EXISTS `publicacionesTendenciaHoy`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `publicacionesTendenciaHoy` AS SELECT 
 1 AS `idPublicacion`,
 1 AS `cantidad`,
 1 AS `idProducto`,
 1 AS `precio`,
 1 AS `fechaPublicacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `subasta`
--

DROP TABLE IF EXISTS `subasta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subasta` (
  `idSubasta` int NOT NULL,
  PRIMARY KEY (`idSubasta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subasta`
--

LOCK TABLES `subasta` WRITE;
/*!40000 ALTER TABLE `subasta` DISABLE KEYS */;
INSERT INTO `subasta` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11);
/*!40000 ALTER TABLE `subasta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `topCategoriasEstaSemana`
--

DROP TABLE IF EXISTS `topCategoriasEstaSemana`;
/*!50001 DROP VIEW IF EXISTS `topCategoriasEstaSemana`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topCategoriasEstaSemana` AS SELECT 
 1 AS `idCategoria`,
 1 AS `nombre`,
 1 AS `cantidad`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `nivel` varchar(45) DEFAULT NULL,
  `reputacion` int DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'juan.perez','Normal',50),(2,'maria.gonzalez','Normal',0),(3,'carlos.rodriguez','Normal',0),(4,'ana.lopez','Normal',0),(5,'pedro.martinez','Normal',0),(6,'laura.fernandez','Normal',0),(7,'javier.diaz','Normal',0),(8,'sofia.ruiz','Normal',0),(9,'diego.sanchez','Normal',75),(10,'valentina.gomez','Normal',0),(11,'martin.torres','Normal',NULL),(12,'camila.ramirez','Normal',100),(13,'facundo.flores','Normal',67),(14,'agustina.benitez','Normal',0),(15,'nicolas.acosta','Normal',0),(16,'florencia.ortiz','Normal',0),(17,'sebastian.herrera','Normal',70),(18,'emilia.garcia','Normal',35),(19,'rodrigo.moreno','Normal',0),(20,'lucia.blanco','Normal',0),(21,'gabriel.sosa','Platinum',0),(22,'daniel.paz','Normal',0),(23,'carolina.vargas','Platinum',0),(24,'enzo.alvarez','Gold',37),(25,'paula.romero','Normal',0),(26,'lucas.gimenez','Normal',0),(27,'sofia.pereyra','Gold',200),(28,'matias.vega','Normal',95),(29,'rocio.castro','Normal',0),(30,'federico.aguirre','Normal',0),(31,'valeria.nuñez','Normal',57),(32,'maximiliano.mendez','Normal',0),(33,'victoria.rojas','Normal',0),(34,'ignacio.silva','Platinum',25),(35,'lourdes.dominguez','Normal',0),(36,'joaquin.gallo','Normal',0),(37,'emilia.sanchez','Normal',50),(38,'agustin.franco','Normal',0),(39,'valentina.ledesma','Normal',0),(40,'benjamin.ortega','Normal',0);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventaDirecta`
--

DROP TABLE IF EXISTS `ventaDirecta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventaDirecta` (
  `idVentaDirecta` int NOT NULL,
  `idMetodoPago` int NOT NULL,
  `idMetodoEnvio` int NOT NULL,
  PRIMARY KEY (`idVentaDirecta`),
  KEY `fk_ventaDirecta_metodoPago1_idx` (`idMetodoPago`),
  KEY `fk_ventaDirecta_metodoEnvio1_idx` (`idMetodoEnvio`),
  CONSTRAINT `fk_ventaDirecta_metodoEnvio1` FOREIGN KEY (`idMetodoEnvio`) REFERENCES `metodoEnvio` (`idMetodoEnvio`),
  CONSTRAINT `fk_ventaDirecta_metodoPago1` FOREIGN KEY (`idMetodoPago`) REFERENCES `metodoPago` (`idMetodoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventaDirecta`
--

LOCK TABLES `ventaDirecta` WRITE;
/*!40000 ALTER TABLE `ventaDirecta` DISABLE KEYS */;
INSERT INTO `ventaDirecta` VALUES (1,1,1),(2,2,2),(3,3,1),(4,4,2),(5,1,1),(6,2,2),(7,3,1),(8,4,2),(9,1,1),(10,2,2),(11,3,1),(12,4,2),(13,1,1),(14,2,2),(15,3,1),(16,4,2),(17,1,1),(18,3,2),(19,1,2),(20,1,2),(21,1,1),(22,1,2),(23,4,2),(24,4,1),(25,1,2),(26,2,2),(27,4,1),(28,4,1),(29,3,2),(30,3,2);
/*!40000 ALTER TABLE `ventaDirecta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `preguntasSinRespuesta`
--

/*!50001 DROP VIEW IF EXISTS `preguntasSinRespuesta`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alumno`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `preguntasSinRespuesta` AS select `comentario`.`idComentario` AS `idComentario`,`comentario`.`idPublicacion` AS `idPublicacion`,`comentario`.`pregunta` AS `pregunta`,`comentario`.`idUsuarioPregunta` AS `idUsuarioPregunta`,`comentario`.`respuesta` AS `respuesta`,`comentario`.`fecha` AS `fecha`,`publicacion`.`idProducto` AS `idProducto` from (`comentario` join `publicacion` on((`publicacion`.`idPublicacion` = `comentario`.`idPublicacion`))) where (`comentario`.`respuesta` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `publicacionesTendenciaHoy`
--

/*!50001 DROP VIEW IF EXISTS `publicacionesTendenciaHoy`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alumno`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `publicacionesTendenciaHoy` AS select `publicacion`.`idPublicacion` AS `idPublicacion`,count(`comentario`.`pregunta`) AS `cantidad`,`publicacion`.`idProducto` AS `idProducto`,`publicacion`.`precio` AS `precio`,`publicacion`.`fechaPublicacion` AS `fechaPublicacion` from (`comentario` join `publicacion` on((`comentario`.`idPublicacion` = `publicacion`.`idPublicacion`))) where (`publicacion`.`fechaPublicacion` = curdate()) group by `publicacion`.`idPublicacion` order by `cantidad` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topCategoriasEstaSemana`
--

/*!50001 DROP VIEW IF EXISTS `topCategoriasEstaSemana`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alumno`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topCategoriasEstaSemana` AS select `categoria`.`idCategoria` AS `idCategoria`,`categoria`.`nombre` AS `nombre`,count(`categoria`.`idCategoria`) AS `cantidad` from (`publicacion` join `categoria` on((`publicacion`.`idCategoria` = `categoria`.`idCategoria`))) where (week(`publicacion`.`fechaPublicacion`,0) = week(curdate(),0)) group by `categoria`.`idCategoria`,`categoria`.`nombre` order by `cantidad` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-25 16:53:57
