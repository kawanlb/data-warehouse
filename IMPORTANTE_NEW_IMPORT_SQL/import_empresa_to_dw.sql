USE db_beneficios;

-- Crie uma tabela temporária com os dados a serem transferidos
CREATE TEMPORARY TABLE TempTable AS 
SELECT codigo_empresa, nome_empresa
FROM tb_empresa;

USE dw_restaurante;

CREATE TABLE IF NOT EXISTS dim_empresa (
    codigo_empresa int primary key,
    nome_empresa varchar (500)
);

INSERT INTO dim_empresa (codigo_empresa, nome_empresa)
SELECT codigo_empresa, nome_empresa
FROM db_beneficios.TempTable;

use db_beneficios;
drop TEMPORARY TABLE TempTable;

use dw_restaurante;
select * from dim_empresa;