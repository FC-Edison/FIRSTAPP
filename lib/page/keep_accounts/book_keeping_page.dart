import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:xiao_yu_ji_zhang/logic/app/config/bookkeeping_button_config.dart';
import 'package:xiao_yu_ji_zhang/logic/app/config/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/manager.dart';
import 'package:xiao_yu_ji_zhang/page/main/page.dart';
import 'package:xiao_yu_ji_zhang/ui/selected_bar.dart';
import 'package:xiao_yu_ji_zhang/page/keep_accounts/selected_button.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class BookKeepingPage extends StatefulWidget {
  final bool isFromList;
  final InitInformation initInformation;
  final int buttonSelectedIndex;

  const BookKeepingPage({Key key, this.isFromList, this.initInformation, this.buttonSelectedIndex})
      : super(key: key);

  @override
  _BookKeepingPageState createState() => _BookKeepingPageState();
}

class _BookKeepingPageState extends State<BookKeepingPage> {
//日期时间变量
  int currentYear;
  int currentMonth;
  int currentDay;
  int currentHour;
  int currentMinute;
  int currentSecond;

//按钮Icon选项索引变量
  int buttonSelectedIndex;

//选择条选项索引变量
  int selectBarCurrentIndex = 0;

//选择条选项
  List<String> selectBarItems = ["支出", "收入"];


  ScrollController _scrollController;

  var amountController ;
  var remarkController ;

  @override
  void initState() {
    buttonSelectedIndex = widget.buttonSelectedIndex;
    currentYear = widget.isFromList
        ? DateTime.fromMillisecondsSinceEpoch(widget.initInformation.timeStamp)
            .year
        : DateTime.now().year;
    currentMonth = widget.isFromList
        ? DateTime.fromMillisecondsSinceEpoch(widget.initInformation.timeStamp)
            .month
        : DateTime.now().month;
    currentDay = widget.isFromList
        ? DateTime.fromMillisecondsSinceEpoch(widget.initInformation.timeStamp)
            .day
        : DateTime.now().day;
    currentHour = widget.isFromList
        ? DateTime.fromMillisecondsSinceEpoch(widget.initInformation.timeStamp)
            .hour
        : DateTime.now().hour;
    currentMinute = widget.isFromList
        ? DateTime.fromMillisecondsSinceEpoch(widget.initInformation.timeStamp)
            .minute
        : DateTime.now().minute;
    currentSecond = widget.isFromList
        ? DateTime.fromMillisecondsSinceEpoch(widget.initInformation.timeStamp)
            .second
        : DateTime.now().second;


    _scrollController = ScrollController()
      ..addListener(() => FocusScope.of(context).requestFocus(FocusNode()));

    amountController = widget.isFromList ? new TextEditingController(text: widget.initInformation.amount.toString()) :
    TextEditingController();
    remarkController = widget.isFromList ? new TextEditingController(text: widget.initInformation.remarks) :
    TextEditingController();

    super.initState();
  }

//决定输出按钮的Icon是支出按钮Icon还是收入按钮Icon
  BookKeepingButtonConfig get currentConfig => selectBarCurrentIndex == 0
      ? AppConfigManager.instance.outcomeConfig
      : AppConfigManager.instance.incomeConfig;

  void onSelectBarItemChange(int index) {
    setState(() {
      selectBarCurrentIndex = index;
    });
  }

  //按钮选择的逻辑
  String selectedType;

  Future<bool> save() async {
    if (double.tryParse(amountController.text) == null) {
      BotToast.showText(text: "金额输入有误！");
      amountController.clear();
      return false;
    } else {
      var response;
      if (currentYear == DateTime.now().year &&
          currentMonth == DateTime.now().month &&
          currentDay == DateTime.now().day) {
        response = await (selectBarCurrentIndex == 0
            ? BookKeepingManager.instance.outcome(
                DateTime.now().millisecondsSinceEpoch,
                double.parse(amountController.text),
                selectedType,
                remarkController.text,DateTime(currentYear,currentMonth,currentDay,currentHour,currentMinute,currentSecond))
            : BookKeepingManager.instance.income(
                DateTime.now().millisecondsSinceEpoch,
                double.parse(amountController.text),
                selectedType,
                remarkController.text,DateTime(currentYear,currentMonth,currentDay,currentHour,currentMinute,currentSecond)));
      } else {
        response = await (selectBarCurrentIndex == 0
            ? BookKeepingManager.instance.outcome(
                DateTime(currentYear, currentMonth, currentDay, currentHour,
                        currentMinute, currentSecond)
                    .millisecondsSinceEpoch,
                double.parse(amountController.text),
                selectedType,
                remarkController.text,DateTime(currentYear,currentMonth,currentDay,currentHour,currentMinute,currentSecond))
            : BookKeepingManager.instance.income(
                DateTime(currentYear, currentMonth, currentDay, currentHour,
                        currentMinute, currentSecond)
                    .millisecondsSinceEpoch,
                double.parse(amountController.text),
                selectedType,
                remarkController.text,DateTime(currentYear,currentMonth,currentDay,currentHour,currentMinute,currentSecond)));
      }
      if (response["success"]) {
        BotToast.showText(text: "保存成功");
        return true;
      } else {
        BotToast.showText(text: response["message"]);
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AlternativeColors.basicColor,
          centerTitle: true,
          title: Text(widget.isFromList ? '改一下' : '记一笔',style: TextStyle(fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          color: Colors.white,
          height: Get.size.height,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: AlternativeColors.basicColor,
                  child: SelectedBar(
                    currentIndex: widget.isFromList ? (widget.initInformation.isOutcome ? 0 : 1) : selectBarCurrentIndex,
                    items: selectBarItems,
                    onSelectedItemChange: onSelectBarItemChange,
                    height: 60,
                    borderColor: Colors.white,
                    selectedColor: Colors.white,
                    unselectedColor: AlternativeColors.basicColor,
                    padding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                ///日期选择框
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    height: 30,
                                    child: OutlinedButton(
                                        onPressed: () {
                                          Picker(
                                              confirmText: "确认",
                                              cancelText: "取消",
                                              confirmTextStyle:
                                              TextStyle(fontSize: 18),
                                              cancelTextStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                              adapter: DateTimePickerAdapter(
                                                  isNumberMonth: true,
                                                  yearBegin: 2018,
                                                  yearEnd: 2022,
                                                  value: DateTime(
                                                      currentYear,
                                                      currentMonth,
                                                      currentDay),
                                                  type: PickerDateTimeType.kYMD


                                              ),
                                              onConfirm:
                                                  (Picker picker, List value) {
                                                setState(() {
                                                  currentYear = 2018 + value[0];
                                                  currentMonth = value[1] + 1;
                                                  currentDay = value[2] + 1;
                                                });
                                              }).showModal(this.context);
                                        },
                                        child: Text('$currentMonth月$currentDay日',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        )),
                                  ),
                                ),


                                Expanded(
                                  child: Container(),
                                  flex: 1,
                                ),

                                ///金额输入框
                                Expanded(
                                    flex: 15,
                                    child: SizedBox(
                                      height: 30,
                                      child: TextField(
                                        controller: amountController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelStyle: TextStyle(fontSize: 14),
                                            labelText: "￥0.00",
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                            border: OutlineInputBorder()),
                                      ),
                                    ))
                              ],
                            ),
                          ),

                          ///按钮
                          Container(
                              color: Colors.white,
                              height: ((
                                  widget.isFromList ?  (widget.initInformation.isOutcome ?
                                  AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig.length :
                                  AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig.length) :
                                  currentConfig.bookKeepingButtonConfig.length) / 5) * 85,
                              child: GridView.count(
                                  primary: false,
                                  padding: const EdgeInsets.all(10),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 5,
                                  children: List.generate(
                                      widget.isFromList ?  (widget.initInformation.isOutcome ?
                                      AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig.length :
                                      AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig.length) :
                                      currentConfig.bookKeepingButtonConfig.length,
                                          (index) => SelectedButton(
                                        icon:
                                        widget.isFromList ?  (widget.initInformation.isOutcome ?
                                        AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[index].icon :
                                        AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[index].icon) :
                                        currentConfig.bookKeepingButtonConfig[index].icon,
                                        iconSel:
                                        widget.isFromList ?  (widget.initInformation.isOutcome ?
                                        AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[index].iconSel :
                                        AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[index].iconSel) :
                                        currentConfig.bookKeepingButtonConfig[index].iconSel,
                                        type:
                                        widget.isFromList ?  (widget.initInformation.isOutcome ?
                                        AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[index].type :
                                        AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[index].type) :
                                        currentConfig.bookKeepingButtonConfig[index].type,
                                        isSelected:
                                        buttonSelectedIndex == index,
                                        onTap: () {
                                          selectedType = currentConfig
                                              .bookKeepingButtonConfig[index]
                                              .type;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          setState(() {
                                            buttonSelectedIndex = index;
                                          });
                                        },
                                      )))),

                          ///备注输入框
                          Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: SizedBox(
                                height: 30,
                                child: TextFormField(
                                  controller: remarkController,
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(fontSize: 14),
                                      labelText: "备注：",
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      border: OutlineInputBorder()),
                                ),
                              ))
                        ],
                      ),
                    ),

                    ///底下俩按钮
                    Container(
                      color: Colors.white,
                      height: 260,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                                  minimumSize:
                                  MaterialStateProperty.all(Size(160, 40))),
                              onPressed: () async {
                                if (widget.isFromList) {
                                  var response = await BookKeepingManager.instance
                                      .delete( widget.initInformation.isOutcome ? true : false,
                                      widget.initInformation.timeStamp,DateTime(currentYear,currentMonth,currentDay,currentHour,currentMinute,currentSecond));
                                  if (response["success"]) {
                                    BotToast.showText(text: "删除成功");
                                  } else {
                                    BotToast.showText(text: response["message"]);
                                  }
                                  Get.back(result: DateTime(currentYear, currentMonth, currentDay, currentHour,
                                      currentMinute, currentSecond));
                                } else {
                                  if (await save()) {
                                    amountController.clear();
                                    remarkController.clear();
                                  }
                                }
                              },
                              child: Text(
                                (widget.isFromList ? '删除' : '保存再记'),
                                style: TextStyle(
                                    color: AlternativeColors.basicColor),
                              ),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AlternativeColors.basicColor),
                                    minimumSize:
                                    MaterialStateProperty.all(Size(160, 40))),
                                onPressed: () async {
                                  if (widget.isFromList) {
                                    if (double.tryParse(amountController.text) ==
                                        null) {
                                      BotToast.showText(text: "金额输入有误！");
                                      amountController.clear();
                                      return;
                                    }else if(buttonSelectedIndex == null){
                                      BotToast.showText(text: "请选择一个类型！");
                                      return;
                                    }
                                    var response =
                                    await BookKeepingManager.instance.modify(
                                        widget.initInformation.isOutcome ? true : false,
                                        widget.initInformation.timeStamp,
                                        DateTime(currentYear, currentMonth, currentDay, currentHour,
                                            currentMinute, currentSecond)
                                            .millisecondsSinceEpoch,
                                        (double.parse(amountController.text)),
                                        (widget.initInformation.isOutcome ?
                                        AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[buttonSelectedIndex].type :
                                        AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[buttonSelectedIndex].type) ,
                                        remarkController.text,DateTime(currentYear,currentMonth,currentDay,currentHour,currentMinute,currentSecond));
                                    if (response["success"]) {
                                      BotToast.showText(text: "保存成功");
                                    } else {
                                      BotToast.showText(
                                          text: response["message"]);
                                    }
                                  } else {
                                    if (await save()) {

                                    }
                                  }
                                  Get.back(result: DateTime(currentYear, currentMonth, currentDay, currentHour,
                                      currentMinute, currentSecond));
                                },
                                child: Text('保存')),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
