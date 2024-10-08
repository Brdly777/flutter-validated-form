import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormularioPage(),
    );
  }
}

class FormularioPage extends StatefulWidget {
  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para cada campo
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _numeroTarjetaController =
      TextEditingController();
  final TextEditingController _mesController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  // Validaciones en tiempo real simplificadas
  String? validarNombre(String? value) {
    final RegExp regex = RegExp(r'^[^0-9]+$');
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    } else if (!regex.hasMatch(value)) {
      return 'No se permiten números en este campo';
    }
    return null;
  }

  String? validarCampoVacio(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este campo es obligatorio'
        : null;
  }

  String? validarNumeroTarjeta(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de tarjeta es obligatorio';
    } else if (value.length != 16) {
      return 'Debe tener 16 dígitos';
    }
    return null;
  }

  String? validarMes(String? value) {
    if (value == null || value.isEmpty) return 'Campo obligatorio';
    int mes = int.tryParse(value) ?? 0;
    return (mes < 1 || mes > 12) ? 'Mes inválido' : null;
  }

  String? validarYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    } else if (value.length != 4) {
      return 'El año debe tener 4 dígitos';
    } else if (int.tryParse(value) == null) {
      return 'El año debe ser un número';
    }

    int year = int.parse(value);
    if (year < DateTime.now().year) {
      return 'Año inválido';
    }

    return null;
  }

  String? validarCvv(String? value) {
    return (value == null || value.length != 3) ? 'Debe tener 3 dígitos' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FORMULARIO'), backgroundColor: Colors.purple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: validarNombre,
              ),
              TextFormField(
                controller: _apellidosController,
                decoration: InputDecoration(labelText: 'Apellidos'),
                validator: validarNombre,
              ),
              TextFormField(
                controller: _direccionController,
                decoration: InputDecoration(labelText: 'Dirección'),
                validator: validarCampoVacio,
              ),
              TextFormField(
                controller: _numeroTarjetaController,
                decoration: InputDecoration(labelText: 'Número de Tarjeta'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: validarNumeroTarjeta,
              ),
              TextFormField(
                controller: _mesController,
                decoration:
                    InputDecoration(labelText: 'Mes de Vencimiento (MM)'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: validarMes,
              ),
              TextFormField(
                controller: _yearController,
                decoration:
                    InputDecoration(labelText: 'Año de Vencimiento (YYYY)'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: validarYear,
              ),
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: validarCvv,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Mostrar el cuadro de datos
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Datos Ingresados Correctamente'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Nombre: ${_nombreController.text}'),
                                Text('Apellidos: ${_apellidosController.text}'),
                                Text('Dirección: ${_direccionController.text}'),
                                Text(
                                    'Número de Tarjeta: ${_numeroTarjetaController.text}'),
                                Text(
                                    'Mes de Vencimiento: ${_mesController.text}'),
                                Text(
                                    'Año de Vencimiento: ${_yearController.text}'),
                                Text('CVV: ${_cvvController.text}'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
