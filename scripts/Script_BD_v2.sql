DROP DATABASE IF EXISTS projeto_extensao;
CREATE DATABASE projeto_extensao;
USE projeto_extensao;

CREATE TABLE IF NOT EXISTS `funcionario` (
  `id_funcionario` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(80),
  `cpf` CHAR(11),
  `telefone` CHAR(12),
  `email` VARCHAR(60),
  `senha` VARCHAR(45)
);
-- Cadastro de funcionários.
INSERT INTO funcionario (nome, cpf, telefone, email, senha) VALUES
	('Bruno', '83756473891', '11985647381', 'bruno@gmail.com', '123456@'),
	('Fernando', '83756473892', '11985647382', 'fernando@gmail.com', '123456@'),
	('Giorgio', '83756473893', '11985647383', 'giorgio@gmail.com', '123456@'),
	('Guilherme', '83756473894', '11985647384', 'guilherme@gmail.com', '123456@'),
	('João', '83756473895', '11985647385', 'joao@gmail.com', '123456@'),
	('Leandro', '83756473896', '11985647386', 'leandro@gmail.com', '123456@');

CREATE TABLE IF NOT EXISTS `permissao` (
  `id_permissao` INT PRIMARY KEY AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL
);
-- Permissões serão fixas no banco, não será necessário cadastro ou atualização
INSERT INTO permissao (descricao) VALUES
	('Visualizar dashboard'),
	('Cadastrar funcionários'),
	('Visualizar histórico do estoque'),
    ('Registrar movimentação do estoque'),
	('Visualizar dados de itens do estoque'),
	('Cadastrar itens do estoque'),
	('Receber alertas de falta de estoque');

CREATE TABLE IF NOT EXISTS `controle_acesso` (
  `fk_funcionario` INT NOT NULL,
  `fk_permissao` INT NOT NULL,
  PRIMARY KEY (`fk_funcionario`, `fk_permissao`),
  FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario` (`id_funcionario`),
  FOREIGN KEY (`fk_permissao`) REFERENCES `permissao` (`id_permissao`)
);
-- Cadastrar as permissões de acesso do funcionário.
INSERT INTO controle_acesso (fk_funcionario, fk_permissao) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
    (2, 1),
	(2, 2),
	(2, 3),
    (3, 1),
	(3, 2),
	(3, 3),
    (4, 1),
	(4, 2),
	(4, 3),
    (5, 1),
	(5, 2),
	(5, 3),
	(6, 1),
	(6, 2),
	(6, 3);

CREATE TABLE IF NOT EXISTS `prateleira` (
  `id_prateleira` INT PRIMARY KEY AUTO_INCREMENT,
  `codigo` VARCHAR(10) UNIQUE NOT NULL
);
-- Cadastro de identificação de prateleiras/local de armazenamento.
INSERT INTO prateleira (codigo) VALUES
	('1R'),
	('2R'),
	('3R'),
	('1T'),
	('2T'),
	('3T');

CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(45),
  `fk_categoria_pai` INT,
  FOREIGN KEY (`fk_categoria_pai`) REFERENCES `categoria` (`id_categoria`)
);
-- Categorias roupa e tecido serão fixas no banco de dados.
INSERT INTO categoria (nome) VALUES
	('Tecido'),
	('Roupa');
-- Cadastro de subcategorias para tecido e roupa.
INSERT INTO categoria (nome, fk_categoria_pai) VALUES
	('Nylon', 1),
	('Poliéster', 1),
	('Algodão', 1),
	('Seda', 1),
	('Lã', 1),
	('Vestido', 2),
	('Camiseta', 2),
	('Calça', 2),
	('Shorts', 2),
	('Saia', 2);
-- Cadastro de características de tecido e produto.
INSERT INTO categoria (nome) VALUES
	('Azul'),
	('Vermelho'),
	('Verde'),
	('Amarelo'),
	('Cinza'),
	('Listrado'),
	('Liso'),
	('Florido'),
	('Grosso'),
	('Fino');

CREATE TABLE IF NOT EXISTS `imagem` (
	`id_imagem` INT PRIMARY KEY AUTO_INCREMENT,
    `url` VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS `item_estoque` (
  `id_item_estoque` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_categoria` INT NOT NULL,
  `fk_prateleira` INT,
  `fk_imagem` INT,
  `descricao` VARCHAR(60),
  `complemento` VARCHAR(45),
  `peso` DECIMAL(5,2),
  `qtd_minimo` DECIMAL(5,2),
  `qtd_armazenado` DECIMAL(5,2),
  `preco` DECIMAL(5,2),
  FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  FOREIGN KEY (`fk_prateleira`) REFERENCES `prateleira` (`id_prateleira`),
  FOREIGN KEY (`fk_imagem`) REFERENCES `imagem` (`id_imagem`)
);
-- Cadastro de itens do estoque (peças de roupa e tecidos).
INSERT INTO item_estoque (fk_categoria, fk_prateleira, descricao, peso, qtd_minimo, qtd_armazenado, preco) VALUES
	(8, 1, 'Vestido azul florido', 1.0, 0, 0, NULL),
	(9, 2, 'Camisa vermelha lisa', 1.0, 0, 0, NULL),
	(11, 3, 'Bermuda cinza com listras vermelhas', 1.0, 0, 0, NULL),
	(5, 4, 'Tecido vermelho liso', 1.0, 0, 0, 100.0),
	(6, 5, 'Tecido azul florido', 1.0, 0, 0, 150.0),
	(3, 6, 'Tecido cinza liso', 1.0, 0, 0, 200.0);

CREATE TABLE IF NOT EXISTS `alerta` (
  `id_alerta` INT PRIMARY KEY,
  `fk_item_estoque` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
);

CREATE TABLE IF NOT EXISTS `caracteristica_item_estoque` (
  `fk_categoria` INT NOT NULL,
  `fk_item_estoque` INT NOT NULL,
  PRIMARY KEY (`fk_categoria`, `fk_item_estoque`),
  FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
);
-- Cadastro de características de cada produto e tecido.
INSERT INTO caracteristica_item_estoque (fk_categoria, fk_item_estoque) VALUES
	(13, 1),
	(20, 1),
	(14, 2),
	(19, 2),
	(17, 3),
	(18, 3),
	(14, 3),
	(14, 4),
	(19, 4),
	(13, 5),
	(20, 5),
	(17, 6),
	(19, 6);

CREATE TABLE IF NOT EXISTS `confeccao_roupa` (
  `id_confeccao_roupa` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_roupa` INT NOT NULL,
  `fk_tecido` INT NOT NULL,
  `qtd_tecido` DECIMAL(5,2),
  FOREIGN KEY (`fk_roupa`) REFERENCES `item_estoque` (`id_item_estoque`),
  FOREIGN KEY (`fk_tecido`) REFERENCES `item_estoque` (`id_item_estoque`)
);
-- Relacionar os tecidos que compõem uma peça de roupa.
INSERT INTO confeccao_roupa (fk_roupa, fk_tecido, qtd_tecido) VALUES
	(1, 5, 10.0),
	(2, 4, 10.0),
	(3, 4, 10.0),
	(3, 6, 10.0);

CREATE TABLE IF NOT EXISTS `parceiro` (
  `id_parceiro` INT PRIMARY KEY AUTO_INCREMENT,
  `categoria` VARCHAR(45),
  `nome` VARCHAR(60),
  `telefone` CHAR(12),
  `email` VARCHAR(45),
  `endereco` VARCHAR(80),
  `identificacao` VARCHAR(20)
);
-- Cadastro de um serviço terceirizado (costura e fornecedor).
INSERT INTO parceiro (categoria, nome, telefone, email, endereco) VAlUES 
	('costureira', 'Maria', '11938563748', 'maria@gmail.com', 'Rua X'),
	('costureira', 'Alice', '11938563748', 'alice@gmail.com', 'Rua Y'),
	('costureira', 'Rebeca', '11938563748', 'rebeca@gmail.com', 'Rua Z'),
	('fornecedor', 'Best Tecidos', '11918465729', 'best_tecidos@gmail.com', 'Rua 1'),
	('fornecedor', 'Fornecedor X', '11918465729', 'fornecedorx@gmail.com', 'Rua 2'),
	('fornecedor', 'Fornecedor Z', '11918465729', 'fornecedorys@gmail.com', 'Rua 3');

CREATE TABLE IF NOT EXISTS `lote` (
  `id_lote` INT PRIMARY KEY AUTO_INCREMENT,
  `descricao` VARCHAR(45),
  `dt_entrada` DATETIME,
  `fk_parceiro` INT NOT NULL,
  `fk_responsavel` INT NOT NULL,
  FOREIGN KEY (`fk_parceiro`) REFERENCES `parceiro` (`id_parceiro`),
  FOREIGN KEY (`fk_responsavel`) REFERENCES `funcionario` (`id_funcionario`)
);
-- Cadastro de lote de roupa.
INSERT INTO lote (descricao, dt_entrada, fk_parceiro, fk_responsavel) VAlUES 
	('lote de roupas', '2025-04-20 11:36:00', 1, 1);
-- Cadastro de lote de tecido.
INSERT INTO lote (descricao, dt_entrada, fk_parceiro, fk_responsavel) VAlUES 
	('lote de tecido', '2025-04-20 11:36:00', 2, 2);

CREATE TABLE IF NOT EXISTS `lote_item_estoque` (
  `id_lote_item_estoque` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_item_estoque` INT,
  `fk_lote` INT,
  `qtd_item` DECIMAL(5,2),
  `preco` DECIMAL(5,2),
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`),
  FOREIGN KEY (`fk_lote`)REFERENCES `lote` (`id_lote`)
);
-- Cadastro dos itens de um lote.
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VAlUES -- teste roupa
	(1, 1, 5, 100.0),
    (1, 2, 3, 150.0),
    (1, 3, 10, 200.0);
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VAlUES -- teste tecido
	(2, 4, 3.5, 80.0),
	(2, 5, 6.5, 70.0),
	(2, 6, 12.5, 120.0);

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
-- Cadastro de saída do estoque (envio para costura).
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque, fk_costureira)
	VAlUES (current_date(), current_time(), 2.50, 'envio de tecido para costura', 1, 6, 1);
-- Cadastro de saída do estoque (venda).
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote_item_estoque)
	VAlUES (current_date(), current_time(), 2, 'produto vendido', 3, 3);

CREATE TABLE IF NOT EXISTS `corte_tecido` (
  `id_corte_tecido` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_lote_item_estoque` INT NOT NULL,
  `fk_funcionario` INT NOT NULL,
  `inicio` DATETIME,
  `termino` DATETIME,
  FOREIGN KEY (`fk_lote_item_estoque`) REFERENCES `lote_item_estoque` (`id_lote_item_estoque`),
  FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario` (`id_funcionario`)
);
-- Cadastro de corte de tecido.
INSERT INTO corte_tecido (fk_lote_item_estoque, fk_funcionario, inicio, termino) VALUES
	(4, 1, '2025-04-20 11:36:00', '2025-04-20 12:36:00'),
	(5, 1, '2025-04-20 14:36:00', '2025-04-20 16:36:00'),
	(6, 2, '2025-04-10 11:36:00', '2025-04-10 11:36:00'),
	(4, 3, '2025-04-10 11:36:00', '2025-04-10 11:36:00'),
	(6, 5, '2025-04-10 11:36:00', '2025-04-10 11:36:00');

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