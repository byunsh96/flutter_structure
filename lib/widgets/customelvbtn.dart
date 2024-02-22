import 'package:flutter/material.dart';

//ElevatedButton
class CustomELVbtn extends StatelessWidget{
  final String text;
  final String url;
  CustomELVbtn({Key? key, required this.text, required this.url }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, url);
      },
      style: ButtonStyle(
        backgroundColor:
        MaterialStatePropertyAll<Color>(Colors.purple),
        foregroundColor:
        MaterialStatePropertyAll<Color>(Colors.white),
      ),
      child: Text(text),
    );
  }
  
}