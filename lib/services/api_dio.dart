import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/config/constant.dart';
import 'package:login/models/model_board_list.dart';
import 'package:path/path.dart' as path;

const baseUrl = APIBASEURL;
late String endPoint;

class ApiDio {
  final storage = const FlutterSecureStorage();

  //board_list_get
  static Future<Model_board_list> board_list_get(String member_idx, String category, int page_num) async {
    FormData formData = FormData.fromMap({
      "member_idx": member_idx,
      "category": category,
      "page_num": page_num,
    });

    endPoint = '/board_v_1_0_0/board_list';

    final response = await Dio().request(
      baseUrl+endPoint,
      options: Options(
        method: 'POST',
      ),
      data:formData,
    );
    try {
      Model_board_list model_board_list = Model_board_list.fromJson(response.data);

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
  Future<bool> insert_board_reg(String title, String contents, File image) async {

    final response_image = await insert_image_reg(image);

    // 데이터 값
    final postData = {
      "title": title,
      "contents": contents,
      "member_idx": "1",
      "category": "1",
      "board_img" : response_image.data['file_path'],
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
  //이미지 경로 가져오기
  String getFileExtension(String filePath) {
    return path.extension(filePath);
  }
  String getFilenameWithExtension(String filePath) {
    return path.basename(filePath);
  }
  //이미지 업로드
  Future<Response<dynamic>> insert_image_reg(File image) async {
    // final base64Image= await encodeImageAsBase64(image); // String 다시 byte 배열로 변환해야 함
    // final imageBytes = await encodeImageAsBytes(image);

    //png, jpg 등만 올릴 수 있음

    String filenameWithExtension = getFilenameWithExtension(image.path);

    // print(filenameWithExtension);
    // SVG_Logo.svg.png

    MultipartFile multipartFile = await MultipartFile.fromFile(
      image.path,
      filename: filenameWithExtension,
    );

    // print('multipartFile: ${multipartFile.contentType}');
    //application/octet-stream
    // print('image.path: ${image.path}');
    ///data/user/0/com.example.login/cache/e1f91660-265d-49a3-81c2-428eff0ed20e/SVG_Logo.svg.png

    FormData formData = FormData.fromMap({
      "file": multipartFile,
    });

    // print('formData: ${formData.files}');
    // [MapEntry(file: Instance of 'MultipartFile')]

    //Url
    endPoint = '/common/fileUpload_action';

    final response = await Dio().request(
      baseUrl + endPoint,
      options: Options(
        method: 'POST',
      ),
      data: formData,
    );

    print(response.data);
    // {
    // code: 1000,
    // code_msg: 성공,
    // file_path: /media/commonfile/202402/28/d95325759c7b77f2bcca323f94c6f5b2.png,
    // img_width: 200,
    // img_height: 200
    // }

    if (response.data['code'] == "1000") {
      print(response.data['code_msg']);
      return response;
    } else {
      print(response.data['code']);
      print(response.data['code_msg']);
      return response;
    }
  }

  //로그아웃
  Future<bool> fetchLogoutPost() async {
    await deleteUserData();
    return true;
  }
  
  // 로그인 후 member_id 쿠키에 저장
  // json으로 넣어버릴 예정
  Future<void> saveUserData(String userData) async {
    await storage.write(key: "userData", value: userData);
  }

  //member_id 조회
  Future<String?> getUserData() async {
    String? userData = await storage.read(key: "userData");
    if(userData == null){
      return null;
    }
    return userData;
  }

  //delete
  Future<void> deleteUserData() async {
    await storage.delete(key: "userData");
    print('delete');
  }

  //이미지 바이트 데이터로 변환
  Future<List<int>> encodeImageAsBytes(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    // FormData formData = FormData.fromMap({
    //   "file": MultipartFile.fromBytes(imageBytes, filename: 'upload.jpg'),
    // });
    return imageBytes;
  }
  
  //Base64 데이터로 변환
  Future<String> encodeImageAsBase64(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    
    return base64Image;
  }

  //dependencies 필요 flutter_image_compress : ^2.1.0
  //이미지 압축 후 리사이징
  Future<Uint8List?> encodeImageAsCompress(File image) async {
    // 이미지를 압축 및 리사이징
    var compressedImage = await FlutterImageCompress.compressWithFile(
      image.absolute.path,
      minWidth: 640,
      minHeight: 480,
      quality: 88,
    );
    // FormData formData = FormData.fromMap({
    //   "file": MultipartFile.fromBytes(compressedImage!, filename: 'compressed.jpg'),
    // });
    return compressedImage;
  }
}
