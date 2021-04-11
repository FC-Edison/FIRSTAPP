import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:xiao_yu_ji_zhang/ui/custom_settings/custom_data.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class FirstLine extends StatefulWidget {
  @override
  _FirstLineState createState() => _FirstLineState();
}

class _FirstLineState extends State<FirstLine> {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AlternativeColors.basicColor,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //左边：日期和支出
          Container(
            width: 210,
            color: AlternativeColors.basicColor,
            child: Row(
              children: [
                //日期
                Container(
                  width: 90,
                  color: AlternativeColors.basicColor,
                  child: TextButton(
                    onPressed: () {
                      Picker(
                              confirmText: "确认",
                              cancelText: "取消",
                              confirmTextStyle: TextStyle(fontSize: 18),
                              cancelTextStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              adapter: DateTimePickerAdapter(
                                yearBegin: 2018,
                                  yearEnd: 2022,
                                  months: CustomData.months,
                                  value: DateTime(currentYear, currentMonth),
                                  type: PickerDateTimeType.kYM),
                              onConfirm: (Picker picker, List value) {
                                setState(() {
                                  currentYear = 2018 + value[0];
                                  currentMonth = value[1] + 1;
                                });
                              }).showModal(this.context); //_scaffoldKey.currentState);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$currentYear年",
                          style: TextStyle(color: Colors.white,fontSize: 13),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: currentMonth > 10? "$currentMonth" : "0$currentMonth",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextSpan(text: "月",style: TextStyle(fontSize: 13)),
                        ])),
                        Container(
                          margin: EdgeInsets.all(2),
                          width: 20,
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 7,
                            height: 0,
                            decoration: new BoxDecoration(
                              border: Border(
                                // 四个值 top right bottom left
                                bottom: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                    style: BorderStyle.solid),
                                right: BorderSide(
                                    color: Colors.transparent,
                                    width: 3.25,
                                    style: BorderStyle.solid),
                                left: BorderSide(
                                    color: Colors.transparent,
                                    width: 3.25,
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //虚线
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      6,
                      (index) => Container(
                        width: 1,
                        height: 4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                //支出
                Container(
                  width: 90,
                  color: AlternativeColors.basicColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 60,
                        color: AlternativeColors.basicColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('支出(元)',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                )),
                            Text(
                              '33.0',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //右边：收入
          Container(
            width: 90,
            color: AlternativeColors.basicColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 60,
                  color: AlternativeColors.basicColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('收入(元)',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          )),
                      Text(
                        '0.0',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
