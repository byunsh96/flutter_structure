import 'package:flutter/material.dart';
import 'package:login/services/api_dio.dart';
import 'package:login/widgets/custometextfiled.dart';
import 'package:login/widgets/customtextformfield.dart';

//게시글 등록
class Board_reg extends StatelessWidget{
  TextEditingController controller = TextEditingController();
  ApiDio apiDio = ApiDio();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller2 = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CustomTextField(controller: controller),
              CustomTextFormField(controller: controller2),
              ElevatedButton(
                onPressed: () async {
                  bool result_bool = await apiDio.insert_board_reg(controller.text, controller2.text);
                  if(result_bool){
                    Navigator.pushNamed(context, '/');
                  }else{
                  //   실패
                  }
                },
                child: Text('적용'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}