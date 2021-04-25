import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class MyLineChart extends StatefulWidget {

  final int tabBarIndex;
  final List<DetailChartItem> outcomeList;
  final List<DetailChartItem> incomeList;
  const MyLineChart({Key key, this.tabBarIndex, this.outcomeList, this.incomeList}) : super(key: key);
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<MyLineChart> {
  bool isShowingMainData;
  int tabBarIndex;
  List<DetailChartItem> outcomeList;
  List<DetailChartItem> incomeList;

  @override
  void initState() {
    super.initState();
    tabBarIndex = widget.tabBarIndex;
    isShowingMainData = true;
    outcomeList = widget.outcomeList;
    incomeList = widget.incomeList;
  }

  ///月度趋势--底线--按照本月天数创建FlSpot列表
  List<FlSpot> get _baseLineOfWeekSpotList{
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

  ///月度趋势--主线--按照本月天数创建FlSpot列表
  List<FlSpot> _lineOfWeekSpotList(List<DetailChartItem> list) {
    int days = daysOfMonth(DateTime.now().millisecondsSinceEpoch);
    List<double> amount = List.filled(days, 0);
    int day = 0;
    for(int i = 0;i < list.length;i++){
      if(DateTime.fromMillisecondsSinceEpoch(list[i].timeStamp).day == day + 1){
        amount[day] += list[i].amount;
      }else{
        i--;
        day++;
        if(day >= days - 1){
          break;
        }
      }
    }
    List<FlSpot> flSpot = [
      FlSpot(1, amount[0]),
      FlSpot(2, amount[1]),
      FlSpot(3, amount[2]),
      FlSpot(4, amount[3]),
      FlSpot(5, amount[4]),
      FlSpot(6, amount[5]),
      FlSpot(7, amount[6]),
      FlSpot(8, amount[7]),
      FlSpot(9, amount[8]),
      FlSpot(10, amount[9]),
      FlSpot(11, amount[10]),
      FlSpot(12, amount[11]),
      FlSpot(13, amount[12]),
      FlSpot(14, amount[13]),
      FlSpot(15, amount[14]),
      FlSpot(16, amount[15]),
      FlSpot(17, amount[16]),
      FlSpot(18, amount[17]),
      FlSpot(19, amount[18]),
      FlSpot(20, amount[19]),
      FlSpot(21, amount[20]),
      FlSpot(22, amount[21]),
      FlSpot(23, amount[22]),
      FlSpot(24, amount[23]),
      FlSpot(25, amount[24]),
      FlSpot(26, amount[25]),
      FlSpot(27, amount[26]),
      FlSpot(28, amount[27]),
    ];
    if(days == 28){
      return flSpot;
    }else if(days == 29){
      flSpot.add(FlSpot(29, amount[28]));
      return flSpot;
    }else if(days == 30){
      flSpot.add(FlSpot(29, amount[28]));
      flSpot.add(FlSpot(30, amount[29]));
      return flSpot;
    }else{
      flSpot.add(FlSpot(29, amount[28]));
      flSpot.add(FlSpot(30, amount[29]));
      flSpot.add(FlSpot(31, amount[30]),);
      return flSpot;
    }
  }

  ///年度趋势--底线
  LineChartBarData get baseLineOfYear => LineChartBarData(
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
      Colors.black54,
    ],
    barWidth: 1,
    isStrokeCapRound: false,
    dotData: FlDotData(
      show: true,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  ///周趋势--底线
  LineChartBarData get baseLineOfWeek => LineChartBarData(
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
      Colors.black54,
    ],
    barWidth: 1,
    isStrokeCapRound: false,
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  ///月度趋势--底线
  LineChartBarData get baseLineOfMonth => LineChartBarData(
    spots: _baseLineOfWeekSpotList,
    isCurved: true,
    colors: const [
      Colors.black54,
    ],
    barWidth: 1,
    isStrokeCapRound: false,
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  ///年度趋势--主线
  LineChartBarData lineOfYear(List<DetailChartItem> list,Color color){
    if(tabBarIndex == 0 || tabBarIndex == 1){
      return null;
    }
    List<double> amount = [0,0,0,0,0,0,0,0,0,0,0,0];
    int month = 0;
    for(int i = 0;i < list.length;i++){
      if(DateTime.fromMillisecondsSinceEpoch(list[i].timeStamp).month == month + 1){
        amount[month] += list[i].amount;
      }else{
        i--;
        month++;
        if(month >= 11){
          break;
        }
      }
    }

    return LineChartBarData(
      spots: [
        FlSpot(1, amount[0]),
        FlSpot(2, amount[1]),
        FlSpot(3, amount[2]),
        FlSpot(4, amount[3]),
        FlSpot(5, amount[4]),
        FlSpot(6, amount[5]),
        FlSpot(7, amount[6]),
        FlSpot(8, amount[7]),
        FlSpot(9, amount[8]),
        FlSpot(10, amount[9]),
        FlSpot(11, amount[10]),
        FlSpot(12, amount[11]),
      ],
      isCurved: true,
      colors: [
        color,
      ],
      barWidth: 4,
      curveSmoothness: 0.4,
      preventCurveOverShooting: true,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false,),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }

  ///周趋势--主线
  LineChartBarData lineOfWeek(List<DetailChartItem> list,Color color){
    if(tabBarIndex == 1 || tabBarIndex == 2){
      return null;
    }
    List<double> amount = [0,0,0,0,0,0,0];
    int day = 0;
    for(int i = 0;i < list.length;i++){
      if(DateTime.fromMillisecondsSinceEpoch(list[i].timeStamp).weekday == day + 1){
        amount[day] += list[i].amount;
      }else{
        i--;
        day++;
        if(day >= 6){
          break;
        }
      }
    }
    return LineChartBarData(
      spots: [
        FlSpot(1, amount[0]),
        FlSpot(2, amount[1]),
        FlSpot(3, amount[2]),
        FlSpot(4, amount[3]),
        FlSpot(5, amount[4]),
        FlSpot(6, amount[5]),
        FlSpot(7, amount[6]),
      ],
      isCurved: true,
      colors: [
        color,
      ],
      barWidth: 4,
      curveSmoothness: 0.4,
      preventCurveOverShooting: true,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false,),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }

  ///月度趋势--主线
  LineChartBarData lineOfMonth(List<DetailChartItem> list,Color color){
    if(tabBarIndex == 0 || tabBarIndex == 2){
      return null;
    }
    return LineChartBarData(
      spots: _lineOfWeekSpotList(list),
      isCurved: true,
      colors: [
        color,
      ],
      barWidth: 4,
      curveSmoothness: 0.4,
      preventCurveOverShooting: true,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false,),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }

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
      tabBarIndex == 0 ? baseLineOfWeek : (tabBarIndex == 1 ? baseLineOfMonth : baseLineOfYear),
      tabBarIndex == 0 ? lineOfWeek(outcomeList,Color(0xffc67ace).withOpacity(0.7)) : (tabBarIndex == 1 ? lineOfMonth(outcomeList,Color(0xffc67ace).withOpacity(0.7)) : lineOfYear(outcomeList,Color(0xffc67ace).withOpacity(0.7))),
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
      tabBarIndex == 0 ? baseLineOfWeek : (tabBarIndex == 1 ? baseLineOfMonth : baseLineOfYear),
      tabBarIndex == 0 ? lineOfWeek(incomeList,Color(0xfffb3640).withOpacity(0.7)) : (tabBarIndex == 1 ? lineOfMonth(incomeList,Color(0xfffb3640).withOpacity(0.7)) : lineOfYear(incomeList,Color(0xfffb3640).withOpacity(0.7))),
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
