-- PROJETO DE EXTENSÃO
-- SCRIPT PARA TESTE DE INSERÇÃO DE DADOS E CONSULTAS

USE projeto_extensao;
SHOW TABLES;

-- Permissões serão fixas no banco, não será necessário cadastro ou atualização
DESC permissao;
INSERT INTO permissao (descricao) VALUES
	('Visualizar dashboard'),
	('Cadastrar funcionários'),
	('Visualizar histórico do estoque'),
    ('Registrar movimentação do estoque'),
	('Visualizar dados de itens do estoque'),
	('Cadastrar itens do estoque'),
	('Receber alertas de falta de estoque');
SELECT * FROM permissao;

-- Cadastro de funcionários.
DESC funcionario;
INSERT INTO funcionario (nome, cpf, telefone, email, senha) VALUES
	('Bruno', '83756473891', '11985647381', 'bruno@gmail.com', '123456@'),
	('Fernando', '83756473892', '11985647382', 'fernando@gmail.com', '123456@'),
	('Giorgio', '83756473893', '11985647383', 'giorgio@gmail.com', '123456@'),
	('Guilherme', '83756473894', '11985647384', 'guilherme@gmail.com', '123456@'),
	('João', '83756473895', '11985647385', 'joao@gmail.com', '123456@'),
	('Leandro', '83756473896', '11985647386', 'leandro@gmail.com', '123456@');
SELECT * FROM funcionario;

-- Cadastrar as permissões de acesso do funcionário.
DESC controle_acesso;
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
SELECT * FROM controle_acesso;

-- Listar permissões de um funcionário
SELECT f.nome, p.descricao FROM funcionario f 
	JOIN controle_acesso c ON f.id_funcionario = c.fk_funcionario
	JOIN permissao p ON p.id_permissao = c.fk_permissao
WHERE f.nome = 'Bruno';
    
-- Atualização de dados de funcionário.
UPDATE funcionario SET nome = 'Bruno Yuji', email = 'bruno.y@gmail.com.br' WHERE id_funcionario = 1;
SELECT * FROM funcionario;

-- Cadastro de identificação de prateleiras/local de armazenamento.
DESC prateleira;
INSERT INTO prateleira (codigo_prateleira) VALUES
	('1R'),
	('2R'),
	('3R'),
	('1T'),
	('2T'),
	('3T');
SELECT * FROM prateleira;

-- Categorias roupa e tecido serão fixas no banco de dados.
DESC categoria;
INSERT INTO categoria (nome) VALUES
	('Tecido'),
	('Roupa');
SELECT * FROM categoria;

-- Cadastro de subcategorias para tecido e roupa.
DESC categoria;
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
SELECT * FROM categoria;

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
SELECT * FROM categoria;

-- Cadastro de itens do estoque (peças de roupa e tecidos).
DESC item_estoque;
INSERT INTO item_estoque (fk_categoria, fk_prateleira, descricao, peso, qtd_minimo, qtd_armazenado) VALUES
	(8, 1, 'Vestido azul florido', 1.0, 0, 0),
	(9, 2, 'Camisa vermelha lisa', 1.0, 0, 0),
	(11, 3, 'Bermuda cinza com listras vermelhas', 1.0, 0, 0),
	(5, 4, 'Tecido vermelho liso', 1.0, 0, 0),
	(6, 5, 'Tecido azul florido', 1.0, 0, 0),
	(3, 6, 'Tecido cinza liso', 1.0, 0, 0);
SELECT * FROM item_estoque;

-- Cadastro de características de cada produto e tecido.
DESC caracteristica_item_estoque;
SELECT * FROM item_estoque;
SELECT * FROM categoria WHERE fk_categoria_pai IS NULL;
INSERT INTO caracteristica_item_estoque (fk_categoria, fk_item_estoque) VALUES
	(13, 1),
	(19, 1),
	(14, 2),
	(18, 2),
	(17, 3),
	(18, 3),
	(14, 3),
	(14, 4),
	(19, 4),
	(13, 5),
	(20, 5),
	(17, 6),
	(19, 6);
SELECT * FROM caracteristica_item_estoque;

-- Listar roupas do estoque.
SELECT id_item_estoque, descricao, qtd_armazenado, categoria.nome AS 'categoria', subcategoria.nome AS 'subcategoria'
FROM item_estoque 
JOIN categoria AS subcategoria
ON item_estoque.fk_categoria = subcategoria.id_categoria
JOIN categoria
ON subcategoria.fk_categoria_pai = categoria.id_categoria
WHERE categoria.nome = 'Roupa';

-- Filtrar itens do estoque por caracteristica.
SELECT id_item_estoque, descricao, qtd_armazenado, nome AS 'característica'
FROM item_estoque
	JOIN caracteristica_item_estoque c ON id_item_estoque = c.fk_item_estoque
	JOIN categoria ON id_categoria = c.fk_categoria
WHERE nome = 'Azul';

-- Listar roupas do estoque com suas características.
SELECT id_item_estoque, descricao, qtd_armazenado, 
categoria.nome AS 'categoria', subcategoria.nome AS 'subcategoria', caracteristica.nome AS 'característica'
FROM item_estoque 
	JOIN categoria AS subcategoria ON item_estoque.fk_categoria = subcategoria.id_categoria
	JOIN categoria ON subcategoria.fk_categoria_pai = categoria.id_categoria
	JOIN caracteristica_item_estoque ON id_item_estoque = fk_item_estoque
	JOIN categoria AS caracteristica ON caracteristica.id_categoria = caracteristica_item_estoque.fk_categoria
WHERE categoria.nome = 'Roupa';

-- Verificar as prateleiras em que se encontram cada item.
SELECT id_item_estoque, descricao, qtd_armazenado, codigo_prateleira 
FROM item_estoque
JOIN prateleira ON id_prateleira = fk_prateleira;

-- Verificar a prateleira em que se encontra uma peça de roupa específica.
SELECT id_item_estoque, descricao, qtd_armazenado, codigo_prateleira 
FROM item_estoque
JOIN prateleira ON id_prateleira = fk_prateleira
WHERE descricao = 'Vestido azul florido';

-- Listar tecidos do estoque
SELECT id_item_estoque, descricao, qtd_armazenado, categoria.nome AS 'categoria', subcategoria.nome AS 'subcategoria'
FROM item_estoque 
JOIN categoria AS subcategoria
ON item_estoque.fk_categoria = subcategoria.id_categoria
JOIN categoria
ON subcategoria.fk_categoria_pai = categoria.id_categoria
WHERE categoria.nome = 'Tecido';

-- Listar tecidos do estoque com suas características.
SELECT id_item_estoque, descricao, qtd_armazenado, 
categoria.nome AS 'categoria', subcategoria.nome AS 'subcategoria', caracteristica.nome AS 'característica'
FROM item_estoque 
	JOIN categoria AS subcategoria ON item_estoque.fk_categoria = subcategoria.id_categoria
	JOIN categoria ON subcategoria.fk_categoria_pai = categoria.id_categoria
	JOIN caracteristica_item_estoque ON id_item_estoque = fk_item_estoque
	JOIN categoria AS caracteristica ON caracteristica.id_categoria = caracteristica_item_estoque.fk_categoria
WHERE categoria.nome = 'Tecido';

-- Relacionar os tecidos que compõem uma peça de roupa.
DESC confeccao_roupa;
INSERT INTO confeccao_roupa (fk_roupa, fk_tecido) VALUES
	(1, 5),
	(2, 4),
	(3, 4),
	(3, 6);
SELECT * FROM confeccao_roupa;

-- Listar tecidos que compõem cada peça de roupa;
SELECT roupa.id_item_estoque, roupa.descricao,
tecido.id_item_estoque, tecido.descricao
	FROM item_estoque AS roupa 
	JOIN confeccao_roupa AS c ON roupa.id_item_estoque = fk_roupa
	JOIN item_estoque AS tecido ON tecido.id_item_estoque = fk_tecido
ORDER BY roupa.id_item_estoque;

-- Listar tecidos que compõem uma peça de roupa específica;
SELECT roupa.id_item_estoque, roupa.descricao,
tecido.id_item_estoque, tecido.descricao
	FROM item_estoque AS roupa 
	JOIN confeccao_roupa AS c ON roupa.id_item_estoque = fk_roupa
	JOIN item_estoque AS tecido ON tecido.id_item_estoque = fk_tecido
WHERE roupa.id_item_estoque = 3;

-- Cadastro de um serviço terceirizado (costura e fornecedor).
DESC servico_terceiro;
INSERT INTO servico_terceiro (categoria, nome, telefone, email, endereco) VAlUES 
	('costureira', 'Maria', '11938563748', 'maria@gmail.com', 'Rua X'),
	('costureira', 'Alice', '11938563748', 'alice@gmail.com', 'Rua Y'),
	('costureira', 'Rebeca', '11938563748', 'rebeca@gmail.com', 'Rua Z'),
	('fornecedor', 'Best Tecidos', '11918465729', 'best_tecidos@gmail.com', 'Rua 1'),
	('fornecedor', 'Fornecedor X', '11918465729', 'fornecedorx@gmail.com', 'Rua 2'),
	('fornecedor', 'Fornecedor Z', '11918465729', 'fornecedorys@gmail.com', 'Rua 3');
SELECT * FROM servico_terceiro;

-- Cadastro de lote de roupa.
DESC lote;
INSERT INTO lote (descricao, dt_entrada, fk_servico_terceiro, fk_responsavel) VAlUES 
	('lote de roupas', '2025-04-20 11:36:00', 1, 1);
SELECT * FROM lote;

-- Cadastro de lote de tecido.
DESC lote;
INSERT INTO lote (descricao, dt_entrada, fk_servico_terceiro, fk_responsavel) VAlUES 
	('lote de tecido', '2025-04-20 11:36:00', 2, 2);
SELECT * FROM lote;

-- Cadastro dos itens de um lote.
DESC lote_item_estoque;
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VAlUES -- teste roupa
	(1, 1, 5, 100.0),
    (1, 2, 3, 150.0),
    (1, 3, 10, 200.0);
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VAlUES -- teste tecido
	(2, 4, 3.5, 80.0),
	(2, 5, 6.5, 70.0),
	(2, 6, 12.5, 120.0);
SELECT * FROM lote_item_estoque;

-- Cadastro de saída do estoque (envio para costura).
DESC saida_estoque;
SELECT * FROM item_estoque;
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote, fk_item_estoque, fk_costureira)
	VAlUES (current_date(), current_time(), 2.50, 'envio de tecido para costura', 1, 2, 6, 1);
SELECT * FROM saida_estoque;
SELECT * FROM item_estoque;

-- Cadastro de saída do estoque (venda).
DESC saida_estoque;
SELECT * FROM item_estoque;
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote, fk_item_estoque)
	VAlUES (current_date(), current_time(), 2, 'produto vendido', 3, 1, 3);
SELECT * FROM saida_estoque;
SELECT * FROM item_estoque;

-- Cadastro de corte de tecido.
DESC corte_tecido;
SELECT * FROM item_estoque WHERE descricao LIKE '%Tecido%';
INSERT INTO corte_tecido (fk_lote, fk_tecido, fk_funcionario, inicio, termino) VALUES
	(2, 4, 1, '2025-04-20 11:36:00', '2025-04-20 12:36:00'),
	(2, 5, 1, '2025-04-20 14:36:00', '2025-04-20 16:36:00'),
	(2, 6, 2, '2025-04-10 11:36:00', '2025-04-10 11:36:00'),
	(2, 4, 3, '2025-04-10 11:36:00', '2025-04-10 11:36:00'),
	(2, 6, 5, '2025-04-10 11:36:00', '2025-04-10 11:36:00');
SELECT * FROM corte_tecido;

-- Listar cortes de tecido de cada funcionário.
SELECT nome, id_corte_tecido, fk_lote, fk_tecido, inicio, termino FROM funcionario
JOIN corte_tecido ON id_funcionario = fk_funcionario;

-- Listar cortes tecido de um funcionário específico.
SELECT nome, id_corte_tecido, fk_lote, fk_tecido, inicio, termino FROM funcionario
JOIN corte_tecido ON id_funcionario = fk_funcionario
WHERE nome = 'Fernando';

-- Visualização geral.
SELECT * FROM caracteristica_item_estoque;
SELECT * FROM categoria;
SELECT * FROM confeccao_roupa;
SELECT * FROM controle_acesso;
SELECT * FROM corte_tecido;
SELECT * FROM funcionario;
SELECT * FROM item_estoque;
SELECT * FROM local_armazenamento;
SELECT * FROM lote;
SELECT * FROM lote_item_estoque;
SELECT * FROM permissao;
SELECT * FROM saida_estoque;
SELECT * FROM servico_terceiro;

-- Verificar estrutura das Triggers criadas.
SHOW TRIGGERS;