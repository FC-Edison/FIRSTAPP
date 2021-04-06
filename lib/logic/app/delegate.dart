import 'package:xiao_yu_ji_zhang/logic/hive/helper.dart';

class AppDelegate {
  static AppDelegate _instance;
  static AppDelegate get instance {
    if (_instance == null) {
      _instance = AppDelegate._init();
    }
    return _instance;
  }

  AppDelegate._init();

  Future beforeAppLaunch() async {
    await HiveHelper.instance.initHive();
  }
}