CREATE DATABASE  IF NOT EXISTS `projeto_extensao` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projeto_extensao`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: projeto_extensao
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `alerta`
--

DROP TABLE IF EXISTS `alerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerta` (
  `id_alerta` int NOT NULL AUTO_INCREMENT,
  `fk_item_estoque` int NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_alerta`),
  KEY `fk_item_estoque` (`fk_item_estoque`),
  CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta`
--

LOCK TABLES `alerta` WRITE;
/*!40000 ALTER TABLE `alerta` DISABLE KEYS */;
INSERT INTO `alerta` VALUES (1,8,'Estoque abaixo do mínimo','2025-10-20 09:00:00'),(2,5,'Estoque abaixo do mínimo','2025-05-20 08:00:00'),(3,7,'Estoque abaixo do mínimo','2025-06-18 09:00:00'),(4,10,'Estoque abaixo do mínimo','2025-08-20 10:00:00'),(5,11,'Estoque abaixo do mínimo','2025-09-25 11:00:00'),(6,11,'Estoque abaixo do mínimo','2025-09-25 11:00:00');
/*!40000 ALTER TABLE `alerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `autocomplete_saida`
--

DROP TABLE IF EXISTS `autocomplete_saida`;
/*!50001 DROP VIEW IF EXISTS `autocomplete_saida`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `autocomplete_saida` AS SELECT 
 1 AS `fk_lote`,
 1 AS `fk_item_estoque`,
 1 AS `descricao`,
 1 AS `quantidade`,
 1 AS `preco`,
 1 AS `id_lote_item_estoque`,
 1 AS `fk_categoria_pai`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `caracteristica_item_estoque`
--

DROP TABLE IF EXISTS `caracteristica_item_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caracteristica_item_estoque` (
  `fk_categoria` int NOT NULL,
  `fk_item_estoque` int NOT NULL,
  PRIMARY KEY (`fk_categoria`,`fk_item_estoque`),
  KEY `fk_item_estoque` (`fk_item_estoque`),
  CONSTRAINT `caracteristica_item_estoque_ibfk_1` FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `caracteristica_item_estoque_ibfk_2` FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caracteristica_item_estoque`
--

LOCK TABLES `caracteristica_item_estoque` WRITE;
/*!40000 ALTER TABLE `caracteristica_item_estoque` DISABLE KEYS */;
INSERT INTO `caracteristica_item_estoque` VALUES (33,1),(33,2),(33,3),(33,4),(33,5),(33,6),(33,7),(33,8),(33,9),(33,10),(33,11),(33,12),(33,13),(33,14),(33,15),(33,16),(33,17),(33,18),(33,19),(33,20),(33,21),(33,22),(33,23),(33,24),(33,25),(33,26),(33,27),(33,28),(33,29),(33,30);
/*!40000 ALTER TABLE `caracteristica_item_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `fk_categoria_pai` int DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  KEY `fk_categoria_pai` (`fk_categoria_pai`),
  CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`fk_categoria_pai`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Tecido',NULL),(2,'Roupa',NULL),(3,'Característica',NULL),(4,'Nylon',1),(5,'Poliéster',1),(6,'Algodão',1),(7,'Lã',1),(8,'Moletinho',1),(9,'Gorgurão',1),(10,'Viscolycra',1),(11,'Suplex',1),(12,'Vestido Manga Curta',2),(13,'Vestido Canelado Mídi',2),(14,'Vestido Regata Estampado',2),(15,'Vestido Plus',2),(16,'Blusa Gola Boba',2),(17,'Blusa Regata Marrocos',2),(18,'Blusa Gola Quadrada Canelada',2),(19,'Blusa Gola V Canelada',2),(20,'Blusa De Ponta',2),(21,'Blusa Meia Manga',2),(22,'Blusa Mulet',2),(23,'Blusa Mulet',2),(24,'Blusa Paris',2),(25,'Calça De Montaria Com Bolso',2),(26,'Calça Flare',2),(27,'Calça Jogger',2),(28,'Conjunto Saia',2),(29,'Conjunto Gabi',2),(30,'Conjunto Pantalona',2),(31,'Shorts Moletinho',2),(32,'Camisa Over',2),(33,'Azul',3),(34,'Vermelho',3),(35,'Verde',3),(36,'Amarelo',3),(37,'Cinza',3),(38,'Listrado',3),(39,'Liso',3),(40,'Florido',3),(41,'Geométrico',3);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confeccao_roupa`
--

DROP TABLE IF EXISTS `confeccao_roupa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confeccao_roupa` (
  `id_confeccao_roupa` int NOT NULL AUTO_INCREMENT,
  `fk_roupa` int NOT NULL,
  `fk_tecido` int NOT NULL,
  `qtd_tecido` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_confeccao_roupa`),
  KEY `fk_roupa` (`fk_roupa`),
  KEY `fk_tecido` (`fk_tecido`),
  CONSTRAINT `confeccao_roupa_ibfk_1` FOREIGN KEY (`fk_roupa`) REFERENCES `item_estoque` (`id_item_estoque`),
  CONSTRAINT `confeccao_roupa_ibfk_2` FOREIGN KEY (`fk_tecido`) REFERENCES `item_estoque` (`id_item_estoque`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confeccao_roupa`
--

LOCK TABLES `confeccao_roupa` WRITE;
/*!40000 ALTER TABLE `confeccao_roupa` DISABLE KEYS */;
INSERT INTO `confeccao_roupa` VALUES (1,1,29,5.00),(2,2,30,5.00),(3,3,29,4.40),(4,4,29,9.00),(5,5,30,3.00),(6,6,30,3.00),(7,7,29,3.50),(8,8,29,3.50),(9,9,29,3.50),(10,10,29,3.50),(11,11,29,3.50),(12,12,30,3.50),(13,13,30,3.60),(14,14,30,3.60),(15,15,27,3.60),(16,16,29,5.00),(17,17,27,6.00),(18,18,27,6.00),(19,19,27,2.50),(20,20,27,3.60),(21,21,29,7.50),(22,22,29,7.50);
/*!40000 ALTER TABLE `confeccao_roupa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controle_acesso`
--

DROP TABLE IF EXISTS `controle_acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `controle_acesso` (
  `fk_funcionario` int NOT NULL,
  `fk_permissao` int NOT NULL,
  PRIMARY KEY (`fk_funcionario`,`fk_permissao`),
  KEY `fk_permissao` (`fk_permissao`),
  CONSTRAINT `controle_acesso_ibfk_1` FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario` (`id_funcionario`),
  CONSTRAINT `controle_acesso_ibfk_2` FOREIGN KEY (`fk_permissao`) REFERENCES `permissao` (`id_permissao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controle_acesso`
--

LOCK TABLES `controle_acesso` WRITE;
/*!40000 ALTER TABLE `controle_acesso` DISABLE KEYS */;
INSERT INTO `controle_acesso` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(1,2),(2,2),(3,2),(4,2),(5,2),(1,3),(2,3),(3,3),(4,3),(5,3),(2,4);
/*!40000 ALTER TABLE `controle_acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) DEFAULT NULL,
  `cpf` char(14) DEFAULT NULL,
  `telefone` char(18) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `senha` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,'Fanuel Felix','00000000000','11930032478','fanu@gmail.com','123456@'),(2,'Fernando Almeida','00000000000','11991991199','fernando_almeida@gmail.com','$2a$10$dgIbkIFfWfyacCgi5TdD0OMYxDemXhgRIryEOMDWwyGzS9/RSAwPa'),(3,'Clebson Cabral','11111111111','11930032475','clebson@gmail.com','$2a$10$dgIbkIFfWfyacCgi5TdD0OMYxDemXhgRIryEOMDWwyGzS9/RSAwPa'),(4,'Aelio Junior Duarte','22222222222','11930032488','junior@gmail.com','123456@'),(5,'Tiago Cartaxo','33333333333','11930032499','tiago@gmail.com','123456@'),(6,'Douglas Mario','44444444444','11930032477','douglas@gmail.com','123456@');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagem`
--

DROP TABLE IF EXISTS `imagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imagem` (
  `id_imagem` int NOT NULL AUTO_INCREMENT,
  `url` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id_imagem`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagem`
--

LOCK TABLES `imagem` WRITE;
/*!40000 ALTER TABLE `imagem` DISABLE KEYS */;
INSERT INTO `imagem` VALUES (1,'https://cdn.awsli.com.br/600x700/143/143951/produto/32328172/7fa3e6d61c.jpg'),(2,'https://static.zattini.com.br/produtos/camiseta-masculina-algodao-basica-camisa-lisa-vermelha/16/GZ0-0008-016/GZ0-0008-016_zoom1.jpg?ts=1670339407'),(3,'https://lojaspeedo.vtexassets.com/arquivos/ids/206110/139569Q_245049_1-BERMUDA-BOLD.jpg?v=637945525518130000'),(4,'https://images.tcdn.com.br/img/img_prod/632834/rolo_de_tecido_tule_50_metros_x_1_20_mt_largura_vermelho_9911_1_1cdde84963063c6dbefff762c02f8b95.jpg'),(5,'https://tfcszo.vteximg.com.br/arquivos/ids/195046/6661-TECIDO-TRICOLINE-ESTAMPADO-FLORAL-AZUL-MARINHO--2-.jpg?v=638521737026530000'),(6,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzDWAcBlgdzuPL_hGF8qPuVGKpKo6cruBwmQ&s'),(7,'https://img-bucket-teste.s3.us-east-1.amazonaws.com/placeholder.jpg');
/*!40000 ALTER TABLE `imagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_estoque`
--

DROP TABLE IF EXISTS `item_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_estoque` (
  `id_item_estoque` int NOT NULL AUTO_INCREMENT,
  `fk_categoria` int DEFAULT NULL,
  `fk_prateleira` int DEFAULT NULL,
  `fk_imagem` int DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `notificar` tinyint(1) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `qtd_minimo` decimal(5,2) DEFAULT NULL,
  `qtd_armazenado` decimal(5,2) DEFAULT NULL,
  `preco` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_item_estoque`),
  KEY `fk_categoria` (`fk_categoria`),
  KEY `fk_prateleira` (`fk_prateleira`),
  KEY `fk_imagem` (`fk_imagem`),
  CONSTRAINT `item_estoque_ibfk_1` FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `item_estoque_ibfk_2` FOREIGN KEY (`fk_prateleira`) REFERENCES `prateleira` (`id_prateleira`),
  CONSTRAINT `item_estoque_ibfk_3` FOREIGN KEY (`fk_imagem`) REFERENCES `imagem` (`id_imagem`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_estoque`
--

LOCK TABLES `item_estoque` WRITE;
/*!40000 ALTER TABLE `item_estoque` DISABLE KEYS */;
INSERT INTO `item_estoque` VALUES (1,12,1,7,'Vestido Manga Curta',0,'Canelado Premium / Viscose / P, M & G',0.35,5.00,21.00,35.00),(2,12,2,7,'Vestido Canelado Mídi',0,'Canelado / Viscose / P, M & G',0.35,5.00,26.00,35.00),(3,12,3,7,'Vestido Regata Estampado',0,'Regata / Viscolycra / P, M & G',0.35,5.00,47.00,25.00),(4,12,4,7,'Vestido Plus',0,'Estampado / Viscolycra / Plus',0.45,5.00,42.00,35.00),(5,13,5,7,'Blusa Gola Boba',0,'Gola Boba / Suplex / P, M & G',0.25,5.00,35.00,20.00),(6,14,6,7,'Blusa Regata Marrocos',0,'Regata / Suplex / P, M & G',0.25,5.00,34.00,20.00),(7,15,7,7,'Blusa Gola Quadrada Canelada',0,'Manga Longa / Gola Quadrada / Viscolycra / U & Plus',0.30,5.00,28.00,22.00),(8,16,8,7,'Blusa Gola V Canelada',0,'Manga Longa / Gola V / Viscolycra / U & Plus',0.30,5.00,47.00,22.00),(9,17,9,7,'Blusa De Ponta',0,'Viscolycra / 40 ao 50',0.30,5.00,50.00,22.00),(10,18,10,7,'Blusa Meia Manga',0,'Gola Quadrada Canelada / Tamanho Único',0.25,5.00,46.00,20.00),(11,19,1,7,'Blusa Mulet',0,'Mulet / Viscolycra / 38 ao 48',0.25,5.00,44.00,27.00),(12,20,2,7,'Blusa Paris',0,'Regata / Suplex Premium / P, M & G',0.25,5.00,42.00,20.00),(13,21,3,7,'Calça De Montaria Com Bolso',0,'Montaria / Gorgurão / P, M, G & GG',0.40,5.00,9.00,30.00),(14,22,4,7,'Calça Flare',0,'Peluciada / Suplex / P, M & G',0.40,5.00,33.00,35.00),(15,23,5,7,'Calça Jogger',0,'Moletinho / Moletinho Viscose',0.40,5.00,50.00,35.00),(16,24,6,7,'Conjunto Saia',0,'Conjunto / Viscolycra / 38 ao 48',0.60,5.00,35.00,49.00),(17,25,7,7,'Conjunto Gabi',0,'Com Touca / Moletinho / P, M & G',0.60,5.00,45.00,75.00),(18,26,8,7,'Conjunto Pantalona',0,'Pantalona / Moletinho / M, G & G1',0.60,5.00,50.00,75.00),(19,27,9,7,'Shorts Moletinho',0,'Moletinho / Moletinho Viscolycra / P, M & G',0.30,5.00,34.00,25.00),(20,28,10,7,'Camisa Over',0,'Moletinho / Moletinho Viscolycra / P, M & G',0.30,5.00,42.00,25.00),(21,29,1,7,'Macacão Lívia',0,'Estampado / Geométrico / 40 ao 48',0.50,5.00,33.00,49.00),(22,30,2,7,'Macacão Lívia',0,'Sem estampa / Geométrico / 40 ao 48',0.50,5.00,46.00,47.00),(23,1,11,7,'Tecido Nylon',0,'Rolo 50m',1.00,5.00,200.00,1.60),(24,2,12,7,'Tecido Poliéster',0,'Rolo 50m',1.00,5.00,200.00,1.40),(25,3,13,7,'Tecido Algodão',0,'Rolo 50m',1.00,5.00,200.00,1.80),(26,4,14,7,'Tecido Lã',0,'Rolo 50m',1.00,5.00,200.00,2.40),(27,5,15,7,'Tecido Moletinho',0,'Rolo 50m',1.00,5.00,250.00,2.00),(28,6,16,7,'Tecido Gorgurão',0,'Rolo 50m',1.00,5.00,202.00,1.80),(29,7,17,7,'Tecido Viscolycra',0,'Rolo 50m',1.00,5.00,200.00,2.20),(30,8,18,7,'Tecido Suplex',0,'Rolo 50m',1.00,5.00,190.00,1.90);
/*!40000 ALTER TABLE `item_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote`
--

DROP TABLE IF EXISTS `lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lote` (
  `id_lote` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `dt_entrada` datetime DEFAULT NULL,
  `fk_parceiro` int NOT NULL,
  `fk_responsavel` int NOT NULL,
  PRIMARY KEY (`id_lote`),
  KEY `fk_parceiro` (`fk_parceiro`),
  KEY `fk_responsavel` (`fk_responsavel`),
  CONSTRAINT `lote_ibfk_1` FOREIGN KEY (`fk_parceiro`) REFERENCES `parceiro` (`id_parceiro`),
  CONSTRAINT `lote_ibfk_2` FOREIGN KEY (`fk_responsavel`) REFERENCES `funcionario` (`id_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote`
--

LOCK TABLES `lote` WRITE;
/*!40000 ALTER TABLE `lote` DISABLE KEYS */;
INSERT INTO `lote` VALUES (1,'lote de roupas','2025-04-20 11:36:00',1,1),(2,'lote de tecido','2025-04-20 11:36:00',2,2);
/*!40000 ALTER TABLE `lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote_item_estoque`
--

DROP TABLE IF EXISTS `lote_item_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lote_item_estoque` (
  `id_lote_item_estoque` int NOT NULL AUTO_INCREMENT,
  `fk_item_estoque` int DEFAULT NULL,
  `fk_lote` int DEFAULT NULL,
  `qtd_item` decimal(5,2) DEFAULT NULL,
  `preco` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_lote_item_estoque`),
  KEY `fk_item_estoque` (`fk_item_estoque`),
  KEY `fk_lote` (`fk_lote`),
  CONSTRAINT `lote_item_estoque_ibfk_1` FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`),
  CONSTRAINT `lote_item_estoque_ibfk_2` FOREIGN KEY (`fk_lote`) REFERENCES `lote` (`id_lote`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote_item_estoque`
--

LOCK TABLES `lote_item_estoque` WRITE;
/*!40000 ALTER TABLE `lote_item_estoque` DISABLE KEYS */;
INSERT INTO `lote_item_estoque` VALUES (1,1,1,50.00,350.00),(2,2,1,50.00,359.50),(3,3,1,50.00,380.50),(4,4,1,50.00,390.00),(5,5,1,50.00,288.00),(6,6,1,50.00,240.00),(7,7,1,50.00,260.50),(8,8,1,50.00,249.50),(9,9,1,50.00,273.50),(10,10,1,50.00,243.00),(11,11,1,50.00,244.00),(12,12,1,50.00,243.50),(13,13,1,50.00,264.50),(14,14,1,50.00,265.00),(15,15,1,50.00,245.00),(16,16,1,50.00,256.50),(17,17,1,50.00,249.00),(18,18,1,50.00,249.00),(19,19,1,50.00,254.00),(20,20,1,50.00,254.00),(21,21,1,50.00,257.50),(22,22,1,50.00,247.50),(23,23,2,200.00,320.00),(24,24,2,200.00,280.00),(25,25,2,200.00,360.00),(26,26,2,200.00,480.00),(27,27,2,260.00,520.00),(28,28,2,210.00,380.00),(29,29,2,210.00,462.00),(30,30,2,200.00,380.00);
/*!40000 ALTER TABLE `lote_item_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parceiro`
--

DROP TABLE IF EXISTS `parceiro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parceiro` (
  `id_parceiro` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(45) DEFAULT NULL,
  `nome` varchar(60) DEFAULT NULL,
  `telefone` char(12) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `endereco` varchar(80) DEFAULT NULL,
  `identificacao` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_parceiro`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parceiro`
--

LOCK TABLES `parceiro` WRITE;
/*!40000 ALTER TABLE `parceiro` DISABLE KEYS */;
INSERT INTO `parceiro` VALUES (1,'costureira','Andresa','11938563748','andresa@gmail.com','Rua Aurora, número 72','00000000000'),(2,'costureira','Maria','11938563748','maria@gmail.com','Rua Y, número 171','00000000001'),(3,'costureira','Rute','11938563748','rebeca@gmail.com','Rua Tal, número 442','00000000002'),(4,'costureira','Sueli','11938563748','rebeca@gmail.com','Rua Z, núemro 777','00000000002'),(5,'costureira','Vera','11938563748','rebeca@gmail.com','Rua Um, número 2','00000000002'),(6,'costureira','Gildete','11938563748','rebeca@gmail.com','Rua Dois, número 1','00000000002'),(7,'fornecedor','Fornecedor Brás','11918465729','fornecedorbrass@gmail.com','Rua Brás, número 1255','00000000000000');
/*!40000 ALTER TABLE `parceiro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissao`
--

DROP TABLE IF EXISTS `permissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissao` (
  `id_permissao` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`id_permissao`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissao`
--

LOCK TABLES `permissao` WRITE;
/*!40000 ALTER TABLE `permissao` DISABLE KEYS */;
INSERT INTO `permissao` VALUES (1,'EDITAR ESTOQUE'),(2,'VISUALIZAR DASHBOARD'),(3,'EDITAR FUNCIONARIOS'),(4,'CADASTRAR ITEM ESTOQUE'),(5,'RECEBER ALERTAS DE FALTA ESTOQUE');
/*!40000 ALTER TABLE `permissao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prateleira`
--

DROP TABLE IF EXISTS `prateleira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prateleira` (
  `id_prateleira` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(10) NOT NULL,
  PRIMARY KEY (`id_prateleira`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prateleira`
--

LOCK TABLES `prateleira` WRITE;
/*!40000 ALTER TABLE `prateleira` DISABLE KEYS */;
INSERT INTO `prateleira` VALUES (10,'10R'),(20,'10T'),(1,'1R'),(11,'1T'),(2,'2R'),(12,'2T'),(3,'3R'),(13,'3T'),(4,'4R'),(14,'4T'),(5,'5R'),(15,'5T'),(6,'6R'),(16,'6T'),(7,'7R'),(17,'7T'),(8,'8R'),(18,'8T'),(9,'9R'),(19,'9T');
/*!40000 ALTER TABLE `prateleira` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saida_estoque`
--

DROP TABLE IF EXISTS `saida_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saida_estoque` (
  `id_saida_estoque` int NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `qtd_saida` decimal(5,2) DEFAULT NULL,
  `motivo_saida` varchar(80) DEFAULT NULL,
  `fk_responsavel` int NOT NULL,
  `fk_lote_item_estoque` int NOT NULL,
  `fk_costureira` int DEFAULT NULL,
  PRIMARY KEY (`id_saida_estoque`),
  KEY `fk_responsavel` (`fk_responsavel`),
  KEY `fk_lote_item_estoque` (`fk_lote_item_estoque`),
  KEY `fk_costureira` (`fk_costureira`),
  CONSTRAINT `saida_estoque_ibfk_1` FOREIGN KEY (`fk_responsavel`) REFERENCES `funcionario` (`id_funcionario`),
  CONSTRAINT `saida_estoque_ibfk_2` FOREIGN KEY (`fk_lote_item_estoque`) REFERENCES `lote_item_estoque` (`id_lote_item_estoque`),
  CONSTRAINT `saida_estoque_ibfk_3` FOREIGN KEY (`fk_costureira`) REFERENCES `parceiro` (`id_parceiro`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saida_estoque`
--

LOCK TABLES `saida_estoque` WRITE;
/*!40000 ALTER TABLE `saida_estoque` DISABLE KEYS */;
INSERT INTO `saida_estoque` VALUES (1,'2025-03-10','10:00:00',2.00,'venda brás',1,5,NULL),(2,'2025-03-15','11:30:00',1.00,'venda ecommerce',2,7,NULL),(3,'2025-03-20','14:00:00',3.00,'venda brás',1,13,NULL),(4,'2025-03-25','15:30:00',2.00,'venda brás',3,1,NULL),(5,'2025-03-05','08:00:00',15.00,'envio de tecido para costura',1,27,1),(6,'2025-03-18','09:00:00',12.00,'envio de tecido para costura',2,29,2),(7,'2025-04-03','10:30:00',3.00,'venda brás',1,2,NULL),(8,'2025-04-08','11:00:00',2.00,'venda brás',2,4,NULL),(9,'2025-04-12','13:45:00',4.00,'venda brás',3,6,NULL),(10,'2025-04-18','14:30:00',2.00,'venda ecommerce',1,14,NULL),(11,'2025-04-25','16:00:00',3.00,'venda brás',2,19,NULL),(12,'2025-04-20','09:00:00',1.00,'defeito de costura',1,7,2),(13,'2025-04-02','08:00:00',18.00,'envio de tecido para costura',1,28,3),(14,'2025-04-16','08:30:00',14.00,'envio de tecido para costura',2,30,1),(15,'2025-05-05','10:00:00',4.00,'venda brás',1,1,NULL),(16,'2025-05-08','11:30:00',3.00,'venda brás',2,3,NULL),(17,'2025-05-12','13:00:00',5.00,'venda brás',3,13,NULL),(18,'2025-05-18','14:30:00',2.00,'venda ecommerce',1,16,NULL),(19,'2025-05-22','15:00:00',4.00,'venda brás',2,7,NULL),(20,'2025-05-28','16:30:00',3.00,'venda brás',3,20,NULL),(21,'2025-05-03','08:00:00',20.00,'envio de tecido para costura',1,27,4),(22,'2025-05-17','09:00:00',16.00,'envio de tecido para costura',2,29,2),(23,'2025-06-02','10:15:00',5.00,'venda brás',1,2,NULL),(24,'2025-06-06','11:00:00',4.00,'venda brás',2,5,NULL),(25,'2025-06-10','13:30:00',6.00,'venda brás',3,14,NULL),(26,'2025-06-15','14:45:00',3.00,'venda ecommerce',1,8,NULL),(27,'2025-06-20','15:30:00',5.00,'venda brás',2,19,NULL),(28,'2025-06-25','16:00:00',4.00,'venda brás',3,22,NULL),(29,'2025-06-04','08:00:00',22.00,'envio de tecido para costura',1,28,5),(30,'2025-06-18','08:30:00',18.00,'envio de tecido para costura',2,30,3),(31,'2025-07-03','10:00:00',6.00,'venda brás',1,1,NULL),(32,'2025-07-08','11:30:00',5.00,'venda brás',2,6,NULL),(33,'2025-07-12','13:00:00',7.00,'venda brás',3,13,NULL),(34,'2025-07-17','14:30:00',4.00,'venda ecommerce',1,10,NULL),(35,'2025-07-22','15:15:00',6.00,'venda brás',2,16,NULL),(36,'2025-07-28','16:00:00',5.00,'venda brás',3,20,NULL),(37,'2025-07-15','09:30:00',1.00,'defeito de acabamento',2,13,4),(38,'2025-07-05','08:00:00',25.00,'envio de tecido para costura',1,27,6),(39,'2025-07-19','08:30:00',20.00,'envio de tecido para costura',2,29,1),(40,'2025-08-02','10:00:00',7.00,'venda brás',1,2,NULL),(41,'2025-08-07','11:00:00',6.00,'venda brás',2,4,NULL),(42,'2025-08-12','13:30:00',8.00,'venda brás',3,12,NULL),(43,'2025-08-16','14:00:00',5.00,'venda ecommerce',1,17,NULL),(44,'2025-08-21','15:30:00',7.00,'venda brás',2,21,NULL),(45,'2025-08-26','16:15:00',6.00,'venda brás',3,14,NULL),(46,'2025-08-05','08:00:00',28.00,'envio de tecido para costura',1,28,2),(47,'2025-08-20','08:30:00',22.00,'envio de tecido para costura',2,30,4),(48,'2025-09-03','10:15:00',8.00,'venda brás',1,1,NULL),(49,'2025-09-08','11:30:00',7.00,'venda brás',2,7,NULL),(50,'2025-09-12','13:00:00',9.00,'venda brás',3,13,NULL),(51,'2025-09-17','14:30:00',6.00,'venda ecommerce',1,11,NULL),(52,'2025-09-22','15:00:00',8.00,'venda brás',2,19,NULL),(53,'2025-09-27','16:00:00',7.00,'venda brás',3,16,NULL),(54,'2025-09-02','08:00:00',30.00,'envio de tecido para costura',1,27,5),(55,'2025-09-16','08:30:00',25.00,'envio de tecido para costura',2,29,3),(56,'2025-09-25','09:00:00',20.00,'envio de tecido para costura',3,30,6),(57,'2025-10-02','10:00:00',9.00,'venda brás',1,2,NULL),(58,'2025-10-05','11:00:00',8.00,'venda brás',2,5,NULL),(59,'2025-10-08','13:30:00',10.00,'venda brás',3,13,NULL),(60,'2025-10-12','14:00:00',7.00,'venda ecommerce',1,6,NULL),(61,'2025-10-15','15:00:00',9.00,'venda brás',2,14,NULL),(62,'2025-10-18','16:00:00',8.00,'venda brás',3,19,NULL),(63,'2025-10-22','10:30:00',10.00,'venda brás',1,21,NULL),(64,'2025-10-25','11:30:00',9.00,'venda brás',2,7,NULL),(65,'2025-10-28','14:00:00',8.00,'venda brás',3,1,NULL),(66,'2025-10-10','09:30:00',1.00,'defeito de costura',1,5,2),(67,'2025-10-01','08:00:00',35.00,'envio de tecido para costura',1,28,1),(68,'2025-10-15','08:30:00',30.00,'envio de tecido para costura',2,29,4),(69,'2025-10-28','09:00:00',25.00,'envio de tecido para costura',3,27,2);
/*!40000 ALTER TABLE `saida_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'projeto_extensao'
--

--
-- Dumping routines for database 'projeto_extensao'
--

--
-- Final view structure for view `autocomplete_saida`
--

/*!50001 DROP VIEW IF EXISTS `autocomplete_saida`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `autocomplete_saida` AS select `t`.`fk_lote` AS `fk_lote`,`t`.`fk_item_estoque` AS `fk_item_estoque`,`t`.`descricao` AS `descricao`,`t`.`quantidade` AS `quantidade`,`t`.`preco` AS `preco`,`t`.`id_lote_item_estoque` AS `id_lote_item_estoque`,`t`.`fk_categoria_pai` AS `fk_categoria_pai` from (select `lie`.`fk_lote` AS `fk_lote`,`lie`.`fk_item_estoque` AS `fk_item_estoque`,`ie`.`descricao` AS `descricao`,(`lie`.`qtd_item` - sum(`se`.`qtd_saida`)) AS `quantidade`,`ie`.`preco` AS `preco`,`lie`.`id_lote_item_estoque` AS `id_lote_item_estoque`,`c`.`fk_categoria_pai` AS `fk_categoria_pai` from (((`lote_item_estoque` `lie` join `saida_estoque` `se` on((`lie`.`id_lote_item_estoque` = `se`.`fk_lote_item_estoque`))) join `item_estoque` `ie` on((`ie`.`id_item_estoque` = `lie`.`fk_item_estoque`))) join `categoria` `c` on((`ie`.`fk_categoria` = `c`.`id_categoria`))) group by `lie`.`fk_item_estoque`,`se`.`fk_lote_item_estoque`,`lie`.`fk_lote`,`lie`.`id_lote_item_estoque` union select `lie`.`fk_lote` AS `fk_lote`,`lie`.`fk_item_estoque` AS `fk_item_estoque`,`ie`.`descricao` AS `descricao`,`lie`.`qtd_item` AS `quantidade`,`ie`.`preco` AS `preco`,`lie`.`id_lote_item_estoque` AS `id_lote_item_estoque`,`c`.`fk_categoria_pai` AS `fk_categoria_pai` from ((`lote_item_estoque` `lie` join `item_estoque` `ie` on((`ie`.`id_item_estoque` = `lie`.`fk_item_estoque`))) join `categoria` `c` on((`ie`.`fk_categoria` = `c`.`id_categoria`))) where `lie`.`id_lote_item_estoque` in (select `se`.`fk_lote_item_estoque` from `saida_estoque` `se`) is false) `t` where (`t`.`quantidade` > 0) order by `t`.`descricao`,`t`.`fk_lote` */;
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

-- Dump completed on 2025-11-29 14:21:18
