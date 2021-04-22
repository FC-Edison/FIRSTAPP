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

  DetailDataController _controller = DetailDataController();

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
  ///列表数据
  List<DetailListItem> _incomeList, _outcomeList;
  List<DetailListItem> get incomeList => _incomeList;
  List<DetailListItem> get outcomeList => _outcomeList;

  ///图表数据
  List<DetailChartItem> _incomeChart, _outcomeChart;
  List<DetailChartItem> get incomeChart => _incomeChart;
  List<DetailChartItem> get outcomeChart => _outcomeChart;


  ///对列表数据进行排序
  List<DetailListItem>  get detailList{
    for(int i = 0;i < _incomeList.length;i++){
      _outcomeList.add(_incomeList[i]);
    }
    _outcomeList.sort();
    return _outcomeList;
  }

  ///主页标题总收入
  double get outcomeAmount {
    double sum = 0;
    _outcomeList.forEach((element) {sum += element.amount;});
    return sum.toPrecision(2);
  }

  ///主页标题总支出
  double get incomeAmount {
    double sum = 0;
    _incomeList.forEach((element) {sum += element.amount;});
    sum.toPrecision(1);
    return sum.toPrecision(2);
  }

  ///需要同步的信息
  Future sync(DateTime dateTime) async {
    var resList = await DetailListApi(dateTime).start();
    var resChart = await DetailChartApi().start();

    var dataList = DetailedListReply.fromJson(resList.data);
    var dataChart = DetailedChartReply.fromJson(resChart.data);

    _incomeList = dataList.incomeList;
    _outcomeList = dataList.outcomeList;

    _incomeChart = dataChart.incomeChart;
    _outcomeChart = dataChart.outcomeChart;

    _controller.sync();
  }

  ///删除一条信息
  Future delete(bool isOutcome,int timeStamp,DateTime dateTime) async{
    var data = (await DeleteRecordApi(isOutcome: isOutcome,timeStamp: timeStamp).start()).data;
    sync(dateTime);
    return data;
  }

  ///修改一条信息
  Future modify(bool isOutcome,int oldTimeStamp,int timeStamp,double amount,String type,String remarks,DateTime dateTime) async{
    var data = (await ModifyRecordApi(isOutcome: isOutcome,oldTimeStamp: oldTimeStamp,timeStamp: timeStamp,amount: amount,type: type,remarks: remarks).start()).data;
    sync(dateTime);
    return data;
  }

}