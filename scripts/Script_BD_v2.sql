DROP DATABASE IF EXISTS projeto_extensao;
CREATE SCHEMA IF NOT EXISTS `projeto_extensao`;
USE `projeto_extensao`;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`item_estoque` (
  `id_item_estoque` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `complemento` VARCHAR(60) NULL,
  `peso` DECIMAL(5,2) NULL,
  `qtd_minimo` DECIMAL(5,2) NULL,
  `qtd_armazenado` DECIMAL(5,2) NULL,
  PRIMARY KEY (`id_item_estoque`))
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`servico_terceiro` (
  `id_servico_terceiro` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NULL,
  `nome` VARCHAR(60) NULL,
  `telefone` CHAR(12) NULL,
  `email` VARCHAR(45) NULL,
  `endereco` VARCHAR(80) NULL,
  `identificacao` VARCHAR(20) NULL,
  PRIMARY KEY (`id_servico_terceiro`))
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`lote` (
  `id_lote` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `dt_entrada` DATETIME NULL,
  `fk_servico_terceiro` INT NOT NULL,
  PRIMARY KEY (`id_lote`),
  INDEX `fk_lote_servico_terceiro1_idx` (`fk_servico_terceiro` ASC) VISIBLE,
  CONSTRAINT `fk_lote_servico_terceiro1`
    FOREIGN KEY (`fk_servico_terceiro`)
    REFERENCES `projeto_extensao`.`servico_terceiro` (`id_servico_terceiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`lote_item_estoque` (
  `fk_lote` INT NOT NULL,
  `fk_item_estoque` INT NOT NULL,
  `qtd_item` DECIMAL(5,2) NULL,
  `preco` DECIMAL(5,2) NULL,
  PRIMARY KEY (`fk_lote`, `fk_item_estoque`),
  INDEX `fk_item_estoque_has_lote_lote1_idx` (`fk_item_estoque` ASC) VISIBLE,
  INDEX `fk_item_estoque_has_lote_item_estoque1_idx` (`fk_lote` ASC) VISIBLE,
  CONSTRAINT `fk_item_estoque_has_lote_item_estoque1`
    FOREIGN KEY (`fk_lote`)
    REFERENCES `projeto_extensao`.`item_estoque` (`id_item_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_estoque_has_lote_lote1`
    FOREIGN KEY (`fk_item_estoque`)
    REFERENCES `projeto_extensao`.`lote` (`id_lote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`funcionario` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NULL,
  `cpf` CHAR(11) NULL,
  `telefone` CHAR(12) NULL,
  `email` VARCHAR(60) NULL,
  `senha` VARCHAR(45) NULL,
  PRIMARY KEY (`id_funcionario`))
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`saida_estoque` (
  `id_saida_estoque` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NULL,
  `hora` TIME NULL,
  `qtd_saida` DECIMAL(5,2) NULL,
  `motivo_saida` VARCHAR(80) NULL,
  `fk_responsavel` INT NOT NULL,
  `fk_lote` INT NOT NULL,
  `fk_item_estoque` INT NOT NULL,
  `fk_costureira` INT NOT NULL,
  PRIMARY KEY (`id_saida_estoque`),
  INDEX `fk_log_estoque_funcionario1_idx` (`fk_responsavel` ASC) VISIBLE,
  INDEX `fk_log_estoque_lote_item_estoque1_idx` (`fk_lote` ASC, `fk_item_estoque` ASC) VISIBLE,
  INDEX `fk_saida_estoque_servico_terceiro1_idx` (`fk_costureira` ASC) VISIBLE,
  CONSTRAINT `fk_log_estoque_funcionario1`
    FOREIGN KEY (`fk_responsavel`)
    REFERENCES `projeto_extensao`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_estoque_lote_item_estoque1`
    FOREIGN KEY (`fk_lote` , `fk_item_estoque`)
    REFERENCES `projeto_extensao`.`lote_item_estoque` (`fk_lote` , `fk_item_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_saida_estoque_servico_terceiro1`
    FOREIGN KEY (`fk_costureira`)
    REFERENCES `projeto_extensao`.`servico_terceiro` (`id_servico_terceiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`confeccao_roupa` (
  `fk_roupa` INT NOT NULL,
  `fk_tecido` INT NOT NULL,
  PRIMARY KEY (`fk_roupa`, `fk_tecido`),
  INDEX `fk_item_estoque_has_item_estoque_item_estoque4_idx` (`fk_tecido` ASC) VISIBLE,
  INDEX `fk_item_estoque_has_item_estoque_item_estoque3_idx` (`fk_roupa` ASC) VISIBLE,
  CONSTRAINT `fk_item_estoque_has_item_estoque_item_estoque3`
    FOREIGN KEY (`fk_roupa`)
    REFERENCES `projeto_extensao`.`item_estoque` (`id_item_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_estoque_has_item_estoque_item_estoque4`
    FOREIGN KEY (`fk_tecido`)
    REFERENCES `projeto_extensao`.`item_estoque` (`id_item_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`permissao` (
  `id_permissao` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`id_permissao`))
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`controle_acesso` (
  `fk_funcionario` INT NOT NULL,
  `fk_permissao` INT NOT NULL,
  PRIMARY KEY (`fk_funcionario`, `fk_permissao`),
  INDEX `fk_funcionario_has_permissao_permissao1_idx` (`fk_permissao` ASC) VISIBLE,
  INDEX `fk_funcionario_has_permissao_funcionario1_idx` (`fk_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_has_permissao_funcionario1`
    FOREIGN KEY (`fk_funcionario`)
    REFERENCES `projeto_extensao`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_has_permissao_permissao1`
    FOREIGN KEY (`fk_permissao`)
    REFERENCES `projeto_extensao`.`permissao` (`id_permissao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS `projeto_extensao`.`corte_tecido` (
  `fk_lote` INT NOT NULL,
  `fk_tecido` INT NOT NULL,
  `fk_funcionario` INT NOT NULL,
  `inicio` DATETIME NULL,
  `termino` DATETIME NULL,
  PRIMARY KEY (`fk_lote`, `fk_tecido`, `fk_funcionario`),
  INDEX `fk_lote_item_estoque_has_funcionario_funcionario1_idx` (`fk_funcionario` ASC) VISIBLE,
  INDEX `fk_lote_item_estoque_has_funcionario_lote_item_estoque1_idx` (`fk_lote` ASC, `fk_tecido` ASC) VISIBLE,
  CONSTRAINT `fk_lote_item_estoque_has_funcionario_lote_item_estoque1`
    FOREIGN KEY (`fk_lote` , `fk_tecido`)
    REFERENCES `projeto_extensao`.`lote_item_estoque` (`fk_lote` , `fk_item_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lote_item_estoque_has_funcionario_funcionario1`
    FOREIGN KEY (`fk_funcionario`)
    REFERENCES `projeto_extensao`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;
