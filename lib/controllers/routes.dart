import 'package:flutter/material.dart';
import 'package:login/models/model_board_list.dart';
import 'package:login/pages/board_detail.dart';
import 'package:login/pages/board_list.dart';
import 'package:login/pages/board_reg.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/login.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {

    // return MaterialPageRoute(builder: (_) => LogIn());

    final String routeName = settings.name ?? '/';
    //
    switch (routeName) {
      case '/board_detail':
        final args = settings.arguments as Board;
        return MaterialPageRoute(builder: (_) => Board_detail(board: args));
      case '/board_list':
        return MaterialPageRoute(builder: (_) => Board_list());
      case '/board_reg':
        return MaterialPageRoute(builder: (_) => Board_reg());
      case '/login':
        return MaterialPageRoute(builder: (_) => LogIn());
    // 예시: 추가적인 라우트를 여기에 정의할 수 있습니다.
    // case '/detail':
    //   return MaterialPageRoute(builder: (_) => DetailPage());
      default:
      // 정의되지 않은 모든 경로에 대해 LogIn 페이지로 리다이렉션합니다.
        return MaterialPageRoute(builder: (_) => Home());
    }

    // settings.name이 널일 수 있으므로, 널 체크를 추가합니다.
    // if (settings.name == null) {
      // 널인 경우 기본 라우트로 리다이렉션
      // return MaterialPageRoute(builder: (context) => LogIn());
    // } else {
      // return MaterialPageRoute(builder: (context) => LogIn());

      // final List<String> pathSegments = settings.name!.split('/');
      // print(pathSegments[1]); // board
      // print(pathSegments[2]); // list

      // pathSegments의 길이를 확인하여 인덱스 에러를 방지합니다.
      // if (pathSegments.length < 2) {
      //   // pathSegments의 길이가 2 미만인 경우 기본 라우트로 리다이렉션
      //   return MaterialPageRoute(builder: (context) => LogIn());
      // }
      //
      // switch (pathSegments[1]) {
      //   case 'board':
      //   // return BoardRouteGenerator.generateRoute(settings);
      //   default:
      //     return MaterialPageRoute(builder: (context) => LogIn());
      // }
    // }
    // 모든 케이스를 처리한 후에도 여기에 도달했다면, 기본 라우트로 리다이렉션

    // return MaterialPageRoute(builder: (context) => LogIn());
  }
}