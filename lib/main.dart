import 'package:flutter/material.dart';
import 'formulario_page.dart'; // Asegúrate de que la ruta sea la correcta

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Tarjeta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormularioPage(), // Aquí se llama a la página del formulario
    );
  }
}
