  -- SELECTS PARA O GRAFANA --
-- ============================================
-- 1. MARGEM DE LUCRO COMPLETA (Tecido + Costura)
SELECT
    roupa.id_item_estoque,
    roupa.descricao,
    roupa.preco AS preco_venda,
    ROUND(SUM(c.qtd_tecido * lie_tecido.preco), 2) AS custo_tecidos,
    lie_roupa.preco AS custo_costura,
    ROUND(SUM(c.qtd_tecido * lie_tecido.preco) + lie_roupa.preco, 2) AS custo_total,
    ROUND(roupa.preco - (SUM(c.qtd_tecido * lie_tecido.preco) + lie_roupa.preco), 2) AS lucro_bruto,
    ROUND(
        ((roupa.preco - (SUM(c.qtd_tecido * lie_tecido.preco) + lie_roupa.preco)) / roupa.preco) * 100,
        2
    ) AS margem_lucro_percentual
FROM
    item_estoque AS roupa
JOIN
    confeccao_roupa AS c ON roupa.id_item_estoque = c.fk_roupa
JOIN
    lote_item_estoque AS lie_roupa ON lie_roupa.fk_item_estoque = roupa.id_item_estoque
JOIN
    item_estoque AS tecido ON tecido.id_item_estoque = c.fk_tecido
JOIN
    lote_item_estoque AS lie_tecido ON lie_tecido.fk_item_estoque = tecido.id_item_estoque
WHERE
    roupa.id_item_estoque BETWEEN 1 AND 22  -- Apenas roupas
GROUP BY 
    roupa.id_item_estoque, 
    roupa.descricao, 
    roupa.preco, 
    lie_roupa.preco
ORDER BY margem_lucro_percentual DESC;


-- 2. TAXA DE DEFEITOS POR ROUPA (desde março/2025)
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
WHERE se.data >= '2025-03-01'
GROUP BY ie.descricao
HAVING qtd_defeitos > 0
ORDER BY taxa_defeito_percentual DESC;


-- 3. TAXA DE DEFEITO POR COSTUREIRA (desde março/2025)
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
WHERE se.fk_costureira IS NOT NULL
  AND se.data >= '2025-03-01'
GROUP BY p.nome
ORDER BY taxa_defeito_percentual DESC;

-- 4. EVOLUÇÃO DE VENDAS POR MÊS (desde março/2025)
SELECT
    DATE_FORMAT(se.data, '%Y-%m') AS mes,
    SUM(se.qtd_saida) AS total_vendas,
    COUNT(se.id_saida_estoque) AS qtd_transacoes,
    ROUND(AVG(se.qtd_saida), 2) AS media_por_venda
FROM saida_estoque AS se
WHERE se.motivo_saida LIKE '%venda%'
  AND se.data >= '2025-03-01'
GROUP BY DATE_FORMAT(se.data, '%Y-%m')
ORDER BY mes ASC;

-- 5. TOP 5 PRODUTOS MENOS VENDIDOS
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
WHERE ie.id_item_estoque BETWEEN 1 AND 22  -- Apenas roupas
GROUP BY ie.id_item_estoque, ie.descricao, ie.qtd_armazenado
ORDER BY total_vendido ASC, dias_sem_vender DESC
LIMIT 5;

-- 6. VENDAS POR CANAL (Brás vs Ecommerce) - desde março/2025
SELECT
    CASE 
        WHEN se.motivo_saida = 'venda brás' THEN 'Brás'
        WHEN se.motivo_saida = 'venda ecommerce' THEN 'E-commerce'
        ELSE 'Outros'
    END AS canal_venda,
    SUM(se.qtd_saida) AS total_vendas,
    COUNT(se.id_saida_estoque) AS qtd_transacoes,
    ROUND((COUNT(se.id_saida_estoque) / 
           (SELECT COUNT(*) FROM saida_estoque 
            WHERE motivo_saida LIKE '%venda%' AND data >= '2025-03-01')) * 100, 2) AS percentual
FROM saida_estoque AS se
WHERE se.motivo_saida LIKE '%venda%'
  AND se.data >= '2025-03-01'
GROUP BY canal_venda
ORDER BY total_vendas DESC;

-- 7. HISTÓRICO DE ALERTAS DE ESTOQUE (blusas em destaque)
SELECT
    ie.descricao AS produto,
    COUNT(a.id_alerta) AS qtd_alertas,
    MAX(a.data_hora) AS ultimo_alerta,
    ie.qtd_armazenado AS estoque_atual,
    ie.qtd_minimo AS estoque_minimo
FROM alerta AS a
JOIN item_estoque AS ie ON a.fk_item_estoque = ie.id_item_estoque
WHERE a.data_hora >= '2025-03-01'
GROUP BY ie.descricao, ie.qtd_armazenado, ie.qtd_minimo
ORDER BY qtd_alertas DESC;

-- 7.1 PRODUTOS EM RISCO DE RUPTURA (Previsão de Estoque Zerado)
-- Calcula quando o estoque acaba baseado na velocidade de vendas
SELECT
    ie.descricao AS produto,
    ie.qtd_armazenado AS estoque_atual,
    ie.qtd_minimo AS estoque_minimo,
    ROUND(AVG(se.qtd_saida), 2) AS media_vendas_dia,
    ROUND(ie.qtd_armazenado / AVG(se.qtd_saida), 0) AS dias_ate_ruptura,
    CASE 
        WHEN ie.qtd_armazenado / AVG(se.qtd_saida) <= 7 THEN 'URGENTE - Produzir Agora'
        WHEN ie.qtd_armazenado / AVG(se.qtd_saida) <= 15 THEN 'ATENÇÃO - Programar Produção'
        WHEN ie.qtd_armazenado / AVG(se.qtd_saida) <= 30 THEN 'MONITORAR'
        ELSE 'OK'
    END AS status_estoque
FROM item_estoque AS ie
LEFT JOIN lote_item_estoque AS lie ON ie.id_item_estoque = lie.fk_item_estoque
LEFT JOIN saida_estoque AS se ON lie.id_lote_item_estoque = se.fk_lote_item_estoque 
    AND se.motivo_saida LIKE '%venda%'
    AND se.data >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)  -- Últimos 30 dias
WHERE ie.id_item_estoque BETWEEN 1 AND 22  -- Apenas roupas
    AND ie.qtd_armazenado > 0
GROUP BY ie.id_item_estoque, ie.descricao, ie.qtd_armazenado, ie.qtd_minimo
HAVING media_vendas_dia > 0
ORDER BY dias_ate_ruptura ASC;

-- 8. CRESCIMENTO MENSAL DE VENDAS (% de crescimento)
SELECT
    mes_atual,
    total_vendas_atual,
    total_vendas_anterior,
    ROUND(((total_vendas_atual - total_vendas_anterior) / total_vendas_anterior) * 100, 2) AS crescimento_percentual
FROM (
    SELECT
        DATE_FORMAT(se.data, '%Y-%m') AS mes_atual,
        SUM(se.qtd_saida) AS total_vendas_atual,
        LAG(SUM(se.qtd_saida)) OVER (ORDER BY DATE_FORMAT(se.data, '%Y-%m')) AS total_vendas_anterior
    FROM saida_estoque AS se
    WHERE se.motivo_saida LIKE '%venda%'
      AND se.data >= '2025-03-01'
    GROUP BY DATE_FORMAT(se.data, '%Y-%m')
) AS subconsulta
WHERE total_vendas_anterior IS NOT NULL
ORDER BY mes_atual ASC;

-- 9. ANÁLISE DE RENTABILIDADE POR CATEGORIA (NOVO - ROI por tipo)
-- Qual categoria gera mais lucro total?
SELECT
    cat.nome AS categoria,
    COUNT(DISTINCT roupa.id_item_estoque) AS qtd_produtos,
    SUM(se.qtd_saida) AS total_vendido,
    ROUND(SUM(se.qtd_saida * roupa.preco), 2) AS receita_total,
    ROUND(SUM(se.qtd_saida * ((c.qtd_tecido * lie_tecido.preco) + lie_roupa.preco)), 2) AS custo_total,
    ROUND(SUM(se.qtd_saida * (roupa.preco - ((c.qtd_tecido * lie_tecido.preco) + lie_roupa.preco))), 2) AS lucro_total,
    ROUND(
        (SUM(se.qtd_saida * (roupa.preco - ((c.qtd_tecido * lie_tecido.preco) + lie_roupa.preco))) /
         SUM(se.qtd_saida * ((c.qtd_tecido * lie_tecido.preco) + lie_roupa.preco))) * 100, 2
    ) AS roi_percentual
FROM item_estoque AS roupa
JOIN categoria AS cat ON roupa.fk_categoria = cat.id_categoria
JOIN confeccao_roupa AS c ON roupa.id_item_estoque = c.fk_roupa
JOIN lote_item_estoque AS lie_roupa ON lie_roupa.fk_item_estoque = roupa.id_item_estoque
JOIN item_estoque AS tecido ON tecido.id_item_estoque = c.fk_tecido
JOIN lote_item_estoque AS lie_tecido ON lie_tecido.fk_item_estoque = tecido.id_item_estoque
LEFT JOIN saida_estoque AS se ON lie_roupa.id_lote_item_estoque = se.fk_lote_item_estoque
    AND se.motivo_saida LIKE '%venda%'
    AND se.data >= '2025-03-01'
WHERE roupa.id_item_estoque BETWEEN 1 AND 22
GROUP BY cat.nome
ORDER BY lucro_total DESC;

-- 10. Faturamento e lucro mensal
-- pode ignorar a coluna custos

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
	WHERE vendas.fk_costureira IS NULL
	GROUP BY periodo;