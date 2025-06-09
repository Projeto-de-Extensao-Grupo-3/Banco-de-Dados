-- PROJETO DE EXTENSÃO
-- SCRIPT PARA TESTE DE CONSULTAS

USE projeto_extensao;
SHOW TABLES;

-- ===========================================VISUALIZAÇÃO DOS DADOS=========================================== --
SELECT * FROM caracteristica_item_estoque;
SELECT * FROM categoria;
SELECT * FROM confeccao_roupa;
SELECT * FROM controle_acesso;
SELECT * FROM corte_tecido;
SELECT * FROM funcionario;
SELECT * FROM item_estoque;
SELECT * FROM prateleira;
SELECT * FROM lote;
SELECT * FROM lote_item_estoque;
SELECT * FROM permissao;
SELECT * FROM saida_estoque;
SELECT * FROM parceiro;
SELECT * FROM imagem;
SELECT * FROM alerta;
-- ============================================================================================================== --

-- ==================================TESTES DE CONSULTA PARA TABELA ITEM_ESTOQUE================================== --
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

-- Verificar custo de produção das peças de roupa.
SELECT roupa.id_item_estoque, roupa.descricao,
SUM(c.qtd_tecido * tecido.preco + lt_item.preco) AS CUSTO_TOTAL
	FROM item_estoque AS roupa 
	JOIN confeccao_roupa AS c 
		ON roupa.id_item_estoque = fk_roupa
	JOIN item_estoque AS tecido 
		ON tecido.id_item_estoque = fk_tecido
	JOIN lote_item_estoque AS lt_item
		ON lt_item.fk_item_estoque = roupa.id_item_estoque
	JOIN lote
		ON lote.id_lote = lt_item.fk_lote
	WHERE lote.dt_entrada = (
		SELECT MAX(dt_entrada) FROM lote JOIN lote_item_estoque
			ON lote.id_lote = lt_item.fk_lote
            WHERE fk_item_estoque = 1)
	AND lt_item.fk_item_estoque = 1 
GROUP BY roupa.id_item_estoque
ORDER BY roupa.id_item_estoque;
-- =============================================================================================================== --

-- ===================================TESTES DE CONSULTA PARA TABELA FUNCIONARIO================================== --
-- Listar permissões de um funcionário
SELECT f.nome, p.descricao FROM funcionario f 
	JOIN controle_acesso c ON f.id_funcionario = c.fk_funcionario
	JOIN permissao p ON p.id_permissao = c.fk_permissao
WHERE f.nome = 'Bruno';
    
-- Atualização de dados de funcionário.
UPDATE funcionario SET nome = 'Bruno Yuji', email = 'bruno.y@gmail.com.br' WHERE id_funcionario = 1;
SELECT * FROM funcionario;

-- Listar cortes de tecido de cada funcionário.
SELECT nome, id_corte_tecido, fk_lote, fk_tecido, inicio, termino FROM funcionario
JOIN corte_tecido ON id_funcionario = fk_funcionario;

-- Listar cortes tecido de um funcionário específico.
SELECT nome, id_corte_tecido, fk_lote, fk_tecido, inicio, termino FROM funcionario
JOIN corte_tecido ON id_funcionario = fk_funcionario
WHERE nome = 'Fernando';
-- =============================================================================================================== --