import 'package:demo_app/widgets/icon_circle/icon_circle.dart';
import 'package:demo_app/widgets/menu_drawer/components/item_drawer.dart';
import 'package:flutter/material.dart';

final Color colorGreySoft = const Color(0xffF8F8FB);
final double diameterCircle = 40.0;
final Color colorBorder = Colors.transparent;
final double widthBorder = 0.0;
final double padding = 5.0;

Widget buildIcon({required Widget child}) {
  return IconCircle(
    diameterCircle: diameterCircle,
    colorBackgroud: colorGreySoft,
    colorBorder: colorBorder,
    widthBorder: widthBorder,
    padding: padding,
    child: child,
  );
}

List<DrawerItem> buildDrawerItems(BuildContext context) => [
  DrawerItem(
    title: 'Perfil',
    subtitle: 'Administrar información del perfil',
    onTap: () {},
    childLeading: buildIcon(child: Icon(Icons.account_circle_rounded)),
  ),
  DrawerItem(
    title: 'Clínica',
    subtitle: 'Administrar información de la clínica',
    onTap: () {},
    childLeading: buildIcon(child: Icon(Icons.settings)),
  ),
  DrawerItem(
    title: 'Usuarios',
    subtitle: 'Administrar usuarios',
    onTap: () {},
    childLeading: buildIcon(child: Icon(Icons.group)),
  ),
  DrawerItem(
    title: 'Temas',
    subtitle: 'Cambiar temas de la aplicación',
    onTap: () {},
    childLeading: buildIcon(child: Icon(Icons.palette)),
  ),
];
