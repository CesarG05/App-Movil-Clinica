import 'package:flutter/material.dart';
import '../models/paciente.dart';
import '../services/paciente_service.dart';

class PacienteActions {


  static Future<void> cambiarEstadoPaciente({
    required BuildContext context,
    required Paciente paciente,
    required Future<void> Function() onSuccess,
  }) async {
    final nuevoEstado = !paciente.activo;

    final confirmacion = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(nuevoEstado ? 'Activar paciente' : 'Inactivar paciente'),
        content: Text(nuevoEstado
            ? '¿Estás seguro de que deseas activar a este paciente?'
            : '¿Estás seguro de que deseas marcar como inactivo a este paciente?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Confirmar')),
        ],
      ),
    );

    if (confirmacion == true) {
      try {
        await PacienteService().cambiarEstadoPaciente(paciente.id, nuevoEstado);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(nuevoEstado ? 'Paciente activado' : 'Paciente inactivado'),
        ));
        await onSuccess();
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString().replaceFirst('Exception: ', '')}')),
        );
      }
    }
  }

  static Future<void> eliminarPaciente({
    required BuildContext context,
    required Paciente paciente,
    required Future<void> Function() onSuccess,
  }) async {
    final confirmacion = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de que deseas eliminar este paciente? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmacion == true) {
      try {
        await PacienteService().eliminarPaciente(paciente.id);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paciente eliminado correctamente')),
        );
        await onSuccess();
      } catch (e) {
        if (!context.mounted) return;
        final mensaje = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje)),
        );
      }
    }
  }
}
