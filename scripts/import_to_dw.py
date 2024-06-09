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

def import_csv_to_mysql(csv_file, table_name):
    # Carregar o arquivo CSV em um DataFrame
    df = pd.read_csv(csv_file, sep=',', encoding='utf-8')
    df.fillna('', inplace=True)

    # Conectar ao banco de dados
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()

    # Obter os nomes das colunas do DataFrame
    columns = df.columns.tolist()
    columns_str = ', '.join(columns)

    # Iterar sobre as linhas do DataFrame e inserir os dados no banco de dados
    for _, row in df.iterrows():
        # Preparar os valores para a inserção
        values = tuple(str(value) if not pd.isna(value) else '' for value in row.values)
        
        # Montar a consulta SQL para inserção dos dados
        placeholders = ', '.join(['%s'] * len(values))
        sql = f"INSERT INTO {table_name} ({columns_str}) VALUES ({placeholders})"
        
        try:
            # Executar a consulta SQL
            cursor.execute(sql, values)
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    # Commit das alterações e fechamento da conexão
    connection.commit()
    connection.close()

# Importar dados para as tabelas na ordem correta

import_csv_to_mysql('../data_to_warehouse/mesa_e_tempo.csv', 'dim_mesa')

