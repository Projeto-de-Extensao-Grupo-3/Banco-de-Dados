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

-- Atualização de dados de funcionário.
UPDATE funcionario SET nome = 'Bruno Yuji', email = 'bruno.y@gmail.com.br' WHERE id_funcionario = 1;
SELECT * FROM funcionario;

-- Cadastrar as permissões de acesso do funcionário.
INSERT INTO controle_acesso (fk_funcionario, fk_permissao) VALUES
	(1, 1),
	(1, 2),
	(1, 3);
SELECT * FROM controle_acesso;

-- Listar permissões de um funcionário
SELECT f.nome, p.descricao FROM funcionario f 
	JOIN controle_acesso c ON f.id_funcionario = c.fk_funcionario
	JOIN permissao p ON p.id_permissao = c.fk_permissao;

-- Cadastro de itens do estoque (peças de roupa e tecidos).
DESC item_estoque;
TRUNCATE TABLE item_estoque;
INSERT INTO item_estoque (categoria, descricao, complemento, peso, qtd_minimo, qtd_armazenado) VALUES
	('roupa', 'vestido,azul', 'florido', 1.0, 0, 0),
	('roupa', 'camisa,vermelho', 'liso', 1.0, 0, 0),
	('roupa', 'bermuda,cinza', 'listras vermelhas', 1.0, 0, 0),
	('tecido', 'vermelho', 'liso', 1.0, 0, 0),
	('tecido', 'azul', 'florido', 1.0, 0, 0),
	('tecido', 'cinza', 'liso', 1.0, 0, 0);
SELECT * FROM item_estoque;

-- Relacionar os tecidos que compõem uma peça de roupa.
INSERT INTO confeccao_roupa (fk_roupa, fk_tecido) VALUES
	(1, 5),
	(2, 4),
	(3, 4),
	(3, 6);
SELECT * FROM confeccao_roupa;

-- Listar tecidos que compõem cada peça de roupa;
SELECT roupa.id_item_estoque, roupa.descricao, roupa.complemento,
tecido.id_item_estoque, tecido.descricao, tecido.complemento
	FROM item_estoque AS roupa 
	JOIN confeccao_roupa AS c ON roupa.id_item_estoque = fk_roupa
	JOIN item_estoque AS tecido ON tecido.id_item_estoque = fk_tecido
ORDER BY roupa.id_item_estoque;

-- Listar tecidos que compõem uma peça de roupa específica;
SELECT roupa.id_item_estoque, roupa.descricao, roupa.complemento,
tecido.id_item_estoque, tecido.descricao, tecido.complemento
	FROM item_estoque AS roupa 
	JOIN confeccao_roupa AS c ON roupa.id_item_estoque = fk_roupa
	JOIN item_estoque AS tecido ON tecido.id_item_estoque = fk_tecido
WHERE roupa.id_item_estoque = 3;

-- Categorias roupa e tecido serão fixas no banco de dados.
INSERT INTO categoria (nome) VALUES
	('Tecido'),
	('Roupa');
SELECT * FROM categoria;

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
SELECT * FROM categoria;

-- Cadastro de características de tecido e produto.
INSERT INTO caracteristica_item_estoque (nome) VALUES
	('Azul'),
	('Vermelho'),
	('Verde'),
	('Amarelo'),
	('Listrado'),
	('Liso'),
	('Florido'),
	('Grosso'),
	('Fino');
SELECT * FROM caracteristica_item_estoque;

-- Cadastro de um serviço terceirizado (costura e fornecedor).
DESC servico_terceiro;
TRUNCATE TABLE servico_terceiro;
INSERT INTO servico_terceiro (categoria, nome, telefone, email, endereco) VAlUES 
	('costureira', 'Maria', '11938563748', 'maria@gmail.com', 'Rua X'),
	('costureira', 'Alice', '11938563748', 'alice@gmail.com', 'Rua Y'),
	('costureira', 'Rebeca', '11938563748', 'rebeca@gmail.com', 'Rua Z'),
	('fornecedor', 'Best Tecidos', '11918465729', 'best_tecidos@gmail.com', 'Rua 1'),
	('fornecedor', 'Fornecedor X', '11918465729', 'fornecedorx@gmail.com', 'Rua 2'),
	('fornecedor', 'Fornecedor Z', '11918465729', 'fornecedorys@gmail.com', 'Rua 3');
SELECT * FROM servico_terceiro;

-- Cadastro de lote de tecido ou roupa.
DESC lote;
TRUNCATE TABLE lote;
INSERT INTO lote (descricao, dt_entrada, fk_servico_terceiro) VAlUES 
	('lote de roupas', now(), 1),
	('lote de tecido', now(), 2);
SELECT * FROM lote;

-- Cadastro dos itens de um lote.
DESC lote_item_estoque;
TRUNCATE TABLE lote_item_estoque;
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VAlUES -- teste roupa
	(1, 1, 5, 100.0),
    (1, 2, 3, 150.0),
    (1, 3, 10, 200.0);
INSERT INTO lote_item_estoque (fk_lote, fk_item_estoque, qtd_item, preco) VAlUES -- teste tecido
	(2, 4, 3.5, 80.0),
	(2, 5, 6.5, 70.0),
	(2, 6, 12.5, 120.0);
SELECT * FROM lote_item_estoque;

-- Cadastro de saída do estoque (venda e envio para costura).
DESC saida_estoque;
TRUNCATE TABLE saida_estoque;
INSERT INTO saida_estoque (data, hora, qtd_saida, motivo_saida, fk_responsavel, fk_lote, fk_item_estoque, fk_costureira)
	VAlUES (current_date(), current_time(), 2.50, 'envio de tecido para costura', 1, 2, 6, 1);

-- Visualização geral.
SELECT * FROM saida_estoque;
SELECT * FROM lote_item_estoque;
SELECT * FROM item_estoque;

SHOW TRIGGERS; -- verificar estrutura das Triggers criadas.