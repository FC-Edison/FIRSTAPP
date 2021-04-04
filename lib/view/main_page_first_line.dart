import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/view/main.dart';
import 'package:flutter_picker/flutter_picker.dart';


class MainPageTopLine extends StatefulWidget {
  @override
  _MainPageTopLineState createState() => _MainPageTopLineState();
}

class _MainPageTopLineState extends State<MainPageTopLine> {

  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: XiaoYuApp.BASIC_COLOR,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          //左边：日期和支出
          Container(
            width: 210,
            color: XiaoYuApp.BASIC_COLOR,
            child: Row(
              children: [

                //日期
                Container(
                  width: 90,
                  color: XiaoYuApp.BASIC_COLOR,
                  child:TextButton(
                    onPressed: () {
                      Picker(
                            confirmText: "确认",
                            cancelText: "取消",
                            confirmTextStyle: TextStyle(),
                            cancelTextStyle: TextStyle(color: Colors.grey),
                            adapter:DateTimePickerAdapter(
                              type: PickerDateTimeType.kYM
                            ),
                            changeToFirst: true,
                            hideHeader: false,
                            onConfirm: (Picker picker, List value) {
                              setState(() {
                                currentYear = 1900 + value[0];
                                currentMonth = value[1] + 1;
                              });
                            }
                        ).showModal(this.context); //_scaffoldKey.currentState);
                    },
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$currentYear年", style: TextStyle(color: Colors.white),),
                        RichText(text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$currentMonth",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextSpan(
                              text: "月"
                            ),
                          ]
                        ))
                      ],
                    ),
                  ),
                ),

                //虚线
                Container(
                  height: 50,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:List.generate(6, (index) =>
                        Container(
                          width: 1,
                          height:4,
                          color: Colors.white,
                        ),
                    ),
                  ),
                ),


                //支出
                Container(
                  width: 90,
                  color: XiaoYuApp.BASIC_COLOR,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 60,
                        color: XiaoYuApp.BASIC_COLOR,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('支出(元)',style: TextStyle(fontSize: 13,color: Colors.white,)),

                            Text('33.0',style: TextStyle(fontSize: 17,color: Colors.white),)
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
            color: XiaoYuApp.BASIC_COLOR,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 60,
                  color: XiaoYuApp.BASIC_COLOR,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('收入(元)',style: TextStyle(fontSize: 13,color: Colors.white,)),

                      Text('0.0',style: TextStyle(fontSize: 17,color: Colors.white),)
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
