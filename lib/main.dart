import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:demo_app/screens/index.dart';
import 'package:demo_app/models/paciente.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX', null);
  Intl.defaultLocale = 'es_MX';
  runApp(AppClinica());
}

class AppClinica extends StatelessWidget {
  AppClinica({super.key});

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
      theme: ThemeData(fontFamily: 'Urbanist'),
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
