SELECT 'codigo_situacao_pedido', 'nome_situacao_pedido'
UNION
SELECT codigo_situacao_pedido, nome_situacao_pedido
FROM tb_situacao_pedido
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/situacao_pedido.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
