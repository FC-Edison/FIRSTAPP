import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:xiao_yu_ji_zhang/logic/app/config/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';
import 'indicator.dart';

class MyPieChart extends StatefulWidget {
  final int tabBarIndex;
  final List<DetailChartItem> outcomeList;
  final List<DetailChartItem> incomeList;

  const MyPieChart(
      {Key key, this.tabBarIndex, this.outcomeList, this.incomeList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State<MyPieChart> {
  int touchedIndex;
  bool isShowingOutcome;
  List<DetailChartItem> outcomeList;
  List<DetailChartItem> incomeList;
  int tabBarIndex;
  double outcomeAmount;
  double incomeAmount;
  List<ChartMainData> outcomeData;
  List<ChartMainData> incomeData;

  @override
  void initState() {
    super.initState();
    outcomeList = widget.outcomeList;
    incomeList = widget.incomeList;
    tabBarIndex = widget.tabBarIndex;
    isShowingOutcome = true;
    outcomeAmount = _outcomeAmount;
    incomeAmount = _incomeAmount;
    outcomeData = dataConversion(outcomeList);
    incomeData = dataConversion(incomeList);
  }

  ///支出总金额
  double get _outcomeAmount {
    if (outcomeList == null || outcomeList.isEmpty) {
      return 0;
    }
    double amount = 0;
    for (int i = 0; i < outcomeList.length; i++) {
      amount += outcomeList[i].amount;
    }
    return amount;
  }

  ///收入总金额
  double get _incomeAmount {
    if (incomeList == null || incomeList.isEmpty) {
      return 0;
    }
    double amount = 0;
    for (int i = 0; i < incomeList.length; i++) {
      amount += incomeList[i].amount;
    }
    return amount;
  }

  ///从列表数据整理出Chart数据
  List<ChartMainData> dataConversion(List<DetailChartItem> list) {
    List<ChartMainData> data = [];
    if (list == null || list.isEmpty) {
      data.add(ChartMainData(type: "无支出", amount: 0));
    } else {
      bool isNewType;
      data.add(ChartMainData(type: list[0].type, amount: list[0].amount));
      for (int i = 1; i < list.length; i++) {
        isNewType = true;
        for (int j = 0; j < data.length; j++) {
          if (data[j].type == list[i].type) {
            data[j].amount += list[i].amount;
            isNewType = false;
          }
        }
        if (isNewType) {
          data.add(ChartMainData(type: list[i].type, amount: list[i].amount));
        }
      }
    }
    data.sort((left, right) => right.amount.compareTo(left.amount));
    return data;
  }

  ScrollController itemBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.45,
      child: Card(
        margin: EdgeInsets.all(8),
        color: Color(0xf0ffffff),
        child: Row(
          children: <Widget>[
            Container(
                alignment: Alignment.centerRight,
                height: 200,
                width: 235,
                child: Stack(
                  children: [
                    PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                final desiredTouch = pieTouchResponse.touchInput
                                        is! PointerExitEvent &&
                                    pieTouchResponse.touchInput
                                        is! PointerUpEvent;
                                if (desiredTouch &&
                                    pieTouchResponse.touchedSection != null) {
                                  touchedIndex = pieTouchResponse
                                      .touchedSection.touchedSectionIndex;
                                } else {
                                  touchedIndex = -1;
                                }
                                // itemBarController.jumpTo();
                              });
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              double _position;
                              if(touchedIndex <= 3){
                                _position = 0;
                              }else{
                                _position = (touchedIndex - 3).toDouble() * 50 ;
                              }

                              if(touchedIndex != -1){
                                itemBarController.animateTo(_position,
                                    duration: Duration(milliseconds: 250), curve: Curves.linear);
                              }
                            });
                            }),
                            startDegreeOffset: isShowingOutcome ? 180 : -180,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 8,
                            centerSpaceRadius: 50,
                            sections: isShowingOutcome
                                ? outcomeChart()
                                : incomeChart()),
                        swapAnimationDuration:
                            const Duration(milliseconds: 250)),
                    Center(
                        child: TextButton(onPressed: () {
                           setState(() {
                              isShowingOutcome = !isShowingOutcome;
                            });
                            },
                             child: Container(
                                   height: 50,
                                    width: 50,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.wifi_protected_setup_outlined,
                                          color: Colors.lightBlueAccent,
                                          size: 15,
                                        ),
                                        Text(
                                          isShowingOutcome ? "支出" : "收入",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            decoration: TextDecoration.underline
                                          ),
                            )
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                    ))
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isShowingOutcome
                      ? "支出: $outcomeAmount(元)"
                      : "收入: $incomeAmount(元)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                ),
                Container(
                  width: 130,
                  height: 200,
                  child: Scrollbar(
                      child: ListView.builder(
                    controller: itemBarController,
                    physics: BouncingScrollPhysics(),
                    itemCount: isShowingOutcome
                        ? outcomeData.length
                        : incomeData.length,
                    itemBuilder: itemBuilder,
                  )),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> outcomeChart() {
    if(outcomeAmount == 0){
      final isTouched = 0 == touchedIndex;
      final double opacity = isTouched ? 1 : 0.6;
      return [PieChartSectionData(
        color: Colors.grey.withOpacity(opacity),
        value:100,
        title: "无支出",
        radius: 40,
        titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        titlePositionPercentageOffset: 0.55,
      )];
    }
    return List.generate(
      outcomeData.length,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        switch (outcomeData[i].type) {
          case "餐饮":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[0]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '餐饮',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.5,
            );
          case "购物":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[1]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '购物',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "交通":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[2]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '交通',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.6,
            );
          case "娱乐":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[3]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '娱乐',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "理财":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[4]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '理财',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "旅行":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[5]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '旅行',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "医疗":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[6]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '医疗',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "礼金":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[7]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '礼金',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "美容":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[8]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '美容',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "其他":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[9]).withOpacity(opacity),
              value: outcomeData[i].amount < outcomeAmount / 20
                  ? outcomeAmount / 20
                  : outcomeData[i].amount,
              title: outcomeData[i].amount < outcomeAmount / 15 ? "..." : '其他',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }

  List<PieChartSectionData> incomeChart() {
    if(incomeAmount == 0){
      final isTouched = 0 == touchedIndex;
      final double opacity = isTouched ? 1 : 0.6;
      return [PieChartSectionData(
        color: Colors.grey.withOpacity(opacity),
        value:100,
        title: "无收入",
        radius: 40,
        titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        titlePositionPercentageOffset: 0.55,
      )];
    }
    return List.generate(
      incomeData.length,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        switch (incomeData[i].type) {
          case "工资":
            return PieChartSectionData(
              color: Color(AlternativeColors.colorList[9]).withOpacity(opacity),
              value: incomeData[i].amount < incomeAmount / 20
                  ? incomeAmount / 20
                  : incomeData[i].amount,
              title: incomeData[i].amount < incomeAmount / 15 ? "..." : '工资',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "奖金":
            return PieChartSectionData(
              color:
                  Color(AlternativeColors.colorList[10]).withOpacity(opacity),
              value: incomeData[i].amount < incomeAmount / 20
                  ? incomeAmount / 20
                  : incomeData[i].amount,
              title: incomeData[i].amount < incomeAmount / 15 ? "..." : '奖金',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "兼职":
            return PieChartSectionData(
              color:
                  Color(AlternativeColors.colorList[11]).withOpacity(opacity),
              value: incomeData[i].amount < incomeAmount / 20
                  ? incomeAmount / 20
                  : incomeData[i].amount,
              title: incomeData[i].amount < incomeAmount / 15 ? "..." : '兼职',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.6,
            );
          case "投资收益":
            return PieChartSectionData(
              color:
                  Color(AlternativeColors.colorList[12]).withOpacity(opacity),
              value: incomeData[i].amount < incomeAmount / 20
                  ? incomeAmount / 20
                  : incomeData[i].amount,
              title: incomeData[i].amount < incomeAmount / 15 ? "..." : '投资',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          case "其他":
            return PieChartSectionData(
              color:
                  Color(AlternativeColors.colorList[13]).withOpacity(opacity),
              value: incomeData[i].amount < incomeAmount / 20
                  ? incomeAmount / 20
                  : incomeData[i].amount,
              title: incomeData[i].amount < incomeAmount / 15 ? "..." : '其他',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    String type =
        (isShowingOutcome ? outcomeData[index].type : incomeData[index].type);
    String ratio = (((isShowingOutcome
                    ? outcomeData[index].amount
                    : incomeData[index].amount) /
                (isShowingOutcome ? outcomeAmount : incomeAmount)) *
            100)
        .toStringAsPrecision(3);
    return Container(
      height: 50,
      child: Indicator(
        color: touchedIndex == index
            ? (isShowingOutcome
                ? typeColor(outcomeData[index].type)
                : typeColor(incomeData[index].type))
            : (isShowingOutcome
                    ? typeColor(outcomeData[index].type)
                    : typeColor(incomeData[index].type))
                .withOpacity(0.6),
        text: ("投资收益" == type ? "投资" : type) + ("无支出" == type ? "" : ": " + ratio + "%"),
        size: touchedIndex == index ? 18 : 16,
        textColor: touchedIndex == index ? Colors.black54 : Colors.grey,
      ),
    );
  }

  Color typeColor(String type) {
    for (int i = 0;
        i <
            AppConfigManager
                .instance.incomeConfig.bookKeepingButtonConfig.length;
        i++) {
      if (type ==
          AppConfigManager
              .instance.incomeConfig.bookKeepingButtonConfig[i].type) {
        return Color(AlternativeColors.colorList[i + 9]);
      }
    }
    for (int i = 0;
        i <
            AppConfigManager
                .instance.outcomeConfig.bookKeepingButtonConfig.length;
        i++) {
      if (type ==
          AppConfigManager
              .instance.outcomeConfig.bookKeepingButtonConfig[i].type) {
        return Color(AlternativeColors.colorList[i]);
      }
    }
    return Colors.grey;
  }
}

class ChartMainData {
  String type;
  double amount;

  ChartMainData({this.type, this.amount});
}
