DROP DATABASE IF EXISTS projeto_extensao;
CREATE DATABASE projeto_extensao;
USE projeto_extensao;

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

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `funcionario` (
  `id_funcionario` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(80),
  `cpf` CHAR(14),
  `telefone` CHAR(18),
  `email` VARCHAR(60),
  `senha` VARCHAR(80)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Cadastro de funcionários.
INSERT INTO funcionario (nome, cpf, telefone, email, senha) VALUES
	('Fanuel Felix', '00000000000', '11930032478', 'fanu@gmail.com', '123456@'),
	('Fernando Almeida', '00000000000', '11991991199', 'fernando_almeida@gmail.com', '$2a$10$dgIbkIFfWfyacCgi5TdD0OMYxDemXhgRIryEOMDWwyGzS9/RSAwPa'),
	('Clebson Cabral', '11111111111', '11930032475', 'clebson@gmail.com', '$2a$10$dgIbkIFfWfyacCgi5TdD0OMYxDemXhgRIryEOMDWwyGzS9/RSAwPa'),
	('Aelio Junior Duarte', '22222222222', '11930032488', 'junior@gmail.com', '123456@'),
	('Tiago Cartaxo', '33333333333', '11930032499', 'tiago@gmail.com', '123456@'),
	('Douglas Mario', '44444444444', '11930032477', 'douglas@gmail.com', '123456@');

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `permissao` (
  `id_permissao` INT PRIMARY KEY AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Permissões serão fixas no banco, não será necessário cadastro ou atualização
INSERT INTO permissao (descricao) VALUES
	('EDITAR ESTOQUE'),
	('VISUALIZAR DASHBOARD'),
	('EDITAR FUNCIONARIOS'),
	('CADASTRAR ITEM ESTOQUE'),
	('RECEBER ALERTAS DE FALTA ESTOQUE');

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `controle_acesso` (
  `fk_funcionario` INT NOT NULL,
  `fk_permissao` INT NOT NULL,
  PRIMARY KEY (`fk_funcionario`, `fk_permissao`),
  FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario` (`id_funcionario`),
  FOREIGN KEY (`fk_permissao`) REFERENCES `permissao` (`id_permissao`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Cadastrar as permissões de acesso do funcionário. 
INSERT INTO controle_acesso (fk_funcionario, fk_permissao)
VALUES 
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(4, 3),
(5, 1),
(5, 2),
(5, 3);

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `prateleira` (
  `id_prateleira` INT PRIMARY KEY AUTO_INCREMENT,
  `codigo` VARCHAR(10) UNIQUE NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Cadastro de identificação de prateleiras/local de armazenamento.
INSERT INTO prateleira (codigo) VALUES
	('1R'),
	('2R'),
	('3R'),
	('4R'),
	('5R'),
	('6R'),
	('7R'),
	('8R'),
	('9R'),
	('10R'),
	('1T'),
	('2T'),
	('3T'),
	('4T'),
	('5T'),
	('6T'),
	('7T'),
	('8T'),
	('9T'),
	('10T');

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(45),
  `fk_categoria_pai` INT,
  FOREIGN KEY (`fk_categoria_pai`) REFERENCES `categoria` (`id_categoria`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Categorias roupa e tecido serão fixas no banco de dados.
INSERT INTO categoria (nome) VALUES
	('Tecido'), -- 1
	('Roupa'), -- 2
    ('Característica'); -- 3
-- Cadastro de subcategorias para tecido e roupa.
INSERT INTO categoria (nome, fk_categoria_pai) VALUES
	('Nylon', 1), -- 4
	('Poliéster', 1), -- 5
	('Algodão', 1), -- 6
	('Lã', 1), -- 7
    ('Moletinho', 1), -- 8
    ('Gorgurão', 1), -- 9
    ('Viscolycra', 1), -- 10
    ('Suplex', 1), -- 11
    
	('Vestidos', 2), -- 12
	('Blusas', 2), -- 13
	('Calças', 2), -- 14
	('Conjuntos', 2), -- 15
	('Shorts', 2), -- 16
	('Macacões', 2); -- 17
-- Cadastro de características de tecido e produto.
INSERT INTO categoria (nome, fk_categoria_pai) VALUES

	('Canelado', 3), -- 18
	('Regata', 3), -- 19
	('Estampado', 3), -- 20
	('Gola Boba', 3), -- 21
	('Manga Longa', 3), -- 22
	('Gola Quadrada', 3), -- 23
	('Gola V', 3), -- 24
	('Montaria', 3), -- 25
	('Com Touca', 3), -- 26
	('Geométrico', 3), -- 27
	('Peluciada', 3), -- 28
	('Mulet', 3), -- 29
	('Liso', 3), -- 30
	('Canelado Premium', 3), -- 31
    ('Manga Curta', 3); -- 32

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `imagem` (
	`id_imagem` INT PRIMARY KEY AUTO_INCREMENT,
    `url` VARCHAR(300)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO imagem (url) VALUES
-- Roupas
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/vestido_manga_curta.jpeg"), -- 1
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/vestido_canelado_midi.jpeg"), -- 2
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/vestido_regata_viscolycra_estampado.jpeg"), -- 3
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/vestido_viscolycra_plus.jpeg"), -- 4
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_gola_boba.jpeg"), -- 5
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_regata_marrocos_suplex.jpeg"), -- 6
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_gola_quadrada_canelada_peluciada.jpeg"), -- 7
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_gola_v_canelada_peluciada.jpeg"), -- 8
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_de_ponta.jpeg"), -- 9
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_canelada_peluciada_meia_manga.jpeg"), -- 10
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_mulet.jpeg"), -- 11
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/blusa_paris.jpeg"), -- 12
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/calca_montaria_gorgurao_bolso.jpeg"), -- 13
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/calca_flaire_suplex_peluciada.jpeg"), -- 14
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/calca_jogger.jpeg"), -- 15
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/conjunto_saia.jpeg"), -- 16
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/conjunto_gabi_ctouca.jpeg"), -- 17
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/conjunto_pantalona.jpeg"), -- 18
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/shorts_moletinho_viscolycra.jpeg"), -- 19
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/camisa_over.jpeg"), -- 20
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/macacao_livia_estampado.jpeg"), -- 21
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/macacao_livia.jpeg"), -- 22
-- Tecidos
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido-nylon.webp"),
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido_poliester.jpg"),
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido_algodao.jpg"),
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido_la.webp"),
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido_moletinho.webp"),
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido_gorgurao.jpeg"),
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido_viscolycra.webp"),
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/tecido_suplex.jpg"),
-- placeholder
	("https://img-bucket-teste.s3.us-east-1.amazonaws.com/placeholder.jpg"); -- 23

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `item_estoque` (
  `id_item_estoque` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_categoria` INT,
  `fk_prateleira` INT,
  `fk_imagem` INT,
  `descricao` VARCHAR(100),
	`notificar` BOOLEAN,
  `complemento` VARCHAR(100),
  `peso` DECIMAL(5,2),
  `qtd_minimo` DECIMAL(5,2),
  `qtd_armazenado` DECIMAL(5,2),
  `preco` DECIMAL(5,2),
  FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  FOREIGN KEY (`fk_prateleira`) REFERENCES `prateleira` (`id_prateleira`),
  FOREIGN KEY (`fk_imagem`) REFERENCES `imagem` (`id_imagem`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

select * from categoria;
-- Cadastro de itens do estoque (peças de roupa e tecidos).
INSERT INTO item_estoque (fk_categoria, fk_prateleira, descricao, complemento,fk_imagem, peso, qtd_minimo, qtd_armazenado, preco, notificar)
VALUES
-- ROUPAS (usando prateleiras 1-10 para roupas, IDs 1-10)
(12, 1, 'Vestido Manga Curta', 'Canelado Premium / Viscose / P, M & G',1, 0.35, 5, 21, 35.00, false), -- 1
(12, 2, 'Vestido Canelado Mídi', 'Canelado / Viscose / P, M & G', 2, 0.35, 5, 26, 35.00, false), -- 2
(12, 3, 'Vestido Regata Estampado', 'Regata / Viscolycra / P, M & G', 3, 0.35, 5, 47, 25.00, false), -- 3
(12, 4, 'Vestido Plus', 'Estampado / Viscolycra / Plus', 4, 0.45, 5, 42, 35.00, false), -- 4
(13, 5, 'Blusa Gola Boba', 'Gola Boba / Suplex / P, M & G', 5, 0.25, 5, 35, 20.00, false), -- 5
(13, 6, 'Blusa Regata Marrocos', 'Regata / Suplex / P, M & G', 6, 0.25, 5, 34, 20.00, false), -- 6
(13, 7, 'Blusa Gola Quadrada Canelada', 'Manga Longa / Gola Quadrada / Viscolycra / U & Plus', 7,0.30, 5, 28, 22.00, false), -- 7
(13, 8, 'Blusa Gola V Canelada', 'Manga Longa / Gola V / Viscolycra / U & Plus', 8, 0.30, 5, 47, 22.00, false), -- 8
(13, 9, 'Blusa De Ponta', 'Viscolycra / 40 ao 50', 9, 0.30, 5, 50, 22.00, false), -- 9
(13, 10, 'Blusa Meia Manga', 'Gola Quadrada Canelada / Tamanho Único', 10, 0.25, 5, 46, 20.00, false), -- 10
(13, 1, 'Blusa Mulet', 'Mulet / Viscolycra / 38 ao 48', 11, 0.25, 5, 44, 27.00, false), -- 11
(13, 2, 'Blusa Paris', 'Regata / Suplex Premium / P, M & G',12, 0.25, 5, 42, 20.00, false), -- 12
(14, 3, 'Calça De Montaria Com Bolso', 'Montaria / Gorgurão / P, M, G & GG', 13, 0.40, 5, 9, 30.00, false), -- 13
(14, 4, 'Calça Flare', 'Peluciada / Suplex / P, M & G', 14, 0.40, 5, 33, 35.00, false), -- 14
(14, 5, 'Calça Jogger', 'Moletinho / Moletinho Viscose', 15, 0.40, 5, 50, 35.00, false), -- 15
(15, 6, 'Conjunto Saia', 'Conjunto / Viscolycra / 38 ao 48', 16, 0.60, 5, 35, 49.00, false), -- 16
(15, 7, 'Conjunto Gabi', 'Com Touca / Moletinho / P, M & G', 17, 0.60, 5, 45, 75.00, false), -- 17
(15, 8, 'Conjunto Pantalona', 'Pantalona / Moletinho / M, G & G1', 18, 0.60, 5, 50, 75.00, false), -- 18
(16, 9, 'Shorts Moletinho', 'Moletinho / Moletinho Viscolycra / P, M & G', 19, 0.30, 5, 34, 25.00, false), -- 19
(17, 10, 'Camisa Over', 'Moletinho / Moletinho Viscolycra / P, M & G', 20, 0.30, 5, 42, 25.00, false), -- 20
(17, 1, 'Macacão Lívia', 'Estampado / Geométrico / 40 ao 48', 21, 0.50, 5, 33, 49.00, false), -- 21
(17, 2, 'Macacão Lívia', 'Sem estampa / Geométrico / 40 ao 48', 22, 0.50, 5, 46, 47.00, false), -- 22

-- TECIDOS (usando prateleiras 11-18, IDs 11-18 = códigos '1T' a '8T')
(4, 11, 'Tecido Nylon', 'Rolo 50m', 23, 1.00, 5, 200, 1.60, false),
(5, 12, 'Tecido Poliéster', 'Rolo 50m', 24, 1.00, 5, 200, 1.40, false),
(6, 13, 'Tecido Algodão', 'Rolo 50m', 25, 26.00, 5, 200, 1.80, false),
(7, 14, 'Tecido Lã', 'Rolo 50m',26, 1.00, 26, 200, 2.40, false),
(8, 15, 'Tecido Moletinho', 'Rolo 50m',27, 1.00, 5, 250, 2.00, false),
(9, 16, 'Tecido Gorgurão', 'Rolo 50m',28, 1.00, 5, 202, 1.80, false),
(10, 17, 'Tecido Viscolycra', 'Rolo 50m',29, 1.00, 5, 200, 2.20, false),
(11, 18, 'Tecido Suplex', 'Rolo 50m',30, 1.00, 5, 190, 1.90, false);

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `alerta` (
  `id_alerta` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_item_estoque` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Alerta de estoque (Blusa Gola V)
INSERT INTO alerta (fk_item_estoque, descricao, data_hora) VALUES
(8, 'Estoque abaixo do mínimo', '2025-10-20 09:00:00');
-- Alerta de estoque (Blusa Gola Boba)
INSERT INTO alerta (fk_item_estoque, descricao, data_hora) VALUES
(5, 'Estoque abaixo do mínimo', '2025-05-20 08:00:00');
-- Alerta de estoque (Blusa Gola Quadrada)
INSERT INTO alerta (fk_item_estoque, descricao, data_hora) VALUES
(7, 'Estoque abaixo do mínimo', '2025-06-18 09:00:00');
-- Alerta de estoque (Blusa Meia Manga)
INSERT INTO alerta (fk_item_estoque, descricao, data_hora) VALUES
(10, 'Estoque abaixo do mínimo', '2025-08-20 10:00:00');
-- Alerta de estoque (Blusa Mulet)
INSERT INTO alerta (fk_item_estoque, descricao, data_hora) VALUES
(11, 'Estoque abaixo do mínimo', '2025-09-25 11:00:00');
-- Alerta de estoque (Blusa Mulet)
INSERT INTO alerta (fk_item_estoque, descricao, data_hora) VALUES
(11, 'Estoque abaixo do mínimo', '2025-09-25 11:00:00');

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `caracteristica_item_estoque` (
  `fk_categoria` INT NOT NULL,
  `fk_item_estoque` INT NOT NULL,
  PRIMARY KEY (`fk_categoria`, `fk_item_estoque`),
  FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Cadastro de características de cada produto e tecido.
INSERT INTO caracteristica_item_estoque (fk_categoria, fk_item_estoque) VALUES
	(32, 1),
	(18, 2),
	(20, 3),
	(20, 4),
	(21, 5),
	(19, 6),
	(22, 7),
	(22, 8),
	(30, 9),
	(23, 10),
	(29, 11),
	(19, 12),
	(25, 13),
	(28, 14),
	(30, 15),
	(30, 16),
	(26, 17),
	(30, 18),
	(30, 19),
	(32, 20),
	(20, 21),
	(27, 22);

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `confeccao_roupa` (
  `id_confeccao_roupa` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_roupa` INT NOT NULL,
  `fk_tecido` INT NOT NULL,
  `qtd_tecido` DECIMAL(5,2),
  FOREIGN KEY (`fk_roupa`) REFERENCES `item_estoque` (`id_item_estoque`),
  FOREIGN KEY (`fk_tecido`) REFERENCES `item_estoque` (`id_item_estoque`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- CONFECCAO_ROUPA CORRIGIDO
-- Agora fk_tecido aponta para os IDs corretos de tecidos (23-30)
INSERT INTO confeccao_roupa (fk_roupa, fk_tecido, qtd_tecido) VALUES
(1 , 29, 5.0),   -- Vestido Manga Curta → Viscolycra
(2 , 30, 5.0),   -- Vestido Canelado Mídi → Suplex
(3 , 29, 4.4),   -- Vestido Regata Estampado → Viscolycra
(4 , 29, 9.0),   -- Vestido Plus → Viscolycra
(5 , 30, 3.0),   -- Blusa Gola Boba → Suplex
(6 , 30, 3.0),   -- Blusa Regata Marrocos → Suplex
(7 , 29, 3.5),   -- Blusa Gola Quadrada → Viscolycra
(8 , 29, 3.5),   -- Blusa Gola V → Viscolycra
(9 , 29, 3.5),   -- Blusa De Ponta → Viscolycra
(10, 29, 3.5),  -- Blusa Meia Manga → Viscolycra
(11, 29, 3.5),  -- Blusa Mulet → Viscolycra
(12, 30, 3.5),  -- Blusa Paris → Suplex
(13, 30, 3.6),  -- Calça Montaria → Gorgurão
(14, 30, 3.6),  -- Calça Flare → Suplex
(15, 27, 3.6),  -- Calça Jogger → Moletinho
(16, 29, 5.0),  -- Conjunto Saia → Viscolycra
(17, 27, 6.0),  -- Conjunto Gabi → Moletinho
(18, 27, 6.0),  -- Conjunto Pantalona → Moletinho
(19, 27, 2.5),  -- Shorts Moletinho → Moletinho
(20, 27, 3.6),  -- Camisa Over → Moletinho
(21, 29, 7.5),  -- Macacão Lívia (Estampado) → Viscolycra
(22, 29, 7.5);  -- Macacão Lívia (Sem estampa) → Viscolycra

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `parceiro` (
  `id_parceiro` INT PRIMARY KEY AUTO_INCREMENT,
  `categoria` VARCHAR(45),
  `nome` VARCHAR(60),
  `telefone` CHAR(12),
  `email` VARCHAR(45),
  `endereco` VARCHAR(80),
  `identificacao` VARCHAR(20)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Cadastro de um serviço terceirizado (costura e fornecedor).
INSERT INTO parceiro (categoria, nome, telefone, email, endereco, identificacao) VAlUES 
	('costureira', 'Andresa', '11938563748', 'andresa@gmail.com', 'Rua Aurora, número 72', '00000000000'),
	('costureira', 'Maria', '11938563748', 'maria@gmail.com', 'Rua Y, número 171', '00000000001'),
	('costureira', 'Rute', '11938563748', 'rebeca@gmail.com', 'Rua Tal, número 442', '00000000002'),
	('costureira', 'Sueli', '11938563748', 'rebeca@gmail.com', 'Rua Z, núemro 777', '00000000002'),
	('costureira', 'Vera', '11938563748', 'rebeca@gmail.com', 'Rua Um, número 2', '00000000002'),
	('costureira', 'Gildete', '11938563748', 'rebeca@gmail.com', 'Rua Dois, número 1', '00000000002'),
	('fornecedor', 'Fornecedor Brás', '11918465729', 'fornecedorbrass@gmail.com', 'Rua Brás, número 1255', '00000000000000');

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `lote` (
  `id_lote` INT PRIMARY KEY AUTO_INCREMENT,
  `descricao` VARCHAR(45),
  `dt_entrada` DATETIME,
  `fk_parceiro` INT NOT NULL,
  `fk_responsavel` INT NOT NULL,
  FOREIGN KEY (`fk_parceiro`) REFERENCES `parceiro` (`id_parceiro`),
  FOREIGN KEY (`fk_responsavel`) REFERENCES `funcionario` (`id_funcionario`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Cadastro de lote de roupa.
INSERT INTO lote (descricao, dt_entrada, fk_parceiro, fk_responsavel) VAlUES 
	('lote de roupas', '2025-04-20 11:36:00', 1, 1);
-- Cadastro de lote de tecido.
INSERT INTO lote (descricao, dt_entrada, fk_parceiro, fk_responsavel) VAlUES 
	('lote de tecido', '2025-04-20 11:36:00', 2, 2);

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `lote_item_estoque` (
  `id_lote_item_estoque` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_item_estoque` INT,
  `fk_lote` INT,
  `qtd_item` DECIMAL(5,2),
  `preco` DECIMAL(5,2),
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`),
  FOREIGN KEY (`fk_lote`)REFERENCES `lote` (`id_lote`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Roupas (lote 1) - APENAS CUSTO DE COSTURA POR PEÇA (REDUZIDO)
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VALUES
(1, 1, 50, 350.00),   -- Vestido Manga Curta - costura
(1, 2, 50, 359.50),   -- Vestido Canelado Mídi - costura
(1, 3, 50, 380.50),   -- Vestido Regata Estampado - costura
(1, 4, 50, 390.00),   -- Vestido Plus - costura
(1, 5, 50, 288.00),   -- Blusa Gola Boba - costura
(1, 6, 50, 240.00),   -- Blusa Regata Marrocos - costura
(1, 7, 50, 260.50),   -- Blusa Gola Quadrada - costura
(1, 8, 50, 249.50),   -- Blusa Gola V - costura
(1, 9, 50, 273.50),   -- Blusa De Ponta - costura
(1, 10, 50, 243.00),  -- Blusa Meia Manga - costura
(1, 11, 50, 244.00),  -- Blusa Mulet - costura
(1, 12, 50, 243.50),  -- Blusa Paris - costura
(1, 13, 50, 264.50),  -- Calça Montaria - costura
(1, 14, 50, 265.00),  -- Calça Flare - costura
(1, 15, 50, 245.00),  -- Calça Jogger - costura
(1, 16, 50, 256.50),  -- Conjunto Saia - costura
(1, 17, 50, 249.00),  -- Conjunto Gabi - costura
(1, 18, 50, 249.00),  -- Conjunto Pantalona - costura
(1, 19, 50, 254.00),  -- Shorts Moletinho - costura
(1, 20, 50, 254.00),  -- Camisa Over - costura
(1, 21, 50, 257.50),  -- Macacão Lívia Estampado - costura
(1, 22, 50, 247.50);  -- Macacão Lívia Sem Estampa - costura

-- Tecidos (lote 2) - Preço total calculado (qtd_item * preço_por_metro)
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VALUES
(2, 23, 200, 320.00),  -- Nylon: m * R$1.60/m
(2, 24, 200, 280.00),  -- Poliéster: m * R$1.40/m
(2, 25, 200, 360.00),  -- Algodão: m * R$1.80/m
(2, 26, 200, 480.00),  -- Lã: m * R$2.40/m
(2, 27, 260, 520.00),  -- Moletinho: m * R$2.00/m
(2, 28, 210, 380.00),  -- Gorgurão: m * R$1.80/m
(2, 29, 210, 462.00),  -- Viscolycra: m * R$2.20/m
(2, 30, 200, 380.00);  -- Suplex: m * R$1.90/m

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `saida_estoque` (
  `id_saida_estoque` INT PRIMARY KEY AUTO_INCREMENT,
  `data` DATE,
  `hora` TIME,
  `qtd_saida` DECIMAL(5,2),
  `motivo_saida` VARCHAR(80),
  `fk_responsavel` INT NOT NULL,
  `fk_lote_item_estoque` INT NOT NULL,
  `fk_costureira` INT NULL,
  FOREIGN KEY (`fk_responsavel`) REFERENCES `funcionario` (`id_funcionario`),
  FOREIGN KEY (`fk_lote_item_estoque`) REFERENCES `lote_item_estoque` (`id_lote_item_estoque`),
  FOREIGN KEY (`fk_costureira`) REFERENCES `parceiro` (`id_parceiro`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

-- Cadastro de saída do estoque (envio para costura).
-- INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira)
-- VAlUES (current_date(), current_time(), 2.50, 'envio de tecido para costura', 1, 6, 1);
-- Cadastro de saída do estoque (venda).
-- INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque)
-- VAlUES (current_date(), current_time(), 2, 'produto vendido', 3, 3);

-- ============================================
-- SAÍDAS DE ESTOQUE - 2025 
-- Negócio iniciado em MARÇO/2025
-- ============================================
-- MARÇO 2025 (Início do negócio - vendas baixas)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-03-10', '10:00:00', 2, 'venda brás', 1, 5),
('2025-03-15', '11:30:00', 1, 'venda ecommerce', 2, 7),
('2025-03-20', '14:00:00', 3, 'venda brás', 1, 13),
('2025-03-25', '15:30:00', 2, 'venda brás', 3, 1);
-- Envios para costura Março 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-03-05', '08:00:00', 15.0, 'envio de tecido para costura', 1, 27, 1),
('2025-03-18', '09:00:00', 12.0, 'envio de tecido para costura', 2, 29, 2);

-- ABRIL 2025 (Crescimento inicial)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-04-03', '10:30:00', 3, 'venda brás', 1, 2),
('2025-04-08', '11:00:00', 2, 'venda brás', 2, 4),
('2025-04-12', '13:45:00', 4, 'venda brás', 3, 6),
('2025-04-18', '14:30:00', 2, 'venda ecommerce', 1, 14),
('2025-04-25', '16:00:00', 3, 'venda brás', 2, 19);
-- Defeito Abril 2025 (taxa baixíssima)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-04-20', '09:00:00', 1, 'defeito de costura', 1, 7, 2);
-- Envios para costura Abril 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-04-02', '08:00:00', 18.0, 'envio de tecido para costura', 1, 28, 3),
('2025-04-16', '08:30:00', 14.0, 'envio de tecido para costura', 2, 30, 1);

-- MAIO 2025 (Vendas aumentando)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-05-05', '10:00:00', 4, 'venda brás', 1, 1),
('2025-05-08', '11:30:00', 3, 'venda brás', 2, 3),
('2025-05-12', '13:00:00', 5, 'venda brás', 3, 13),
('2025-05-18', '14:30:00', 2, 'venda ecommerce', 1, 16),
('2025-05-22', '15:00:00', 4, 'venda brás', 2, 7),
('2025-05-28', '16:30:00', 3, 'venda brás', 3, 20);
-- Envios para costura Maio 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-05-03', '08:00:00', 20.0, 'envio de tecido para costura', 1, 27, 4),
('2025-05-17', '09:00:00', 16.0, 'envio de tecido para costura', 2, 29, 2);

-- JUNHO 2025 (Crescimento consistente)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-06-02', '10:15:00', 5, 'venda brás', 1, 2),
('2025-06-06', '11:00:00', 4, 'venda brás', 2, 5),
('2025-06-10', '13:30:00', 6, 'venda brás', 3, 14),
('2025-06-15', '14:45:00', 3, 'venda ecommerce', 1, 8),
('2025-06-20', '15:30:00', 5, 'venda brás', 2, 19),
('2025-06-25', '16:00:00', 4, 'venda brás', 3, 22);
-- Envios para costura Junho 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-06-04', '08:00:00', 22.0, 'envio de tecido para costura', 1, 28, 5),
('2025-06-18', '08:30:00', 18.0, 'envio de tecido para costura', 2, 30, 3);

-- JULHO 2025 (Consolidação)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-07-03', '10:00:00', 6, 'venda brás', 1, 1),
('2025-07-08', '11:30:00', 5, 'venda brás', 2, 6),
('2025-07-12', '13:00:00', 7, 'venda brás', 3, 13),
('2025-07-17', '14:30:00', 4, 'venda ecommerce', 1, 10),
('2025-07-22', '15:15:00', 6, 'venda brás', 2, 16),
('2025-07-28', '16:00:00', 5, 'venda brás', 3, 20);
-- Defeito Julho 2025 (taxa baixíssima)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-07-15', '09:30:00', 1, 'defeito de acabamento', 2, 13, 4);
-- Envios para costura Julho 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-07-05', '08:00:00', 25.0, 'envio de tecido para costura', 1, 27, 6),
('2025-07-19', '08:30:00', 20.0, 'envio de tecido para costura', 2, 29, 1);

-- AGOSTO 2025 (Boa performance)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-08-02', '10:00:00', 7, 'venda brás', 1, 2),
('2025-08-07', '11:00:00', 6, 'venda brás', 2, 4),
('2025-08-12', '13:30:00', 8, 'venda brás', 3, 12),
('2025-08-16', '14:00:00', 5, 'venda ecommerce', 1, 17),
('2025-08-21', '15:30:00', 7, 'venda brás', 2, 21),
('2025-08-26', '16:15:00', 6, 'venda brás', 3, 14);
-- Envios para costura Agosto 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-08-05', '08:00:00', 28.0, 'envio de tecido para costura', 1, 28, 2),
('2025-08-20', '08:30:00', 22.0, 'envio de tecido para costura', 2, 30, 4);

-- SETEMBRO 2025 (Crescimento acelerado)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-09-03', '10:15:00', 8, 'venda brás', 1, 1),
('2025-09-08', '11:30:00', 7, 'venda brás', 2, 7),
('2025-09-12', '13:00:00', 9, 'venda brás', 3, 13),
('2025-09-17', '14:30:00', 6, 'venda ecommerce', 1, 11),
('2025-09-22', '15:00:00', 8, 'venda brás', 2, 19),
('2025-09-27', '16:00:00', 7, 'venda brás', 3, 16);
-- Envios para costura Setembro 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-09-02', '08:00:00', 30.0, 'envio de tecido para costura', 1, 27, 5),
('2025-09-16', '08:30:00', 25.0, 'envio de tecido para costura', 2, 29, 3),
('2025-09-25', '09:00:00', 20.0, 'envio de tecido para costura', 3, 30, 6);

-- OUTUBRO 2025 (Mês atual - melhor performance)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque) VALUES
('2025-10-02', '10:00:00', 9, 'venda brás', 1, 2),
('2025-10-05', '11:00:00', 8, 'venda brás', 2, 5),
('2025-10-08', '13:30:00', 10, 'venda brás', 3, 13),
('2025-10-12', '14:00:00', 7, 'venda ecommerce', 1, 6),
('2025-10-15', '15:00:00', 9, 'venda brás', 2, 14),
('2025-10-18', '16:00:00', 8, 'venda brás', 3, 19),
('2025-10-22', '10:30:00', 10, 'venda brás', 1, 21),
('2025-10-25', '11:30:00', 9, 'venda brás', 2, 7),
('2025-10-28', '14:00:00', 8, 'venda brás', 3, 1);
-- Defeito Outubro 2025 (taxa baixíssima)
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-10-10', '09:30:00', 1, 'defeito de costura', 1, 5, 2);
-- Envios para costura Outubro 2025
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira) VALUES
('2025-10-01', '08:00:00', 35.0, 'envio de tecido para costura', 1, 28, 1),
('2025-10-15', '08:30:00', 30.0, 'envio de tecido para costura', 2, 29, 4),
('2025-10-28', '09:00:00', 25.0, 'envio de tecido para costura', 3, 27, 2);


-- Trigger para atualizar quantidade armazenada em estoque com base em entrada de lote
-- CREATE TRIGGER update_stock BEFORE INSERT ON lote_item_estoque
-- 	FOR EACH ROW UPDATE item_estoque SET qtd_armazenado = qtd_armazenado + NEW.qtd_item
-- 		WHERE item_estoque.id_item_estoque = NEW.fk_item_estoque;
-- DROP TRIGGER update_stock;

-- Trigger para atualizar quantidade armazenada em estoque em caso de saÍda
-- CREATE TRIGGER update_stock_saida BEFORE INSERT ON saida_estoque
-- 	FOR EACH ROW UPDATE item_estoque SET qtd_armazenado = qtd_armazenado - NEW.qtd_saida
-- 		WHERE item_estoque.id_item_estoque = NEW.fk_item_estoque;
-- DROP TRIGGER update_stock_saida;

-- CREATE VIEW autocomplete_saida AS
-- SELECT * FROM (
--   SELECT lie.fk_lote, 
--   lie.fk_item_estoque, 
--   ie.descricao, (lie.qtd_item - (sum(se.qtd_saida))) as quantidade,
--   lie.preco
--     FROM lote_item_estoque as lie 
--       JOIN saida_estoque as se
--         ON lie.id_lote_item_estoque = se.fk_lote_item_estoque
--       JOIN item_estoque as ie
--         ON ie.id_item_estoque = lie.fk_item_estoque
--       GROUP BY lie.fk_item_estoque, se.fk_lote_item_estoque, lie.fk_lote
--         UNION
--   SELECT lie.fk_lote,  
--   lie.fk_item_estoque, 
--   ie.descricao, 
--   qtd_item as quantidade,
--   ie.preco
--     FROM lote_item_estoque as lie
--       JOIN item_estoque as ie
--         ON ie.id_item_estoque = lie.fk_item_estoque
--       WHERE lie.id_lote_item_estoque NOT IN (SELECT se.fk_lote_item_estoque FROM saida_estoque as se)
--     ) as t WHERE quantidade > 0 
--   ORDER BY t.descricao, t.fk_lote;

CREATE VIEW autocomplete_saida AS
SELECT * FROM (
  SELECT lie.fk_lote, 
  lie.fk_item_estoque, 
  ie.descricao, (lie.qtd_item - (sum(se.qtd_saida))) as quantidade,
  ie.preco,
  lie.id_lote_item_estoque,
  c.fk_categoria_pai
    FROM lote_item_estoque as lie 
      JOIN saida_estoque as se
        ON lie.id_lote_item_estoque = se.fk_lote_item_estoque
      JOIN item_estoque as ie
        ON ie.id_item_estoque = lie.fk_item_estoque
	  JOIN categoria as c
	  	ON ie.fk_categoria = c.id_categoria
      GROUP BY lie.fk_item_estoque, se.fk_lote_item_estoque, lie.fk_lote, lie.id_lote_item_estoque
        UNION
  SELECT lie.fk_lote,  
  lie.fk_item_estoque, 
  ie.descricao, 
  qtd_item as quantidade,
  ie.preco,
  lie.id_lote_item_estoque,
  c.fk_categoria_pai
    FROM lote_item_estoque as lie
      JOIN item_estoque as ie
        ON ie.id_item_estoque = lie.fk_item_estoque
	  JOIN categoria AS c
	  	ON ie.fk_categoria = c.id_categoria
      WHERE lie.id_lote_item_estoque NOT IN (SELECT se.fk_lote_item_estoque FROM saida_estoque as se)
    ) as t WHERE quantidade > 0 
  ORDER BY t.descricao, t.fk_lote;

-- select * from autocomplete_saida;

-- select * from lote;