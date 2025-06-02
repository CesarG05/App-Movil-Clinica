import 'package:flutter/material.dart';
import '../services/paciente_service.dart';
import '../widgets/paciente_form.dart';

class AgregarPacienteScreen extends StatelessWidget {
  const AgregarPacienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Paciente')),
      body: PacienteForm(
        onSubmit: (paciente) async {
          final servicio = PacienteService();
          final exito = await servicio.agregarPaciente(paciente);
          if (exito && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Paciente añadido exitosamente')),
            );
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al añadir paciente')),
            );
          }
        },
      ),
    );
  }
}
