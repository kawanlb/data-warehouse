import mysql.connector
import pandas as pd

def connect_to_mysql():
    return mysql.connector.connect(
        host='mysql',
        user='root',
        password='root',
        database='db_beneficios'
    )

def import_csv_to_mysql(csv_file, table_name):
    df = pd.read_csv(csv_file, sep=';', encoding='utf-8')

    # Substituir os valores NaN por valores vazios
    df.fillna('', inplace=True)

    connection = connect_to_mysql()
    cursor = connection.cursor()

    # Iterar sobre as linhas do DataFrame e inserir os dados no banco de dados
    for _, row in df.iterrows():
        # Substituir os valores NaN por valores vazios ou um valor padrão antes de inserir no banco de dados
        cleaned_row = [str(value) if not pd.isna(value) else '' for value in row.values]
        sql = f"INSERT INTO {table_name} VALUES ({','.join(map(repr, cleaned_row))})"
        try:
            cursor.execute(sql)
        except mysql.connector.Error as err:
            print(f"Erro MySQL: {err}")

    connection.commit()
    connection.close()

import_csv_to_mysql('./tb_beneficio.csv', 'TB_BENEFICIO')
import_csv_to_mysql('./tb_empresa.csv', 'TB_EMPRESA')
