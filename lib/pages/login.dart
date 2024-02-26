import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/services/api_dio.dart';
import 'package:login/test.dart';
import 'package:login/widgets/customlogin.dart';
import 'package:login/index/main_index.dart';
import 'package:login/widgets/customlogout.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // Textfield에 입력되는 값 가져올 때
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  // // dispose method ->  사용안하는 리소스들 꺼주는 메소드

  final _dio = Dio(BaseOptions(
      baseUrl: "http://p.api.bandal.or.kr"
  ));
  List<dynamic> _todos = [];
  // https://jsonplaceholder.typicode.com/todos

  List<dynamic> _login = [];

  ApiDio apiDio = ApiDio();


  @override
  void initState(){
    _fetchTodos();
    super.initState();
  }

  // Todos get
  Future<void> _fetchTodos() async {
    Response response = await _dio.get('https://jsonplaceholder.typicode.com/todos');
    // print(response.statusCode);
    // print('response.data : ${response.data}');
    // print('response.data type check : ${response.runtimeType}');
    // API 호출을 통해 데이터를 성공적으로 받아온 후 UI를 업데이트
    setState(() {
      _todos = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Test()),
          Expanded(child: CustomLogIn()),
          Expanded(child: CustomLogOut()),
        ],
      ),
    );
  }
}
