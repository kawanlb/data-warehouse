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
