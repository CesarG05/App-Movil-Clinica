import 'package:demo_app/widgets/nav_bar/nav_bar_custom.dart';
import 'package:flutter/material.dart';

class ScaffoldBase extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final bool showNavBar;
  final int selectedIndex;
  final Function(int)? onNavTap;

  const ScaffoldBase({
    super.key,
    required this.body,
    this.showNavBar = true,
    required this.selectedIndex,
    this.onNavTap,
    this.appBar,
    this.endDrawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      backgroundColor: Colors.white,

      appBar: appBar,
      endDrawer: endDrawer,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar:
          showNavBar
              ? SafeArea(
                child: CustomNavigationBar(
                  selectedIndex: selectedIndex,
                  widthScreen: widthScreen,
                  onItemSelected: onNavTap ?? (_) {},
                ),
              )
              : null,
    );
  }
}
