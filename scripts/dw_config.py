import mysql.connector

def connect_to_dw():
    config = {
        'host': 'localhost',
        'port': '3306',
        'user': 'root',
        'password': 'root',
        'database': 'dw_restaurante'
    }
    
    try:
        dw_connection = mysql.connector.connect(**config)
        if dw_connection.is_connected():
            print("Conexão ao MySQL bem-sucedida!")
            return dw_connection
        else:
            print("Falha ao conectar ao MySQL!")
            return None
    except mysql.connector.Error as err:
        print(f"Erro ao conectar ao MySQL: {err}")
        return None

if __name__ == "__main__":
    # Teste da conexão
    connect_to_dw()
