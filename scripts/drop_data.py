import mysql.connector
from dw_config import connect_to_dw 

def reset_tables():
    connection = connect_to_dw()  
    if not connection:
        return
    
    cursor = connection.cursor()
    
    # listar todas as tabelas que precisam ser limpas e resetadas
    tables = ['dim_tempo','dim_cliente','dim_empresa','dim_beneficio','dim_situacao_pedido','dim_mesa','dim_prato','dim_tipo_prato','fato_pedido']
    
    for table in tables:
        try:
            # Deletar todos os registros
            cursor.execute(f"DELETE FROM {table}")
            
            # Resetar o auto increment
            cursor.execute(f"ALTER TABLE {table} AUTO_INCREMENT = 1")
            print(f"Tabela {table} limpa e ID resetado.")
        except mysql.connector.Error as err:
            print(f"Erro MySQL ao limpar a tabela {table}: {err}")
    
    connection.commit()
    connection.close()

reset_tables()

print("Todas as tabelas foram limpas e os IDs foram resetados.")
#necessario rodar o script mais de uma vez para fazer a limpeza completa