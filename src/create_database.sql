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
  `descricao` varchar(255) DEFAULT NULL,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_alerta`),
  KEY `fk_item_estoque` (`fk_item_estoque`),
  CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta`
--

LOCK TABLES `alerta` WRITE;
/*!40000 ALTER TABLE `alerta` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerta` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `caracteristica_item_estoque` VALUES (14,1),(21,1),(15,2),(20,2),(15,3),(18,3),(19,3),(15,4),(20,4),(14,5),(21,5),(18,6),(20,6),(18,7);
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
  `nome` varchar(255) DEFAULT NULL,
  `fk_categoria_pai` int DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  KEY `fk_categoria_pai` (`fk_categoria_pai`),
  CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`fk_categoria_pai`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Tecido',NULL),(2,'Roupa',NULL),(3,'Característica',NULL),(4,'Nylon',1),(5,'Poliéster',1),(6,'Algodão',1),(7,'Seda',1),(8,'Lã',1),(9,'Vestido',2),(10,'Camiseta',2),(11,'Calça',2),(12,'Shorts',2),(13,'Saia',2),(14,'Azul',3),(15,'Vermelho',3),(16,'Verde',3),(17,'Amarelo',3),(18,'Cinza',3),(19,'Listrado',3),(20,'Liso',3),(21,'Florido',3),(22,'Grosso',3),(23,'Fino',3);
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
  `qtd_tecido` double DEFAULT NULL,
  PRIMARY KEY (`id_confeccao_roupa`),
  KEY `fk_roupa` (`fk_roupa`),
  KEY `fk_tecido` (`fk_tecido`),
  CONSTRAINT `confeccao_roupa_ibfk_1` FOREIGN KEY (`fk_roupa`) REFERENCES `item_estoque` (`id_item_estoque`),
  CONSTRAINT `confeccao_roupa_ibfk_2` FOREIGN KEY (`fk_tecido`) REFERENCES `item_estoque` (`id_item_estoque`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confeccao_roupa`
--

LOCK TABLES `confeccao_roupa` WRITE;
/*!40000 ALTER TABLE `confeccao_roupa` DISABLE KEYS */;
INSERT INTO `confeccao_roupa` VALUES (1,1,5,10),(2,2,4,10),(3,3,4,10),(4,3,6,10);
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
INSERT INTO `controle_acesso` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3);
/*!40000 ALTER TABLE `controle_acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corte_tecido`
--

DROP TABLE IF EXISTS `corte_tecido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corte_tecido` (
  `id_corte_tecido` int NOT NULL AUTO_INCREMENT,
  `fk_lote_item_estoque` int NOT NULL,
  `fk_funcionario` int NOT NULL,
  `inicio` varchar(255) DEFAULT NULL,
  `termino` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_corte_tecido`),
  KEY `fk_lote_item_estoque` (`fk_lote_item_estoque`),
  KEY `fk_funcionario` (`fk_funcionario`),
  CONSTRAINT `corte_tecido_ibfk_1` FOREIGN KEY (`fk_lote_item_estoque`) REFERENCES `lote_item_estoque` (`id_lote_item_estoque`),
  CONSTRAINT `corte_tecido_ibfk_2` FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario` (`id_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corte_tecido`
--

LOCK TABLES `corte_tecido` WRITE;
/*!40000 ALTER TABLE `corte_tecido` DISABLE KEYS */;
INSERT INTO `corte_tecido` VALUES (1,4,1,'2025-04-20 11:36:00','2025-04-20 12:36:00'),(2,5,1,'2025-04-20 14:36:00','2025-04-20 16:36:00'),(3,6,2,'2025-04-10 11:36:00','2025-04-10 11:36:00'),(4,4,3,'2025-04-10 11:36:00','2025-04-10 11:36:00'),(5,6,5,'2025-04-10 11:36:00','2025-04-10 11:36:00');
/*!40000 ALTER TABLE `corte_tecido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `cpf` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,'Bruno','83756473891','11985647381','bruno@gmail.com','123456@'),(2,'Fernando Almeida','000.000.000-00','55 900000000','fernando_almeida@gmail.com','$2a$10$dgIbkIFfWfyacCgi5TdD0OMYxDemXhgRIryEOMDWwyGzS9/RSAwPa'),(3,'Giorgio','83756473893','11985647383','giorgio@gmail.com','123456@'),(4,'Guilherme','83756473894','11985647384','guilherme@gmail.com','123456@'),(5,'João','83756473895','11985647385','joao@gmail.com','123456@'),(6,'Leandro','83756473896','11985647386','leandro@gmail.com','123456@');
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
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_imagem`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagem`
--

LOCK TABLES `imagem` WRITE;
/*!40000 ALTER TABLE `imagem` DISABLE KEYS */;
INSERT INTO `imagem` VALUES (1,'https://cdn.awsli.com.br/600x700/143/143951/produto/32328172/7fa3e6d61c.jpg'),(2,'https://static.zattini.com.br/produtos/camiseta-masculina-algodao-basica-camisa-lisa-vermelha/16/GZ0-0008-016/GZ0-0008-016_zoom1.jpg?ts=1670339407'),(3,'https://lojaspeedo.vtexassets.com/arquivos/ids/206110/139569Q_245049_1-BERMUDA-BOLD.jpg?v=637945525518130000'),(4,'https://images.tcdn.com.br/img/img_prod/632834/rolo_de_tecido_tule_50_metros_x_1_20_mt_largura_vermelho_9911_1_1cdde84963063c6dbefff762c02f8b95.jpg'),(5,'https://tfcszo.vteximg.com.br/arquivos/ids/195046/6661-TECIDO-TRICOLINE-ESTAMPADO-FLORAL-AZUL-MARINHO--2-.jpg?v=638521737026530000'),(6,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzDWAcBlgdzuPL_hGF8qPuVGKpKo6cruBwmQ&s'),(7,'https://img-bucket-teste.s3.amazonaws.com/RzYcuF3jcN1LSfTymHSRIP30VSi8B44p.jpg');
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
  `fk_categoria` int NOT NULL,
  `fk_prateleira` int DEFAULT NULL,
  `fk_imagem` int DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `notificar` tinyint(1) DEFAULT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `peso` double DEFAULT NULL,
  `qtd_minimo` double DEFAULT NULL,
  `qtd_armazenado` double DEFAULT NULL,
  `preco` double DEFAULT NULL,
  PRIMARY KEY (`id_item_estoque`),
  KEY `fk_categoria` (`fk_categoria`),
  KEY `fk_prateleira` (`fk_prateleira`),
  KEY `fk_imagem` (`fk_imagem`),
  CONSTRAINT `item_estoque_ibfk_1` FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `item_estoque_ibfk_2` FOREIGN KEY (`fk_prateleira`) REFERENCES `prateleira` (`id_prateleira`),
  CONSTRAINT `item_estoque_ibfk_3` FOREIGN KEY (`fk_imagem`) REFERENCES `imagem` (`id_imagem`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_estoque`
--

LOCK TABLES `item_estoque` WRITE;
/*!40000 ALTER TABLE `item_estoque` DISABLE KEYS */;
INSERT INTO `item_estoque` VALUES (1,9,1,1,'Vestido azul florido',1,NULL,1,0,5,NULL),(2,10,2,2,'Camisa vermelha lisa',0,NULL,1,0,3,NULL),(3,12,3,3,'Bermuda cinza com listras vermelhas',1,NULL,1,0,10,NULL),(4,5,4,4,'Tecido vermelho liso',0,NULL,1,0,3.5,100),(5,6,5,5,'Tecido azul florido',0,NULL,1,0,6.5,150),(6,4,6,6,'Tecido cinza liso',1,NULL,1,0,12.5,200),(7,10,1,7,'Camiseta',0,'teste',1,1,1,0);
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
  `descricao` varchar(255) DEFAULT NULL,
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
  `qtd_item` double DEFAULT NULL,
  `preco` double DEFAULT NULL,
  PRIMARY KEY (`id_lote_item_estoque`),
  KEY `fk_item_estoque` (`fk_item_estoque`),
  KEY `fk_lote` (`fk_lote`),
  CONSTRAINT `lote_item_estoque_ibfk_1` FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`),
  CONSTRAINT `lote_item_estoque_ibfk_2` FOREIGN KEY (`fk_lote`) REFERENCES `lote` (`id_lote`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote_item_estoque`
--

LOCK TABLES `lote_item_estoque` WRITE;
/*!40000 ALTER TABLE `lote_item_estoque` DISABLE KEYS */;
INSERT INTO `lote_item_estoque` VALUES (1,1,1,5,100),(2,2,1,3,150),(3,3,1,10,200),(4,4,2,3.5,80),(5,5,2,6.5,70),(6,6,2,12.5,120);
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
  `categoria` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `identificacao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_parceiro`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parceiro`
--

LOCK TABLES `parceiro` WRITE;
/*!40000 ALTER TABLE `parceiro` DISABLE KEYS */;
INSERT INTO `parceiro` VALUES (1,'costureira','Maria','11938563748','maria@gmail.com','Rua X','000.000.000-00'),(2,'costureira','Alice','11938563748','alice@gmail.com','Rua Y','000.000.000-01'),(3,'costureira','Rebeca','11938563748','rebeca@gmail.com','Rua Z','000.000.000-02'),(4,'fornecedor','Best Tecidos','11918465729','best_tecidos@gmail.com','Rua 1','00.000.000/0000-00'),(5,'fornecedor','Fornecedor X','11918465729','fornecedorx@gmail.com','Rua 2','00.000.000/0000-00'),(6,'fornecedor','Fornecedor Z','11918465729','fornecedorys@gmail.com','Rua 3','00.000.000/0000-00');
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
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_permissao`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissao`
--

LOCK TABLES `permissao` WRITE;
/*!40000 ALTER TABLE `permissao` DISABLE KEYS */;
INSERT INTO `permissao` VALUES (1,'Visualizar dashboard'),(2,'Cadastrar funcionários'),(3,'Visualizar histórico do estoque'),(4,'Registrar movimentação do estoque'),(5,'Visualizar dados de itens do estoque'),(6,'Cadastrar itens do estoque'),(7,'Receber alertas de falta de estoque');
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
  `codigo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_prateleira`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prateleira`
--

LOCK TABLES `prateleira` WRITE;
/*!40000 ALTER TABLE `prateleira` DISABLE KEYS */;
INSERT INTO `prateleira` VALUES (1,'1R'),(4,'1T'),(2,'2R'),(5,'2T'),(3,'3R'),(6,'3T');
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
  `qtd_saida` double DEFAULT NULL,
  `motivo_saida` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saida_estoque`
--

LOCK TABLES `saida_estoque` WRITE;
/*!40000 ALTER TABLE `saida_estoque` DISABLE KEYS */;
INSERT INTO `saida_estoque` VALUES (1,'2025-10-18','20:19:42',2.5,'envio de tecido para costura',1,6,1),(2,'2025-10-18','20:19:42',2,'produto vendido',3,3,NULL);
/*!40000 ALTER TABLE `saida_estoque` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-20 11:40:40
