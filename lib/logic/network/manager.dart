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

  // TODO 补上accountName
  Map<String, String> defaultHeader= {"account_name": ""};
}
