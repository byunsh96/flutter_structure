import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/services/api_dio.dart';

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
      body: ListView.builder(itemBuilder: (context, index){
        return Row(
            children:<Widget>[
              Expanded(
                child: ListTile(
                  leading: Text('${index + 1}'),
                  title: Text('title : ${_todos[index]['title']}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible( // Flexible 위젯을 사용하여 버튼에 유연성 추가
                        child: ElevatedButton(
                          onPressed: () {
                            apiDio.fetchLoginPost(controller.text,controller2.text);
                          },
                          child: Text('post'),
                        ),
                      ),
                      SizedBox(width: 4), // 버튼 사이의 공간을 추가
                      Flexible(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Enter your ID',
                          ),
                        ),
                      ),
                      SizedBox(width: 4), // 버튼 사이의 공간을 추가
                      Flexible(
                        child: TextField(
                          controller: controller2,
                          decoration: InputDecoration(
                            labelText: 'Enter your ID',
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(onPressed: (){
                    print('상세보기 이동');
                  },
                      icon: Icon(Icons.add)),
                ),
              )
            ]
        );
      }, itemCount: _todos.length),
    );
  }
}
