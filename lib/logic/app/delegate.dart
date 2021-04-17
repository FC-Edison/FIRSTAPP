import 'package:xiao_yu_ji_zhang/logic/app/config/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/manager.dart';
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
    await AppConfigManager.instance.sync();
    BookKeepingManager.instance.sync(DateTime.now());
    BookKeepingManager.instance.initController();
  }
}