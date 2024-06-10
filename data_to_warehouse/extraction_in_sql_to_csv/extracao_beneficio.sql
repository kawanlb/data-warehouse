SELECT 'codigo_funcionario', 'email_funcionario', 'codigo_empresa', 'valor_beneficio'
UNION
SELECT codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio
FROM tb_beneficio
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/funcionario.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
