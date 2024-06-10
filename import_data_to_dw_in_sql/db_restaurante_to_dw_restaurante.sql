--dim_tipo_prato
INSERT INTO dw_restaurante.dim_tipo_prato (codigo_tipo_prato, nome_tipo_prato) 
VALUES (1,'Entrada'),(2,'Principal'),(3,'Sobremesa'),(4,'Bebida')

-- dim_situacao_pedido
INSERT INTO dw_restaurante.dim_situacao_pedido (codigo_situacao_pedido, nome_situacao_pedido) 
VALUES (1,'Em preparo'),(2,'Entregue'),(3,'Devolvido')


-- tb_cliente para dim_cliente

USE db_restaurante;

CREATE TEMPORARY TABLE TempTable AS
SELECT id_cliente, nome_cliente, email_cliente
FROM tb_cliente;

ALTER TABLE TempTable ADD COLUMN codigo_funcionario INT;

UPDATE TempTable t
JOIN dw_restaurante.dim_beneficio b ON t.email_cliente = b.email_funcionario
SET t.codigo_funcionario = b.codigo_funcionario;

USE dw_restaurante;
INSERT INTO dim_cliente (id_cliente, nome_cliente, email_cliente, codigo_funcionario)
SELECT id_cliente, nome_cliente, email_cliente, codigo_funcionario
FROM db_restaurante.TempTable;

USE db_restaurante;
DROP TEMPORARY TABLE TempTable;

SELECT * FROM dw_restaurante.dim_cliente;

-- tb_prato para dim_prato

USE db_restaurante;

CREATE TEMPORARY TABLE TempTable AS
SELECT codigo_prato, nome_prato, preco_unitario_prato, codigo_tipo_prato
FROM tb_prato;

USE dw_restaurante;
INSERT INTO dim_prato (codigo_prato, nome_prato, preco_unitario_prato, codigo_tipo_prato)
SELECT codigo_prato, nome_prato, preco_unitario_prato, codigo_tipo_prato
FROM db_restaurante.TempTable;

USE db_restaurante;
DROP TEMPORARY TABLE TempTable;

SELECT * FROM dw_restaurante.dim_prato;

-- data de tb_mesa para dim_tempo

INSERT INTO dw_restaurante.dim_tempo (data, ano, mes, dia, hora, minuto, segundo)
SELECT data_hora_entrada,
       YEAR(data_hora_entrada),
       MONTH(data_hora_entrada),
       DAY(data_hora_entrada),
       HOUR(data_hora_entrada),
       MINUTE(data_hora_entrada),
       SECOND(data_hora_entrada)
FROM db_restaurante.tb_mesa;

-- tb_mesa para dim_mesa
INSERT INTO dw_restaurante.dim_mesa (codigo_mesa, id_cliente, num_pessoa_mesa, data)
SELECT codigo_mesa,
       id_cliente,
       num_pessoa_mesa,
       data_hora_entrada
FROM db_restaurante.tb_mesa;

-- fato_pedido

INSERT INTO dw_restaurante.fato_pedido (preco_unitario_prato, preco_total_pedido, quantidade_pedido, codigo_mesa, codigo_situacao_pedido, codigo_prato)
SELECT
    dp.preco_unitario_prato,
    (dp.preco_unitario_prato * quantidade_pedido) AS preco_total_pedido,
    quantidade_pedido,
    dm.codigo_mesa,
    dsp.codigo_situacao_pedido,
    dp.codigo_prato
FROM
    db_restaurante.tb_pedido p
INNER JOIN
    dw_restaurante.dim_prato dp ON p.codigo_prato = dp.codigo_prato
INNER JOIN
    dw_restaurante.dim_mesa dm ON p.codigo_mesa = dm.codigo_mesa
INNER JOIN
    dw_restaurante.dim_situacao_pedido dsp ON p.codigo_situacao_pedido = dsp.codigo_situacao_pedido;