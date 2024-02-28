import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login/config/constant.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/services/api_dio.dart';
import 'package:login/widgets/custometextfiled.dart';
import 'package:login/widgets/customtextformfield.dart';

//게시글 등록
class Board_detail extends StatelessWidget{

  Board board;

  Board_detail({
    Key? key,
    required this.board,
  }) : super(key:key);

  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    logger.d(board.board_idx);
    return Scaffold(
      appBar: AppBar(
        title: Text('상세 페이지'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('제목: ${board.title}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('등록일: ${board.ins_date}'),
            SizedBox(height: 8),
            Text('좋아요: ${board.like_cnt}'),
            SizedBox(height: 8),
            Text('작성자: ${board.member_nickname}'),
            SizedBox(height: 16),
            Text('contents', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              color: Colors.grey[300],
              child: Text(board.contents!),
            ),
            SizedBox(height: 8),
            Image.network(board.board_img!),
          ],
        ),
      ),
    );
  }
}

