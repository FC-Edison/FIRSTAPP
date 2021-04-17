import 'package:get/get.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/api.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/controller.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';

class BookKeepingManager{
  static BookKeepingManager _instance;
  static BookKeepingManager get instance{
    if(_instance == null){
      _instance = BookKeepingManager._init();
    }
    return _instance;
  }
  BookKeepingManager._init();

  DetailListController _controller = DetailListController();

  void initController () {
    Get.put(_controller);
  }
  Future<Map> outcome (int timeStamp, double amount, String type, String remarks,DateTime dateTime) async {
    var data = (await OutcomeApi(timeStamp: timeStamp,amount: amount,type: type,remarks: remarks).start()).data;
    sync(dateTime);
    return data;
  }

  Future<Map> income (int timeStamp, double amount, String type, String remarks,DateTime dateTime) async {
    var data = (await IncomeApi(timeStamp: timeStamp,amount: amount,type: type,remarks: remarks).start()).data;
    sync(dateTime);
    return data;
  }

  List<DetailListItem> _incomeList, _outcomeList;


  List<DetailListItem> get incomeList => _incomeList;

  List<DetailListItem> get outcomeList => _outcomeList;


  //排序
  List<DetailListItem>  get detailList{
    for(int i = 0;i < _incomeList.length;i++){
      _outcomeList.add(_incomeList[i]);
    }
    _outcomeList.sort();
    return _outcomeList;
  }

  //总收入
  double get outcomeAmount {
    double sum = 0;
    _outcomeList.forEach((element) {sum += element.amount;});
    return sum.toPrecision(2);
  }

  //总支出
  double get incomeAmount {
    double sum = 0;
    _incomeList.forEach((element) {sum += element.amount;});
    sum.toPrecision(1);
    return sum.toPrecision(2);
  }


  Future sync(DateTime dateTime) async {
    var res = await DetailListApi(dateTime).start();
    var data = DetailedListReply.fromJson(res.data);
    // TODO 处理失败情况
    _incomeList = data.incomeList;
    _outcomeList = data.outcomeList;
    _controller.sync();
  }

  Future delete(bool isOutcome,int timeStamp,DateTime dateTime) async{
    var data = (await DeleteRecordApi(isOutcome: isOutcome,timeStamp: timeStamp).start()).data;
    sync(dateTime);
    return data;
  }

  Future modify(bool isOutcome,int oldTimeStamp,int timeStamp,double amount,String type,String remarks,DateTime dateTime) async{
    var data = (await ModifyRecordApi(isOutcome: isOutcome,oldTimeStamp: oldTimeStamp,timeStamp: timeStamp,amount: amount,type: type,remarks: remarks).start()).data;
    sync(dateTime);
    return data;
  }

}