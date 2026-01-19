import requests

print("=== CONVERSOR DE TEMPERATURA ===")

def celsius_para_fahrenheit(celsius):
    return (celsius * 9/5) + 32 

def celsius_para_kelvin(celsius):
    return celsius + 273.15


# ===== conversor de moedas ===

def converter_moeda(valor, moeda_orig, moeda_fim):
    """
    Converte moedas usando API gratuita
    """
    # API gratuita do ExchangeRate
    url = f"https://api.exchangerate-api.com/v4/latest/{moeda_orig}"


    try: 
        resposta = requests.get(url)
        dados = resposta.json()
        taxa = dados['rates'] [moeda_fim]
        return valor * taxa
    
    except:
        print(" API OFF. USANDO TAXAS FIXAS...")
        taxas_fixas = {
            'USD_BRL': 5.0,    # 1 USD = 5 BRL
            'BRL_USD': 0.2,    # 1 BRL = 0.2 USD
            'USD_EUR': 0.85,   # 1 USD = 0.85 EUR
            'EUR_USD': 1.18,   # 1 EUR = 1.18 USD
            'BRL_EUR': 0.17,   # 1 BRL = 0.17 EUR
            'EUR_BRL': 5.88,   # 1 EUR = 5.88 BRL
        }

        chave = f"{moeda_orig}_{moeda_fim}"    
        if chave in taxas_fixas:
            return valor * taxas_fixas[chave]
        else:
            return valor
        
# === func distancia ===
def converter_distancia(valor, unidade_orig, unidade_fim):
    """
    Converte entre km, milhas e metros
    """

    if unidade_orig == "km":
        metros = valor * 1000
    elif unidade_orig == "milhas":
        metros = valor * 1609.34
    else:   
        metros = valor

    if unidade_fim == "km":
        return metros / 1000
    elif unidade_fim == "milhas":
        return metros / 1609.34
    else: 
        return metros

# ========== MENUS ==========
def menu_principal():
    print("\n" + "="*40)
    print("MENU PRINCIPAL")
    print("="*40)
    print("1. Temperatura")
    print("2. Moedas")
    print("3. Distância")
    print("4. Sair")
    print("="*40)
    
    return input("Digite sua escolha (1-4): ")

def menu_temperatura():
    print("\n--- CONVERSOR DE TEMPERATURA ---")
    print("1. Celsius → Fahrenheit")
    print("2. Celsius → Kelvin")
    print("3. Fahrenheit → Celsius")
    print("4. Kelvin → Celsius")
    print("5. Voltar")

    escolha = input("Digite sua escolha (1-5): ")

    if escolha == '5' :
        return

    try:

        temp = float(input("Digite a temperatura: "))        

        if escolha == '1':
            resultado = celsius_para_fahrenheit(temp)
            print(f"\n✅ {temp}°C = {resultado:.2f}°F")
        elif escolha == '2':
            resultado = celsius_para_kelvin(temp)
            print(f"\n✅ {temp}°C = {resultado:.2f}K")
        elif escolha == '3':
            resultado = (temp - 32) * 5/9
            print(f"\n✅ {temp}°F = {resultado:.2f}°C")
        elif escolha == '4':
            resultado = temp - 273.15
            print(f"\n✅ {temp}K = {resultado:.2f}°C")
        else: 
            print("❌ Opção inválida!")
    except ValueError:
        print("❌ Erro: Digite um número válido!")

def menu_moedas():
    print("\n--- CONVERSOR DE MOEDAS ---")
    print("Siglas: USD (Dólar), BRL (Real), EUR (Euro)")
    print("        GBP (Libra), JPY (Iene)")

    # Validação moeda origem
    while True:
        origem = input("Moeda de origem (ex: USD): ").upper().strip()
        if origem in ['USD', 'BRL', 'EUR', 'GBP', 'JPY']:
            break
        else:
            print("❌ Moeda inválida! Use: USD, BRL, EUR, GBP, JPY")

    # Validação moeda destino
    while True:
        destino = input("Moeda de destino (ex: BRL): ").upper().strip()
        if destino in ['USD', 'BRL', 'EUR', 'GBP', 'JPY']:
            if destino != origem:
                break
            else:
                print("❌ Escolha uma moeda DIFERENTE da origem!")
        else:
            print("❌ Moeda inválida! Use: USD, BRL, EUR, GBP, JPY")

    # Validação do valor
    while True:
        try:
            valor_str = input(f"Valor em {origem}: ").strip()
            valor = float(valor_str)
            if valor > 0:
                break
            else:
                print("❌ Digite um valor maior que zero!")
        except ValueError:
            print("❌ Erro: Digite um número válido (ex: 10.50)")

    resultado = converter_moeda(valor, origem, destino)


    print(f"\n{'='*40}")
    print(f"💱 RESULTADO DA CONVERSÃO:")
    print(f"{'='*40}")
    print(f"💰 {valor:.2f} {origem} = {resultado:.2f} {destino}")


    taxa = resultado / valor
    print(f"📊 Taxa atual: 1 {origem} = {taxa:.4f} {destino}")
    print(f"{'='*40}")



def menu_distancia():
    print("\n--- CONVERSOR DE DISTÂNCIA ---")
    print("Unidades: km, milhas, metros")

    # Validação unidade origem
    while True:
        origem = input("Unidade de origem (km/milhas/metros): ").lower().strip()
        if origem in ['km', 'milhas', 'metros']:
            break
        else:
            print("❌ Unidade inválida! Use: km, milhas ou metros")

    # Validação unidade destino
    while True:
        destino = input("Unidade de destino (km/milhas/metros): ").lower().strip()
        if destino in ['km', 'milhas', 'metros']:
            if destino != origem:
                break
            else:
                print("❌ Escolha uma unidade DIFERENTE da origem!")
        else:
            print("❌ Unidade inválida! Use: km, milhas ou metros")

    # Validação do valor
    while True:
        try:
            valor_str = input(f"Distância em {origem}: ").strip()
            valor = float(valor_str)
            if valor > 0:
                break
            else:
                print("❌ Digite um valor maior que zero!")
        except ValueError:
            print("❌ Erro: Digite um número válido (ex: 10.5)")

    resultado = converter_distancia(valor, origem, destino)

    # Mostra resultado formatado
    print(f"\n{'='*40}")
    print(f"📏 RESULTADO DA CONVERSÃO:")
    print(f"{'='*40}")
    print(f"📐 {valor:.2f} {origem} = {resultado:.2f} {destino}")
    print(f"{'='*40}")

# ========== PROGRAMA PRINCIPAL ========
def main():
    print("Bem-vindo ao Conversor Universal! ")

    while True:
        escolha = menu_principal()

        if escolha == '4':
            print("\nObrigado por usar o Conversor! Até logo! 👋")
            break
        elif escolha == '1':        
            menu_temperatura()    
        elif escolha == '2':    
            menu_moedas()
        elif escolha == '3':
            menu_distancia()
        else:
            print("❌ Opção inválida! Tente novamente.")
        
        input("\nPressione Enter para continuar...")

if __name__ == "__main__":
    main()  


