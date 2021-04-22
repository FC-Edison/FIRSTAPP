import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:xiao_yu_ji_zhang/logic/account/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/app/config/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/controller.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/page/main/listCell.dart';
import 'package:xiao_yu_ji_zhang/ui/selected_bar.dart';
import 'package:xiao_yu_ji_zhang/page/main/chart.dart';
import 'package:xiao_yu_ji_zhang/ui/small_information_bar.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';
import 'package:xiao_yu_ji_zhang/page/keep_accounts/book_keeping_page.dart';

class InitInformation{
  final bool isOutcome;
  final int timeStamp;
  final double amount;
  final String type;
  final String remarks;

  InitInformation(this.isOutcome, {this.timeStamp, this.amount, this.type, this.remarks});
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final DetailDataController detailController = Get.find();

  int selectBarCurrentIndex = 0;
  List<String> selectBarItems = ["明细", "报表"];

  void onSelectBarItemChange(int index) {
    setState(() {
      selectBarCurrentIndex = index;
    });
  }

  ///记一笔之后回到主页面主页面显示记一笔的时间
  DateTime timeTo;

  ///把天数不同的信息分开放进一个list里
  List<List<DetailListItem>> get cellAddInforBar{
    List<List<DetailListItem>> list = List<List<DetailListItem>>();
      list.add(List<DetailListItem>());
    for(int i = 0;i < detailController.detailList.length - 1;i++){
      list.last.add(detailController.detailList[i]);
      if((DateTime.fromMillisecondsSinceEpoch(detailController.detailList[i].timeStamp).day) != (DateTime.fromMillisecondsSinceEpoch(detailController.detailList[i + 1].timeStamp).day)){
        list.add(List<DetailListItem>());
      }
    }
    list.last.add(detailController.detailList.last);
    return list;
  }

  ///是否加信息条
  bool isNeedInforBar (DetailListItem item){
    for(int i = 0; i < cellAddInforBar.length;i++){
      if(item.timeStamp == cellAddInforBar[i].last.timeStamp){
        return true;
      }
    }
    return false;
  }

  ///应该选择cellAddInforBar这个二维数组的哪个index传进信息条中
  int inforBarIndex (DetailListItem item){
    for(int i = 0;i < cellAddInforBar.length;i++){
      for(int j = 0;j < cellAddInforBar[i].length;j++){
        if(item.timeStamp == cellAddInforBar[i][j].timeStamp){
          return i;
        }
      }
    }
    return -1;
  }

  int indexFromType(DetailListItem item){
    if(item.type == "其他"){
      if(item.isOutcome){
        return 9;
      }else{
        return 4;
      }
    }
    for(int i = 0;i < AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig.length;i++){
      if(item.type == AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[i].type){
        return i;
      }
    }

    for(int i = 0;i < AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig.length;i++){
      if(item.type == AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[i].type){
        return i;
      }
    }
    return -1;
  }

  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AlternativeColors.basicColor,
          child: Icon(Icons.logout),
          onPressed: () {
            AccountManager.instance.logout();
          },
        ),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AlternativeColors.basicColor,
            title: Center(
              child: Text('记账本',style: TextStyle(fontWeight: FontWeight.bold)),
            )),
        body: Stack(
          alignment: const FractionalOffset(0.5, 1.0),
          children: [
            Obx(() => ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: selectBarCurrentIndex == 0 ? (detailController.detailList.isEmpty ?
                                                        0 : (detailController.detailList.length + 1)) + 3 : 3,
              itemBuilder: (BuildContext context, int index) {
                //日期支出收入行
                if (index == 0) {
                  return
                    // FirstLine(timeTo: timeTo);
                    Container(
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
                                    onPressed: () async {
                                      timeTo = null;
                                      Picker(
                                          confirmText: "确认",
                                          cancelText: "取消",
                                          confirmTextStyle: TextStyle(fontSize: 18),
                                          cancelTextStyle:
                                          TextStyle(fontSize: 18, color: Colors.grey),
                                          adapter: DateTimePickerAdapter(
                                              yearBegin: 2018,
                                              yearEnd: 2022,
                                              isNumberMonth: true,
                                              value: DateTime(currentYear, currentMonth) ,
                                              type: PickerDateTimeType.kYM),
                                          onConfirm: (Picker picker, List value) async {
                                            setState(() {
                                              currentYear = 2018 + value[0];
                                              currentMonth = value[1] + 1;
                                            });
                                            await BookKeepingManager.instance.sync(DateTime(currentYear,currentMonth));
                                          }).showModal(this.context);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          (timeTo) == null ? "$currentYear年" : timeTo.year.toString() + "年",
                                          style: TextStyle(color: Colors.white,fontSize: 13),
                                        ),
                                        RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: currentMonth >= 10? ((timeTo) == null ? "$currentMonth" : timeTo.month.toString()) :
                                                ((timeTo) == null ? "0$currentMonth" : "0" + timeTo.month.toString()),
                                                // "$currentMonth" : "0$currentMonth",
                                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
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
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),

                                //支出
                                Container(
                                  width: 110,
                                  color: AlternativeColors.basicColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 88,
                                        color: AlternativeColors.basicColor,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('支出 (元)',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                )),
                                            Text(
                                                (detailController.outcomeAmount.toDouble() - detailController.incomeAmount.toDouble()).toPrecision(2).toString(),
                                              maxLines: 1,
                                              style:
                                              TextStyle(fontSize: 14, color: Colors.white),
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
                              width: 100,
                              color: AlternativeColors.basicColor,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('收入 (元)',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      detailController.incomeAmount.toDouble().toPrecision(2).toString(),
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    );
                }
                //明细报表行
                else if (index == 1)
                  return Container(
                    width: Get.size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SelectedBar(
                          currentIndex: selectBarCurrentIndex,
                          items: selectBarItems,
                          onSelectedItemChange: onSelectBarItemChange,
                          height: 40,
                          borderColor: AlternativeColors.basicColor,
                          selectedColor: AlternativeColors.basicColor,
                          unselectedColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        ),
                        (detailController.detailList.isNotEmpty && index == 1 && selectBarCurrentIndex == 0) ? SmallInformationBar(cellInforBar:cellAddInforBar[0]) : Container()
                      ],
                    ),
                  );


                if (selectBarCurrentIndex == 0) {
                  if (index < (detailController.detailList.isEmpty ? 0 : (detailController.detailList.length + 1))  + 2) {
                    var cellIndex = index - 3;
                    if(detailController.detailList.isNotEmpty && index == 2){
                      return Container();
                    }

                    return Container(child: Column(children: [
                      (index == (detailController.detailList.length + 2)) ?
                      TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () async {
                            DetailListItem item = detailController.detailList[cellIndex];
                            timeTo = await Get.to<DateTime>(() => BookKeepingPage(isFromList: true,initInformation: InitInformation(
                                item.isOutcome,
                                timeStamp: item.timeStamp,
                                amount: item.amount,
                                type: item.type,
                                remarks: item.remarks
                            ),
                              buttonSelectedIndex: indexFromType(item),
                            ));
                          },
                          child: ListCell(item: detailController.detailList[cellIndex]) )
                          : Column(
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                    ),
                                    onPressed: () async {
                                      DetailListItem item = detailController.detailList[cellIndex];
                                      timeTo = await Get.to<DateTime>(() => BookKeepingPage(isFromList: true,initInformation: InitInformation(
                                          item.isOutcome,
                                          timeStamp: item.timeStamp,
                                          amount: item.amount,
                                          type: item.type,
                                          remarks: item.remarks
                                      ),
                                        buttonSelectedIndex: indexFromType(item),
                                      ));
                                    },
                                    child: ListCell(item: detailController.detailList[cellIndex]) ),
                                !isNeedInforBar(detailController.detailList[cellIndex]) ?
                                Container() : SmallInformationBar(cellInforBar:
                                cellAddInforBar[inforBarIndex(detailController.detailList[cellIndex + 1])])
                              ]
                          )
                    ],),);
                  }
                  return Container(
                    alignment: Alignment.topCenter,
                    height: 80,
                    child:Text("本月没有更多了!" ,style: TextStyle(fontSize: 12,color: Colors.black54),),

                  );
                } else {
                  return ChartPage();
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(
                height: 0.5,
              ),
            )),
            TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(BorderSide(
                        width: 1, color: Color.fromARGB(255, 200, 200, 200)))
                    // elevation: MaterialStateProperty.all(3)
                    ),
                onPressed: () async {
                  timeTo = await Get.to<DateTime>(() => BookKeepingPage(isFromList: false));
                },
                child: Container(
                  height: 50,
                  width: Get.size.width,
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
                          style: TextStyle(color: AlternativeColors.basicColor, fontSize: 17,fontWeight: FontWeight.bold)),
                        ],
                  )),
                ))
          ],
        ));
  }
}
