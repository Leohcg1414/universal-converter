import tkinter as tk
from tkinter import ttk, messagebox
import requests

class ConversorApp:
    def __init__(self):
        self.janela = tk.Tk()
        self.janela.title("Conversor Universal Pro v2.0")
        self.janela.geometry("550x650")
        self.janela.configure(bg="#f0f0f0")
        self.janela.resizable(False, False) 

        self.centralizar_janela()
        
        self.criar_widgets()
        self.janela.mainloop()
    
    def centralizar_janela(self):
        self.janela.update_idletasks()
        largura = self.janela.winfo_width()
        altura = self.janela.winfo_height()
        x = (self.janela.winfo_screenwidth() // 2) - (largura // 2)
        y = (self.janela.winfo_screenheight() // 2) - (altura // 2)
        self.janela.geometry(f'{largura}x{altura}+{x}+{y}')
    
    def criar_widgets(self):
        cabecalho = tk.Frame(self.janela, bg="#2c3e50", height=80)
        cabecalho.pack(fill='x')
        
        titulo = tk.Label(
            cabecalho,
            text="🧮 CONVERSOR UNIVERSAL PRO",
            font=("Arial", 22, "bold"),
            bg="#2c3e50",
            fg="white"
        )
        titulo.pack(pady=20)

        self.notebook = ttk.Notebook(self.janela)
        self.notebook.pack(fill='both', expand=True, padx=20, pady=10)
        
        # Criar abas
        self.criar_aba_temperatura()
        self.criar_aba_moedas()
        self.criar_aba_distancia()

        self.notebook.bind("<<NotebookTabChanged>>", self.ao_trocar_aba)
        rodape = tk.Frame(self.janela, bg="#34495e", height=50)
        rodape.pack(fill='x', side='bottom')
        
        tk.Label(
            rodape,
            text="Desenvolvido com Python + Tkinter | Pressione Enter para converter",
            font=("Arial", 9),
            bg="#34495e",
            fg="#ecf0f1"
        ).pack(pady=15)
    
    def criar_aba_temperatura(self):
        frame = tk.Frame(self.notebook, bg="white")
        self.notebook.add(frame, text="🌡️ Temperatura")
        
        tk.Label(
            frame,
            text="Conversor de Temperatura",
            font=("Arial", 16, "bold"),
            bg="white"
        ).pack(pady=20)

        frame_entrada = tk.Frame(frame, bg="white")
        frame_entrada.pack(pady=10)
        
        # Valor
        tk.Label(frame_entrada, text="Valor:", bg="white", font=("Arial", 11)).grid(row=0, column=0, padx=5, pady=8, sticky='e')
        self.entry_temp = tk.Entry(frame_entrada, width=15, font=("Arial", 12), relief=tk.GROOVE, bd=2)
        self.entry_temp.grid(row=0, column=1, padx=5, pady=8)
        self.entry_temp.bind("<Return>", lambda e: self.converter_temperatura())
        self.entry_temp.focus()
        
        # De
        tk.Label(frame_entrada, text="De:", bg="white", font=("Arial", 11)).grid(row=1, column=0, padx=5, pady=8, sticky='e')
        self.combo_temp_origem = ttk.Combobox(frame_entrada, values=["Celsius", "Fahrenheit", "Kelvin"], 
                                             width=13, font=("Arial", 11), state="readonly")
        self.combo_temp_origem.grid(row=1, column=1, padx=5, pady=8)
        self.combo_temp_origem.current(0)
        
        # Para
        tk.Label(frame_entrada, text="Para:", bg="white", font=("Arial", 11)).grid(row=2, column=0, padx=5, pady=8, sticky='e')
        self.combo_temp_destino = ttk.Combobox(frame_entrada, values=["Celsius", "Fahrenheit", "Kelvin"], 
                                              width=13, font=("Arial", 11), state="readonly")
        self.combo_temp_destino.grid(row=2, column=1, padx=5, pady=8)
        self.combo_temp_destino.current(1)

        frame_botoes = tk.Frame(frame, bg="white")
        frame_botoes.pack(pady=15)
        
        #  Converter
        btn_converter = tk.Button(
            frame_botoes,
            text="Converter",
            command=self.converter_temperatura,
            bg="#3498db",
            fg="white",
            font=("Arial", 11, "bold"),
            padx=20,
            pady=8,
            width=12,
            relief=tk.RAISED,
            bd=2,
            cursor="hand2"
        )
        btn_converter.grid(row=0, column=0, padx=5)
        
        # Botão Limpar
        btn_limpar = tk.Button(
            frame_botoes,
            text="Limpar",
            command=self.limpar_aba_temperatura,
            bg="#95a5a6",
            fg="white",
            font=("Arial", 11, "bold"),
            padx=20,
            pady=8,
            width=12,
            relief=tk.RAISED,
            bd=2,
            cursor="hand2"
        )
        btn_limpar.grid(row=0, column=1, padx=5)

        frame_resultado = tk.Frame(frame, bg="#ecf0f1", relief=tk.GROOVE, bd=3)
        frame_resultado.pack(pady=20, padx=30, fill='x')
        
        tk.Label(
            frame_resultado,
            text="RESULTADO",
            font=("Arial", 12, "bold"),
            bg="#ecf0f1",
            fg="#2c3e50"
        ).pack(pady=(10, 5))
        
        self.label_temp_resultado = tk.Label(
            frame_resultado,
            text="---",
            font=("Arial", 20, "bold"),
            bg="#ecf0f1",
            fg="#e74c3c",
            height=3
        )
        self.label_temp_resultado.pack(pady=(5, 15))
        
        tk.Label(
            frame,
            text="💡 Dica: C = Celsius | F = Fahrenheit | K = Kelvin",
            font=("Arial", 9),
            bg="white",
            fg="#7f8c8d"
        ).pack(pady=5)
    
    def criar_aba_moedas(self):
        frame = tk.Frame(self.notebook, bg="white")
        self.notebook.add(frame, text="💰 Moedas")
        
        tk.Label(
            frame,
            text="Conversor de Moedas",
            font=("Arial", 16, "bold"),
            bg="white"
        ).pack(pady=20)
        
        # Moedas disponíveis
        moedas = ["USD - Dólar Americano", "BRL - Real Brasileiro", "EUR - Euro", 
                  "GBP - Libra Esterlina", "JPY - Iene Japonês"]
        
        frame_controles = tk.Frame(frame, bg="white")
        frame_controles.pack(pady=10)
        
        # De
        tk.Label(frame_controles, text="De:", bg="white", font=("Arial", 11)).grid(row=0, column=0, padx=5, pady=8, sticky='e')
        self.combo_moeda_origem = ttk.Combobox(frame_controles, values=moedas, width=25, 
                                              font=("Arial", 11), state="readonly")
        self.combo_moeda_origem.grid(row=0, column=1, padx=5, pady=8)
        self.combo_moeda_origem.current(0)
        
        # Para
        tk.Label(frame_controles, text="Para:", bg="white", font=("Arial", 11)).grid(row=1, column=0, padx=5, pady=8, sticky='e')
        self.combo_moeda_destino = ttk.Combobox(frame_controles, values=moedas, width=25, 
                                               font=("Arial", 11), state="readonly")
        self.combo_moeda_destino.grid(row=1, column=1, padx=5, pady=8)
        self.combo_moeda_destino.current(1)
        
        # Valor
        tk.Label(frame_controles, text="Valor:", bg="white", font=("Arial", 11)).grid(row=2, column=0, padx=5, pady=8, sticky='e')
        self.entry_moeda = tk.Entry(frame_controles, width=15, font=("Arial", 12), relief=tk.GROOVE, bd=2)
        self.entry_moeda.grid(row=2, column=1, padx=5, pady=8)
        self.entry_moeda.bind("<Return>", lambda e: self.converter_moeda())
        
        # Frame dos botões
        frame_botoes = tk.Frame(frame, bg="white")
        frame_botoes.pack(pady=15)
        
        # Botão Converter
        btn_converter = tk.Button(
            frame_botoes,
            text="Converter",
            command=self.converter_moeda,
            bg="#2ecc71",
            fg="white",
            font=("Arial", 11, "bold"),
            padx=20,
            pady=8,
            width=12,
            relief=tk.RAISED,
            bd=2,
            cursor="hand2"
        )
        btn_converter.grid(row=0, column=0, padx=5)
        
        # Botão Limpar
        btn_limpar = tk.Button(
            frame_botoes,
            text="Limpar",
            command=self.limpar_aba_moedas,
            bg="#95a5a6",
            fg="white",
            font=("Arial", 11, "bold"),
            padx=20,
            pady=8,
            width=12,
            relief=tk.RAISED,
            bd=2,
            cursor="hand2"
        )
        btn_limpar.grid(row=0, column=1, padx=5)
        
        frame_resultado = tk.Frame(frame, bg="#ecf0f1", relief=tk.GROOVE, bd=3)
        frame_resultado.pack(pady=20, padx=30, fill='x')
        
        self.label_moeda_resultado = tk.Label(
            frame_resultado,
            text="Digite um valor e clique em CONVERTER\n\n💱 Resultado aparecerá aqui",
            font=("Arial", 11),
            bg="#ecf0f1",
            fg="#2c3e50",
            justify="center",
            wraplength=400
        )
        self.label_moeda_resultado.pack(pady=25)
        
        # Status API
        self.label_status_api = tk.Label(
            frame,
            text="🟢 API Online",
            font=("Arial", 9),
            bg="white",
            fg="#27ae60"
        )
        self.label_status_api.pack(pady=5)
    
    def criar_aba_distancia(self):
        frame = tk.Frame(self.notebook, bg="white")
        self.notebook.add(frame, text="📏 Distância")
        
        tk.Label(
            frame,
            text="Conversor de Distância",
            font=("Arial", 16, "bold"),
            bg="white"
        ).pack(pady=20)
        
        unidades = ["Quilômetros (km)", "Milhas", "Metros (m)"]
        
        frame_controles = tk.Frame(frame, bg="white")
        frame_controles.pack(pady=10)
        
        # De
        tk.Label(frame_controles, text="De:", bg="white", font=("Arial", 11)).grid(row=0, column=0, padx=5, pady=8, sticky='e')
        self.combo_dist_origem = ttk.Combobox(frame_controles, values=unidades, width=20, 
                                             font=("Arial", 11), state="readonly")
        self.combo_dist_origem.grid(row=0, column=1, padx=5, pady=8)
        self.combo_dist_origem.current(0)
        
        # Para
        tk.Label(frame_controles, text="Para:", bg="white", font=("Arial", 11)).grid(row=1, column=0, padx=5, pady=8, sticky='e')
        self.combo_dist_destino = ttk.Combobox(frame_controles, values=unidades, width=20, 
                                              font=("Arial", 11), state="readonly")
        self.combo_dist_destino.grid(row=1, column=1, padx=5, pady=8)
        self.combo_dist_destino.current(1)
        
        # Valor
        tk.Label(frame_controles, text="Valor:", bg="white", font=("Arial", 11)).grid(row=2, column=0, padx=5, pady=8, sticky='e')
        self.entry_dist = tk.Entry(frame_controles, width=15, font=("Arial", 12), relief=tk.GROOVE, bd=2)
        self.entry_dist.grid(row=2, column=1, padx=5, pady=8)
        self.entry_dist.bind("<Return>", lambda e: self.converter_distancia())

        frame_botoes = tk.Frame(frame, bg="white")
        frame_botoes.pack(pady=15)

        btn_converter = tk.Button(
            frame_botoes,
            text="Converter",
            command=self.converter_distancia,
            bg="#e74c3c",
            fg="white",
            font=("Arial", 11, "bold"),
            padx=20,
            pady=8,
            width=12,
            relief=tk.RAISED,
            bd=2,
            cursor="hand2"
        )
        btn_converter.grid(row=0, column=0, padx=5)

        btn_limpar = tk.Button(
            frame_botoes,
            text="Limpar",
            command=self.limpar_aba_distancia,
            bg="#95a5a6",
            fg="white",
            font=("Arial", 11, "bold"),
            padx=20,
            pady=8,
            width=12,
            relief=tk.RAISED,
            bd=2,
            cursor="hand2"
        )
        btn_limpar.grid(row=0, column=1, padx=5)

        frame_resultado = tk.Frame(frame, bg="#ecf0f1", relief=tk.GROOVE, bd=3)
        frame_resultado.pack(pady=20, padx=30, fill='x')
        
        tk.Label(
            frame_resultado,
            text="RESULTADO",
            font=("Arial", 12, "bold"),
            bg="#ecf0f1",
            fg="#2c3e50"
        ).pack(pady=(10, 5))
        
        self.label_dist_resultado = tk.Label(
            frame_resultado,
            text="---",
            font=("Arial", 18, "bold"),
            bg="#ecf0f1",
            fg="#2980b9",
            height=3
        )
        self.label_dist_resultado.pack(pady=(5, 15))

        frame_equivalencias = tk.Frame(frame, bg="white")
        frame_equivalencias.pack(pady=10)
        
        tk.Label(
            frame_equivalencias,
            text="📐 Equivalências: 1 km = 0.6214 milhas | 1 milha = 1.6093 km | 1 km = 1000 m",
            font=("Arial", 9),
            bg="white",
            fg="#7f8c8d"
        ).pack()
    
    # ===== MÉTODOS DE LIMPEZA =====
    def limpar_aba_temperatura(self):
        self.entry_temp.delete(0, tk.END)
        self.combo_temp_origem.current(0)
        self.combo_temp_destino.current(1)
        self.label_temp_resultado.config(text="---", fg="#e74c3c")
        self.entry_temp.focus()
    
    def limpar_aba_moedas(self):
        self.entry_moeda.delete(0, tk.END)
        self.combo_moeda_origem.current(0)
        self.combo_moeda_destino.current(1)
        self.label_moeda_resultado.config(
            text="Digite um valor e clique em CONVERTER\n\n💱 Resultado aparecerá aqui",
            fg="#2c3e50"
        )
        self.entry_moeda.focus()
    
    def limpar_aba_distancia(self):
        self.entry_dist.delete(0, tk.END)
        self.combo_dist_origem.current(0)
        self.combo_dist_destino.current(1)
        self.label_dist_resultado.config(text="---", fg="#2980b9")
        self.entry_dist.focus()
    
    
    def ao_trocar_aba(self, event):
        aba_atual = self.notebook.index(self.notebook.select())
        
        if aba_atual == 0:  
            self.limpar_aba_temperatura()
        elif aba_atual == 1:  
            self.limpar_aba_moedas()
        elif aba_atual == 2: 
            self.limpar_aba_distancia()
    
    # ===== FUNÇÕES DE CONVERSÃO =====
    def converter_temperatura(self):
        try:
            valor = float(self.entry_temp.get())
            origem = self.combo_temp_origem.get()
            destino = self.combo_temp_destino.get()
            
            # Converter para Celsius primeiro
            if origem == "Celsius":
                celsius = valor
            elif origem == "Fahrenheit":
                celsius = (valor - 32) * 5/9
            else:  # Kelvin
                celsius = valor - 273.15
            
            #  destino
            if destino == "Celsius":
                resultado = celsius
                simbolo = "°C"
            elif destino == "Fahrenheit":
                resultado = (celsius * 9/5) + 32
                simbolo = "°F"
            else:  # Kelvin
                resultado = celsius + 273.15
                simbolo = "K"
            
            #  resultado
            self.label_temp_resultado.config(
                text=f"{valor:.2f} {origem[:1]} = {resultado:.2f}{simbolo}",
                fg="#27ae60"  
            )
            
        except ValueError:
            messagebox.showerror("Erro", "❌ Digite um número válido!")
            self.label_temp_resultado.config(text="ERRO", fg="#e74c3c")
    
    def converter_moeda(self):
        try: 
            valor = float(self.entry_moeda.get())
            origem = self.combo_moeda_origem.get().split(" - ")[0]
            destino = self.combo_moeda_destino.get().split(" - ")[0]
            
            # Tentar API
            url = f"https://api.exchangerate-api.com/v4/latest/{origem}"
            
            try:
                resposta = requests.get(url, timeout=5)
                dados = resposta.json()
                taxa = dados['rates'][destino]
                resultado = valor * taxa
                fonte = "API Online"
                self.label_status_api.config(text="🟢 API Online", fg="#27ae60")
            except:
                # Taxas fixas se API falhar
                taxas_fixas = {
                    'USD_BRL': 5.20,
                    'BRL_USD': 0.19,
                    'USD_EUR': 0.92,
                    'EUR_USD': 1.09,
                    'BRL_EUR': 0.18,
                    'EUR_BRL': 5.56,
                    'USD_GBP': 0.79,
                    'GBP_USD': 1.27,
                    'USD_JPY': 148.50,
                    'JPY_USD': 0.0067,
                }
                chave = f"{origem}_{destino}"
                if chave in taxas_fixas:
                    resultado = valor * taxas_fixas[chave]
                    fonte = f"Taxa Fixa: 1 {origem} = {taxas_fixas[chave]} {destino}"
                else:
                    resultado = valor
                    fonte = "Taxa 1:1 (par não encontrado)"
                self.label_status_api.config(text="⚠️ API Offline - Usando taxas fixas", fg="#e67e22")
            
            # resultado
            texto_resultado = f"""💱 {valor:.2f} {origem} = {resultado:.2f} {destino}

📊 Taxa de Câmbio:
1 {origem} = {resultado/valor:.4f} {destino}

ℹ️  {fonte}"""
            
            self.label_moeda_resultado.config(text=texto_resultado, fg="#27ae60")
            
        except ValueError:
            messagebox.showerror("Erro", "❌ Digite um número válido!")
            self.label_moeda_resultado.config(
                text="❌ ERRO: Digite um número válido!",
                fg="#e74c3c"
            )
        except Exception as e:
            messagebox.showerror("Erro", f"❌ Erro na conversão: {str(e)}")
            self.label_moeda_resultado.config(
                text=f"❌ ERRO: {str(e)[:50]}...",
                fg="#e74c3c"
            )
    
    def converter_distancia(self):
        try: 
            valor = float(self.entry_dist.get())
            origem = self.combo_dist_origem.get()
            destino = self.combo_dist_destino.get()
            
            # Converter para metros primeiro
            if "km" in origem.lower():
                metros = valor * 1000
            elif "milhas" in origem.lower():     
                metros = valor * 1609.344
            else:  # metros
                metros = valor
            
            #  destino
            if "km" in destino.lower():
                resultado = metros / 1000
                simbolo_destino = "km"
            elif "milhas" in destino.lower():
                resultado = metros / 1609.344
                simbolo_destino = "milhas"
            else:  # metros
                resultado = metros
                simbolo_destino = "m"
            
            #  origem
            if "km" in origem.lower():
                simbolo_origem = "km"
            elif "milhas" in origem.lower():
                simbolo_origem = "milhas"
            else:
                simbolo_origem = "m"
            
            self.label_dist_resultado.config(
                text=f"📏 {valor:.2f} {simbolo_origem} = {resultado:.2f} {simbolo_destino}",
                fg="#27ae60"
            )
            
        except ValueError:
            messagebox.showerror("Erro", "❌ Digite um número válido!")
            self.label_dist_resultado.config(text="❌ ERRO", fg="#e74c3c")

# ===== INICIAR APLICAÇÃO =====
if __name__ == "__main__":
    app = ConversorApp()