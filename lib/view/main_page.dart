import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/view/main.dart';
import 'package:xiao_yu_ji_zhang/view/main_page_first_line.dart';
import 'package:xiao_yu_ji_zhang/view/selected_bar.dart';

class MainPage extends StatefulWidget {
  static int selectedTable = 1;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C',
    'B',
    'C'
  ];

  int selectBarCurrentIndex = 0;
  List<String> selectBarItems = ["明细", "报表"];

  void onSelectBarItemChange(int index) {
    setState(() {
      selectBarCurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: XiaoYuApp.BASIC_COLOR,
            title: Center(
              child: Text('记账本'),
            )),
        body: Stack(
          alignment: const FractionalOffset(0.5, 1.0),
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: selectBarCurrentIndex == 0 ? entries.length + 2 : 3,
              itemBuilder: (BuildContext context, int index) {
                //日期支出收入行
                if (index == 0) {
                  return MainPageTopLine();
                }

                //明细报表行
                else if (index == 1)
                  return SelectedBar(
                    currentIndex: selectBarCurrentIndex,
                    items: selectBarItems,
                    onSelectedItemChange: onSelectBarItemChange,
                  );

                if (selectBarCurrentIndex == 0) {
                  if (index < entries.length + 1) {
                    return TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {},
                      child: Container(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 180,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.agriculture_rounded,
                                    ),
                                    Text(
                                      '餐饮-aaaaaa',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                child: Text(
                                  '-22.00',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                ),
                              )
                            ],
                          )),
                    );
                  }
                  return Container(
                    height: 80,
                  );
                } else {
                  return Container();
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 0,
              ),
            ),
            TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(BorderSide(
                        width: 1, color: Color.fromARGB(255, 200, 200, 200)))
                    // elevation: MaterialStateProperty.all(3)
                    ),
                onPressed: () {},
                child: Container(
                  height: 50,
                  width: 400,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: XiaoYuApp.BASIC_COLOR,
                        size: 30,
                      ),
                      Text('记一笔',
                          style: TextStyle(
                              color: XiaoYuApp.BASIC_COLOR, fontSize: 17)),
                    ],
                  )),
                ))
          ],
        ));
  }
}
