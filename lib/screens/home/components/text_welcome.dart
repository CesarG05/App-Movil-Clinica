import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextWelcome extends StatelessWidget {
  const TextWelcome({
    super.key,
    required this.widthScreen,
    required this.colorPrimaryText,
    required this.colorSecundaryText,
  });

  final double widthScreen;
  final Color colorPrimaryText;
  final Color colorSecundaryText;

  String get currentDate {
    final texto = DateFormat(
      "EEEE, d 'de' MMMM 'de' y",
      'es_MX',
    ).format(DateTime.now());

    return texto[0].toUpperCase() + texto.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 120,
        width: widthScreen - 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenid@ César',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: colorPrimaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Que tengas un buen día 😊',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: colorSecundaryText,
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_month_outlined, color: colorPrimaryText),
                  SizedBox(width: 8),
                  Text(
                    currentDate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorPrimaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
