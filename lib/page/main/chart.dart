import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/controller.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/page/main/my_line_chart.dart';
import 'package:xiao_yu_ji_zhang/page/main/my_pie_chart.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with SingleTickerProviderStateMixin {

  final DetailDataController detailController = Get.find();

  TabController _tabController;



  ///获取支出全部数据
  List<DetailChartItem> get outcomeChartData{
    List<DetailChartItem> list = List<DetailChartItem>();
    for(int i = 0;i < detailController.outcomeChart.length;i++){
      list.add(detailController.outcomeChart[i]);
    }
    return list;
  }

  ///获取收入全部数据
  List<DetailChartItem> get incomeChartData{
    List<DetailChartItem> list = List<DetailChartItem>();
    for(int i = 0;i < detailController.incomeChart.length;i++){
      list.add(detailController.incomeChart[i]);
    }
    return list;
  }

  ///年数据
  List<DetailChartItem> get yearOutcomeData{
    List<DetailChartItem> list = List<DetailChartItem>();
    for(int i = 0;;i++){
      if(i == outcomeChartData.length){
        break;
      }
      if(DateTime.fromMillisecondsSinceEpoch(outcomeChartData[i].timeStamp).year == DateTime.now().year){
          list.add(outcomeChartData[i]);
      }
    }
    list.sort();
    return list;
  }

  ///月数据
  List<DetailChartItem> get monthOutcomeData{
    List<DetailChartItem> list = List<DetailChartItem>();
    for(int i = 0;;i++){
      if(i == yearOutcomeData.length){
        break;
      }
      if(DateTime.fromMillisecondsSinceEpoch(yearOutcomeData[i].timeStamp).month == DateTime.now().month){
          list.add(yearOutcomeData[i]);
      }
    }
    list.sort();
    return list;
  }

  ///周数据
  List<DetailChartItem> get weekOutcomeData{
    List<DetailChartItem> list = List<DetailChartItem>();
    int day;
    int weekday;
    int dayNow;
    int weekdayNow;
    int differenceDay;
    int differenceWeekday;
    for(int i = 0;;i++){
      if(i == monthOutcomeData.length){
        break;
      }
      day = DateTime.fromMillisecondsSinceEpoch(yearOutcomeData[i].timeStamp).day;
      weekday = DateTime.fromMillisecondsSinceEpoch(yearOutcomeData[i].timeStamp).weekday;
      dayNow = DateTime.now().day;
      weekdayNow = DateTime.now().weekday;
      differenceDay = dayNow - day;
      differenceWeekday = weekdayNow - weekday;
      if(differenceWeekday == differenceDay){
          list.add(monthOutcomeData[i]);
      }
    }
    list.sort();
    return list;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
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
              controller: _tabController,
              children: <Widget>[
                Container(
                  width: Get.size.width,
                  child: FutureBuilder(
                    future: Future.value(weekOutcomeData),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            MyLineChart(tabBarIndex: weekIndex,list: snapshot.data),
                            SizedBox(height: 3),
                            MyPieChart(tabBarIndex: weekIndex,list: snapshot.data)
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                ),
                Container(
                  width: Get.size.width,
                  child: Column(
                    children: [
                      MyLineChart(tabBarIndex: monthIndex,list: monthOutcomeData),
                      SizedBox(height: 3),
                      MyPieChart(tabBarIndex: monthIndex,list: monthOutcomeData)
                    ],
                  ),
                ),
                Container(
                  width: Get.size.width,
                  child: Column(
                    children: [
                      MyLineChart(tabBarIndex: yearIndex,list: yearOutcomeData),
                      SizedBox(height: 3),
                      MyPieChart(tabBarIndex: yearIndex,list: yearOutcomeData)
                    ],
                  ),
                ),
                // Container(),
                // Container()
              ],
            ),
          )
        ],
      );
  }
}
