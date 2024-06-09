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
