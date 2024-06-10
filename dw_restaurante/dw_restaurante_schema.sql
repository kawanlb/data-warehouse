create database dw_restaurante;

use dw_restaurante;

CREATE TABLE dim_empresa (
    codigo_empresa INT PRIMARY KEY,
    nome_empresa VARCHAR(500)
    );

CREATE TABLE dim_beneficio(
	codigo_funcionario INT PRIMARY KEY,
    email_funcionario VARCHAR(200),
	valor_beneficio VARCHAR(45),
    codigo_empresa int,
    FOREIGN KEY (codigo_empresa) REFERENCES dim_empresa(codigo_empresa)
);

CREATE TABLE dim_cliente (
	id_cliente INT PRIMARY KEY,
    nome_cliente VARCHAR(150),
    email_cliente VARCHAR(45),
    codigo_funcionario int,
    FOREIGN KEY (codigo_funcionario) REFERENCES dim_beneficio(codigo_funcionario)
    );
    
    create table dim_tempo(
	data datetime primary key,
    ano int,
    mes int,
    dia int,
    hora int,
    minuto int,
    segundo int
);
create table dim_mesa(
	codigo_mesa INT primary key,
    num_pessoa_mesa INT,
    id_cliente int,
    data datetime,
    foreign key (id_cliente) references dim_cliente(id_cliente),
    foreign key (data) references dim_tempo(data)
    );

create table dim_tipo_prato(
	codigo_tipo_prato int primary key,
    nome_tipo_prato varchar (45)
    );
    
create table dim_prato(
	codigo_prato int primary key,
    nome_prato varchar(45),
    preco_unitario_prato double,
    codigo_tipo_prato int,
    foreign key (codigo_tipo_prato) references dim_tipo_prato(codigo_tipo_prato)
);

create table dim_situacao_pedido(
	codigo_situacao_pedido int primary key,
	nome_situacao_pedido varchar(45)
);


create table fato_pedido(
	preco_unitario_prato double,
    preco_total_pedido double,
    quantidade_pedido int,
    codigo_mesa INT,
    codigo_situacao_pedido int,
    codigo_prato int,
    foreign key (codigo_prato) references dim_prato(codigo_prato),
    foreign key (codigo_mesa) references dim_mesa(codigo_mesa),
    foreign key (codigo_situacao_pedido) references dim_situacao_pedido(codigo_situacao_pedido)
);