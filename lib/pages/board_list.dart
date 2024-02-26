import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/services/api_dio.dart';
import 'package:login/widgets/customboardlist.dart';
import 'package:login/widgets/custompaging.dart';


//board_list
class Board_list extends StatefulWidget {
  @override
  _Board_list createState() => _Board_list();
}

class _Board_list extends State<Board_list>{
  late Future<Model_board_list> _future;

  @override
  void initState(){
    _future = ApiDio.board_list_get("1", "1", 1);
    super.initState();
  }

  @override
  void _fetchData(int page){
    setState(() {
      int _currentPage = page;
      _future = ApiDio.board_list_get("1", "1", page);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Model_board_list>(
              future: _future,
              builder: (context, snapshot) {
                  //server에서 데이터를 가져오는 것을 기다리는동안 다른화면을 보여줌
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                }
                //가져온 데이터가 오류가 났을 경우.
                if (snapshot.hasError) {

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
                if (snapshot.data != null) {

                } else {

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
          ),
          Row(
            children: [
              Expanded(
                child: FutureBuilder<Model_board_list>(
                  future: _future, // Model_board_list 객체를 반환하는 Future
                  builder: (BuildContext context, AsyncSnapshot<Model_board_list> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {

                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final pagerInfo = snapshot.data!;
                      final int? currentPage = pagerInfo.page_num;
                      final int? totalPages = pagerInfo.total_page;

                  // UI에 페이지 정보를 표시하거나 사용합니다.
                      return CustomPaging(
                        currentPage: currentPage!,
                        totalPages: totalPages!,
                        onPageSelected: (int page) {
                          print('page onpage : ${page}');
                          _fetchData(page);
                        },
                      );
                    }
                  }
                  // 데이터를 기다리는 동안 표시할 위젯
                  return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}