import 'package:xiao_yu_ji_zhang/logic/network/api_base.dart';

class IncomeApi extends ApiBase{

  final int timeStamp;
  final double amount;
  final String type;
  final String remarks;
  IncomeApi({this.timeStamp, this.amount, this.type, this.remarks});

  Future<Response> start() {
    return dio.post("/book-keeping/income", data: FormData.fromMap({
      "time_stamp": timeStamp,
      "amount": amount,
      "type": type,
      "remarks": remarks
    }));
  }

}

class OutcomeApi extends ApiBase{

  final int timeStamp;
  final double amount;
  final String type;
  final String remarks;
  OutcomeApi({this.timeStamp, this.amount, this.type, this.remarks});

  Future<Response> start() {
    return dio.post("/book-keeping/outcome", data: FormData.fromMap({
      "time_stamp": timeStamp,
      "amount": amount,
      "type": type,
      "remarks": remarks
    }));
  }

}

class DetailListApi extends ApiBase {

  final DateTime dateTime;
  DetailListApi(this.dateTime);


  int get beginTimeStamp => DateTime(dateTime.year,dateTime.month).millisecondsSinceEpoch;
  int get endTimeStamp => DateTime(dateTime.year,dateTime.month + 1).millisecondsSinceEpoch;


  Future<Response> start() {
    return dio.get("/detailed-list", queryParameters: ({
      "begin_time_stamp": beginTimeStamp,
      "end_time_stamp": endTimeStamp
    }));
  }
}

class DetailChartApi extends ApiBase {

  Future<Response> start() {
    return dio.get("/detailed-chart");
  }
}

class DeleteRecordApi extends ApiBase {

  final bool isOutcome;
  final int timeStamp;

  DeleteRecordApi({this.isOutcome, this.timeStamp});
  
  Future<Response> start() {
    return dio.post("/book-keeping/delete-record",data: FormData.fromMap({
      "is_outcome":isOutcome,
      "time_stamp": timeStamp
    }));
  }
}

class ModifyRecordApi extends ApiBase {

  final bool isOutcome;
  final int oldTimeStamp;
  final int timeStamp;
  final double amount;
  final String type;
  final String remarks;

  ModifyRecordApi({this.isOutcome, this.oldTimeStamp, this.timeStamp, this.amount, this.type, this.remarks});
  
  Future<Response> start() {
    return dio.post("/book-keeping/modify-record",data: FormData.fromMap({
      "is_outcome":isOutcome,
      "old_time_stamp": oldTimeStamp,
      "time_stamp":timeStamp,
      "amount":amount,
      "type":type,
      "remarks":remarks
    }));
  }
}