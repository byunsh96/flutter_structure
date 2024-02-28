import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/services/api_dio.dart';

class Image_load extends StatefulWidget{

  @override
  _Image_loadState createState() => _Image_loadState();
}
class _Image_loadState extends State<Image_load>{
  File? _image;
  ApiDio apiDio = ApiDio();
  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    print('pickedFile : ${pickedFile}');


    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path); // 선택된 이미지를 _image에 저장
        print(_image);
        print('apidio fdsadffdsa : ${apiDio.encodeImageAsBase64( _image!)}');
      } else {
        print(_image);
        print('no image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
        children: [
          Expanded(
            child: Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!), // 선택된 이미지를 화면에 표시
            ),
          ),
          ElevatedButton(
              onPressed: (){
                if(_image != null) {
                  apiDio.insert_image_reg(_image!);
                }else{
                  print('_image is null');
                }
              },
              child:Text('send'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage, // 버튼을 눌렀을 때 getImage 함수 호출
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}