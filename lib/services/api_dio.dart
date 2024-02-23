import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/config/constant.dart';
import 'package:login/models/model_board_list.dart';

const baseUrl = APIBASEURL;
late String endPoint;

class ApiDio {
  final storage = const FlutterSecureStorage();

  //board_list_get
  static Future<Model_board_list> board_list_get(String member_idx, String category, String page_num) async {
    final data = {
      "member_idx": member_idx,
      "category": category,
      "page_num": page_num,
    };
    endPoint = '/board_v_1_0_0/board_list';

    final response = await Dio().get(
      baseUrl+endPoint,
      queryParameters:data,
    );
    print('response.data : ${response.data}');
    print('response : ${response.runtimeType}'); //Response<dynamic>
    print('response.data : ${response.data.runtimeType}');//Map<String, dynamic>
    print('response.data[data_array] :${response.data['data_array'][0].runtimeType}'); // Map<String, dynamic>
    // // API 호출을 통해 데이터를 성공적으로 받아온 후 UI를 업데이트
    try {
      Model_board_list model_board_list = Model_board_list.fromJson(response.data);
      print('model_board_list : ${model_board_list}'); //Model_board_list

      print('model_board_list : ${model_board_list.runtimeType}'); //Model_board_list
      print('model_board_list.data_array : ${model_board_list.data_array!.runtimeType}'); //List<dynamic>
      print(model_board_list.data_array);

      return model_board_list;
    } catch (e) {
      print('Model_board_list 생성 중 예외 발생: $e');
      rethrow;
    }
  }

  // login
  Future<bool> fetchLoginPost(String id, String pw ) async {
    // 데이터 값
    final postData = {
      "member_id": id,
      "member_pw": pw,
      "device_os": "A",
      "gcm_key": "3333333"
    };

    //Url
    endPoint = '/login_v_1_0_0/member_login';

    Response response = await Dio().post(
      baseUrl + endPoint,
      data: FormData.fromMap(postData),
    );
    print(response.data);

    print(response.data['code_msg']);
    // '-1' : 불일치 , 비밀번호 입력, 이메일 입력
    if(response.data['code'] == "-1"){
      return false;
    }

    String? memberId = await getUserData();

    if(memberId == null){
      print("쿠키 없음");

      print("Login successful");

      String userData = jsonEncode(response.data) ;
      await saveUserData(userData); // 세션 저장

      print("Member ID123: $memberId");
      return true;

    }else{
      print('쿠키 있음');

      print('쿠키 있음 밑 print : $memberId');
      print(memberId.runtimeType);
      await deleteUserData(); // 세션 지우기
      return false;
    }

    print(response.data);
  }

  //board_reg
  Future<bool> insert_board_reg(String title, String contents) async {
    // 데이터 값
    final postData = {
      "title": title,
      "contents": contents,
      "member_idx": "1",
      "category": "1",
      "board_img" : "/media/commonfile/202307/17/5cabaf7efcd88b7c40326a48234c82b4.jpg",
    };

    //Url
    endPoint = '/board_v_1_0_0/board_reg_in';

    Response response = await Dio().post(
      baseUrl + endPoint,
      data: FormData.fromMap(postData),
    );

    // {
    //     "code": "1000",
    //     "code_msg": "정상적으로 처리되었습니다."
    // }

    if(response.data['code'] == "1000"){
      print(response.data['code_msg']);
      return true;
    }else{
      print(response.data['code']);
      print(response.data['code_msg']);
      return false;
    }
  }


  // 로그인 후 member_id 쿠키에 저장
  // json으로 넣어버릴 예정
  Future<void> saveUserData(String userData) async {
    await storage.write(key: "userData", value: userData);
  }

  //member_id 조회
  Future<String?> getUserData() async {
    String? userData = await storage.read(key: "userData");
    return userData;
  }

  //delete
  Future<void> deleteUserData() async {
    await storage.delete(key: "userData");
  }
}
