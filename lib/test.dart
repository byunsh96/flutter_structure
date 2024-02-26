import 'package:flutter/material.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/pages/board_detail.dart';
import 'package:login/services/api_dio.dart';

//ElevatedButton
class Test extends StatelessWidget{

  Test({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: ApiDio().getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // 반환된 데이터의 타입에 따라 다르게 처리
          if (snapshot.data == null) {
            return Text('Storage에 ID 없음 Fetched String: ${snapshot.data}');
          } else {
            return Text('Storage에 ID 있음 : ${snapshot.data}');
          }
        }
      },
    );
  }
}