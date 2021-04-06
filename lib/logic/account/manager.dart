import 'package:xiao_yu_ji_zhang/logic/account/api.dart';

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
    return res.data;
  }
}