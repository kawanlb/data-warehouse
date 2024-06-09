import mysql.connector
import pandas as pd

# Configurações de conexão com o banco de dados
config = {
    'host': 'localhost',
    'port': '3306',
    'user': 'root',
    'password': 'root',
    'database': 'dw_restaurante'
}

def connect_to_mysql():
    return mysql.connector.connect(**config)

def import_clientes_with_funcionario(csv_file, table_name):
    df = pd.read_csv(csv_file, sep=',', encoding='utf-8')
    df.fillna('', inplace=True)

    connection = connect_to_mysql()
    cursor = connection.cursor()

    for _, row in df.iterrows():
        email_cliente = row['email_cliente']
        
        # verificar se o email do cliente está presente na tabela dim_beneficio
        cursor.execute("SELECT codigo_funcionario FROM dim_beneficio WHERE email_funcionario = %s", (email_cliente,))
        result = cursor.fetchone()
        
        # caso exista vai usar o codigo_funcionario e preencher o email
        if result:
            codigo_funcionario = result[0]
            email_funcionario = email_cliente
        else:
            codigo_funcionario = None
            email_funcionario = ''
        
        # define os valores para a inserção na tabela dim_cliente
        values = (
            row['id_cliente'],
            row['nome_cliente'],
            email_funcionario,
            codigo_funcionario
        )
        
        # queries sql
        sql = f"INSERT INTO {table_name} (id_cliente, nome_cliente, email_cliente, codigo_funcionario) VALUES (%s, %s, %s, %s)"
        
        try:
            # executar a consulta sql
            cursor.execute(sql, values)
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_clientes_with_funcionario('../data_to_warehouse/cliente.csv', 'dim_cliente')
