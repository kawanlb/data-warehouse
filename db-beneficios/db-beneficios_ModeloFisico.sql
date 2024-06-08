CREATE TABLE TB_EMPRESA (
    codigo_empresa INT PRIMARY KEY,
    nome_empresa VARCHAR(500),
    uf_sede_empresa VARCHAR(2)
);

CREATE TABLE TB_BENEFICIO (
    codigo_funcionario INT PRIMARY KEY,
    email_funcionario VARCHAR(200),
    codigo_beneficio INT,
    codigo_empresa INT,
    tipo_beneficio VARCHAR(45),
    valor_beneficio VARCHAR(45),
    FOREIGN KEY (codigo_empresa) REFERENCES TB_EMPRESA(codigo_empresa)
);
