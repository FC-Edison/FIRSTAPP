import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class MyBarChart extends StatefulWidget {
  final int tabBarIndex;
  final List<DetailChartItem> outcomeList;
  final List<DetailChartItem> incomeList;
  const MyBarChart({Key key, this.tabBarIndex, this.outcomeList, this.incomeList}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyBarChartState();
}

class MyBarChartState extends State<MyBarChart> {

  bool isShowingOutcome;
  int tabBarIndex;
  List<DetailChartItem> outcomeList;
  List<DetailChartItem> incomeList;
  int touchedIndex;

  @override
  void initState() {
    super.initState();
    tabBarIndex = widget.tabBarIndex;
    isShowingOutcome = true;
    outcomeList = widget.outcomeList;
    incomeList = widget.incomeList;
  }



  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.1,
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
                          width: Get.size.width - 180,
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
                            isShowingOutcome = true;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              '支出:',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                              textAlign: TextAlign.center,
                            ),
                            Text(" "),
                            Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                    color: Color(0xfffdb827))),
                          ],
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isShowingOutcome = false;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              '收入:',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                              textAlign: TextAlign.center,
                            ),
                            Text(" "),
                            Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                    color: Color(0xff51adcf))),
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
                padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 6),
                child: BarChart(
                  // isPlaying ? randomData() : mainBarData(),
                  tabBarIndex == 0 ? weekBar() : (tabBarIndex == 1 ? monthBar() : yearBar()),
                  swapAnimationDuration: Duration(milliseconds: 500),
                  swapAnimationCurve: Curves.linear,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///周柱状图数据格式
  BarChartGroupData weekDataFormat(double maxAmount, int x, double y, {bool isTouched = false, Color barColor = const Color(0xfffdb827), double width = 5, List<int> showTooltips = const [],}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isShowingOutcome ? (isTouched ? [Color(0xffff7171)] : [barColor]) : (isTouched ? [Color(0xff0278ae)] : [Color(0xff51adcf)]),
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxAmount,
            colors: isShowingOutcome ? [Color(0xffff7a00).withOpacity(0.2)] : [Color(0xff51adcf).withOpacity(0.2)],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
  ///年柱状图数据格式
  BarChartGroupData yearDataFormat(double maxAmount, int x, double y, {bool isTouched = false, Color barColor = const Color(0xfffdb827), double width = 4, List<int> showTooltips = const [],}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isShowingOutcome ? (isTouched ? [Color(0xffff7171)] : [barColor]) : (isTouched ? [Color(0xff0278ae)] : [Color(0xff51adcf)]),
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxAmount,
            colors: isShowingOutcome ? [Color(0xffff7a00).withOpacity(0.2)] : [Color(0xff51adcf).withOpacity(0.2)],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
  ///月柱状图数据格式
  BarChartGroupData monthDataFormat(double maxAmount, int x, double y, {bool isTouched = false, Color barColor = const Color(0xfffdb827), double width = 3, List<int> showTooltips = const [],}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isShowingOutcome ? (isTouched ? [Color(0xffff7171)] : [barColor]) : (isTouched ? [Color(0xff0278ae)] : [Color(0xff51adcf)]),
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxAmount,
            colors: isShowingOutcome ? [Color(0xffff7a00).withOpacity(0.2)] : [Color(0xff51adcf).withOpacity(0.2)],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  ///周柱状图-数据
  List<BarChartGroupData> weekData(List<DetailChartItem> list) => List.generate(7, (i) {
    if(tabBarIndex == 1 || tabBarIndex == 2){
      return null;
    }
    List<double> amount = [0,0,0,0,0,0,0];
    int day = 0;
    double maxAmount = 0;
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
    for(int i = 0;i < amount.length;i++){
      maxAmount = amount[i] > maxAmount ? amount[i] : maxAmount;
    }
    maxAmount = maxAmount == 0 ? 20 : maxAmount;

    switch (i) {
      case 0:
        return weekDataFormat(maxAmount,0, amount[0], isTouched: i == touchedIndex);
      case 1:
        return weekDataFormat(maxAmount,1, amount[1], isTouched: i == touchedIndex);
      case 2:
        return weekDataFormat(maxAmount,2, amount[2], isTouched: i == touchedIndex);
      case 3:
        return weekDataFormat(maxAmount,3, amount[3], isTouched: i == touchedIndex);
      case 4:
        return weekDataFormat(maxAmount,4, amount[4], isTouched: i == touchedIndex);
      case 5:
        return weekDataFormat(maxAmount,5, amount[5], isTouched: i == touchedIndex);
      case 6:
        return weekDataFormat(maxAmount,6, amount[6], isTouched: i == touchedIndex);
      default:
        return null;
    }
  });
  ///周柱状图
  BarChartData weekBar() {
    if(tabBarIndex == 1 || tabBarIndex == 2){
      return null;
    }
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipMargin: 18,
          tooltipPadding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
          tooltipRoundedRadius: 8,
            tooltipBgColor: isShowingOutcome ? Color(0xfffdb827) : Color(0xff51adcf),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '周一';
                  break;
                case 1:
                  weekDay = '周二';
                  break;
                case 2:
                  weekDay = '周三';
                  break;
                case 3:
                  weekDay = '周四';
                  break;
                case 4:
                  weekDay = '周五';
                  break;
                case 5:
                  weekDay = '周六';
                  break;
                case 6:
                  weekDay = '周日';
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: isShowingOutcome ? Color(0xffff7171) : Color(0xff0278ae),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "(元)",
                    style: TextStyle(
                      color: isShowingOutcome ? Color(0xffff7171) : Color(0xff0278ae),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 9,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '一';
              case 1:
                return '二';
              case 2:
                return '三';
              case 3:
                return '四';
              case 4:
                return '五';
              case 5:
                return '六';
              case 6:
                return '日';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: isShowingOutcome ? weekData(outcomeList) : weekData(incomeList),
    );
  }

  ///年柱状图-数据
  List<BarChartGroupData> yearData(List<DetailChartItem> list) => List.generate(12, (i) {
    if(tabBarIndex == 0 || tabBarIndex == 1){
      return null;
    }
    List<double> amount = [0,0,0,0,0,0,0,0,0,0,0,0];
    int month = 0;
    double maxAmount = 0;
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
    for(int i = 0;i < amount.length;i++){
      maxAmount = amount[i] > maxAmount ? amount[i] : maxAmount;
    }
    maxAmount = maxAmount == 0 ? 20 : maxAmount;

    switch (i) {
      case 0:
        return yearDataFormat(maxAmount,0, amount[0], isTouched: i == touchedIndex);
      case 1:
        return yearDataFormat(maxAmount,1, amount[1], isTouched: i == touchedIndex);
      case 2:
        return yearDataFormat(maxAmount,2, amount[2], isTouched: i == touchedIndex);
      case 3:
        return yearDataFormat(maxAmount,3, amount[3], isTouched: i == touchedIndex);
      case 4:
        return yearDataFormat(maxAmount,4, amount[4], isTouched: i == touchedIndex);
      case 5:
        return yearDataFormat(maxAmount,5, amount[5], isTouched: i == touchedIndex);
      case 6:
        return yearDataFormat(maxAmount,6, amount[6], isTouched: i == touchedIndex);
      case 7:
        return yearDataFormat(maxAmount,7, amount[7], isTouched: i == touchedIndex);
      case 8:
        return yearDataFormat(maxAmount,8, amount[8], isTouched: i == touchedIndex);
      case 9:
        return yearDataFormat(maxAmount,9, amount[9], isTouched: i == touchedIndex);
      case 10:
        return yearDataFormat(maxAmount,10, amount[10], isTouched: i == touchedIndex);
      case 11:
        return yearDataFormat(maxAmount,11, amount[11], isTouched: i == touchedIndex);
      default:
        return null;
    }
  });
  ///年柱状图
  BarChartData yearBar() {
    if(tabBarIndex == 0 || tabBarIndex == 1){
      return null;
    }
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipMargin: 18,
          tooltipPadding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
          tooltipRoundedRadius: 8,
            tooltipBgColor: isShowingOutcome ? Color(0xfffdb827) : Color(0xff51adcf),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '一月';
                  break;
                case 1:
                  weekDay = '二月';
                  break;
                case 2:
                  weekDay = '三月';
                  break;
                case 3:
                  weekDay = '四月';
                  break;
                case 4:
                  weekDay = '五月';
                  break;
                case 5:
                  weekDay = '六月';
                  break;
                case 6:
                  weekDay = '七月';
                  break;
                case 7:
                  weekDay = '八月';
                  break;
                case 8:
                  weekDay = '九月';
                  break;
                case 9:
                  weekDay = '十月';
                  break;
                case 10:
                  weekDay = '十一月';
                  break;
                case 11:
                  weekDay = '十二月';
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: isShowingOutcome ? Color(0xffff7171) : Color(0xff0278ae),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "(元)",
                    style: TextStyle(
                      color: isShowingOutcome ? Color(0xffff7171) : Color(0xff0278ae),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),
          margin: 9,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '一';
              case 1:
                return '二';
              case 2:
                return '三';
              case 3:
                return '四';
              case 4:
                return '五';
              case 5:
                return '六';
              case 6:
                return '七';
              case 7:
                return '八';
              case 8:
                return '九';
              case 9:
                return '十';
              case 10:
                return '冬';
              case 11:
                return '腊';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: isShowingOutcome ? yearData(outcomeList) : yearData(incomeList),
    );
  }

  ///月柱状图-数据
  List<BarChartGroupData> monthData(List<DetailChartItem> list) {
    if(tabBarIndex == 0 || tabBarIndex == 2){
      return null;
    }
    return List.generate(daysOfMonth(DateTime.now().millisecondsSinceEpoch), (i) {
      List<double> amount = List.filled(daysOfMonth(DateTime.now().millisecondsSinceEpoch), 0);
    int day = 0;
    double maxAmount = 0;
    for(int i = 0;i < list.length;i++){
      if(DateTime.fromMillisecondsSinceEpoch(list[i].timeStamp).day == day + 1){
        amount[day] += list[i].amount;
      }else{
        i--;
        day++;
        if(day >= daysOfMonth(DateTime.now().millisecondsSinceEpoch) - 1){
          break;
        }
      }
    }
    for(int i = 0;i < amount.length;i++){
      maxAmount = amount[i] > maxAmount ? amount[i] : maxAmount;
    }
    maxAmount = maxAmount == 0 ? 20 : maxAmount;

    switch (i) {
      case 0:
        return monthDataFormat(maxAmount,0, amount[0], isTouched: i == touchedIndex);
      case 1:
        return monthDataFormat(maxAmount,1, amount[1], isTouched: i == touchedIndex);
      case 2:
        return monthDataFormat(maxAmount,2, amount[2], isTouched: i == touchedIndex);
      case 3:
        return monthDataFormat(maxAmount,3, amount[3], isTouched: i == touchedIndex);
      case 4:
        return monthDataFormat(maxAmount,4, amount[4], isTouched: i == touchedIndex);
      case 5:
        return monthDataFormat(maxAmount,5, amount[5], isTouched: i == touchedIndex);
      case 6:
        return monthDataFormat(maxAmount,6, amount[6], isTouched: i == touchedIndex);
      case 7:
        return monthDataFormat(maxAmount,7, amount[7], isTouched: i == touchedIndex);
      case 8:
        return monthDataFormat(maxAmount,8, amount[8], isTouched: i == touchedIndex);
      case 9:
        return monthDataFormat(maxAmount,9, amount[9], isTouched: i == touchedIndex);
      case 10:
        return monthDataFormat(maxAmount,10, amount[10], isTouched: i == touchedIndex);
      case 11:
        return monthDataFormat(maxAmount,11, amount[11], isTouched: i == touchedIndex);
      case 12:
        return monthDataFormat(maxAmount,12, amount[12], isTouched: i == touchedIndex);
      case 13:
        return monthDataFormat(maxAmount,13, amount[13], isTouched: i == touchedIndex);
      case 14:
        return monthDataFormat(maxAmount,14, amount[14], isTouched: i == touchedIndex);
      case 15:
        return monthDataFormat(maxAmount,15, amount[15], isTouched: i == touchedIndex);
      case 16:
        return monthDataFormat(maxAmount,16, amount[16], isTouched: i == touchedIndex);
      case 17:
        return monthDataFormat(maxAmount,17, amount[17], isTouched: i == touchedIndex);
      case 18:
        return monthDataFormat(maxAmount,18, amount[18], isTouched: i == touchedIndex);
      case 19:
        return monthDataFormat(maxAmount,19, amount[19], isTouched: i == touchedIndex);
      case 20:
        return monthDataFormat(maxAmount,20, amount[20], isTouched: i == touchedIndex);
      case 21:
        return monthDataFormat(maxAmount,21, amount[21], isTouched: i == touchedIndex);
      case 22:
        return monthDataFormat(maxAmount,22, amount[22], isTouched: i == touchedIndex);
      case 23:
        return monthDataFormat(maxAmount,23, amount[23], isTouched: i == touchedIndex);
      case 24:
        return monthDataFormat(maxAmount,24, amount[24], isTouched: i == touchedIndex);
      case 25:
        return monthDataFormat(maxAmount,25, amount[25], isTouched: i == touchedIndex);
      case 26:
        return monthDataFormat(maxAmount,26, amount[26], isTouched: i == touchedIndex);
      case 27:
        return monthDataFormat(maxAmount,27, amount[27], isTouched: i == touchedIndex);
      case 28:
        return monthDataFormat(maxAmount,28, amount[28], isTouched: i == touchedIndex);
      case 29:
        return monthDataFormat(maxAmount,29, amount[29], isTouched: i == touchedIndex);
      case 30:
        return monthDataFormat(maxAmount,30, amount[30], isTouched: i == touchedIndex);
      default:
        return null;
    }
  });}
  ///月柱状图
  BarChartData monthBar() {
    if(tabBarIndex == 0 || tabBarIndex == 2){
      return null;
    }
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipMargin: 18,
          tooltipPadding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
          tooltipRoundedRadius: 8,
            tooltipBgColor: isShowingOutcome ? Color(0xfffdb827) : Color(0xff51adcf),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '1号';
                  break;
                case 1:
                  weekDay = '2号';
                  break;
                case 2:
                  weekDay = '3号';
                  break;
                case 3:
                  weekDay = '4号';
                  break;
                case 4:
                  weekDay = '5号';
                  break;
                case 5:
                  weekDay = '6号';
                  break;
                case 6:
                  weekDay = '7号';
                  break;
                case 7:
                  weekDay = '8号';
                  break;
                case 8:
                  weekDay = '9号';
                  break;
                case 9:
                  weekDay = '10号';
                  break;
                case 10:
                  weekDay = '11号';
                  break;
                case 11:
                  weekDay = '12号';
                  break;
                case 12:
                  weekDay = '13号';
                  break;
                case 13:
                  weekDay = '14号';
                  break;
                case 14:
                  weekDay = '15号';
                  break;
                case 15:
                  weekDay = '16号';
                  break;
                case 16:
                  weekDay = '17号';
                  break;
                case 17:
                  weekDay = '18号';
                  break;
                case 18:
                  weekDay = '19号';
                  break;
                case 19:
                  weekDay = '20号';
                  break;
                case 20:
                  weekDay = '21号';
                  break;
                case 21:
                  weekDay = '22号';
                  break;
                case 22:
                  weekDay = '23号';
                  break;
                case 23:
                  weekDay = '24号';
                  break;
                case 24:
                  weekDay = '25号';
                  break;
                case 25:
                  weekDay = '26号';
                  break;
                case 26:
                  weekDay = '27号';
                  break;
                case 27:
                  weekDay = '28号';
                  break;
                case 28:
                  weekDay = '29号';
                  break;
                case 29:
                  weekDay = '30号';
                  break;
                case 30:
                  weekDay = '31号';
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: isShowingOutcome ? Color(0xffff7171) : Color(0xff0278ae),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "(元)",
                    style: TextStyle(
                      color: isShowingOutcome ? Color(0xffff7171) : Color(0xff0278ae),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 11),
          margin: 5,
          getTitles: (double value) {
            if(daysOfMonth(DateTime.now().millisecondsSinceEpoch) == 28){
              switch (value.toInt()) {
                case 0:
                  return '1';
                case 3:
                  return '4';
                case 6:
                  return '7';
                case 9:
                  return '10';
                case 12:
                  return '13';
                case 15:
                  return '16';
                case 18:
                  return '19';
                case 21:
                  return '22';
                case 24:
                  return '25';
                case 27:
                  return '28';
                default:
                  return '';
              }
            }else if(daysOfMonth(DateTime.now().millisecondsSinceEpoch) == 29){
              switch (value.toInt()) {
                case 0:
                  return '1';
                case 4:
                  return '5';
                case 8:
                  return '9';
                case 12:
                  return '13';
                case 16:
                  return '17';
                case 20:
                  return '21';
                case 24:
                  return '25';
                case 28:
                  return '29';
                default:
                  return '';
              }
            }else if(daysOfMonth(DateTime.now().millisecondsSinceEpoch) == 30){
              switch (value.toInt()) {
                case 0:
                  return '1';
                case 4:
                  return '5';
                case 9:
                  return '10';
                case 14:
                  return '15';
                case 19:
                  return '20';
                case 24:
                  return '25';
                case 29:
                  return '30';
                default:
                  return '';
              }
            }else{
              switch (value.toInt()) {
                case 0:
                  return '1';
                case 3:
                  return '4';
                case 6:
                  return '7';
                case 9:
                  return '10';
                case 12:
                  return '13';
                case 15:
                  return '16';
                case 18:
                  return '19';
                case 21:
                  return '22';
                case 24:
                  return '25';
                case 27:
                  return '28';
                case 30:
                  return '31';
                default:
                  return '';
              }
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: isShowingOutcome ? monthData(outcomeList) : monthData(incomeList),
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
}
