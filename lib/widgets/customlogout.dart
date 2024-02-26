
import 'package:flutter/material.dart';
import 'package:login/component/component.dart';
import 'package:login/services/api_dio.dart';

//ElevatedButton
class CustomLogOut extends StatelessWidget{
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  CustomLogOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible( // Flexible 위젯을 사용하여 버튼에 유연성 추가
          child: LogoutBTN(
            onPressed: () async {
              bool result_bool = await ApiDio().fetchLogoutPost();
              if(result_bool){
                Navigator.pushNamed(context, '/');
              }else{
              }
            },
            label: 'logout',
          ),
        ),
      ],
    );
  }

}