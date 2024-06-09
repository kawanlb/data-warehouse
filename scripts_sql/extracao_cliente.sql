SELECT 'id_cliente', 'nome_cliente', 'email_cliente', 'telefone_cliente'
UNION
SELECT id_cliente, nome_cliente, email_cliente, telefone_cliente
FROM tb_cliente
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/cliente.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
