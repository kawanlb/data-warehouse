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
