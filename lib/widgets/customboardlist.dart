import 'package:flutter/material.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/pages/board_detail.dart';

//ElevatedButton
class Customboardlist extends StatelessWidget{
  final Board data;

  Customboardlist({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/board_detail',
          arguments: data,
        );
      },
      child: Container(
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
              data.title!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'by ${data.member_nickname}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Text(
              data.contents!,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

}