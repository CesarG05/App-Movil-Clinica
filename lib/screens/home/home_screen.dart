import 'package:demo_app/screens/home/components/box_info_clinic.dart';
import 'package:demo_app/screens/home/components/list_molules.dart';
import 'package:demo_app/screens/home/components/text_welcome.dart';
import 'package:demo_app/screens/scaffold_base/scaffold_base.dart';
import 'package:demo_app/widgets/menu_drawer/menu_drawer.dart';
//import 'package:demo_app/widgets/nav_bar/nav_bar_custom.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final logoApp = 'assets/images/logo/logo.png';
  final gradient = 'assets/images/gradients/Blur.png';
  final colorPrimaryText = Color(0xff1D1E25);
  final colorSecundaryText = Color(0xFF4E545B);

  int selectBtn = 0;

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return ScaffoldBase(
      selectedIndex: selectBtn,
      onNavTap: (int index) {
        setState(() {
          selectBtn = index;
        });
      },

      endDrawer: CustomMenuDrawer(widthScreen: widthScreen),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Image.asset(logoApp, width: 25, height: 25),
        ),
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.menu_rounded, size: 25, color: Colors.black),
                ),
          ),
        ],
      ),

      body: Stack(
        children: [
          SizedBox(
            height: heightScreen * 0.4,
            width: widthScreen,
            child: Image.asset(gradient, fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight + 60),
                TextWelcome(
                  widthScreen: widthScreen,
                  colorPrimaryText: colorPrimaryText,
                  colorSecundaryText: colorSecundaryText,
                ),
                const SizedBox(height: 20),
                AnimatedBoxInfoClinic(
                  widthScreen: widthScreen,
                  heightScreen: heightScreen,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Modules(widthScreen: widthScreen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
