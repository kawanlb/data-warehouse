CREATE TABLE dim_beneficio (
    codigo_funcionario INT PRIMARY KEY,
    email_funcionario VARCHAR(200),
    codigo_empresa INT,
    valor_beneficio VARCHAR(45),
    FOREIGN KEY (codigo_empresa) REFERENCES dim_empresa(codigo_empresa)
);

CREATE TABLE dim_empresa (
    codigo_empresa INT PRIMARY KEY,
    nome_empresa VARCHAR(500)
);