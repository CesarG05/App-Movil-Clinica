import 'package:demo_app/screens/home/components/card_module.dart';
import 'package:flutter/material.dart';

class Modules extends StatelessWidget {
  const Modules({super.key, required this.widthScreen});

  final double widthScreen;
  final TextStyle titleStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Operativo', style: titleStyle),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardModule(
              widthScreen: widthScreen,
              nameAction: 'Lista de pacientes',
              ruteImage: 'assets/images/modules/multitud.png',
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/pacientes',
                  (route) => false,
                );
              },
            ),
            CardModule(
              widthScreen: widthScreen,
              nameAction: 'Historiales Clínicos',
              ruteImage: 'assets/images/modules/paciente.png',
              onTap: () {},
            ),
            CardModule(
              widthScreen: widthScreen,
              nameAction: 'Control de sesiones',
              ruteImage: 'assets/images/modules/terapia.png',
              onTap: () {},
            ),
          ],
        ),
        SizedBox(height: 20),
        Text('Administativo', style: titleStyle),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardModule(
              widthScreen: widthScreen,
              nameAction: 'Administar servicios',
              ruteImage: 'assets/images/modules/clinica.png',
              onTap: () {},
            ),
            CardModule(
              widthScreen: widthScreen,
              nameAction: 'Pago de servicios',
              ruteImage: 'assets/images/modules/pagos.png',
              onTap: () {},
            ),
            CardModule(
              widthScreen: widthScreen,
              nameAction: 'Generación de reportes',
              ruteImage: 'assets/images/modules/reporte.png',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
