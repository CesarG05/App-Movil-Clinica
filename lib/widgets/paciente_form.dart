import 'package:flutter/material.dart';
import '../models/paciente.dart';
import '../models/sexo.dart';

class PacienteForm extends StatefulWidget {
  final Function(Paciente) onSubmit;
  final Paciente? paciente;

  const PacienteForm({super.key, required this.onSubmit, this.paciente});

  @override
  State<PacienteForm> createState() => _PacienteFormState();
}

class _PacienteFormState extends State<PacienteForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _segundoNombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _segundoApellidoController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  late TextEditingController _direccionController;
  DateTime? _fechaNacimiento;
  int _sexoId = 1;
  bool _activo = true;

  @override
  void initState() {
    super.initState();

    final paciente = widget.paciente;

    _nombreController = TextEditingController(text: paciente?.primerNombre ?? '');
    _segundoNombreController = TextEditingController(text: paciente?.segundoNombre ?? '');
    _apellidoController = TextEditingController(text: paciente?.primerApellido ?? '');
    _segundoApellidoController = TextEditingController(text: paciente?.segundoApellido ?? '');
    _telefonoController = TextEditingController(text: paciente?.telefono ?? '');
    _correoController = TextEditingController(text: paciente?.correoElectronico ?? '');
    _direccionController = TextEditingController(text: paciente?.direccion ?? '');
    _fechaNacimiento = paciente?.fechaNacimiento;
    _sexoId = paciente?.sexo.id ?? 1;
    _activo = paciente?.activo ?? true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _segundoNombreController.dispose();
    _apellidoController.dispose();
    _segundoApellidoController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Primer nombre'),
            validator: (value) => value!.isEmpty ? 'Requerido' : null,
          ),
          TextFormField(
            controller: _segundoNombreController,
            decoration: const InputDecoration(labelText: 'Segundo nombre'),
          ),
          TextFormField(
            controller: _apellidoController,
            decoration: const InputDecoration(labelText: 'Primer apellido'),
            validator: (value) => value!.isEmpty ? 'Requerido' : null,
          ),
          TextFormField(
            controller: _segundoApellidoController,
            decoration: const InputDecoration(labelText: 'Segundo apellido'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Fecha de nacimiento: '),
              TextButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _fechaNacimiento ?? DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _fechaNacimiento = picked);
                  }
                },
                child: Text(
                  _fechaNacimiento == null
                      ? 'Seleccionar'
                      : _fechaNacimiento!.toLocal().toString().split(' ')[0],
                ),
              ),
            ],
          ),
          DropdownButtonFormField<int>(
            value: _sexoId,
            items: const [
              DropdownMenuItem(value: 1, child: Text('Masculino')),
              DropdownMenuItem(value: 2, child: Text('Femenino')),
            ],
            onChanged: (value) => setState(() => _sexoId = value!),
            decoration: const InputDecoration(labelText: 'Sexo'),
          ),
          TextFormField(
            controller: _direccionController,
            decoration: const InputDecoration(labelText: 'Dirección'),
          ),
          TextFormField(
            controller: _telefonoController,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            keyboardType: TextInputType.phone,
          ),
          TextFormField(
            controller: _correoController,
            decoration: const InputDecoration(labelText: 'Correo electrónico'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('¿Activo?'),
            value: _activo,
            onChanged: (value) {
              setState(() => _activo = value);
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _fechaNacimiento != null) {
                    final paciente = Paciente(
                      id: widget.paciente?.id ?? 0,
                      primerNombre: _nombreController.text,
                      segundoNombre: _segundoNombreController.text.isEmpty ? null : _segundoNombreController.text,
                      primerApellido: _apellidoController.text,
                      segundoApellido: _segundoApellidoController.text,
                      fechaNacimiento: _fechaNacimiento!,
                      sexo: Sexo(id: _sexoId, tipoSexo: ''),
                      direccion: _direccionController.text,
                      telefono: _telefonoController.text,
                      correoElectronico: _correoController.text.isEmpty ? null : _correoController.text,
                      activo: _activo,
                    );
                    widget.onSubmit(paciente);
                  }
                },
                icon: Icon(
                  widget.paciente == null ? Icons.save : Icons.save_as,
                ),
                label: Text(
                  widget.paciente == null ? 'Registrar paciente' : 'Guardar cambios',
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


