import 'package:flutter/material.dart';

class CustomButtonIconWidget extends StatelessWidget {
  final VoidCallback onClick;
  final Color primaryColor;
  final String text;
  final IconData icon;
  const CustomButtonIconWidget(
      {Key? key,
      required this.onClick,
      required this.primaryColor,
      required this.text,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: primaryColor),
      onPressed: onClick,
      label: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      icon: Icon(icon),
    );
  }
}
