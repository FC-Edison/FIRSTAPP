import 'package:get/get.dart';
import 'package:xiao_yu_ji_zhang/logic/account/api.dart';
import 'package:xiao_yu_ji_zhang/logic/hive/helper.dart';
import 'package:xiao_yu_ji_zhang/page/login/page.dart';

class AccountManager {
  static AccountManager _instance;
  static AccountManager get instance {
    if (_instance == null) {
      _instance = AccountManager._init();
    }
    return _instance;
  }

  AccountManager._init();

  Future<Map> login(String accountName) async {
    var res = await LoginApi(accountName:accountName).start();
    if (res.data["success"]) {
      instance.accountName = accountName;
    }
    return res.data;
  }

  void logout() {
    accountName = null;
    Get.offAll(() => LoginPage());
  }

  bool get isLogin => accountName != null;

  String get _kAccountName => "account_name";

  String get accountName => HiveHelper.dBox.get(_kAccountName);
  set accountName(String v) => HiveHelper.dBox.put(_kAccountName, v);
}