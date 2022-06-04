import 'package:flutter/material.dart';
import 'package:healing_travelling/themes/color_themes.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    Key? key, 
    required this.prefixIcon, 
    this.suffixIcon, 
    required this.hintText, 
    this.obscureText = false, 
    this.onTap, 
    this.textInputType,
    required this.controller
  }) : super(key: key);

  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final bool obscureText;
  final VoidCallback? onTap;
  final TextInputType? textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: textInputType,
      cursorColor: kPrimaryColor,
      style: TextStyle(
        color: kSecondaryColor
      ),
      decoration: InputDecoration(
        fillColor: kPrimaryLightColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none
          )
        ),
        contentPadding: EdgeInsets.fromLTRB(17, 15, 17, 12),
        prefixIcon: Icon(prefixIcon, color: kPrimaryDarkColor, size: 18,),
        hintText: hintText,
        hintStyle: TextStyle(
          color: kPrimaryDarkColor,
          fontSize: 14,
          fontWeight: FontWeight.w500
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(suffixIcon, color: kPrimaryDarkColor, size: 18,),
        ),
      ),
    );
  }
}
