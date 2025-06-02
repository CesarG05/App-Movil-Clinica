import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 106,
          color: Colors.teal,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Menú',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Pacientes'),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/pacientes',
                  (route) => false,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.healing),
          title: const Text('Servicios'),
          onTap: () {
            Navigator.pushNamed(context, '/servicios');
          },
        ),
      ],
    ),
  );
}
