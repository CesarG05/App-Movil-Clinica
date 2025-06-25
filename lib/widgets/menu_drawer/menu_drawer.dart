import 'package:demo_app/widgets/custom_button/custom_button.dart';
import 'package:demo_app/widgets/custom_dialog/custom_bottom_dialog.dart';
import 'package:demo_app/widgets/icon_circle/icon_circle.dart';
import 'package:demo_app/widgets/menu_drawer/components/data_drawer.dart';
import 'package:flutter/material.dart';

class CustomMenuDrawer extends StatelessWidget {
  const CustomMenuDrawer({super.key, required this.widthScreen});

  final double widthScreen;

  final Color colorGreyScale = const Color(0xffE9E9EA);

  @override
  Widget build(BuildContext context) {
    final widthDrawer = widthScreen * 0.7;
    return Drawer(
      width: widthDrawer,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Encabezado
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
              ),
              child: Row(
                children: [
                  IconCircle(
                    diameterCircle: 50,
                    colorBackgroud: Colors.teal,
                    colorBorder: Colors.transparent,
                    widthBorder: 0,
                    padding: 0,
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'César Chan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'cesarchan34@fisiofort.com',
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Contenido
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Titulo
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5,
                      ),
                      child: Text(
                        'General',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //Items
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        itemCount: buildDrawerItems(context).length,
                        separatorBuilder:
                            (_, __) => Divider(
                              height: 2,
                              color: colorGreyScale,
                              indent: 16,
                              endIndent: 16,
                            ),
                        itemBuilder:
                            (context, index) =>
                                buildDrawerItems(context)[index],
                      ),
                    ),

                    //Boton cerrar sesion
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: CustomButton(
                            text: Text(
                              'Cerrar sesión',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            backgroundColor: Colors.red.withAlpha(30),
                            icon: Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 20,
                            ),
                            horizontalPadding: 20,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder:
                                    (context) => CustomBottomSheetDialog(
                                      title: 'Cerrar sesión',
                                      content:
                                          '¿Estás seguro de que deseas salir?',
                                      confirmText: 'Sí, cerrar',
                                      cancelText: 'Cancelar',
                                      onConfirm: () {},
                                    ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
