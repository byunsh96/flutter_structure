import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/controllers/routes.dart';
import 'package:login/dice.dart';
import 'package:login/pages/login.dart';
import 'package:login/themes/app_theme.dart';
import 'dart:async';
import 'services/api_dio.dart';
import 'dart:convert';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //화면 방향을 설정하는 부분 (확인 x)
  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]
  ).then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp ({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '로그인',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue, //앱 기본 테마
        textTheme: AppTheme.textTheme, //앱 텍스트 테마 설정
        platform: TargetPlatform.iOS, // 플랫폼을 ios 스타일로 설정
      ),
      initialRoute: '/',

      // home: LogIn(),
    );
  }
}



// final snackBar1 = SnackBar(
//   content: Text(
//     '로그인 정보를 다시 확인하세요',
//     textAlign: TextAlign.center,
//     style: TextStyle(color: Colors.white),
//   ),
//   backgroundColor: Colors.blue,
//   duration: Duration(seconds: 2),
// );
// final snackBar2 = SnackBar(
//   content: Text(
//     '비밀번호가 일치하지 않습니다.',
//     textAlign: TextAlign.center,
//     style: TextStyle(color: Colors.white),
//   ),
//   backgroundColor: Colors.blue,
//   duration: Duration(seconds: 2),
// );
// final snackBar3 = SnackBar(
//   content: Text(
//     'dice의 철자를 확인하세요',
//     textAlign: TextAlign.center,
//     style: TextStyle(color: Colors.white),
//   ),
//   backgroundColor: Colors.blue,
//   duration: Duration(seconds: 2),
// );

// void showSnackBar1(BuildContext ctx) {
//   ScaffoldMessenger.of(ctx).showSnackBar(snackBar1);
// }
// void showSnackBar2(BuildContext ctx) {
//   ScaffoldMessenger.of(ctx).showSnackBar(snackBar2);
// }
// void showSnackBar3(BuildContext ctx) {
//   ScaffoldMessenger.of(ctx).showSnackBar(snackBar3);
// }
