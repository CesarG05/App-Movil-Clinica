import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../actions/paciente_actions.dart';
import '../../models/paciente.dart';
import '../../services/paciente_service.dart';

class PacienteDetalleScreen extends StatefulWidget {
  final Paciente paciente;

  const PacienteDetalleScreen({super.key, required this.paciente});

  @override
  State<PacienteDetalleScreen> createState() => _PacienteDetalleScreenState();
}

class _PacienteDetalleScreenState extends State<PacienteDetalleScreen> {
  late Paciente paciente;

  @override
  void initState() {
    super.initState();
    paciente = widget.paciente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ficha del Paciente')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(child: PacienteInfoCard(paciente: paciente)),
              const SizedBox(height: 16),
              BotonesPaciente(
                paciente: paciente,
                onActualizar: (p) => setState(() => paciente = p),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget para mostrar los datos del paciente
class PacienteInfoCard extends StatelessWidget {
  final Paciente paciente;

  const PacienteInfoCard({super.key, required this.paciente});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _infoTile(
            Icons.person,
            'Nombre completo',
            '${paciente.primerNombre} '
                '${paciente.segundoNombre ?? ''} '
                '${paciente.primerApellido} '
                '${paciente.segundoApellido}',
          ),
          _infoTile(
            Icons.calendar_today,
            'Fecha de nacimiento',
            DateFormat('yyyy-MM-dd').format(paciente.fechaNacimiento),
          ),
          _infoTile(Icons.wc, 'Sexo', paciente.sexo.tipoSexo),
          _infoTile(Icons.location_on, 'Dirección', paciente.direccion),
          _infoTile(Icons.phone, 'Teléfono', paciente.telefono),
          _infoTile(
            Icons.email,
            'Correo electrónico',
            paciente.correoElectronico ?? 'No proporcionado',
          ),
          _infoTile(
            paciente.activo == true ? Icons.check_circle : Icons.cancel,
            'Estado',
            paciente.activo == true ? 'Activo' : 'Inactivo',
            color: paciente.activo == true ? Colors.teal[800] : Colors.red[600],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String subtitle, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon),

      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 18.0, color: color ?? Colors.teal[800]),
      ),
    );
  }
}

// Widget para los botones inferiores
class BotonesPaciente extends StatelessWidget {
  final Paciente paciente;
  final Function(Paciente) onActualizar;

  const BotonesPaciente({
    super.key,
    required this.paciente,
    required this.onActualizar,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final resultado = await Navigator.pushNamed(
              context,
              '/editarPaciente',
              arguments: paciente,
            );

            if (resultado == true) {
              try {
                final pacienteActualizado = await PacienteService()
                    .fetchPacientePorId(paciente.id);
                onActualizar(pacienteActualizado);
              } catch (e) {
                if (!context.mounted) return;
                final mensaje = e.toString().replaceFirst('Exception: ', '');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al refrescar: $mensaje')),
                );
              }
            }
          },
          icon: const Icon(Icons.edit),
          label: const Text('Actualizar Datos'),
          style: _botonStyle(color: Colors.teal),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.medical_services),
          label: const Text('Historial Clínico'),
          style: _botonStyle(color: Colors.teal),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            await PacienteActions.eliminarPaciente(
              context: context,
              paciente: paciente,
              onSuccess: () async {
                Navigator.pop(context);
              },
            );
          },
          icon: const Icon(Icons.delete),
          label: const Text('Eliminar'),
          style: _botonStyle(color: Colors.red),
        ),
      ],
    );
  }

  ButtonStyle _botonStyle({required Color color}) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }
}
