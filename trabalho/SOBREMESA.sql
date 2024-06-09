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
