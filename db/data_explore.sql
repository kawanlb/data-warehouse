# Agregações Básicas
-- Contagem utilizando a função COUNT
select count(*) from tb_prato;

-- Soma de valores
select p.nome_prato, p.preco_unitario_prato as preco_unitario , count(p.nome_prato) num_pedidos,sum(pd.quantidade_pedido ) quantidade_em_pedidos ,sum(pd.quantidade_pedido * p.preco_unitario_prato) as total
from tb_pedido pd
left join tb_prato p 
on pd.codigo_prato = p.codigo_prato
left join tb_tipo_prato tp
on p.codigo_tipo_prato = tp.codigo_tipo_prato
group by 1,2
order by 5 desc;

-- Media de valores
select avg(p.preco_unitario_prato) as preco_medio
from tb_prato p;

-- Valor Maximo e Minimo
select max(p.preco_unitario_prato) as maior_preco
from tb_prato p;

select min(p.preco_unitario_prato) as menor_preco
from tb_prato p;

# Agregações com Agrupamentos
select tp.nome_tipo_prato, count(p.nome_prato)
from tb_prato p
left join tb_tipo_prato tp
on p.codigo_tipo_prato = tp.codigo_tipo_prato
group by 1
order by 1 ;

#Filtrando Resultados Agregados
select tp.nome_tipo_prato, count(p.nome_prato)
from tb_prato p
left join tb_tipo_prato tp
on p.codigo_tipo_prato = tp.codigo_tipo_prato
where tp.codigo_tipo_prato = 2
group by 1
order by 1 ;

# Analises Temporais
-- soma de pedidos por ano
select year(ms.data_hora_entrada),sum(pd.quantidade_pedido ) quantidade_em_pedidos ,sum(pd.quantidade_pedido * p.preco_unitario_prato) as total
from tb_pedido pd
left join tb_prato p 
on pd.codigo_prato = p.codigo_prato
left join tb_tipo_prato tp
on p.codigo_tipo_prato = tp.codigo_tipo_prato
left join tb_mesa ms
on pd.codigo_mesa = ms.codigo_mesa
group by 1
order by 1 desc;

# Construção de visões
create view vw_faturamento_ano as 
select year(ms.data_hora_entrada),sum(pd.quantidade_pedido ) quantidade_em_pedidos ,sum(pd.quantidade_pedido * p.preco_unitario_prato) as total
from tb_pedido pd
left join tb_prato p 
on pd.codigo_prato = p.codigo_prato
left join tb_tipo_prato tp
on p.codigo_tipo_prato = tp.codigo_tipo_prato
left join tb_mesa ms
on pd.codigo_mesa = ms.codigo_mesa
group by 1
order by 1 desc;


select * from vw_faturamento_ano;


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
