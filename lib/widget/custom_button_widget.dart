import 'package:flutter/material.dart';
import 'package:healing_travelling/themes/color_themes.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key, 
    required this.text, 
    required this.onPressed, 
    this.borderRadius = 0, 
    required this.textStyle, 
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: kPrimaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.only(top: 13, bottom: 9)
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}