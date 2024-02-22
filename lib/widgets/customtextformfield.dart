import 'package:flutter/material.dart';

//큰 인풋창

class CustomTextFormField extends StatelessWidget{
  final TextEditingController controller;

  CustomTextFormField({Key? key, required this.controller}) : super(key:key);
  @override
  Widget build(BuildContext context) {

    final double textFieldHeight = MediaQuery.of(context).size.height * 0.4;

    return Center(
      child: Container(
      height: textFieldHeight, // Container의 높이를 설정
      padding: EdgeInsets.all(8.0),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.top,
          expands: true,
          maxLines: null,
          controller: controller,
          decoration: InputDecoration(
            labelText: '내용을 입력하세요.',
            hintText: 'Enter your text here',
            border: OutlineInputBorder(),
            ),
          style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}