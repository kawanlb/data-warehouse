# Quantos clientes o restaurante desde a abertura ?
select count(*) from tb_cliente;

# Quantas vezes estes clientes estiveram no restaurante ?
select count(*) from tb_mesa;

# Quantas vezes estes clientes estiveram no restaurante acompanhados ?
describe tb_mesa;
select count(*) from tb_mesa where num_pessoa_mesa >1;

#Qual o período do ano em que o restaurante tem maior movimento
-- ???

# Quantas mesas estão em dupla no dia dos namorados ?
select count(*),year(data_hora_entrada)
from tb_mesa
	where num_pessoa_mesa = 2 
	and day(data_hora_entrada) = 12 
    and month(data_hora_entrada) = 06
group by 2
order by 2
;

# Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano
-- 1
select distinct year(data_hora_entrada)
from tb_mesa;
-- 2
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 10;
-- 3

select * 
from (
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 10)
union
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2023
group by 1,2
order by 3 desc
limit 10)
union(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2024
group by 1,2
order by 3 desc
limit 10
)) as
tb_top10_major_consumer_per_year;

# Qual o cliente que mais fez pedidos por ano
-- ??

# Qual o cliente que mais gastou em todos os anos
-- ??
