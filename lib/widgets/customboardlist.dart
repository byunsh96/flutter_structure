import 'package:flutter/material.dart';

//ElevatedButton
class Customboardlist extends StatelessWidget{
  final String title;
  final String memberNickname;
  final String contents;

  Customboardlist({
    Key? key,
    required this.title,
    required this.memberNickname,
    required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'by $memberNickname',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 16),
          Text(
            contents,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

}