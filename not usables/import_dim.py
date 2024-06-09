import mysql.connector

def connect_to_mysql(database):
    return mysql.connector.connect(
        host='localhost',
        port='3306',
        user='root',
        password='root',
        database=database
    )

def insert_data_into_dim_empresa(codigo_empresa, nome_empresa):
    connection = connect_to_mysql('db_restaurante')
    cursor = connection.cursor()

    # Query para inserir dados na tabela dim_empresa
    insert_query = f"INSERT INTO dim_empresa (codigo_empresa, nome_empresa) VALUES ({codigo_empresa}, '{nome_empresa}')"

    try:
        # Executar a query de inserção
        cursor.execute(insert_query)
        print("Dados inseridos na tabela dim_empresa com sucesso!")
    except mysql.connector.Error as err:
        print(f"Erro MySQL: {err}")

    # Commit e fechar a conexão
    connection.commit()
    connection.close()

def insert_data_into_dim_beneficio(codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio):
    connection = connect_to_mysql('db_restaurante')
    cursor = connection.cursor()

    # Query para inserir dados na tabela dim_beneficio
    insert_query = f"INSERT INTO dim_beneficio (codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio) VALUES ({codigo_funcionario}, '{email_funcionario}', {codigo_empresa}, '{valor_beneficio}')"

    try:
        # Executar a query de inserção
        cursor.execute(insert_query)
        print("Dados inseridos na tabela dim_beneficio com sucesso!")
    except mysql.connector.Error as err:
        print(f"Erro MySQL: {err}")

    # Commit e fechar a conexão
    connection.commit()
    connection.close()

# Consultar dados do banco de dados db_beneficios e inserir na tabela dim_empresa e dim_beneficio
connection = connect_to_mysql('db_beneficios')
cursor = connection.cursor()

# Consulta SQL para selecionar os dados da tabela tb_empresa
select_empresa_query = "SELECT * FROM tb_empresa"
cursor.execute(select_empresa_query)
empresas = cursor.fetchall()

# Inserir dados na tabela dim_empresa
for empresa in empresas:
    codigo_empresa, nome_empresa = empresa[0], empresa[1]
    insert_data_into_dim_empresa(codigo_empresa, nome_empresa)

# Consulta SQL para selecionar os dados da tabela tb_beneficio
select_beneficio_query = "SELECT * FROM tb_beneficio"
cursor.execute(select_beneficio_query)
beneficios = cursor.fetchall()

# Inserir dados na tabela dim_beneficio
for beneficio in beneficios:
    codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio = beneficio[0], beneficio[1], beneficio[2], beneficio[3]
    insert_data_into_dim_beneficio(codigo_funcionario, email_funcionario, codigo_empresa, valor_beneficio)

# Fechar a conexão
connection.close()
