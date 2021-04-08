import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:xiao_yu_ji_zhang/logic/network/manager.dart';

export 'package:dio/dio.dart';

class ApiBase {
  
  ApiBase() {
    dio.interceptors.add(PrettyDioLogger());
  }
  
  Dio dio = Dio(BaseOptions(
      baseUrl: NetworkManager.instance.baseURL,
      headers: NetworkManager.instance.defaultHeader,
  ));

  // need override
  Future<Response> start() => null;
}
