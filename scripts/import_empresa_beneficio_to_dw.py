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

    columns = df.columns.tolist()
    columns_str = ', '.join(columns)

    for _, row in df.iterrows():
        values = tuple(str(value) if not pd.isna(value) else '' for value in row.values)
        
        placeholders = ', '.join(['%s'] * len(values))
        sql = f"INSERT INTO {table_name} ({columns_str}) VALUES ({placeholders})"
        
        try:
            cursor.execute(sql, values)
            print(f"Inserido na tabela {table_name}: {values}")
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

# Importar dados para as tabelas na ordem correta
import_csv_to_mysql('../data_to_warehouse/empresa.csv', 'dim_empresa')
import_csv_to_mysql('../data_to_warehouse/beneficio.csv', 'dim_beneficio')
