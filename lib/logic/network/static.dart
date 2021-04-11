import 'package:xiao_yu_ji_zhang/logic/network/api_base.dart';

class StaticApi extends ApiBase {

  final String fileName;

  StaticApi(this.fileName);

  @override
  Future<Response> start() => dio.get("/static/$fileName");
}