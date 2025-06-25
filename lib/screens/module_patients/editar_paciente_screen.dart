import 'package:flutter/material.dart';
import '../../../models/paciente.dart';
import '../../../services/paciente_service.dart';
import '../../../widgets/paciente_form.dart';

class EditarPacienteScreen extends StatelessWidget {
  final Paciente paciente;

  const EditarPacienteScreen({super.key, required this.paciente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Actualizar Datos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PacienteForm(
          paciente: paciente,
          onSubmit: (pacienteActualizado) async {
            try {
              await PacienteService().actualizarPaciente(pacienteActualizado);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Datos actualizados exitosamente'),
                ),
              );
              Navigator.pop(context, true);
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          },
        ),
      ),
    );
  }
}
