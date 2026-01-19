import 'package:flutter/material.dart';
import 'telas/temperatura.dart';
import 'telas/moedas.dart';
import 'telas/distancia.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _abaAtual = 0;

  final List<Widget> _abas = [
    TelaTemperatura(),
    TelaMoedas(),
    TelaDistancia(),
  ];

  final List<String> _titulos = [
    '🌡️ Temperatura',
    '💰 Moedas',
    '📏 Distância',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulos[_abaAtual]),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blue.shade800,
      ),
      body: _abas[_abaAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaAtual,
        onTap: (index) {
          setState(() {
            _abaAtual = index;
          });
        },
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),
              label: 'Temperatura'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Moedas'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.straighten),
            label: 'Distância',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.change_circle,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Conversor Universal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'vl.0.0',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.thermostat, color: Colors.blue),
              title: Text('Temperatura'),
              onTap: () {
                setState(() {
                  _abaAtual = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.green),
              title: Text('Moedas'),
              onTap: () {
                setState(() {
                  _abaAtual = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.straighten, color: Colors.red),
              title: Text('Distância'),
              onTap: () {
                setState(() {
                  _abaAtual = 2;
                });
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey),
              title: Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Conversor Universal',
                  applicationVersion: '1.0.0',
                  children: [
                    Text('Desenvolvido com Flutter'),
                    SizedBox(height: 10),
                    Text('Converte temperatura, moedas e distância')
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}