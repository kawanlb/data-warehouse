import mysql.connector
import pandas as pd

def connect_to_mysql():
    return mysql.connector.connect(
        host='localhost',
        port='3306',
        user='root',
        password='root',
        database='db_beneficios'
    )

try:
    connection = connect_to_mysql()
    if connection.is_connected():
        print("Conexão ao MySQL bem-sucedida!")
    else:
        print("Falha ao conectar ao MySQL!")
except mysql.connector.Error as err:
    print(f"Erro ao conectar ao MySQL: {err}")
finally:
    if 'connection' in locals() and connection.is_connected():
        connection.close()

def import_csv_to_mysql(csv_file, table_name):
    df = pd.read_csv(csv_file, sep=';', encoding='utf-8')
    df.fillna('', inplace=True)

    connection = connect_to_mysql()
    cursor = connection.cursor()

    for _, row in df.iterrows():
        cleaned_row = [str(value) if not pd.isna(value) else '' for value in row.values]
        sql = f"INSERT INTO {table_name} VALUES ({','.join(map(repr, cleaned_row))})"
        try:
            cursor.execute(sql)
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('./tb_empresa.csv', 'tb_empresa')
import_csv_to_mysql('./tb_beneficio.csv', 'tb_beneficio')
