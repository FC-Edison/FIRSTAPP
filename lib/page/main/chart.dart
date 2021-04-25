import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/controller.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/page/main/my_bar_chart.dart';
import 'package:xiao_yu_ji_zhang/page/main/my_pie_chart.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with SingleTickerProviderStateMixin {

  final DetailDataController detailController = Get.find();

  TabController _tabController;

  List<DetailChartItem> yearOutcomeData,monthOutcomeData,weekOutcomeData,
                        yearIncomeData,monthIncomeData,weekIncomeData;

  ///初始化状态
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    yearOutcomeData = _yearOutcomeData;
    monthOutcomeData = _monthOutcomeData;
    weekOutcomeData = _weekOutcomeData;
    yearIncomeData = _yearIncomeData;
    monthIncomeData = _monthIncomeData;
    weekIncomeData = _weekIncomeData;
  }


  ///支出年数据
  List<DetailChartItem> get _yearOutcomeData{
    List<DetailChartItem> list = [];
    for(int i = 0;;i++){
      if(i == detailController.outcomeChart.length){
        break;
      }
      if(DateTime.fromMillisecondsSinceEpoch(detailController.outcomeChart[i].timeStamp).year == DateTime.now().year){
          list.add(detailController.outcomeChart[i]);
      }
    }
    list.sort();
    return list;
  }

  ///支出月数据
  List<DetailChartItem> get _monthOutcomeData{
    List<DetailChartItem> list = [];
    for(int i = 0;;i++){
      if(i == yearOutcomeData.length){
        break;
      }
      if(DateTime.fromMillisecondsSinceEpoch(yearOutcomeData[i].timeStamp).month == DateTime.now().month){
          list.add(yearOutcomeData[i]);
      }
    }
    return list;
  }

  ///支出周数据
  List<DetailChartItem> get _weekOutcomeData{
    List<DetailChartItem> list = [];
    int differenceDay;
    int differenceWeekday;
    for(int i = 0;;i++){
      if(i == monthOutcomeData.length){
        break;
      }
      differenceDay = DateTime.now().day - DateTime.fromMillisecondsSinceEpoch(monthOutcomeData[i].timeStamp).day;
      differenceWeekday = DateTime.now().weekday - DateTime.fromMillisecondsSinceEpoch(monthOutcomeData[i].timeStamp).weekday;
      if(differenceWeekday == differenceDay){
          list.add(monthOutcomeData[i]);
      }
    }
    return list;
  }

  ///收入年数据
  List<DetailChartItem> get _yearIncomeData{
    List<DetailChartItem> list = [];
    for(int i = 0;;i++){
      if(i == detailController.incomeChart.length){
        break;
      }
      if(DateTime.fromMillisecondsSinceEpoch(detailController.incomeChart[i].timeStamp).year == DateTime.now().year){
          list.add(detailController.incomeChart[i]);
      }
    }
    list.sort();
    return list;
  }

  ///收入月数据
  List<DetailChartItem> get _monthIncomeData{
    List<DetailChartItem> list = [];
    for(int i = 0;;i++){
      if(i == yearIncomeData.length){
        break;
      }
      if(DateTime.fromMillisecondsSinceEpoch(yearIncomeData[i].timeStamp).month == DateTime.now().month){
          list.add(yearIncomeData[i]);
      }
    }
    return list;
  }

  ///收入周数据
  List<DetailChartItem> get _weekIncomeData{
    List<DetailChartItem> list = [];
    int day;
    int weekday;
    int dayNow;
    int weekdayNow;
    int differenceDay;
    int differenceWeekday;
    for(int i = 0;;i++){
      if(i == monthIncomeData.length){
        break;
      }
      day = DateTime.fromMillisecondsSinceEpoch(monthIncomeData[i].timeStamp).day;
      weekday = DateTime.fromMillisecondsSinceEpoch(monthIncomeData[i].timeStamp).weekday;
      dayNow = DateTime.now().day;
      weekdayNow = DateTime.now().weekday;
      differenceDay = dayNow - day;
      differenceWeekday = weekdayNow - weekday;
      if(differenceWeekday == differenceDay){
          list.add(monthIncomeData[i]);
      }
    }
    return list;
  }

  ///定义周月年的全局变量
  final int weekIndex = 0;
  final int monthIndex = 1;
  final int yearIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: Text("周",style: TextStyle(color: Colors.black54,fontSize: 17)),
              ),
              Tab(
                child: Text("月",style: TextStyle(color: Colors.black54,fontSize: 17)),
              ),
              Tab(
                child: Text("年",style: TextStyle(color: Colors.black54,fontSize: 17)),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            height: Get.size.height / 3 * 2,
            width: Get.size.width,
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                Container(
                  width: Get.size.width,
                  child: Column(
                    children: [
                      MyBarChart(tabBarIndex: weekIndex,outcomeList: weekOutcomeData,incomeList: weekIncomeData),
                      SizedBox(height: 3),
                      MyPieChart(tabBarIndex: weekIndex,outcomeList: weekOutcomeData,incomeList: weekIncomeData)

                    ],
                  )
                ),
                Container(
                  width: Get.size.width,
                  child: Column(
                    children: [
                      MyBarChart(tabBarIndex: monthIndex,outcomeList: monthOutcomeData,incomeList: monthIncomeData),
                      SizedBox(height: 3),
                      MyPieChart(tabBarIndex: monthIndex,outcomeList: monthOutcomeData,incomeList: monthIncomeData)
                    ],
                  ),
                ),
                Container(
                  width: Get.size.width,
                  child: Column(
                    children: [
                      MyBarChart(tabBarIndex: yearIndex,outcomeList: yearOutcomeData,incomeList: yearIncomeData),
                      SizedBox(height: 3),
                      MyPieChart(tabBarIndex: yearIndex,outcomeList: yearOutcomeData,incomeList: yearIncomeData)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
  }
}
