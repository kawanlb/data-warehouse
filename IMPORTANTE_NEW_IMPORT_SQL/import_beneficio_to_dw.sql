USE db_beneficios;

-- Crie uma tabela temporária com os dados a serem transferidos
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