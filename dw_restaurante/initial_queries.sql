 -- Qual o cliente que mais fez pedidos por ano

 SELECT 
    ano,
    id_cliente,
    nome_cliente,
    total_pedidos
FROM (
    SELECT 
        YEAR(m.data) AS ano,
        c.id_cliente,
        c.nome_cliente,
        COUNT(*) AS total_pedidos,
        ROW_NUMBER() OVER(PARTITION BY YEAR(m.data) ORDER BY COUNT(*) DESC) AS row_num
    FROM 
        fato_pedido AS fp
    INNER JOIN 
        dim_mesa AS m ON fp.codigo_mesa = m.codigo_mesa
    INNER JOIN 
        dim_cliente AS c ON m.id_cliente = c.id_cliente
    GROUP BY 
        ano, c.id_cliente, c.nome_cliente
) AS subquery
WHERE 
    row_num = 1;


------------------------------------------------------------------------------------------------

 
 -- Qual o cliente que mais gastou em todos os anos

SELECT 
    c.nome_cliente,
    SUM(fp.preco_total_pedido) AS total_gasto
FROM 
    fato_pedido AS fp
INNER JOIN 
    dim_mesa AS m ON fp.codigo_mesa = m.codigo_mesa
INNER JOIN 
    dim_cliente AS c ON m.id_cliente = c.id_cliente
GROUP BY 
    c.nome_cliente
ORDER BY 
    total_gasto DESC
LIMIT 1;



------------------------------------------------------------------------

-- Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano

SELECT 
    ano,
    nome_cliente,
    total_pessoas
FROM (
    SELECT 
        YEAR(dt.data) AS ano,
        c.nome_cliente,
        SUM(m.num_pessoa_mesa) AS total_pessoas,
        ROW_NUMBER() OVER(PARTITION BY YEAR(dt.data) ORDER BY SUM(m.num_pessoa_mesa) DESC) AS row_num
    FROM 
        dim_mesa AS m
    INNER JOIN 
        dim_cliente AS c ON m.id_cliente = c.id_cliente
    INNER JOIN 
        dim_tempo AS dt ON m.data = dt.data
    GROUP BY 
        YEAR(dt.data), c.nome_cliente
) AS subquery
WHERE 
    row_num = 1;

-------------------------------------------------------


-- qual empresa tem mais funcionarios como clientes do restaurante

SELECT 
    b.codigo_empresa,
    e.nome_empresa,
    COUNT(*) AS total_funcionarios
FROM 
    dim_beneficio AS b
INNER JOIN 
    dim_empresa AS e ON b.codigo_empresa = e.codigo_empresa
GROUP BY 
    b.codigo_empresa, e.nome_empresa
ORDER BY 
    total_funcionarios DESC
LIMIT 1;

------------------------------------------------------------------

-- Qual empresa que tem mais funcionarios que consomem sobremesas no restaurante por ano;

SELECT 
    YEAR(dt.data) AS ano,
    e.nome_empresa,
    COUNT(DISTINCT b.codigo_funcionario) AS total_funcionarios_sobremesa
FROM 
    dim_beneficio AS b
INNER JOIN 
    dim_empresa AS e ON b.codigo_empresa = e.codigo_empresa
INNER JOIN 
    dim_cliente AS c ON b.codigo_funcionario = c.codigo_funcionario
INNER JOIN 
    dim_mesa AS m ON c.id_cliente = m.id_cliente
INNER JOIN 
    fato_pedido AS fp ON m.codigo_mesa = fp.codigo_mesa
INNER JOIN 
    dim_prato AS p ON fp.codigo_prato = p.codigo_prato
INNER JOIN 
    dim_tipo_prato AS tp ON p.codigo_tipo_prato = tp.codigo_tipo_prato
INNER JOIN 
    dim_tempo AS dt ON m.data = dt.data
WHERE 
    tp.nome_tipo_prato = 'sobremesa'
GROUP BY 
    YEAR(dt.data), e.nome_empresa
ORDER BY 
    total_funcionarios_sobremesa DESC
LIMIT 1;
