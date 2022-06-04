import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({
    Key? key, 
    required this.content, 
    required this.onDeny, 
    required this.onAllow,
    this.onAllowText = 'Izinkan',
    this.onDenyText = 'Tolak'
  }) : super(key: key);

  final String content;
  final VoidCallback onDeny;
  final VoidCallback onAllow;
  final String onAllowText;
  final String onDenyText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content, textAlign: TextAlign.justify,),
      actions: [
        TextButton(
          onPressed: onDeny,
          child: Text(
            'Tolak',
            style: TextStyle(
              color: Colors.grey[400]
            ),
          )
        ),
        TextButton(
          onPressed: onAllow,
          child: Text(onAllowText)
        ),
      ],
    );
  }
}