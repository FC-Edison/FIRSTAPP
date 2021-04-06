import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/page/main/page.dart';

void main() {
  runApp(XiaoYuApp());
}

class XiaoYuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}