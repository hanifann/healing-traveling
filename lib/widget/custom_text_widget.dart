import 'package:flutter/material.dart';
import 'package:healing_travelling/themes/color_themes.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomTextWidget({
    Key? key, 
    required this.text, 
    this.color = kSecondaryColor, 
    this.fontSize = 12.0, 
    this.fontWeight = FontWeight.w400
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    );
  }
}