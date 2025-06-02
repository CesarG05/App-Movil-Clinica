import 'package:intl/intl.dart';

import 'sexo.dart';

class Paciente {
  final int id;
  final String primerNombre;
  final String? segundoNombre;
  final String primerApellido;
  final String segundoApellido;
  final DateTime fechaNacimiento;
  final Sexo sexo;
  final String direccion;
  final String telefono;
  final String? correoElectronico;
  final bool activo;

  Paciente({
    required this.id,
    required this.primerNombre,
    this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.fechaNacimiento,
    required this.sexo,
    required this.direccion,
    required this.telefono,
    this.correoElectronico,
    required this.activo,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'] ?? 0,
      primerNombre: json['primerNombre'] ?? '',
      segundoNombre: json['segundoNombre'],
      primerApellido: json['primerApellido'] ?? '',
      segundoApellido: json['segundoApellido'] ?? '',
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      sexo: Sexo.fromJson(json['sexo']),
      direccion: json['direccion'] ?? '',
      telefono: json['telefono'] ?? '',
      correoElectronico: json['correoElectronico'],
      activo: json['activo'],
    );
  }

  Map<String, dynamic> toJson(Paciente paciente) => {
    "primerNombre": primerNombre,
    "segundoNombre": segundoNombre,
    "primerApellido": primerApellido,
    "segundoApellido": segundoApellido,
    "fechaNacimiento": DateFormat('yyyy-MM-dd').format(fechaNacimiento),
    "sexoId": paciente.sexo.id,
    "direccion": direccion,
    "telefono": telefono,
    "correoElectronico": correoElectronico,
    "activo": activo,
  };
}
