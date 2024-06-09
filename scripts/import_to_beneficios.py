import pandas as pd
from connect_to_mysql import connect_to_mysql

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
