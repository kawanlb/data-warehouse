SELECT 'codigo_tipo_prato', 'nome_tipo_prato'
UNION
SELECT codigo_tipo_prato, nome_tipo_prato
FROM tb_tipo_prato
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/tipo_prato.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
