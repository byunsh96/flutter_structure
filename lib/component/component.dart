

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginBTN extends StatelessWidget{
  final String label;
  final VoidCallback? onPressed;

  LoginBTN({
    Key? key,
    required this.label,
    required this.onPressed, // 옵셔널
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}