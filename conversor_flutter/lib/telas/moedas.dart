import 'package:flutter/material.dart';

class TelaMoedas extends StatefulWidget {
  @override
  _TelaMoedasState createState() => _TelaMoedasState();
}

class _TelaMoedasState extends State<TelaMoedas> {
  TextEditingController _controller = TextEditingController();
  String _de = 'USD';
  String _para = 'BRL';
  String _resultado = '';

  final Map<String, String> _moedas = {
    'USD': 'Dólar Americano',
    'BRL': 'Real Brasileiro',
    'EUR': 'Euro',
    'GBP': 'Libra Esterlina',
    'JPY': 'Iene Japonês',
  };

  final Map<String, double> _taxas = {
    'USD_BRL': 5.20,
    'USD_EUR': 0.92,
    'USD_GBP': 0.79,
    'USD_JPY': 148.50,
    'BRL_USD': 0.19,
    'BRL_EUR': 0.18,
    'EUR_USD': 1.09,
    'EUR_BRL': 5.56,
    'GBP_USD': 1.27,
    'JPY_USD': 0.0067,
  };

  void _converter() {
    try {
      double valor = double.parse(_controller.text);
      String chave = '${_de}_${_para}';

      if (_taxas.containsKey(chave)) {
        double resultado = valor * _taxas[chave]!;
        double taxa = _taxas[chave]!;

        setState(() {
          _resultado = '${valor.toStringAsFixed(2)} $_de = '
              '${resultado.toStringAsFixed(2)} $_para\n'
              'Taxa: 1 $_de = ${taxa.toStringAsFixed(4)} $_para';
        });
      } else if (_de == _para) {
        setState(() {
          _resultado = '⚠️ Selecione moedas diferentes!';
        });
      } else {
        setState(() {
          _resultado = '❌ Taxa não disponível para $_de → $_para';
        });
      }
    } catch (e) {
      setState(() {
        _resultado = '❌ Digite um número válido!';
      });
    }
  }

  void _limpar() {
    setState(() {
      _controller.clear();
      _resultado = '';
    });
  }

  void _trocarMoedas() {
    setState(() {
      String temp = _de;
      _de = _para;
      _para = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> moedasList = _moedas.keys.toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.attach_money, size: 40, color: Colors.green),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Conversor de Moedas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      hintText: 'Ex: 100',
                      prefixIcon: Icon(Icons.monetization_on, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    onSubmitted: (_) => _converter(),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'De:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _de,
                                  isExpanded: true,
                                  items: moedasList.map((moeda) {
                                    return DropdownMenuItem<String>(
                                      value: moeda,
                                      child: Text('$moeda - ${_moedas[moeda]}'),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _de = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          SizedBox(height: 24),
                          IconButton(
                            onPressed: _trocarMoedas,
                            icon: Icon(Icons.swap_horiz, color: Colors.green),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.green.shade50,
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Para:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _para,
                                  isExpanded: true,
                                  items: moedasList.map((moeda) {
                                    return DropdownMenuItem<String>(
                                      value: moeda,
                                      child: Text('$moeda - ${_moedas[moeda]}'),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _para = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _converter,
                          icon: Icon(Icons.autorenew),
                          label: Text('CONVERTER'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade800,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _limpar,
                          icon: Icon(Icons.cleaning_services),
                          label: Text('LIMPAR'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade600,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          if (_resultado.isNotEmpty)
            Card(
              elevation: 4,
              color: _resultado.contains('❌') || _resultado.contains('⚠️')
                  ? Colors.orange.shade50
                  : Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: _resultado.contains('❌') || _resultado.contains('⚠️')
                      ? Colors.orange.shade200
                      : Colors.green.shade200,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      _resultado.contains('❌') ? '❌ ERRO' :
                      _resultado.contains('⚠️') ? '⚠️ AVISO' : '✅ RESULTADO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _resultado.contains('❌') ? Colors.red.shade800 :
                        _resultado.contains('⚠️') ? Colors.orange.shade800 :
                        Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      _resultado.replaceAll('❌ ', '').replaceAll('⚠️ ', ''),
                      style: TextStyle(
                        fontSize: _resultado.contains('\n') ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: _resultado.contains('❌') ? Colors.red.shade900 :
                        _resultado.contains('⚠️') ? Colors.orange.shade900 :
                        Colors.green.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 25),
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        '💱 Taxas Atuais (fixas):',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('• 1 USD = ${_taxas['USD_BRL']?.toStringAsFixed(2) ?? '5.20'} BRL'),
                  Text('• 1 USD = ${_taxas['USD_EUR']?.toStringAsFixed(2) ?? '0.92'} EUR'),
                  Text('• 1 EUR = ${_taxas['EUR_BRL']?.toStringAsFixed(2) ?? '5.56'} BRL'),
                  Text('• 1 GBP = ${_taxas['GBP_USD']?.toStringAsFixed(2) ?? '1.27'} USD'),
                  SizedBox(height: 10),
                  Text(
                    'ℹ️ As taxas são fixas para demonstração.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}