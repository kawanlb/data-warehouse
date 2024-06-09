SELECT 'codigo_empresa', 'nome_empresa'
UNION
SELECT codigo_empresa, nome_empresa
FROM tb_empresa
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/empresa.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
