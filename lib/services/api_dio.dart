
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/models/model_board_list.dart';

const baseUrl = "http://p.api.bandal.or.kr";
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
    print('3');
    try {
      Model_board_list model_board_list = Model_board_list(
        code: response.data['code'],
        code_msg: response.data['code_msg'],
        list_cnt: response.data['list_cnt'],
        page_num: response.data['page_num'],
        total_page: response.data['total_page'],
        data_array: response.data['data_array'][1], // list [게시글1,게시글2,게시글3, ...]
      );
      print(model_board_list.runtimeType);
      print('5');
      return model_board_list;
    } catch (e) {
      print('Model_board_list 생성 중 예외 발생: $e');
      rethrow;
    }
  }

  // login
  Future<void> fetchLoginPost(String id, String pw ) async {
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

    String? memberId = await getUserData();

    if(memberId == null){
      print("쿠키 없음");

      if(response.data['code'] == "1000"){
        print("Login successful");
        // 로그인 성공하면 서버에서 헤더에 쿠키를 달아서 보내줘야 interceptors로 자동 저장이 되는데
        // 현재 상황은 바디에 저장되어 딸려옴 따라서 따로 저장해줘야 함.
        String userData = jsonEncode(response.data) ;
        await saveUserData(userData);

        print("Member ID123: $memberId");
      }
    }else{
      print('쿠키 있음');
      print('쿠키 있음 밑 print : $memberId');
      print(memberId.runtimeType);
    }
    await deleteUserData("member_id");

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
      "board_img" : "test",
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
  Future<void> deleteUserData(String key) async {
    await storage.delete(key: key);
  }
}
