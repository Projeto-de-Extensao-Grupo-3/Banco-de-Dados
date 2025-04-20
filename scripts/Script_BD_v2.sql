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

CREATE TABLE IF NOT EXISTS `permissao` (
  `id_permissao` INT PRIMARY KEY AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS `controle_acesso` (
  `fk_funcionario` INT NOT NULL,
  `fk_permissao` INT NOT NULL,
  PRIMARY KEY (`fk_funcionario`, `fk_permissao`),
  FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario` (`id_funcionario`),
  FOREIGN KEY (`fk_permissao`) REFERENCES `permissao` (`id_permissao`)
);

CREATE TABLE IF NOT EXISTS `local_armazenamento` (
  `id_local_armazenamento` INT PRIMARY KEY AUTO_INCREMENT,
  `num_prateleira` VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` INT PRIMARY KEY AUTO_INCREMENT,
  `nome` VARCHAR(45),
  `fk_categoria_pai` INT,
  FOREIGN KEY (`fk_categoria_pai`) REFERENCES `categoria` (`id_categoria`)
);

CREATE TABLE IF NOT EXISTS `item_estoque` (
  `id_item_estoque` INT PRIMARY KEY AUTO_INCREMENT,
  `fk_categoria` INT NOT NULL,
  `fk_local_armazenamento` INT NOT NULL,
  `descricao` VARCHAR(60),
  `peso` DECIMAL(5,2),
  `qtd_minimo` DECIMAL(5,2),
  `qtd_armazenado` DECIMAL(5,2),
  FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  FOREIGN KEY (`fk_local_armazenamento`) REFERENCES `local_armazenamento` (`id_local_armazenamento`)
);

CREATE TABLE IF NOT EXISTS `caracteristica_item_estoque` (
  `fk_categoria` INT NOT NULL,
  `fk_item_estoque` INT NOT NULL,
  PRIMARY KEY (`fk_categoria`, `fk_item_estoque`),
  FOREIGN KEY (`fk_categoria`) REFERENCES `categoria` (`id_categoria`),
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`)
);

CREATE TABLE IF NOT EXISTS `confeccao_roupa` (
  `fk_roupa` INT NOT NULL,
  `fk_tecido` INT NOT NULL,
  PRIMARY KEY (`fk_roupa`, `fk_tecido`),
  FOREIGN KEY (`fk_roupa`) REFERENCES `item_estoque` (`id_item_estoque`),
  FOREIGN KEY (`fk_tecido`) REFERENCES `item_estoque` (`id_item_estoque`)
);

CREATE TABLE IF NOT EXISTS `servico_terceiro` (
  `id_servico_terceiro` INT PRIMARY KEY AUTO_INCREMENT,
  `categoria` VARCHAR(45),
  `nome` VARCHAR(60),
  `telefone` CHAR(12),
  `email` VARCHAR(45),
  `endereco` VARCHAR(80),
  `identificacao` VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS `lote` (
  `id_lote` INT PRIMARY KEY AUTO_INCREMENT,
  `descricao` VARCHAR(45),
  `dt_entrada` DATETIME,
  `fk_servico_terceiro` INT NOT NULL,
  `fk_responsavel` INT NOT NULL,
  FOREIGN KEY (`fk_servico_terceiro`) REFERENCES `servico_terceiro` (`id_servico_terceiro`),
  FOREIGN KEY (`fk_responsavel`) REFERENCES `funcionario` (`id_funcionario`)
);

CREATE TABLE IF NOT EXISTS `lote_item_estoque` (
  `fk_item_estoque` INT,
  `fk_lote` INT,
  `qtd_item` DECIMAL(5,2),
  `preco` DECIMAL(5,2),
  PRIMARY KEY (`fk_item_estoque`, `fk_lote`),
  FOREIGN KEY (`fk_item_estoque`) REFERENCES `item_estoque` (`id_item_estoque`),
  FOREIGN KEY (`fk_lote`)REFERENCES `lote` (`id_lote`)
);

CREATE TABLE IF NOT EXISTS `saida_estoque` (
  `id_saida_estoque` INT PRIMARY KEY AUTO_INCREMENT,
  `data` DATE,
  `hora` TIME,
  `qtd_saida` DECIMAL(5,2),
  `motivo_saida` VARCHAR(80),
  `fk_responsavel` INT NOT NULL,
  `fk_lote` INT NOT NULL,
  `fk_item_estoque` INT NOT NULL,
  `fk_costureira` INT NULL,
  FOREIGN KEY (`fk_responsavel`) REFERENCES `funcionario` (`id_funcionario`),
  FOREIGN KEY (`fk_lote`, `fk_item_estoque`) REFERENCES `lote_item_estoque` (`fk_lote`, `fk_item_estoque`),
  FOREIGN KEY (`fk_costureira`) REFERENCES `servico_terceiro` (`id_servico_terceiro`)
);

CREATE TABLE IF NOT EXISTS `corte_tecido` (
  `id_corte_tecido` INT NOT NULL AUTO_INCREMENT,
  `fk_lote` INT NOT NULL,
  `fk_tecido` INT NOT NULL,
  `fk_funcionario` INT NOT NULL,
  `inicio` DATETIME,
  `termino` DATETIME,
  PRIMARY KEY (`id_corte_tecido`, `fk_lote`, `fk_tecido`, `fk_funcionario`),
  FOREIGN KEY (`fk_lote` , `fk_tecido`) REFERENCES `lote_item_estoque` (`fk_lote`, `fk_item_estoque`),
  FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario` (`id_funcionario`)
);


-- Trigger para atualizar quantidade armazenada em estoque com base em entrada de lote
CREATE TRIGGER update_stock BEFORE INSERT ON lote_item_estoque
	FOR EACH ROW UPDATE item_estoque SET qtd_armazenado = qtd_armazenado + NEW.qtd_item
		WHERE item_estoque.id_item_estoque = NEW.fk_item_estoque;
-- DROP TRIGGER update_stock;

-- Trigger para atualizar quantidade armazenada em estoque em caso de saÍda
CREATE TRIGGER update_stock_saida BEFORE INSERT ON saida_estoque
	FOR EACH ROW UPDATE item_estoque SET qtd_armazenado = qtd_armazenado - NEW.qtd_saida
		WHERE item_estoque.id_item_estoque = NEW.fk_item_estoque;
-- DROP TRIGGER update_stock_saida;