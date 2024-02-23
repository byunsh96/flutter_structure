
import 'package:flutter/material.dart';
import 'package:login/component/component.dart';
import 'package:login/services/api_dio.dart';

//ElevatedButton
class CustomLogIn extends StatelessWidget{
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  CustomLogIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 40),
            Flexible(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter your ID',
                ),
              ),
            ),
            SizedBox(width: 20), // 버튼 사이의 공간을 추가
            Flexible(
              child: TextField(
                controller: controller2,
                decoration: InputDecoration(
                  labelText: 'Enter your ID',
                ),
              ),
            ),
            SizedBox(width: 40),
          ],
        ),
        SizedBox(height: 20),
        Flexible( // Flexible 위젯을 사용하여 버튼에 유연성 추가
          child: LoginBTN(
            onPressed: () async {
              bool result_bool = await ApiDio().fetchLoginPost(controller.text,controller2.text);
              if(result_bool){
                Navigator.pushNamed(context, '/');
              }else{
              }
            },
            label: 'post',
          ),
        ),
      ],
    );
  }

}