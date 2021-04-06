import 'package:xiao_yu_ji_zhang/logic/account/manager.dart';

class NetworkManager {
  static NetworkManager _instance;

  static NetworkManager get instance {
    if (_instance == null) {
      _instance = NetworkManager._init();
    }
    return _instance;
  }
  NetworkManager._init();

  String baseURL = "http://192.168.3.51:80/";

  Map<String, String> defaultHeader= {"account_name": AccountManager.instance.accountName};
}
