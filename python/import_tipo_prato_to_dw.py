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
        codigo_tipo_prato = int(row['codigo_tipo_prato'])
        nome_tipo_prato = str(row['nome_tipo_prato'])

        values = (codigo_tipo_prato, nome_tipo_prato)

        sql = f"INSERT INTO {table_name} (codigo_tipo_prato, nome_tipo_prato) VALUES (%s, %s)"
        
        try:
            cursor.execute(sql, values)
            print(f"Inserido na tabela {table_name}: {values}")
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('../data_to_warehouse/tipo_prato.csv', 'dim_tipo_prato')
