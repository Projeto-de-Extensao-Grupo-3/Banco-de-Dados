USE projeto_extensao;
SHOW TABLES;

DESC funcionario;
INSERT INTO funcionario VALUES(null, 'David', '83756473896', '11985647382', 'david@gmail.com', 'Sjgi%#_J>23dH');
SELECT * FROM funcionario;

DESC item_estoque;
-- TRUNCATE TABLE item_estoque;
INSERT INTO item_estoque VALUES (null, 'roupa', 'vestido,azul', 'florido', 1.0, null, 0);
INSERT INTO item_estoque VALUES (null, 'roupa', 'camisa,vermelho', 'liso', 1.0, null, 0);
INSERT INTO item_estoque VALUES (null, 'tecido', 'marrom', 'listrado', 1.0, null, 0);
SELECT * FROM item_estoque;

DESC servico_terceiro;
INSERT INTO servico_terceiro VAlUES (null, 'costureira', 'Maria', '11938563748', 'maria@gmail.com', 'Rua X', null);
INSERT INTO servico_terceiro VAlUES (null, 'fornecedor', 'Best Tecidos', '11918465729', 'best_tecidos@gmail.com', 'Rua Y', null);
SELECT * FROM servico_terceiro;

DESC lote;
INSERT INTO lote VAlUES (null, 'lote de roupas', now(), 1);
INSERT INTO lote VAlUES (null, 'lote de tecido', now(), 2);
SELECT * FROM lote;

-- Trigger para atualizar quantidade armazenada em estoque com base em entrada de lote
CREATE TRIGGER update_stock BEFORE INSERT ON lote_item_estoque
	FOR EACH ROW UPDATE item_estoque SET qtd_armazenado = qtd_armazenado + NEW.qtd_item
		WHERE item_estoque.id_item_estoque = NEW.fk_item_estoque;
-- DROP TRIGGER update_stock;

-- Trigger para atualizar quantidade armazenada em estoque em caso de saída
CREATE TRIGGER update_stock_saida BEFORE INSERT ON saida_estoque
	FOR EACH ROW UPDATE item_estoque SET qtd_armazenado = qtd_armazenado - NEW.qtd_saida
		WHERE item_estoque.id_item_estoque = NEW.fk_item_estoque;
-- DROP TRIGGER update_stock_saida;

DESC lote_item_estoque;
-- TRUNCATE TABLE lote_item_estoque;
INSERT INTO lote_item_estoque VAlUES -- teste roupa
	(1, 1, 5, 100.0),
    (1, 2, 3, 100.0);
INSERT INTO lote_item_estoque VAlUES -- teste tecido
	(2, 3, 3.5, 80.0);

DESC saida_estoque;
INSERT INTO saida_estoque VAlUES (null, current_date(), current_time(), 0.5, 'envio de tecido para costura', 1, 2, 3, 1);
SELECT * FROM saida_estoque;

SELECT * FROM lote_item_estoque;
SELECT * FROM item_estoque;