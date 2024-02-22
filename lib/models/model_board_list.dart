import 'dart:convert';

// Model_board_list modelFromJson(Map<String, dynamic> map_data) => Model_board_list.fromJson(map_data);
//
// String modelToJson(Model_board_list data) => json.encode(data.toJson());

class Model_board_list{

  Model_board_list({
    this.code,
    this.code_msg,
    this.list_cnt,
    this.page_num,
    this.total_page,
    this.data_array,
  });

  String? code;
  String? code_msg;
  int? list_cnt;
  int? page_num;
  int? total_page;
  Map<String, dynamic>? data_array;

  // factory Model_board_list.fromJson(Map<String, dynamic> map_data) => Model_board_list(
  //   code : map_data['code'] ,
  //   code_msg : map_data['code_msg'],
  //   list_cnt : map_data['list_cnt'],
  //   page_num : map_data['page_num'],
  //   total_page : map_data['total_page'],
  //   data_array : map_data['data_array'],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //
  // };

}