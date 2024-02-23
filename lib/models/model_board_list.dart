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
  // Map<String, dynamic>? data_array;
  List<dynamic>? data_array;

  factory Model_board_list.fromJson(Map<String, dynamic> json) => Model_board_list(
    code : json['code'],
    code_msg : json['code_msg'],
    list_cnt : json['list_cnt'],
    page_num : json['page_num'],
    total_page : json['total_page'],
    data_array : List<dynamic>.from(json["data_array"].map((x) => Board.fromJson(x))),
  );
}

class Board{
  Board({
    this.board_idx,
    this.member_idx,
    this.member_nickname,
    this.member_img,
    this.member_img_width,
    this.member_img_height,
    this.board_img,
    this.img_width,
    this.img_height,
    this.category,
    this.title,
    this.contents,
    this.like_cnt,
    this.reply_cnt,
    this.scrap_cnt,
    this.my_like_yn,
    this.my_scrap_yn,
    this.ins_date,
  });

  String? board_idx;
  String? member_idx;
  String? member_nickname;
  String? member_img;
  int? member_img_width;
  int? member_img_height;
  String? board_img;
  int? img_width;
  int? img_height;
  String? category;
  String? title;
  String? contents;
  String? like_cnt;
  String? reply_cnt;
  String? scrap_cnt;
  String? my_like_yn;
  String? my_scrap_yn;
  String? ins_date;

  factory Board.fromJson(Map<String, dynamic> json) => Board(
      board_idx : json["board_idx"],
      member_idx : json["member_idx"],
      member_nickname : json["member_nickname"],
      member_img : json["member_img"],
      member_img_width : json["member_img_width"],
      member_img_height : json["member_img_height"],
      board_img : json["board_img"],
      img_width : json["img_width"],
      img_height : json["img_height"],
      category : json["category"],
      title : json["title"],
      contents : json["contents"],
      like_cnt : json["like_cnt"],
      reply_cnt : json["reply_cnt"],
      scrap_cnt : json["scrap_cnt"],
      my_like_yn : json["my_like_yn"],
      my_scrap_yn : json["my_scrap_yn"],
      ins_date : json["ins_date"],
  );
}