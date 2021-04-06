import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/logic/account/manager.dart';
import 'package:xiao_yu_ji_zhang/ui/selected_bar.dart';
import 'package:xiao_yu_ji_zhang/page/main/chart.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';
import 'package:xiao_yu_ji_zhang/page/keep_accounts/make_notes.dart';
import 'first_line.dart';

class MainPage extends StatefulWidget {

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: AccountManager.instance.logout,
      ),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AlternativeColors.basicColor,
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
                  return FirstLine();
                }
                //明细报表行
                else if (index == 1)
                  return SelectedBar(
                    currentIndex: selectBarCurrentIndex,
                    items: selectBarItems,
                    onSelectedItemChange: onSelectBarItemChange,
                    height: 40,
                    borderColor: AlternativeColors.basicColor,
                    selectedColor: AlternativeColors.basicColor,
                    unselectedColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                  );

                if (selectBarCurrentIndex == 0) {
                  if (index < entries.length + 1) {
                    return TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MakeNotes())
                        );
                      },
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
                  return ChartPage();
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeNotes())
                      );
                },
                child: Container(
                  height: 50,
                  width: 400,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: AlternativeColors.basicColor,
                        size: 30,
                      ),
                      Text('记一笔',
                          style: TextStyle(
                              color: AlternativeColors.basicColor, fontSize: 17)),
                    ],
                  )),
                ))
          ],
        ));
  }
}
