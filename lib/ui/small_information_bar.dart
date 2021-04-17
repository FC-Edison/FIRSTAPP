import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';

class SmallInformationBar extends StatelessWidget {
  final List<DetailListItem> cellInforBar;
  const SmallInformationBar({Key key, this.cellInforBar}) : super(key: key);

  String get outcomeAmount{
    double amount = 0;
    for(int i = 0;i < cellInforBar.length;i++){
      if(cellInforBar[i].isOutcome){
        amount += cellInforBar[i].amount;
      }
    }
    return "支出: " + amount.toStringAsFixed(2);
  }

  String get incomeAmount{
    double amount = 0;
    for(int i = 0;i < cellInforBar.length;i++){
      if(!cellInforBar[i].isOutcome){
        amount += cellInforBar[i].amount;
      }
    }

    return "收入: " + amount.toStringAsFixed(2);
  }

  String chineseWeekday(int i) {
    if(i == 1){
      return "星期一";
    }else if(i == 2){
      return "星期二";
    }else if(i == 3){
      return "星期三";
    }else if(i == 4){
      return "星期四";
    }else if(i == 5){
      return "星期五";
    }else if(i == 6){
      return "星期六";
    }else{
      return "星期日";
    }
  }

  String get date{
    int month = DateTime.fromMillisecondsSinceEpoch(cellInforBar[0].timeStamp).month;
    int day = DateTime.fromMillisecondsSinceEpoch(cellInforBar[0].timeStamp).day;
    String weekday = chineseWeekday(DateTime.fromMillisecondsSinceEpoch(cellInforBar[0].timeStamp).weekday);

    String date = (month >= 10 ? month.toString() : "0" + month.toString()) + "-" + (day >= 10 ? day.toString() : "0" + day.toString()) + " " + (weekday);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text("   " + date,style: TextStyle(color: Colors.black54,fontSize: 12)),



          Text(outcomeAmount + "   " + incomeAmount + "   ",style: TextStyle(color: Colors.black54,fontSize: 12)),

        ],
      ),
    );
  }

}
