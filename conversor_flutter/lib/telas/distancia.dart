import 'package:flutter/material.dart';

class TelaDistancia extends StatefulWidget {
  @override
  _TelaDistanciaState createState() => _TelaDistanciaState();
}

class _TelaDistanciaState extends State<TelaDistancia> {
  TextEditingController _controller = TextEditingController();
  String _de = 'Quilômetros';
  String _para = 'Milhas';
  String _resultado = '';
  final List<String> _unidades = ['Quilômetros', 'Metros', 'Milhas'];

  final Map<String, double> _conversoes = {
    'Quilômetros_Metros': 1000.0,
    'Quilômetros_Milhas': 0.621371,
    'Metros_Quilômetros': 0.001,
    'Metros_Milhas': 0.000621371,
    'Milhas_Quilômetros': 1.60934,
    'Milhas_Metros': 1609.34,
  };

  void _converter() {
    try {
      double valor = double.parse(_controller.text);

      if (_de == _para) {
        setState(() {
          _resultado = '⚠️ Selecione unidades diferentes!';
        });
        return;
      }

      String chave = '${_de}_${_para}';

      if (_conversoes.containsKey(chave)) {
        double resultado = valor * _conversoes[chave]!;

        String abreviacaoDe = _getAbreviacao(_de);
        String abreviacaoPara = _getAbreviacao(_para);

        setState(() {
          _resultado = '${valor.toStringAsFixed(2)} $abreviacaoDe = '
              '${resultado.toStringAsFixed(2)} $abreviacaoPara';
        });
      } else {
        setState(() {
          _resultado = '❌ Conversão não disponível';
        });
      }
    } catch (e) {
      setState(() {
        _resultado = '❌ Digite um número válido!';
      });
    }
  }

  String _getAbreviacao(String unidade) {
    switch (unidade) {
      case 'Quilômetros': return 'km';
      case 'Metros': return 'm';
      case 'Milhas': return 'mi';
      default: return unidade;
    }
  }

  void _limpar() {
    setState(() {
      _controller.clear();
      _resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  Icon(Icons.straighten, size: 40, color: Colors.red),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Conversor de Distância',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
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
                      prefixIcon: Icon(Icons.place, color: Colors.red),
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
                                  items: _unidades.map((unidade) {
                                    return DropdownMenuItem<String>(
                                      value: unidade,
                                      child: Text(unidade),
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
                      SizedBox(width: 15),
                      Icon(Icons.arrow_forward, color: Colors.red, size: 30),
                      SizedBox(width: 15),
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
                                  items: _unidades.map((unidade) {
                                    return DropdownMenuItem<String>(
                                      value: unidade,
                                      child: Text(unidade),
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
                            backgroundColor: Colors.red.shade800,
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
                  : Colors.red.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: _resultado.contains('❌') || _resultado.contains('⚠️')
                      ? Colors.orange.shade200
                      : Colors.red.shade200,
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
                        Colors.red.shade800,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      _resultado.replaceAll('❌ ', '').replaceAll('⚠️ ', ''),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _resultado.contains('❌') ? Colors.red.shade900 :
                        _resultado.contains('⚠️') ? Colors.orange.shade900 :
                        Colors.red.shade900,
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
                      Icon(Icons.straighten, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        '📐 Equivalências:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('• 1 Quilômetro (km) = 1000 Metros (m)'),
                  Text('• 1 Quilômetro (km) = 0.6214 Milhas (mi)'),
                  Text('• 1 Milha (mi) = 1.6093 Quilômetros (km)'),
                  Text('• 1 Milha (mi) = 1609.34 Metros (m)'),
                  Text('• 1 Metro (m) = 0.001 Quilômetros (km)'),
                  Text('• 1 Metro (m) = 0.0006214 Milhas (mi)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}