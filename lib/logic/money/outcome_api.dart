import 'package:xiao_yu_ji_zhang/logic/network/api_base.dart';

class OutcomeApi extends ApiBase{

  final int timeStamp;
  final double amount;
  final String type;
  final String remarks;
  OutcomeApi({this.timeStamp, this.amount, this.type, this.remarks});

  Future<Response> start() {
    return dio.post("/book-keeping/outcome", data: FormData.fromMap({
      "time_stamp": timeStamp,
      "out_come_amount": amount,
      "type": type,
      "remarks": remarks
    }));
  }

}