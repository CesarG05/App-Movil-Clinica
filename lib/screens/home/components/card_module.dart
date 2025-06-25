import 'package:demo_app/widgets/icon_circle/icon_circle.dart';
import 'package:flutter/material.dart';

class CardModule extends StatelessWidget {
  const CardModule({
    super.key,
    required this.widthScreen,
    required this.nameAction,
    required this.ruteImage,
    required this.onTap,
  });

  final double widthScreen;
  final String nameAction;
  final String ruteImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: widthScreen / 4,
        height: 140,
        decoration: BoxDecoration(
          color: Color(0xffF8F8FB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconCircle(
                diameterCircle: widthScreen / 6,
                colorBackgroud: Colors.white,
                colorBorder: Color(0xffE9ECF2),
                widthBorder: 2.0,
                padding: 12.0,
                child: Image.asset(ruteImage),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: widthScreen / 6,
                child: Text(
                  nameAction,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
