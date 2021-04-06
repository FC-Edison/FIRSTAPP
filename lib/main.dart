import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:xiao_yu_ji_zhang/logic/account/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/app/delegate.dart';
import 'package:xiao_yu_ji_zhang/page/login/page.dart';
import 'package:xiao_yu_ji_zhang/page/main/page.dart';

Future main() async {
  await AppDelegate.instance.beforeAppLaunch();
  runApp(XiaoYuApp());
}

class XiaoYuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      home: AccountManager.instance.isLogin ? MainPage() : LoginPage(),
    );
  }
}
