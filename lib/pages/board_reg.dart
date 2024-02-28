import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/services/api_dio.dart';
import 'package:login/widgets/custometextfiled.dart';
import 'package:login/widgets/customtextformfield.dart';

//게시글 등록
class Board_reg extends StatefulWidget{
  @override
  _Board_regState createState() => _Board_regState();

}
class _Board_regState extends State<Board_reg>{
  File? _image;

  TextEditingController controller = TextEditingController();
  ApiDio apiDio = ApiDio();

  // text 입력 후 이미지 업로드하면 초기화 됨
  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path); // 선택된 이미지를 _image에 저장
      } else {
        _image = null;
      }
    });
  }

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
              Container(
                child: Center(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image!), // 선택된 이미지를 화면에 표시
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool result_bool = await apiDio.insert_board_reg(
                      controller.text, controller2.text, _image!);
                  if (result_bool) {
                    Navigator.pushNamed(context, '/');
                  } else {
                    //   실패
                  }
                },
                child: Text('적용'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage, // 버튼을 눌렀을 때 getImage 함수 호출
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}