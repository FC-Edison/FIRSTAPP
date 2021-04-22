import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class MyLineChart extends StatefulWidget {

  final int tabBarIndex;
  final List<DetailChartItem> list;
  const MyLineChart({Key key, this.tabBarIndex, this.list}) : super(key: key);
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<MyLineChart> {
  bool isShowingMainData;
  int tabBarIndex;
  List<DetailChartItem> list;

  @override
  void initState() {
    super.initState();
    tabBarIndex = widget.tabBarIndex;
    isShowingMainData = true;
    list = widget.list;
  }

  ///月度趋势底线按照本月天数创建FlSpot列表
  List<FlSpot> get lineOfWeekSpotList{
    int days = daysOfMonth(DateTime.now().millisecondsSinceEpoch);
    if(days == 28){
      return [
        FlSpot(1, 0),
        FlSpot(4, 0),
        FlSpot(7, 0),
        FlSpot(10, 0),
        FlSpot(13, 0),
        FlSpot(16, 0),
        FlSpot(19, 0),
        FlSpot(22, 0),
        FlSpot(25, 0),
        FlSpot(28, 0),
      ];
    }else if(days == 29){
      return [
        FlSpot(1, 0),
        FlSpot(5, 0),
        FlSpot(9, 0),
        FlSpot(13, 0),
        FlSpot(17, 0),
        FlSpot(21, 0),
        FlSpot(25, 0),
        FlSpot(29, 0),
      ];
    }else if(days == 30){
      return [
        FlSpot(1, 0),
        FlSpot(5, 0),
        FlSpot(10, 0),
        FlSpot(15, 0),
        FlSpot(20, 0),
        FlSpot(25, 0),
        FlSpot(30, 0),
      ];
    }else{
      return [
        FlSpot(1, 0),
        FlSpot(4, 0),
        FlSpot(7, 0),
        FlSpot(10, 0),
        FlSpot(13, 0),
        FlSpot(16, 0),
        FlSpot(19, 0),
        FlSpot(22, 0),
        FlSpot(25, 0),
        FlSpot(28, 0),
        FlSpot(31, 0),
      ];
    }
  }

  ///年度趋势底线
  final LineChartBarData lineOfYear = LineChartBarData(
    spots: [
      FlSpot(1, 0),
      FlSpot(2, 0),
      FlSpot(3, 0),
      FlSpot(4, 0),
      FlSpot(5, 0),
      FlSpot(6, 0),
      FlSpot(7, 0),
      FlSpot(8, 0),
      FlSpot(9, 0),
      FlSpot(10, 0),
      FlSpot(11, 0),
      FlSpot(12, 0),
    ],
    isCurved: true,
    colors: const [
      Color(0xffccf2f4),
    ],
    barWidth: 2,
    curveSmoothness: 0.2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  ///周趋势底线
  final LineChartBarData lineOfWeek = LineChartBarData(
    spots: [
      FlSpot(1, 0),
      FlSpot(2, 0),
      FlSpot(3, 0),
      FlSpot(4, 0),
      FlSpot(5, 0),
      FlSpot(6, 0),
      FlSpot(7, 0),
    ],
    isCurved: true,
    colors: const [
      Color(0xffccf2f4),
    ],
    barWidth: 2,
    curveSmoothness: 0.2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  ///月度趋势底线
  final LineChartBarData lineOfMonth = LineChartBarData(
    spots: [
      FlSpot(1, 0),
      FlSpot(5, 0),
      FlSpot(10, 0),
      FlSpot(15, 0),
      FlSpot(20, 0),
      FlSpot(25, 0),
      FlSpot(30, 0),
    ],
    isCurved: true,
    colors: const [
      Color(0xffccf2f4),
    ],
    barWidth: 2,
    curveSmoothness: 0.2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  ///判断该月有几天
  int daysOfMonth(int timeStamp){
    int year = DateTime.fromMillisecondsSinceEpoch(timeStamp).year;
    int month = DateTime.fromMillisecondsSinceEpoch(timeStamp).month;
    List<int> days = [31,28,31,30,31,30,31,31,30,31,30,31];
    if(year % 4 == 0 && year % 100 != 0){
      days[1] = 29;
    }
    return days[month - 1];
  }

  ///趋势图底线标字
  String getTitles(double value){
    if(tabBarIndex == 0){
      switch (value.toInt()) {
        case 1:
          return '1';
        case 2:
          return '2';
        case 3:
          return '3';
        case 4:
          return '4';
        case 5:
          return '5';
        case 6:
          return '6';
        case 7:
          return '7';
      }
    }else if(tabBarIndex == 2){
      switch (value.toInt()) {
        case 1:
          return '1';
        case 2:
          return '2';
        case 3:
          return '3';
        case 4:
          return '4';
        case 5:
          return '5';
        case 6:
          return '6';
        case 7:
          return '7';
        case 8:
          return '8';
        case 9:
          return '9';
        case 10:
          return '10';
        case 11:
          return '11';
        case 12:
          return '12';
      }
    }else{
      int days = daysOfMonth(DateTime.now().millisecondsSinceEpoch);
      if(days == 28){
        switch (value.toInt()) {
          case 1:
            return '1';
          case 4:
            return '4';
          case 7:
            return '7';
          case 10:
            return '10';
          case 13:
            return '13';
          case 16:
            return '16';
          case 19:
            return '19';
          case 22:
            return '22';
          case 25:
            return '25';
          case 28:
            return '28';
        }
      }else if(days == 29){
        switch (value.toInt()) {
          case 1:
            return '1';
          case 5:
            return '5';
          case 9:
            return '9';
          case 13:
            return '13';
          case 17:
            return '17';
          case 21:
            return '21';
          case 25:
            return '25';
          case 29:
            return '29';
        }
      }else if(days == 30){
        switch (value.toInt()) {
          case 1:
            return '1';
          case 5:
            return '5';
          case 10:
            return '10';
          case 15:
            return '15';
          case 20:
            return '20';
          case 25:
            return '25';
          case 30:
            return '30';
        }
      }else{
        switch (value.toInt()) {
          case 1:
            return '1';
          case 4:
            return '4';
          case 7:
            return '7';
          case 10:
            return '10';
          case 13:
            return '13';
          case 16:
            return '16';
          case 19:
            return '19';
          case 22:
            return '22';
          case 25:
            return '25';
          case 28:
            return '28';
          case 31:
            return '31';
        }
      }
    }
    return '';
  }

  ///支出趋势数据
  LineChartData outcomeData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            return getTitles(value);
          },
        ),
        leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return '';
            },
            margin: 0),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black54,
            width: 1,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 1,
      maxX: tabBarIndex == 1 ? daysOfMonth(DateTime.now().millisecondsSinceEpoch).toDouble() : (tabBarIndex == 0 ? 7 : 12),
      minY: 0,
      lineBarsData: outcomeLine(),
    );
  }

  ///支出趋势线
  List<LineChartBarData> outcomeLine() {
    return [
      tabBarIndex == 0 ? lineOfWeek : (tabBarIndex == 1 ? lineOfMonth : lineOfYear),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(2, 1.5),
          FlSpot(3, 1.4),
          FlSpot(4, 3.4),
          FlSpot(5, 2),
          FlSpot(6, 2.2),
          FlSpot(7, 1),
          FlSpot(8, 1.5),
          FlSpot(9, 1.4),
          FlSpot(10, 3.4),
          FlSpot(11, 2),
          FlSpot(12, 2.2),
        ],
        isCurved: true,
        colors: [
          const Color(0xffccf2f4),
        ],
        barWidth: 4,
        curveSmoothness: 0.4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),

    ];
  }

  ///收入趋势数据
  LineChartData incomeData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            return getTitles(value);
          },
        ),
        leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return '';
            },
            margin: 0),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Colors.transparent,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 1,
      maxX: tabBarIndex == 1 ? daysOfMonth(DateTime.now().millisecondsSinceEpoch).toDouble() : (tabBarIndex == 0 ? 7 : 12),
      minY: 0,
      lineBarsData: incomeLine(),
    );
  }

  ///收入趋势线
  List<LineChartBarData> incomeLine() {
    return [
      tabBarIndex == 0 ? lineOfWeek : (tabBarIndex == 1 ? lineOfMonth : lineOfYear),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(2, 4),
          FlSpot(3, 2.2),
          FlSpot(4, 3.1),
          FlSpot(5, 1.6),
          FlSpot(6, 3.5),
          FlSpot(7, 4.6),
          FlSpot(8, 3.1),
          FlSpot(9, 2.4),
          FlSpot(10, 1.2),
          FlSpot(11, 0.4),
          FlSpot(12, 2.7),
        ],
        isCurved: true,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 4,
        curveSmoothness: 0.4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Card(
        margin: EdgeInsets.all(8),
        color: Color(0xf0ffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 35,
                        child: Container(
                          height: 35,
                          width: Get.size.width-180,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "近期趋势",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        )),

                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowingMainData = true;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              '支出: ',
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                    color: Color(0xffccf2f4))),
                          ],
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowingMainData = false;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              '收入: ',
                              style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                    color: Color(0xffa4ebf3))),
                          ],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 21.0, left: 0),
                child: LineChart(
                  isShowingMainData ? outcomeData() : incomeData(),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
