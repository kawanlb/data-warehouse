import mysql.connector

config = {
    'host': 'localhost',
    'port': '3306',
    'user': 'root',
    'password': 'root',
    'database': 'dw_restaurante'
}

def connect_to_mysql():
    return mysql.connector.connect(**config)

def reset_tables():
    connection = connect_to_mysql()
    cursor = connection.cursor()
    
    # Listar todas as tabelas que precisam ser limpas e resetadas
    tables = ['dim_cliente']
    
    for table in tables:
        try:
            # Deletar todos os registros
            cursor.execute(f"DELETE FROM {table}")
            
            # Resetar o auto increment
            cursor.execute(f"ALTER TABLE {table} AUTO_INCREMENT = 1")
        except mysql.connector.Error as err:
            print(f"Erro MySQL ao limpar a tabela {table}: {err}")
    
    connection.commit()
    connection.close()

reset_tables()

print("Todas as tabelas foram limpas e os IDs foram resetados.")
