import 'package:flutter/material.dart';
import '../screens/index.dart';
import '../models/paciente.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routes = {
    '/home': (context) => const HomeScreen(),
    '/pacientes': (context) => const ListaPacientesScreen(),
    '/agregarPaciente': (context) => const AgregarPacienteScreen(),
    '/editarPaciente': (context) {
      final paciente = ModalRoute.of(context)!.settings.arguments as Paciente;
      return EditarPacienteScreen(paciente: paciente);
    },
    '/detallePaciente': (context) {
      final paciente = ModalRoute.of(context)!.settings.arguments as Paciente;
      return PacienteDetalleScreen(paciente: paciente);
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clínica App',
      theme: ThemeData(
        //colorSchemeSeed: Colors.teal,
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/home',
      routes: _routes,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => ErrorScreen(routeName: settings.name),
        );
      },
    );
  }
}


