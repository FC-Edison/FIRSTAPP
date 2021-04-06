import 'package:xiao_yu_ji_zhang/logic/network/api_base.dart';

class LoginApi extends ApiBase {
  final String accountName;
  LoginApi({this.accountName});

  Future<Response> start() => dio.post("/login", data: FormData.fromMap({
    "account_name": accountName
  }));
}