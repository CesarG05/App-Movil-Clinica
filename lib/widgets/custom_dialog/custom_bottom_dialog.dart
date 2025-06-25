import 'package:demo_app/widgets/custom_button/custom_button.dart';
import 'package:flutter/material.dart';

class CustomBottomSheetDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;

  const CustomBottomSheetDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmText = 'Aceptar',
    this.cancelText = 'Cancelar',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade400, Colors.teal.shade100, Colors.white],
            stops: [0.0, 0.4, 0.8],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Barra
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              const SizedBox(height: 50),

              //Titulo
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              //Contenido
              Text(
                content,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: 18,
                    text: Text(
                      cancelText,
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    borderRadius: 18,
                    text: Text(
                      confirmText,
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
