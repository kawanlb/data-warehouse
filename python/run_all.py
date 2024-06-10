import subprocess

def run_script(script_name):
    result = subprocess.run(['python', script_name], capture_output=True, text=True)
    print(result.stdout)
    if result.returncode != 0:
        print(f"Erro ao executar {script_name}:")
        print(result.stderr)
    return result.returncode

# Lista de scripts na ordem de execução
scripts = [
    'import_empresa_beneficio_to_dw.py',
    'import_cliente_to_dw.py',
    'import_tempo_to_dw.py',
    'import_mesa_to_dw.py',
    'import_situacao_pedido_to_dw.py',
    'import_tipo_prato_to_dw.py',
    'import_prato_to_dw.py',
    'import_pedido_to_dw.py'
]

# Iterar sobre a lista e executar cada script
for script in scripts:
    print(f"Executando {script}...")
    ret_code = run_script(script)
    if ret_code != 0:
        print(f"Execução interrompida devido a erro no script {script}")
        break
    print(f"{script} executado com sucesso.\n")
