import 'package:xiao_yu_ji_zhang/logic/network/api_base.dart';

class ExpenseApi extends ApiBase{

  final int timeStamp;
  final double amount;
  final String type;
  final String remarks;
  ExpenseApi({this.timeStamp, this.amount, this.type, this.remarks});

  Future<Response> start() {
    return dio.post("/bookKeeping", data: FormData.fromMap({
      "time_stamp": timeStamp,
      "out_come_amount": amount,
      "type": type,
      "remarks": remarks
    }));
  }

}