SELECT 'codigo_mesa', 'codigo_prato', 'quantidade_pedido', 'codigo_situacao_pedido'
UNION
SELECT codigo_mesa, codigo_prato, quantidade_pedido, codigo_situacao_pedido
FROM tb_pedido
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/pedido.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
