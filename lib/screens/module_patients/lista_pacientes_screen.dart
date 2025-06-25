import 'package:demo_app/screens/scaffold_base/scaffold_base.dart';
import 'package:demo_app/widgets/animation_fa_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../actions/paciente_actions.dart';
import '../../services/paciente_service.dart';
import '../../models/paciente.dart';

class ListaPacientesScreen extends StatefulWidget {
  const ListaPacientesScreen({super.key});

  @override
  ListaPacientesScreenState createState() => ListaPacientesScreenState();
}

class ListaPacientesScreenState extends State<ListaPacientesScreen> {
  late Future<List<Paciente>> _pacientes;
  int _currentPage = 1;
  final int _pageSize = 6;
  bool _hasMore = true;

  int selectBtn = 1;
  bool isGoingDown = false;

  //Metodo para cargar a los pacientes
  Future<void> _loadPacientes() async {
    final futurePacientes = PacienteService().fetchPacientes(
      pageNumber: _currentPage,
      pageSize: _pageSize,
    );

    setState(() {
      _pacientes = futurePacientes;
    });

    final pacientes = await futurePacientes;
    final hasMore = pacientes.length == _pageSize;

    setState(() {
      _hasMore = hasMore;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPacientes();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBase(
      selectedIndex: selectBtn,
      onNavTap: (int index) {
        setState(() {
          selectBtn = index;
        });
      },
      appBar: AppBar(
        title: const Text('Pacientes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (onScrollNotification) {
          if (onScrollNotification is ScrollUpdateNotification) {
            if (onScrollNotification.scrollDelta! <= 0.0) {
              if (isGoingDown) setState(() => isGoingDown = false);
            } else {
              if (!isGoingDown) setState(() => isGoingDown = true);
            }
          }
          return false;
        },
        child: SafeArea(
          child: FutureBuilder<List<Paciente>>(
            future: _pacientes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildPacienteView(snapshot.data!);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: CustomAnimationFAButton(
          isExpand: isGoingDown,
          onTap: () async {
            final resultado = await Navigator.pushNamed(
              context,
              '/agregarPaciente',
            );
            if (resultado == true) {
              await _loadPacientes();
            }
          },
        ),
      ),
    );
  }

  //  Widget Principal
  Widget _buildPacienteView(List<Paciente> pacientes) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: _buildPacienteGrid(pacientes)),
        const SizedBox(height: 8),
        _buildPaginationControls(),
      ],
    );
  }

  //  Widget Barra filtar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: 'Buscar paciente...',
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  //  Widget Grid de las tarjetas
  Widget _buildPacienteGrid(List<Paciente> pacientes) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3 / 1.2,
      ),
      itemCount: pacientes.length,
      itemBuilder: (context, index) {
        return _buildPacienteCard(pacientes[index]);
      },
    );
  }

  // Menu de las tarjetas
  Widget _buildPacienteMenu(Paciente paciente) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        switch (value) {
          case 'detalles':
            await _verDetallesPaciente(paciente);
            break;
          case 'historial':
            break;
          case 'inactivo':
            await _cambiarEstadoPaciente(paciente);
            break;
          case 'eliminar':
            await _eliminarPaciente(paciente);
            break;
        }
      },
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'detalles',
              child: Text('Ver ficha del paciente'),
            ),
            const PopupMenuItem<String>(
              value: 'historial',
              child: Text('Ver historial clínico'),
            ),
            PopupMenuItem<String>(
              value: 'inactivo',
              child: Text(
                paciente.activo == true
                    ? 'Inactivar paciente'
                    : 'Activar paciente',
              ),
            ),
            const PopupMenuItem<String>(
              value: 'eliminar',
              child: Text('Eliminar'),
            ),
          ],
    );
  }

  //  Widget Tarjeta pacientes
  Widget _buildPacienteCard(Paciente paciente) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _verDetallesPaciente(paciente);
                      },
                      child: Text(
                        '${paciente.primerApellido} '
                        '${paciente.primerNombre}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.teal[800],
                        ),
                      ),
                    ),
                    Text('  |  '),
                    Text(
                      paciente.activo == true ? 'Activo' : 'No Activo',
                      style: TextStyle(
                        color:
                            paciente.activo == true ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildPacienteMenu(paciente),
              ],
            ),

            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Sexo: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  TextSpan(
                    text: paciente.sexo.tipoSexo,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Fecha Nacimiento: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  TextSpan(
                    text: DateFormat(
                      'yyyy-MM-dd',
                    ).format(paciente.fechaNacimiento),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Botones de paginación
  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed:
                _currentPage > 1
                    ? () {
                      setState(() {
                        _currentPage--;
                        _loadPacientes();
                      });
                    }
                    : null,
            child: const Text('Anterior'),
          ),
          Text('Página $_currentPage'),
          ElevatedButton(
            onPressed:
                _hasMore
                    ? () {
                      setState(() {
                        _currentPage++;
                        _loadPacientes();
                      });
                    }
                    : null,
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }

  Future<void> _verDetallesPaciente(Paciente paciente) async {
    await Navigator.pushNamed(context, '/detallePaciente', arguments: paciente);
    await _loadPacientes();
  }

  Future<void> _cambiarEstadoPaciente(Paciente paciente) async {
    await PacienteActions.cambiarEstadoPaciente(
      context: context,
      paciente: paciente,
      onSuccess: _loadPacientes,
    );
  }

  Future<void> _eliminarPaciente(Paciente paciente) async {
    await PacienteActions.eliminarPaciente(
      context: context,
      paciente: paciente,
      onSuccess: _loadPacientes,
    );
  }
}
