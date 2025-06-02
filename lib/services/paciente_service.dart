import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/paciente.dart';

class PacienteService {
  static const String baseUrl = 'http://10.0.2.2:5237/api/pacientes';

  // Telefono fisico
  //static const String baseUrl = 'http://192.168.1.69:5237/api/pacientes';

  //Metodo para traer a los pacientes
  Future<List<Paciente>> fetchPacientes({int pageNumber = 1, int pageSize = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?pageNumber=$pageNumber&pageSize=$pageSize'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Paciente.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar pacientes');
    }
  }

  //Metodo para trear paciente por id
  Future<Paciente> fetchPacientePorId(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Paciente.fromJson(data);
    } else {
      throw Exception('Error al obtener paciente: ${response.body}');
    }
  }

  //Metodo para agregar paciente
  Future<bool> agregarPaciente(Paciente paciente) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(paciente.toJson(paciente)),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  //Metodo para actualizar/editar paciente
  Future<bool> actualizarPaciente(Paciente paciente) async {
    final url = Uri.parse('$baseUrl/${paciente.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(paciente.toJson(paciente)),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Error al actualizar paciente: ${response.body}');
    }
    /*
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Error al actualizar paciente: ${response.body}');
    }*/
  }

  //Metodo para eliminar un paciente
  Future<void> eliminarPaciente(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      // Eliminado con éxito (NoContent)
      return;
    } else if (response.statusCode == 400) {
      throw Exception(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Paciente no encontrado.');
    } else {
      throw Exception('Error inesperado al eliminar el paciente.');
    }
  }

  // Metodo cambiar estado del Paciente
  Future<void> cambiarEstadoPaciente(int id, bool activo) async {
    final url = Uri.parse('$baseUrl/$id/estado');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(activo),
    );

    if (response.statusCode != 204) {
      throw Exception('Error al cambiar el estado del paciente');
    }
  }


}
