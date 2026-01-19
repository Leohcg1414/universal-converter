# Conversor Universal 

Projeto de estudo desenvolvido para praticar **desenvolvimento mobile com Flutter** e **aplicações em Python**, reunindo diferentes tipos de conversão em um único projeto.

O foco principal foi aplicar **lógica de programação**, **organização de código** e **validação de dados**, criando algo funcional e apresentável para portfólio.

---

## Objetivo do Projeto

* Praticar desenvolvimento **Flutter (Dart)** e **Python**
* Trabalhar com múltiplas plataformas (mobile e desktop)
* Aplicar validações e tratamento de erros
* Consumir API externa e tratar falhas de conexão
* Criar um projeto real para o **GitHub / Portfólio**

---

## Tecnologias Utilizadas

### Mobile

* **Flutter**
* **Dart**
* Material Design
* Navegação por abas

### Desktop

* **Python**
* **Tkinter** (interface gráfica)
* **Requests** (consumo de API)
* API de câmbio em tempo real

### Outros

* Git & GitHub
* Organização por módulos
* Tratamento de exceções

---

## Funcionalidades

### Aplicativo Flutter

* Conversão de **Temperatura**

  * Celsius
  * Fahrenheit
  * Kelvin
* Conversão de **Moedas**
* Conversão de **Distância**
* Navegação por abas
* Interface responsiva e intuitiva
* Validação de entradas e mensagens de erro amigáveis

---

### Aplicativo Python (Desktop)

#### Conversões disponíveis

* Temperatura
* Moedas (com API em tempo real)
* Distância

#### Diferenciais

* Interface gráfica com **Tkinter**
* Versão **CLI (terminal)** e **GUI**
* Consumo de API externa para câmbio
* **Fallback automático** para taxas fixas quando a API está offline
* Validação de dados (valores inválidos, negativos, unidades iguais, etc.)
* Feedback visual do status da API

---

## Como Executar o Projeto

### Flutter App

```bash
cd conversor_flutter
flutter pub get
flutter run
```

---

### Python App

```bash
cd python-app
pip install -r requirements.txt
python gui_converter.py
```

Ou versão terminal:

```bash
python converter.py
```

---

## Aprendizados

Durante o desenvolvimento deste projeto, foram praticados:

* Organização de projetos Flutter
* Separação de telas e responsabilidades
* Criação de interfaces gráficas em Python
* Consumo de API externa
* Tratamento de exceções e falhas de conexão
* Validação de entrada do usuário
* Uso do Git para versionamento

---

## Autor

Desenvolvido por **Leonardo Garcia**
📌 Projeto criado para estudo 
