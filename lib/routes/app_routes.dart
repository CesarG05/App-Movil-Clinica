// lib/routes/app_routes.dart

import 'package:flutter/material.dart';
import 'package:demo_app/screens/index.dart';
import 'package:demo_app/models/paciente.dart';

class AppRoutes {
  // Rutas nombradas como constantes para evitar errores
  static const String home = '/home';
  static const String pacientes = '/pacientes';
  static const String agregarPaciente = '/agregarPaciente';
  static const String editarPaciente = '/editarPaciente';
  static const String detallePaciente = '/detallePaciente';

  /// Rutas estáticas sin argumentos
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      pacientes: (context) => const ListaPacientesScreen(),
      agregarPaciente: (context) => const AgregarPacienteScreen(),
    };
  }

  /// Rutas que requieren argumentos dinámicos
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case editarPaciente:
        final paciente = settings.arguments as Paciente;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditarPacienteScreen(paciente: paciente),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      // return MaterialPageRoute(
      //   builder: (context) => EditarPacienteScreen(paciente: paciente),
      // );

      case detallePaciente:
        final paciente = settings.arguments as Paciente;
        return MaterialPageRoute(
          builder: (context) => PacienteDetalleScreen(paciente: paciente),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => ErrorScreen(routeName: settings.name),
        );
    }
  }
}
