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
