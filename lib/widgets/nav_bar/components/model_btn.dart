class Model {
  final int id;
  final String imagePath;
  final String name;
  final String route;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.route,
  });
}

List<Model> navBtn = [
  Model(
    id: 0,
    imagePath: 'assets/images/icons/casa.png',
    name: 'Inicio',
    route: '/home',
  ),
  Model(
    id: 1,
    imagePath: 'assets/images/icons/usuarios-alt.png',
    name: 'Pacientes',
    route: '/pacientes',
  ),
  Model(
    id: 2,
    imagePath: 'assets/images/icons/usuario-del-hospital.png',
    name: 'Servicios',
    route: '/servicios',
  ),
  Model(
    id: 3,
    imagePath: 'assets/images/icons/usd-circulo.png',
    name: 'Pagos',
    route: '/pagos',
  ),
  Model(
    id: 4,
    imagePath: 'assets/images/icons/informe-de-datos.png',
    name: 'Reportes',
    route: '/reportes',
  ),
];
