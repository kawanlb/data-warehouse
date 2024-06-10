SELECT 'codigo_prato', 'codigo_tipo_prato', 'nome_prato', 'preco_unitario_prato'
UNION
SELECT codigo_prato, codigo_tipo_prato, nome_prato, preco_unitario_prato
FROM tb_prato
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/prato.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
