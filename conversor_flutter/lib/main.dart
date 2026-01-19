import 'package:flutter/material.dart';
import 'tela_principal.dart';

void main() {
  runApp(ConversorApp());
}

class ConversorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor Universal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaPrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}