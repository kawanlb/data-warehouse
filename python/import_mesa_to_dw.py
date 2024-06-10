import mysql.connector
import pandas as pd
from dw_config import connect_to_dw 

def import_csv_to_mysql(csv_file, table_name):
    df = pd.read_csv(csv_file, sep=',', encoding='utf-8')
    df.fillna('', inplace=True)

    connection = connect_to_dw()
    if not connection:
        return
    
    cursor = connection.cursor()

    for _, row in df.iterrows():
        codigo_mesa = int(row['codigo_mesa'])
        id_cliente = int(row['id_cliente'])
        num_pessoa_mesa = int(row['num_pessoa_mesa'])
        data_hora_entrada = str(row['data_hora_entrada'])

        values = (codigo_mesa, num_pessoa_mesa, id_cliente, data_hora_entrada)

        sql = f"INSERT INTO {table_name} (codigo_mesa, num_pessoa_mesa, id_cliente, data) VALUES (%s, %s, %s, %s)"
        
        try:
            cursor.execute(sql, values)
            print(f"Inserido na tabela {table_name}: {values}")
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('../data_to_warehouse/mesa_e_tempo.csv', 'dim_mesa')
