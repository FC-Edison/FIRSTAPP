import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';
import 'indicator.dart';

class MyPieChart extends StatefulWidget {
  final int tabBarIndex;
  final List<DetailChartItem> list;
  const MyPieChart({Key key, this.tabBarIndex, this.list}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State<MyPieChart> {
  int touchedIndex;
  bool isShowingOutcome;
  List<DetailChartItem> list;
  int tabBarIndex;
  @override
  void initState() {
    super.initState();
    tabBarIndex = widget.tabBarIndex;
    isShowingOutcome = true;
    list = widget.list;
  }

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
                        isShowingOutcome
                            ? PieChartData(
                                pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    final desiredTouch = pieTouchResponse
                                            .touchInput is! PointerExitEvent &&
                                        pieTouchResponse.touchInput
                                            is! PointerUpEvent;
                                    if (desiredTouch &&
                                        pieTouchResponse.touchedSection !=
                                            null) {
                                      touchedIndex = pieTouchResponse
                                          .touchedSection.touchedSectionIndex;
                                    } else {
                                      touchedIndex = -1;
                                    }
                                  });
                                }),
                                startDegreeOffset: 100,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 8,
                                centerSpaceRadius: 50,
                                sections: outcomeChart())
                            : PieChartData(
                                pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    final desiredTouch = pieTouchResponse
                                            .touchInput is! PointerExitEvent &&
                                        pieTouchResponse.touchInput
                                            is! PointerUpEvent;
                                    if (desiredTouch &&
                                        pieTouchResponse.touchedSection !=
                                            null) {
                                      touchedIndex = pieTouchResponse
                                          .touchedSection.touchedSectionIndex;
                                    } else {
                                      touchedIndex = -1;
                                    }
                                  });
                                }),
                                startDegreeOffset: -160,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 8,
                                centerSpaceRadius: 50,
                                sections: incomeChart()),
                        swapAnimationDuration:
                            const Duration(milliseconds: 250)),
                    Center(
                        child: TextButton(
                            onPressed: () {
                            //TODO
                              setState(() {
                             isShowingOutcome = !isShowingOutcome;
                              });
                             print("1");
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
                                      color: Colors.lightBlueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,),
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
                  isShowingOutcome ? "支出: 15215.2(元)" : "收入: 15215.2(元)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                ),
                Indicator(
                  color: touchedIndex == 0
                      ? Color(0xff0293ee)
                      : Color(0xff0293ee).withOpacity(0.6),
                  text: '餐饮: 24%',
                  size: touchedIndex == 0 ? 18 : 16,
                  textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: touchedIndex == 1
                      ? Color(0xfff8b250)
                      : Color(0xfff8b250).withOpacity(0.6),
                  text: '娱乐',
                  size: touchedIndex == 1 ? 18 : 16,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: touchedIndex == 2
                      ? Color(0xff845bef)
                      : Color(0xff845bef).withOpacity(0.6),
                  text: '购物',
                  size: touchedIndex == 2 ? 18 : 16,
                  textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: touchedIndex == 3
                      ? Color(0xff13d38e)
                      : Color(0xff13d38e).withOpacity(0.6),
                  text: '其他',
                  size: touchedIndex == 3 ? 18 : 16,
                  textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
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
    return List.generate(
      5,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Color(0xff0293ee).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: Color(0xfff8b250).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: Color(0xff845bef).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
            );
          case 3:
            return PieChartSectionData(
              color: Color(0xff13d38e).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          case 4:
            return PieChartSectionData(
              color: const Color(0xff53d385).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }

  List<PieChartSectionData> incomeChart() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Color(0xff0293ee).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: Color(0xfff8b250).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: Color(0xff845bef).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
            );
          case 3:
            return PieChartSectionData(
              color: Color(0xff13d38e).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          case 4:
            return PieChartSectionData(
              color: const Color(0xff53d385).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 40,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }
}
