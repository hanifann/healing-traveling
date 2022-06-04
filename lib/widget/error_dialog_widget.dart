import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorValue;

  const ErrorDialog({Key? key, required this.errorValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        errorValue,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      actions: [
        TextButton(
          onPressed: ()=> Navigator.pop(context), 
          child: Text('kembali')
        )
      ],
    );
  }
}