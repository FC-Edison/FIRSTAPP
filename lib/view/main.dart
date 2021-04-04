import 'package:flutter/material.dart';
import "package:xiao_yu_ji_zhang/view/main_page.dart";

void main() {
  runApp(XiaoYuApp());
}

class XiaoYuApp extends StatelessWidget {
  static final Color BASIC_COLOR = Color.fromARGB(255, 228, 65, 60);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}




// class XiaoYuApp extends StatefulWidget {
//   @override
//   _XiaoYuAppState createState() => _XiaoYuAppState();
// }
//
// class _XiaoYuAppState extends State<XiaoYuApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MainPage();
//   }
// }


