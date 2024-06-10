-- tb_empresa para dim_empresa
USE db_beneficios;

CREATE TEMPORARY TABLE TempTable AS
SELECT codigo_empresa, nome_empresa
FROM tb_empresa;

USE dw_restaurante;
INSERT INTO dim_empresa (codigo_empresa, nome_empresa)
SELECT codigo_empresa, nome_empresa
FROM db_beneficios.TempTable;

USE db_beneficios;
DROP TEMPORARY TABLE TempTable;

USE dw_restaurante;
select * from dim_empresa;


-----------------------------------------

-- tb_beneficio para dim_beneficio
USE db_beneficios;

CREATE TEMPORARY TABLE TempTable AS
SELECT codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio
FROM tb_beneficio
WHERE TRIM(email_funcionario) <> '';

USE dw_restaurante;
INSERT INTO dim_beneficio (codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio)
SELECT codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio
FROM db_beneficios.TempTable;

use db_beneficios;
drop temporary table TempTable;

use dw_restaurante;
select * from dim_beneficio;