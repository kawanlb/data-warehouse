-- Qual o cliente que mais fez pedidos por ano
SELECT  
	dc.nome_cliente, 
	YEAR(dt.data) AS ano,
	SUM(fp.quantidade_pedido) AS total_pedidos
FROM fato_pedido fp 
INNER JOIN dim_mesa dm ON dm.codigo_mesa = fp.codigo_mesa 
INNER JOIN dim_cliente dc ON dc.id_cliente = dm.id_cliente
INNER JOIN dim_tempo dt ON dm.data = dt.data 
GROUP BY dc.nome_cliente, YEAR(dt.data)
ORDER BY total_pedidos DESC
LIMIT 1;

-- Qual o cliente que mais gastou em todos os anos

SELECT dc.nome_cliente, SUM(fp.preco_total_pedido) AS quantidade_total_pedidos 
FROM fato_pedido fp 
INNER JOIN dim_mesa dm ON fp.codigo_mesa = dm.codigo_mesa 
INNER JOIN dim_cliente dc ON dm.id_cliente = dc.id_cliente 
GROUP BY dc.nome_cliente
ORDER BY quantidade_total_pedidos DESC
LIMIT 1;

-- Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano

SELECT dc.nome_cliente, dt.ano, SUM(dm.num_pessoa_mesa) AS total_pessoas
FROM fato_pedido fp 
INNER JOIN dim_mesa dm ON fp.codigo_mesa = dm.codigo_mesa 
INNER JOIN dim_cliente dc ON dm.id_cliente = dc.id_cliente 
INNER JOIN dim_tempo dt ON dm.data = dt.data
GROUP BY dc.nome_cliente, dt.ano
ORDER BY total_pessoas DESC

-- Qual a empresa que tem mais funcionarios como clientes do restaurante;

SELECT de.nome_empresa, COUNT(DISTINCT db.codigo_funcionario) AS quantidade_funcionarios
FROM dim_empresa de
INNER JOIN dim_beneficio db ON de.codigo_empresa = db.codigo_empresa
GROUP BY de.nome_empresa
ORDER BY quantidade_funcionarios DESC
LIMIT 1;

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