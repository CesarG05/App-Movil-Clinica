import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? routeName;

  const ErrorScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            Navigator.canPop(context)
                ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
        title: const Text('Ruta no encontrada'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                'No se encontró la ruta:\n$routeName',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Ir al inicio'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
