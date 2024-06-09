import mysql.connector
import pandas as pd
from dw_config import connect_to_dw  #

def import_csv_to_mysql(csv_file, table_name):
    df = pd.read_csv(csv_file)
    df.fillna('', inplace=True) 

    connection = connect_to_dw()  
    if not connection:
        return
    
    cursor = connection.cursor()

    # iterar sobre as linhas do DataFrame e inserir os dados na tabela dim_prato
    for _, row in df.iterrows():
        codigo_prato = int(row['codigo_prato'])
        nome_prato = str(row['nome_prato'])
        preco_unitario_prato = float(row['preco_unitario_prato'])
        codigo_tipo_prato = int(row['codigo_tipo_prato'])

        values = (codigo_prato, nome_prato, preco_unitario_prato, codigo_tipo_prato)
        sql = f"INSERT INTO {table_name} (codigo_prato, nome_prato, preco_unitario_prato, codigo_tipo_prato) VALUES (%s, %s, %s, %s)"
        
        try:
            cursor.execute(sql, values)
            print(f"Inserido na tabela {table_name}: {values}")
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('../data_to_warehouse/prato.csv', 'dim_prato')
