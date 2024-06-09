-- coluna temporaria
ALTER TABLE tb_cliente
ADD COLUMN novo_email varchar(45) DEFAULT NULL;

UPDATE tb_cliente
SET 
    novo_email = telefone_cliente,
  telefone_cliente = email_cliente,
   email_cliente = novo_email;

 -- remover a coluna temporaria
ALTER TABLE tb_cliente
DROP COLUMN novo_email;


select * from tb_cliente