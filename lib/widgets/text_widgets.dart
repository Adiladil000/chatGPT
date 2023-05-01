import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget({Key? key, this.textalign, required this.label, this.fontSize = 18, this.color, this.fontWeight}) : super(key: key);
  TextAlign? textalign;
  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textalign,
      label,
      // textAlign: TextAlign.justify,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
