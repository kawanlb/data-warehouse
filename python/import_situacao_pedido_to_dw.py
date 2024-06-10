import mysql.connector
import pandas as pd
from dw_config import connect_to_dw

def import_csv_to_mysql(csv_file, table_name):
    df = pd.read_csv(csv_file)
    df.fillna('', inplace=True)

    connection = connect_to_dw()  
    if not connection:
        return
    
    cursor = connection.cursor()

    for _, row in df.iterrows():
        codigo_situacao_pedido = int(row['codigo_situacao_pedido'])
        nome_situacao_pedido = str(row['nome_situacao_pedido'])

        values = (codigo_situacao_pedido, nome_situacao_pedido)
        sql = f"INSERT INTO {table_name} (codigo_situacao_pedido, nome_situacao_pedido) VALUES (%s, %s)"
        
        try:
            cursor.execute(sql, values)
            print(f"Inserido na tabela {table_name}: {values}")
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('../data_to_warehouse/situacao_pedido.csv', 'dim_situacao_pedido')
