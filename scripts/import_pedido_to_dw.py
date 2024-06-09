import mysql.connector
import pandas as pd
from dw_config import connect_to_dw 
import mysql.connector 

def import_csv_to_mysql(prato_file, pedido_file, table_name):
    # Carregar o arquivo CSV do prato para obter o preco_unitario_prato
    df_prato = pd.read_csv(prato_file)
    df_prato.fillna('', inplace=True) 
    prato_dict = df_prato.set_index('codigo_prato')['preco_unitario_prato'].to_dict()


    df_pedido = pd.read_csv(pedido_file)
    df_pedido.fillna('', inplace=True)  
    connection = connect_to_dw() 
    if not connection:
        return
    
    cursor = connection.cursor()

    for _, row in df_pedido.iterrows():
        codigo_mesa = int(row['codigo_mesa'])
        codigo_prato = int(row['codigo_prato'])
        quantidade_pedido = int(row['quantidade_pedido'])
        codigo_situacao_pedido = int(row['codigo_situacao_pedido'])

        # Obter o preco_unitario_prato do dicionário prato_dict
        preco_unitario_prato = prato_dict.get(codigo_prato, 0)

        # calculo do preco_total_pedido 
        preco_total_pedido = preco_unitario_prato * quantidade_pedido

        values = (preco_unitario_prato, preco_total_pedido, quantidade_pedido, codigo_mesa, codigo_situacao_pedido, codigo_prato)
        sql = f"INSERT INTO {table_name} (preco_unitario_prato, preco_total_pedido, quantidade_pedido, codigo_mesa, codigo_situacao_pedido, codigo_prato) VALUES (%s, %s, %s, %s, %s, %s)"

        try:
            cursor.execute(sql, values)
            print(f"Inserido na tabela {table_name}: {values}")
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('../data_to_warehouse/prato.csv', '../data_to_warehouse/pedido.csv', 'fato_pedido')
