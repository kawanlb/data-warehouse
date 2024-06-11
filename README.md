# Modelagem Dimensional

Este projeto foi clonado do repositorio: [Datawarehouse101](https://gitlab.com/lipe.nscm/datawarehouse101). Ele serve como um trabalho para a cadeira de Database Application na Uninassau.

## 🚀 Começando

Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste.

Consulte **[Implantação](#-implanta%C3%A7%C3%A3o)** para saber como implantar o projeto.

### 📋 Pré-requisitos
Clone do https://gitlab.com/lipe.nscm/datawarehouse101.

Python, python-pandas, python-mysql-connector

mysql_workbench

## 🎯 Visão Geral

O projeto tem como objetivo criar um Datawarehouse para um restaurante, implementando os dados de empresas, seus funcionarios e seus respectivos benefícios, sem modificar o banco de dados principal. 
Um Datawarehouse organiza e armazena dados de maneira estruturada, facilitando a consulta e a análise de grandes volumes de informações.

## 🎲 Bancos de Dados Estruturados

Aqui está a explicação das tabelas do banco de dados `db_restaurante`, `db_beneficios` e por ultimo o warehouse `dw_restaurante`

### `db_restaurante`

### Tabelas

- **`tb_cliente`**: Informações dos clientes, incluindo CPF, nome, email e telefone.
- **`tb_mesa`**: Detalhes das mesas, como cliente associado, número de pessoas, horários de entrada e saída.
- **`tb_tipo_prato`**: Tipos de pratos oferecidos pelo restaurante.
- **`tb_situacao_pedido`**: Status dos pedidos (e.g., pendente, concluído).
- **`tb_prato`**: Informações sobre os pratos, incluindo nome, tipo e preço.
- **`tb_pedido`**: Pedidos, incluindo mesa, prato, quantidade e situação do pedido.

### `db_beneficios`

### Tabelas

- **`tb_empresa`**: Informações sobre as empresas, incluindo código, nome e UF da sede.
- **`tb_beneficio`**: Benefícios dos funcionários, incluindo código do funcionário, email, código do benefício, empresa associada, tipo e valor do benefício.

### `dw_restaurante`

### Tabelas Dimensionais

- **`dim_empresa`**: Armazena informações das empresas, incluindo código e nome.
- **`dim_beneficio`**: Registra benefícios dos funcionários, incluindo código do funcionário, email, valor do benefício e empresa associada.
- **`dim_cliente`**: Contém informações dos clientes, incluindo código, nome, email e referência ao funcionário associado.
- **`dim_tempo`**: Detalha dimensões de tempo, incluindo data, ano, mês, dia, hora, minuto e segundo.
- **`dim_mesa`**: Armazena informações das mesas, como código, número de pessoas, cliente associado e referência à dimensão de tempo.
- **`dim_tipo_prato`**: Contém os tipos de pratos oferecidos pelo restaurante.
- **`dim_prato`**: Registra detalhes dos pratos, incluindo código, nome, preço unitário e tipo de prato.
- **`dim_situacao_pedido`**: Armazena os possíveis status dos pedidos (e.g., pendente, concluído).

### Tabela Fato

- **`fato_pedido`**: Registra os pedidos feitos, incluindo preço unitário, preço total, quantidade, mesa associada, situação do pedido e prato pedido.

---

Estas tabelas foram projetadas para organizar eficientemente os dados relacionados a clientes, mesas, tipos de pratos, pratos, situações de pedidos, pedidos no restaurante, empresas, benefícios dos funcionários e informações dimensionais em um Datawarehouse. Isso facilita a consulta e análise dos dados do restaurante.

### Modelo db_restaurante
![image](https://github.com/kawanlb/data-warehouse/assets/144124952/76a1968d-7846-4432-bede-05b191355ca3)

### Modelo db_beneficios
![image](https://github.com/kawanlb/data-warehouse/assets/144124952/5412966b-5fe8-4eba-89e9-5c93bf46d490)

### Modelo Snowflake
![image](https://github.com/kawanlb/data-warehouse/assets/144124952/347a7b2e-f06f-4497-ac43-1a3eaee49b70)




---

## ⚡Validação de Dados

Antes de criar o `dw_restaurante`, é necessário inserir os dados do CSV no banco `db_beneficios`. O script responsável por essa tarefa é `/python/import_to_db_beneficios.py`.

### Inserção de Dados para o Warehouse

Os dados para o Data Warehouse foram manipulados de duas formas:

#### Forma 1 (Mais Complicada)

Após criar o `db_beneficios`, é necessário inserir os dados do CSV no banco usando o script `/python/import_to_db_beneficios.py`.

Utilizando o modelo Snowflake, que foi criado a partir da análise dos bancos `db_restaurante` e `db_beneficios`, foram selecionados os dados necessários para o Data Warehouse `dw_restaurante`.

Os scripts na pasta `/data_to_warehouse/extraction_in_sql_to_csv/` selecionam os dados a serem extraídos de cada tabela e os salvam como CSVs na pasta `/data_to_warehouse`.

Os dados extraídos já estão normalizados e limpos, restando apenas a inserção no `dw_restaurante`.

Na pasta `/python`, há scripts `.py` para inserção de CSVs em tabelas SQL, um script de conexão com o banco, o script `run_all.py` que executa todos os scripts de inserção no DW em sequência, e o script mencionado para popular o `db_beneficios`.

Com esses scripts Python, o Data Warehouse estará populado e pronto para consultas, com os dados armazenados em CSVs.

#### Forma 2 (Mais Fácil)

Com os bancos de dados `db_beneficio` e `db_restaurante` populados no MySQL Workbench, alguns scripts SQL são executados para enviar os dados dos bancos para o Warehouse.

Todos os códigos SQL estão na pasta `/import_data_to_dw_in_sql`.

Executando esses scripts SQL, os dados serão transferidos dos bancos de origem para o Data Warehouse.

---

## 🔎 Queries Solicitadas

todas queries estão em /dw_restaurante/consultas_solicitadas.sql

### Consultas SQL

1. **Cliente com Mais Pedidos por Ano**
   - Esta consulta retorna o cliente que fez o maior número de pedidos em cada ano.

2. **Cliente que Mais Gastou em Todos os Anos**
   - Retorna o cliente que gastou mais em pedidos em todos os anos.

3. **Cliente(s) que Trouxe(ram) Mais Pessoas por Ano**
   - Identifica o(s) cliente(s) que trouxeram o maior número de pessoas por ano.

4. **Empresa com Mais Funcionários como Clientes**
   - Retorna a empresa que possui o maior número de funcionários como clientes do restaurante.

5. **Empresa com Mais Funcionários que Consomem Sobremesas por Ano**
   - Identifica a empresa que possui o maior número de funcionários que consomem sobremesas no restaurante em cada ano.

---

Essas consultas são úteis para análises específicas sobre o comportamento dos clientes e empresas relacionadas ao restaurante ao longo do tempo.

