import 'package:xiao_yu_ji_zhang/logic/account/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/money/expense_api.dart';

class MoneyManager{
  static MoneyManager _instance;
  static MoneyManager get instance{
    if(_instance == null){
      _instance = MoneyManager._init();
    }
    return _instance;
  }
  MoneyManager._init();

  String accountName = AccountManager.instance.accountName;

  Future<Map> bookKeeping (int timeStamp, double amount, String type, String remarks) async => (await ExpenseApi(timeStamp: timeStamp,amount: amount,type: type,remarks: remarks).start()).data;
}