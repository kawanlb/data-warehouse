SELECT 'codigo_mesa', 'id_cliente', 'num_pessoa_mesa', 'data_hora_entrada'
UNION
SELECT codigo_mesa, id_cliente, num_pessoa_mesa, data_hora_entrada
FROM tb_mesa
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/mesa_e_tempo.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
