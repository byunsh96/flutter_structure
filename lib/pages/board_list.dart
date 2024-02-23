import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/services/api_dio.dart';
import 'package:login/widgets/customboardlist.dart';


//board_list
class Board_list extends StatefulWidget {
  @override
  _Board_list createState() => _Board_list();
}

class _Board_list extends State<Board_list>{
  TextEditingController controller = TextEditingController();
  ApiDio apiDio = ApiDio();
  // Map<String, dynamic> board_list = {};
  // late Future<Response> response;
  late Future<Model_board_list> _future;
  // final Model_board_list model_board_list;

  @override
  void initState(){
    // print(board_list_get);
    _future = ApiDio.board_list_get("1", "1", "1");
    // setState(() {
    //   _future = board_list_get("1", "0", "1");
    // });
    // print(_future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Model_board_list>(
        future: _future,
        builder: (context, snapshot) {
            //server에서 데이터를 가져오는 것을 기다리는동안 다른화면을 보여줌
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          }
          //가져온 데이터가 오류가 났을 경우.
          if (snapshot.hasError) {

            print('In widget : ${context}');

            print(snapshot.error);
            return Column(
              children: const [Icon(Icons.error), Text("데이터 오류가 발생했습니다.")],
            );
          }
         //가져온 데이터가 없는 경우.
          if (!snapshot.hasData) {
            return Column(
              children: const [Icon(Icons.cancel), Text("데이터가 존재하지 않습니다.")],
            );
          }
          //정상적으로 데이터를 가져온 경우.
          print('snapshot : ${snapshot}');
          // print('snapshot data : ${snapshot.data!.data_array['member_nickname']}');
          if (snapshot.data != null) {
            // print(snapshot.data);
            // print(snapshot.data![1].member_idx);
            // print(snapshot.data![1].board_idx);

            // var logger = Logger();
            // logger.d(snapshot.data!.data_array![1].board_idx);

            // print('snapshot board_idx : ${snapshot.data!.data_array![1].board_idx}');
            // print('snapshot member_idx : ${snapshot.data!.data_array![1].member_idx}');
            //
            // print('snapshot member_nickname : ${snapshot.data!.data_array![1].member_nickname}');
            //
            // print('snapshot title : ${snapshot.data!.data_array![1].title}');
            //
            // print('snapshot data : ${snapshot.data!.data_array![0].board_idx}');


          } else {
            print('data_array is null');
          }
          return ListView.builder(
            itemCount: snapshot.data!.data_array!.length,
            itemBuilder: (context, index) {
              // data_array의 각 Board 객체에 대한 위젯을 생성
              Board data = snapshot.data!.data_array![index];
              return Customboardlist(
                data : data,
              );
            },
          );
        },
      ),
    );
  }
}