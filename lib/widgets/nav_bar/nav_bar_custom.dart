import 'package:demo_app/widgets/nav_bar/components/nav_button.dart';
import 'package:flutter/material.dart';
import 'components/model_btn.dart';
import 'package:demo_app/screens/index.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final double widthScreen;
  final Function(int) onItemSelected;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.widthScreen,
  });

  void _navigateWithFade(BuildContext context, String route) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        settings: RouteSettings(name: route),
        pageBuilder:
            (context, animation, secondaryAnimation) => _getPageByRoute(route),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _getPageByRoute(String route) {
    switch (route) {
      case '/home':
        return HomeScreen();
      case '/pacientes':
        return ListaPacientesScreen();
      default:
        return HomeScreen(); // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthContainer = widthScreen;
    return AnimatedContainer(
      height: 65.0,
      width: widthContainer,
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.teal, width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            NavButton(
              label: navBtn[i].name,
              iconPath: navBtn[i].imagePath,
              isActive: selectedIndex == i,
              onTap: () {
                onItemSelected(i);
                if (i != selectedIndex) {
                  _navigateWithFade(context, navBtn[i].route);
                }
                // if (ModalRoute.of(context)?.settings.name != navBtn[i].route) {
                //   Navigator.pushNamedAndRemoveUntil(
                //     context,
                //     navBtn[i].route,
                //     (route) => false,
                //   );
                // }
              },
              widthContainer: widthContainer,
            ),
        ],
      ),
    );
  }
}
