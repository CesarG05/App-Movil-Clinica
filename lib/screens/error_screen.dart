import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? routeName;

  const ErrorScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta no encontrada')),
      body: Center(child: Text('No se encontró la ruta: $routeName')),
    );
  }
}
