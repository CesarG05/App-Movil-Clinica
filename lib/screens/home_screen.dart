import 'package:flutter/material.dart';
import '../widgets/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Inicio')
      ),
      drawer: buildDrawer(context),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

