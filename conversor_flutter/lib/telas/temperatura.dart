import 'package:flutter/material.dart';

class TelaTemperatura extends StatefulWidget {
  @override
  TelaTemperaturaState createState() => TelaTemperaturaState();
}

class TelaTemperaturaState extends State<TelaTemperatura> {
  TextEditingController _controller = TextEditingController();
  String _de = 'Celsius';
  String _para = 'Fahrenheit';
  String _resultado = '';

  final List<String> _unidades = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _converter() {
    try {
      double valor = double.parse(_controller.text);
      double celsius;

      if (_de == 'Celsius') {
        celsius = valor;
      } else if (_de == 'Fahrenheit') {
        celsius = (valor - 32) * 5/9;
      } else {
        celsius = valor - 273.15;
      }

      double resultado;
      if (_para == 'Celsius') {
        resultado = celsius;
      } else if (_para == 'Fahrenheit') {
        resultado = (celsius * 9/5) + 32;
      } else { // Kelvin
        resultado = celsius + 273.15;
      }

      setState(() {
        _resultado = '${valor.toStringAsFixed(2)}°${_de[0]} = '
            '${resultado.toStringAsFixed(2)}°${_para[0]}';
      });
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
                  Icon(Icons.thermostat, size: 40, color: Colors.blue),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Conversor de Temperatura',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
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
                      prefixIcon: Icon(Icons.edit, color: Colors.blue),
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
                      Icon(Icons.arrow_forward, color: Colors.blue, size: 30),
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
                            backgroundColor: Colors.blue.shade800,
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
              color: _resultado.contains('❌')
                  ? Colors.red.shade50
                  : Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: _resultado.contains('❌')
                      ? Colors.red.shade200
                      : Colors.green.shade200,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      _resultado.contains('❌') ? '❌ ERRO' : '✅RESULTADO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _resultado.contains('❌')
                            ? Colors.red.shade800
                            : Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      _resultado.replaceAll('❌ ', ''),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _resultado.contains('❌')
                            ? Colors.red.shade900
                            : Colors.green.shade900,
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
                  Text(
                    '💡 Informações:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('• C = Celsius (°C)'),
                  Text('• F = Fahrenheit (°F)'),
                  Text('• K = Kelvin (K)'),
                  SizedBox(height: 10),
                  Text('• Fórmula: °F = (°C × 9/5) + 32'),
                  Text('• Fórmula: K = °C + 273.15'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}