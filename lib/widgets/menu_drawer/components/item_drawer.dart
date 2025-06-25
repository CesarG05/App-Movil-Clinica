import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final Widget childLeading;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.childLeading,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorGrey = Color(0xff808D9E);

    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: childLeading,
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: colorGrey,
                  ),
                )
                : null,
        onTap: onTap,
        splashColor: Colors.teal.withAlpha(30),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: colorGrey,
        ),
      ),
    );
  }
}
