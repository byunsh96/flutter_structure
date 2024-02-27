import 'package:flutter/material.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/pages/board_detail.dart';
import 'package:login/pages/board_list.dart';
import 'package:login/pages/board_reg.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/image_load.dart';
import 'package:login/pages/login.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String routeName = settings.name ?? '/';

//-------------------------로그인 후에 쿠키 정보(사용자 로컬 저장소 이용)는 여기서 관리한다.---------------------------------------

    switch (routeName) {
      case '/board_detail':
        final args = settings.arguments as Board;
        return MaterialPageRoute(builder: (_) => Board_detail(board: args));
      case '/board_list':
        return MaterialPageRoute(builder: (_) => Board_list());
      case '/board_reg':
        return MaterialPageRoute(builder: (_) => Board_reg());
      case '/image_load':
        return MaterialPageRoute(builder: (_) => Image_load());
      case '/login':
        return MaterialPageRoute(builder: (_) => LogIn());
      default:
      // 정의되지 않은 모든 경로에 대해 LogIn 페이지로 리다이렉션합니다.
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}