use projeto_extensao;use projeto_extensao;

/* =============================================================================================================================================
 * 
 *  SELECTS NESSE ARQUIVO NÃO SÃO EXECUTAVEIS DEVIDO AS CLAUSULAS NO WHERE, QUE POSSUEM NOMES DOS ARGUMENTOS
 * 
 * =============================================================================================================================================
 */

/* =============================================================================================================================================
 *  Select A: Margem de lucro dos produtos
 * =============================================================================================================================================
 *  endpoint: /lotes-item-estoque/margem-lucro-produtos
 * =============================================================================================================================================
 *  Novidades
 * 
 *  Parametros - obtidos pelo @RequestParam {
 *	 String dataInicio, -- Se ficar melhor uma classe de data pode usar
 *	 String dataFim, -- Se ficar melhor uma classe de data pode usar
 *	 String caracteristica, -- String da caracteristica
 *	 String categoria, -- String da categoria
 *  }
 *  Novos campos retorno: nao
 * ============================================================================================================================================= 
 *	SELECT NOVO - validar nome argumentos
 *============================================================================================================================================= 
 */

SELECT lie_roupa.fk_item_estoque AS id_roupa, 
	ie.descricao,
	ROUND(((ie.preco - ROUND(AVG(lie_roupa.preco / lie_roupa.qtd_item) + cnf.custo_tecidos, 2)) / ie.preco) * 100, 2) as 'margem_lucro_%'
	FROM lote_item_estoque as lie_roupa
		JOIN item_estoque as ie
			ON lie_roupa.fk_item_estoque = ie.id_item_estoque
		JOIN (SELECT cnf.fk_roupa, SUM(cnf.qtd_tecido * ie.preco) as custo_tecidos FROM confeccao_roupa as cnf JOIN item_estoque as ie ON cnf.fk_tecido = ie.id_item_estoque GROUP BY cnf.fk_roupa) as cnf
			ON ie.id_item_estoque = cnf.fk_roupa
		JOIN categoria as c
			ON ie.fk_categoria = c.id_categoria
		JOIN lote as l
			ON lie_roupa.fk_lote = l.id_lote 
		LEFT JOIN caracteristica_item_estoque as carac_ie 	
			ON ie.id_item_estoque = carac_ie.fk_item_estoque
		LEFT JOIN categoria as carac						
			ON carac_ie.fk_categoria  = carac.id_categoria
	WHERE IFNULL(carac.nome, '') LIKE "%:caracteristica%"
		AND c.nome LIKE "%:categoria%"
		AND l.dt_entrada BETWEEN ":dataInicio" AND ":dataFim"
	GROUP BY lie_roupa.fk_item_estoque, ie.descricao;





/* =============================================================================================================================================
 *  Select B: Margem de lucro dos produtos
 * =============================================================================================================================================
 *  endpoint: /lotes-item-estoque/peca-maior-mao-obra
 * =============================================================================================================================================
 *  Novidades
 * 
 *  Parametros - obtidos pelo @RequestParam {
 *	 String dataInicio, -- Se ficar melhor uma classe de data pode usar
 *	 String dataFim, -- Se ficar melhor uma classe de data pode usar
 *	 String caracteristica, -- String da caracteristica
 *	 String categoria, -- String da categoria
 *  }
 * Novos campos retorno: nao
 * ============================================================================================================================================= 
 *	SELECT NOVO - inserir respectivas variáveis nos nomes, no "WHERE". Apenas substituir valor dentro dos colchetes (e os colchetes)
 *============================================================================================================================================= 
 */

SELECT lie_roupa.fk_item_estoque, 
	truncate(AVG(lie_roupa.preco / lie_roupa.qtd_item), 2) as custo_costureira,
	truncate(cnf.custo_tecidos, 2) as custo_tecidos,
	truncate(AVG(lie_roupa.preco / lie_roupa.qtd_item) + cnf.custo_tecidos, 2) as custo_total,
	ie.preco,
	truncate(((ie.preco - ROUND(AVG(lie_roupa.preco / lie_roupa.qtd_item) + cnf.custo_tecidos, 2)) / ie.preco) * 100, 2) as 'margem_lucro_%',
	ie.descricao 
	FROM lote_item_estoque as lie_roupa
		JOIN item_estoque as ie
			ON lie_roupa.fk_item_estoque = ie.id_item_estoque
		JOIN categoria as c
			ON ie.fk_categoria = c.id_categoria
		JOIN (SELECT cnf.fk_roupa, SUM(cnf.qtd_tecido * ie.preco) as custo_tecidos FROM confeccao_roupa as cnf JOIN item_estoque as ie ON cnf.fk_tecido = ie.id_item_estoque GROUP BY cnf.fk_roupa) as cnf
			ON ie.id_item_estoque = cnf.fk_roupa 
				JOIN lote as l
			ON lie_roupa.fk_lote = l.id_lote 
		LEFT JOIN caracteristica_item_estoque as carac_ie 	
			ON ie.id_item_estoque = carac_ie.fk_item_estoque
		LEFT JOIN categoria as carac						
			ON carac_ie.fk_categoria  = carac.id_categoria
	WHERE IFNULL(carac.nome, '') LIKE "%:caracteristica%"
		AND c.nome LIKE "%:categoria%"
		AND l.dt_entrada BETWEEN ":dataInicio" AND ":dataFim"
	GROUP BY lie_roupa.fk_item_estoque, ie.descricao, ie.preco;






/* =============================================================================================================================================
 *  Select C: Produtos Giro Baixo
 * =============================================================================================================================================
 *  endpoint: /itens-estoque/produtos-giro-baixo
 * =============================================================================================================================================
 *  Novidades
 * 
 *  Parametros - obtidos pelo @RequestParam {
 *	 String caracteristica, -- String da caracteristica
 *	 String categoria, -- String da categoria
 *  }
 * Novos campos retorno: nao
 * ============================================================================================================================================= 
 *	SELECT NOVO - inserir respectivas variáveis nos nomes, no "WHERE". Apenas substituir valor dentro dos colchetes (e os colchetes)
 *============================================================================================================================================= 
 */

SELECT
    ie.descricao AS produto,
    COALESCE(SUM(se.qtd_saida), 0) AS total_vendido,
    COUNT(se.id_saida_estoque) AS qtd_vendas,
    ie.qtd_armazenado AS estoque_atual,
    DATEDIFF(CURDATE(), MAX(se.data)) AS dias_sem_vender,
    CASE 
        WHEN DATEDIFF(CURDATE(), MAX(se.data)) > 60 THEN 'CRÍTICO - Liquidar'
        WHEN DATEDIFF(CURDATE(), MAX(se.data)) > 30 THEN 'ATENÇÃO - Promoção'
        ELSE 'OK'
    END AS status_recomendacao
FROM item_estoque AS ie
LEFT JOIN lote_item_estoque AS lie ON ie.id_item_estoque = lie.fk_item_estoque
LEFT JOIN saida_estoque AS se ON lie.id_lote_item_estoque = se.fk_lote_item_estoque 
    AND se.motivo_saida LIKE '%venda%'
    AND se.data >= '2025-03-01'
		JOIN categoria as c
			ON ie.fk_categoria = c.id_categoria
		LEFT JOIN caracteristica_item_estoque as carac_ie 	
			ON ie.id_item_estoque = carac_ie.fk_item_estoque
		LEFT JOIN categoria as carac						
			ON carac_ie.fk_categoria  = carac.id_categoria
	WHERE IFNULL(carac.nome, '') LIKE "%:caracteristica%"
		AND c.nome LIKE "%:categoria%"
		AND carac.fk_categoria_pai = 2
GROUP BY ie.id_item_estoque, ie.descricao, ie.qtd_armazenado
ORDER BY total_vendido ASC, dias_sem_vender DESC
LIMIT 5;





/* =============================================================================================================================================
 *  Select D: Defeitos por roupa
 * =============================================================================================================================================
 *  endpoint: /itens-estoque/defeitos-por-roupa
 * =============================================================================================================================================
 *  Novidades
 * 
 *  Parametros - obtidos pelo @RequestParam {
 *	 String dataInicio, -- Se ficar melhor uma classe de data pode usar
 *	 String dataFim, -- Se ficar melhor uma classe de data pode usar
 *	 String caracteristica, -- String da caracteristica
 *	 String categoria, -- String da categoria
 *  }
 * Novos campos retorno: nao
 * ============================================================================================================================================= 
 *	SELECT NOVO - inserir respectivas variáveis nos nomes, no "WHERE". Apenas substituir valor dentro dos colchetes (e os colchetes)
 *============================================================================================================================================= 
 */

SELECT
    ie.descricao AS roupa,
    COUNT(CASE WHEN se.motivo_saida LIKE '%defeito%' THEN 1 END) AS qtd_defeitos,
    COUNT(se.id_saida_estoque) AS qtd_total_saidas,
    ROUND(
        (COUNT(CASE WHEN se.motivo_saida LIKE '%defeito%' THEN 1 END) /
         COUNT(se.id_saida_estoque)) * 100, 2
    ) AS taxa_defeito_percentual
FROM saida_estoque AS se
JOIN lote_item_estoque AS lie ON se.fk_lote_item_estoque = lie.id_lote_item_estoque
JOIN item_estoque AS ie ON ie.id_item_estoque = lie.fk_item_estoque
JOIN categoria as c ON ie.fk_categoria = c.id_categoria
JOIN lote as l ON lie.fk_lote = l.id_lote 
LEFT JOIN caracteristica_item_estoque as carac_ie ON ie.id_item_estoque = carac_ie.fk_item_estoque
LEFT JOIN categoria as carac ON carac_ie.fk_categoria  = carac.id_categoria
WHERE IFNULL(carac.nome, '') LIKE "%:caracteristica%"
	AND c.nome LIKE "%:categoria%"
	AND l.dt_entrada BETWEEN ":dataInicio" AND ":dataFim"
GROUP BY ie.descricao
HAVING qtd_defeitos > 0
ORDER BY taxa_defeito_percentual DESC;





/* =============================================================================================================================================
 *  Select E: Defeitos por costureira
 * =============================================================================================================================================
 *  endpoint: /saidas-estoque/taxa-defeito-costura
 * =============================================================================================================================================
 *  Novidades
 * 
 *  Parametros - obtidos pelo @RequestParam {
 *	 String dataInicio, -- Se ficar melhor uma classe de data pode usar
 *	 String dataFim, -- Se ficar melhor uma classe de data pode usar
 *  }
 * Novos campos retorno: nao
 * ============================================================================================================================================= 
 *	SELECT NOVO - inserir respectivas variáveis nos nomes, no "WHERE". Apenas substituir valor dentro dos colchetes (e os colchetes)
 *============================================================================================================================================= 
 */

SELECT
    p.nome AS costureira,
    COUNT(CASE WHEN se.motivo_saida LIKE '%defeito%' THEN 1 END) AS qtd_defeitos,
    COUNT(se.id_saida_estoque) AS qtd_total_entregas,
    ROUND(
        (COUNT(CASE WHEN se.motivo_saida LIKE '%defeito%' THEN 1 END) /
         COUNT(se.id_saida_estoque)) * 100, 2
    ) AS taxa_defeito_percentual
FROM saida_estoque AS se
LEFT JOIN parceiro AS p ON se.fk_costureira = p.id_parceiro
WHERE se.data BETWEEN ":dataInicio" AND ":dataFim"
AND se.fk_costureira IS NOT NULL
GROUP BY p.nome
ORDER BY taxa_defeito_percentual DESC;





/* =============================================================================================================================================
 *  Select F: Rendimento mensal
 * =============================================================================================================================================
 *  endpoint: /itens-estoque/evolucao-vendas
 * =============================================================================================================================================
 *  Novidades
 * 
 *  ATENCAO!!! APENAS ANO E MES AQUI, DIFERENTE DAS OUTRAS!!!
 *  Parametros - obtidos pelo @RequestParam {
 *	 String dataInicio, -- Se ficar melhor uma classe de data pode usar
 *	 String dataFim, -- Se ficar melhor uma classe de data pode usar
 *	 String caracteristica, -- String da caracteristica
 *	 String categoria, -- String da categoria
 *  }
 * Novos campos retorno: Existe alteracao de campos se ainda nao foi atualizado para o novo de faturamento. Caso contrario, nao.
 * 				 		Os campos devem ser periodo, faturamento_bruto e lucro. Se custos ja foi feito, pode manter, mas nao e necessario adicionar
 * ============================================================================================================================================= 
 *	SELECT NOVO - inserir respectivas variáveis nos nomes, no "WHERE". Apenas substituir valor dentro dos colchetes (e os colchetes)
 *============================================================================================================================================= 
 */

SELECT DATE_FORMAT(vendas.data, '%Y-%m') as periodo,
	SUM(ie.preco * qtd_saida) as faturamento_bruto,
	SUM(margem_lucro.margem * ie.preco * qtd_saida) as lucro,
	SUM(ie.preco * qtd_saida - margem_lucro.margem * ie.preco * qtd_saida) as custos
	FROM saida_estoque as vendas 
		JOIN lote_item_estoque as lie 
			ON vendas.fk_lote_item_estoque = lie.id_lote_item_estoque
		JOIN item_estoque as ie 
			ON lie.fk_item_estoque = ie.id_item_estoque
		JOIN (SELECT ie.id_item_estoque as id, 
				ROUND(((ie.preco - ROUND(AVG(lie_roupa.preco / lie_roupa.qtd_item) + cnf.custo_tecidos, 2)) / ie.preco) , 2) as 'margem', 
				ie.descricao 
					FROM lote_item_estoque as lie_roupa
						JOIN item_estoque as ie 
							ON lie_roupa.fk_item_estoque = ie.id_item_estoque
						JOIN categoria as c 
							ON ie.fk_categoria = c.id_categoria
						JOIN (SELECT cnf.fk_roupa, 
							SUM(cnf.qtd_tecido * ie.preco) as custo_tecidos 
							FROM confeccao_roupa as cnf 
								JOIN item_estoque as ie 
									ON cnf.fk_tecido = ie.id_item_estoque 
								GROUP BY cnf.fk_roupa) as cnf
							ON ie.id_item_estoque = cnf.fk_roupa 
						WHERE c.fk_categoria_pai = 2
						GROUP BY lie_roupa.fk_item_estoque, 
						ie.descricao, 
						ie.preco) as margem_lucro 
			ON ie.id_item_estoque = margem_lucro.id
		JOIN categoria as c
			ON ie.fk_categoria = c.id_categoria
		JOIN lote as l
			ON lie.fk_lote = l.id_lote 
		LEFT JOIN caracteristica_item_estoque as carac_ie 	
			ON ie.id_item_estoque = carac_ie.fk_item_estoque
		LEFT JOIN categoria as carac						
			ON carac_ie.fk_categoria  = carac.id_categoria
	WHERE IFNULL(carac.nome, '') LIKE "%:caracteristica%"
		AND c.nome LIKE "%:categoria%"
		AND vendas.fk_costureira IS NULL
		AND DATE_FORMAT(vendas.data, '%Y-%m') BETWEEN ":dataInicio" AND ":dataFim"
	GROUP BY periodo;

/* 
   ____     U  ___ u  __  __        _____    ____        _        ____      _       _       _   _     U  ___ u  _    
U | __")u    \/"_ \/U|' \/ '|u     |_ " _|U |  _"\ u U  /"\  u U | __")uU  /"\  u  |"|     |'| |'|     \/"_ \/U|"|u  
 \|  _ \/    | | | |\| |\/| |/       | |   \| |_) |/  \/ _ \/   \|  _ \/ \/ _ \/ U | | u  /| |_| |\    | | | |\| |/  
  | |_) |.-,_| |_| | | |  | |       /| |\   |  _ <    / ___ \    | |_) | / ___ \  \| |/__ U|  _  |u.-,_| |_| | |_|   
  |____/  \_)-\___/  |_|  |_|      u |_|U   |_| \_\  /_/   \_\   |____/ /_/   \_\  |_____| |_| |_|  \_)-\___/  (_)   
 _|| \\_       \\   <<,-,,-.       _// \\_  //   \\_  \\    >>  _|| \\_  \\    >>  //  \\  //   \\       \\    |||_  
(__) (__)     (__)   (./  \.)     (__) (__)(__)  (__)(__)  (__)(__) (__)(__)  (__)(_")("_)(_") ("_)     (__)  (__)_) 
*/