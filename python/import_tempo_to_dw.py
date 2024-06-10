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

    for index, row in df.iterrows():
        datetime = str(row['data_hora_entrada'])  # Data e hora no formato 'YYYY-MM-DD HH:MM:SS'

        date, time = datetime.split()  # dividir a data e hora
        year, month, day = map(int, date.split('-')) 
        hour, minute, second = map(int, time.split(':'))  

        values = (datetime, year, month, day, hour, minute, second)

        sql = f"INSERT INTO {table_name} (data, ano, mes, dia, hora, minuto, segundo) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        
        try:
            cursor.execute(sql, values)
            print(f"Inserido na tabela {table_name}: {values}")
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('../data_to_warehouse/mesa_e_tempo.csv', 'dim_tempo')
