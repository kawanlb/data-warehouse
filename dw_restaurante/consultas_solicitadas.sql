-- Qual o cliente que mais fez pedidos por ano
SELECT
    dc.nome_cliente,
    YEAR(dm.data) AS ano,
    SUM(fp.quantidade_pedido) AS total_pedidos
FROM fato_pedido fp
JOIN dim_mesa dm ON fp.codigo_mesa = dm.codigo_mesa
JOIN dim_cliente dc ON dm.id_cliente = dc.id_cliente
GROUP BY dc.nome_cliente, YEAR(dm.data)
ORDER BY total_pedidos DESC
LIMIT 1;

-- ---------------------------------------------------------

-- Qual o cliente que mais gastou em todos os anos
SELECT c.nome_cliente, SUM(fp.preco_total_pedido) AS total_gasto
FROM fato_pedido AS fp
INNER JOIN dim_mesa AS m ON fp.codigo_mesa = m.codigo_mesa
INNER JOIN dim_cliente AS c ON m.id_cliente = c.id_cliente
GROUP BY c.nome_cliente
ORDER BY total_gasto DESC
LIMIT 1;

-- ---------------------------------------------------------

-- Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano
SELECT ano, cliente, total_pessoas
FROM (
    SELECT YEAR(dt.data) AS ano,dc.nome_cliente AS cliente,
        SUM(dm.num_pessoa_mesa) AS total_pessoas,
        ROW_NUMBER() OVER (PARTITION BY YEAR(dt.data)
        ORDER BY SUM(dm.num_pessoa_mesa) DESC) AS classificacao
    FROM dim_mesa dm
    INNER JOIN dim_cliente dc ON dm.id_cliente = dc.id_cliente
    INNER JOIN dim_tempo dt ON dm.data = dt.data
    GROUP BY YEAR(dt.data), dc.nome_cliente
) AS ranked
WHERE classificacao = 1
ORDER BY ano;

-- ---------------------------------------------------------

-- Qual a empresa que tem mais funcionarios como clientes do restaurante;
SELECT e.nome_empresa,
COUNT(DISTINCT c.id_cliente) AS total_funcionarios_clientes
FROM dim_empresa AS e
INNER JOIN dim_beneficio AS b ON e.codigo_empresa = b.codigo_empresa
INNER JOIN dim_cliente AS c ON b.codigo_funcionario = c.codigo_funcionario
GROUP BY e.nome_empresa
ORDER BY total_funcionarios_clientes DESC
LIMIT 1;

-- ---------------------------------------------------------

-- Qual empresa que tem mais funcionarios que consomem sobremesas no restaurante por ano;
SELECT de.nome_empresa, dt.ano AS ano,COUNT(DISTINCT db.codigo_funcionario) AS quantidade_funcionarios
FROM dim_empresa de
INNER JOIN dim_beneficio db ON de.codigo_empresa = db.codigo_empresa
INNER JOIN dim_cliente dc ON db.codigo_funcionario = dc.codigo_funcionario 
INNER JOIN dim_mesa dm ON dc.id_cliente = dm.id_cliente 
INNER JOIN dim_tempo dt ON dm.data = dt.data 
INNER JOIN fato_pedido fp ON dm.codigo_mesa = fp.codigo_mesa 
INNER JOIN dim_prato dp ON fp.codigo_prato =dp.codigo_prato 
INNER JOIN dim_tipo_prato dtp ON dp.codigo_tipo_prato = dtp.codigo_tipo_prato 
WHERE dtp.nome_tipo_prato  = 'Sobremesa'
GROUP BY de.nome_empresa, ano
ORDER BY quantidade_funcionarios DESC
LIMIT 1;

