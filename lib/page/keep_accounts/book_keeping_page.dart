import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:xiao_yu_ji_zhang/logic/app/config/bookkeeping_button_config.dart';
import 'package:xiao_yu_ji_zhang/logic/app/config/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/money/manager.dart';
import 'package:xiao_yu_ji_zhang/ui/custom_settings/custom_data.dart';
import 'package:xiao_yu_ji_zhang/ui/selected_bar.dart';
import 'package:xiao_yu_ji_zhang/page/keep_accounts/selected_button.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class BookKeepingPage extends StatefulWidget {
  @override
  _BookKeepingPageState createState() => _BookKeepingPageState();
}

class _BookKeepingPageState extends State<BookKeepingPage> {
//日期时间变量
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int currentDay = DateTime.now().day;
//按钮Icon选项索引变量
  int buttonSelectedIndex;
//选择条选项索引变量
  int selectBarCurrentIndex = 0;
  //选择条选项
  List<String> selectBarItems = ["支出", "收入"];
//
  ScrollController _scrollController;

  final amountController = TextEditingController();
  final remarkController = TextEditingController();

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() => FocusScope.of(context).requestFocus(FocusNode()));
    super.initState();
  }

//决定输出按钮的Icon是支出按钮Icon还是收入按钮Icon
  BookKeepingButtonConfig get currentConfig => selectBarCurrentIndex == 0 ? AppConfigManager.instance.outcomeConfig : AppConfigManager.instance.incomeConfig;

  void onSelectBarItemChange(int index) {
    setState(() {
      selectBarCurrentIndex = index;
    });
  }
  //按钮选择的逻辑
  String selectedType;
  Future<bool> save() async {
    if(double.tryParse(amountController.text) == null){
      BotToast.showText(text: "金额输入有误！");
      amountController.clear();
      return false;
    }else{
      var response = await (selectBarCurrentIndex == 0 ? MoneyManager.instance.outcome(DateTime(currentYear, currentMonth, currentDay).microsecondsSinceEpoch, double.parse(amountController.text), selectedType, remarkController.text) : MoneyManager.instance.income(DateTime(currentYear, currentMonth, currentDay).microsecondsSinceEpoch, double.parse(amountController.text), selectedType, remarkController.text));
      if(response["success"]){
        BotToast.showText(text: "保存成功");
        return true;
      }else{
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
          title: Text('记账本')),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: AlternativeColors.basicColor,
                child: SelectedBar(
                  currentIndex: selectBarCurrentIndex,
                  items: selectBarItems,
                  onSelectedItemChange: onSelectBarItemChange,
                  height: 60,
                  borderColor: Colors.white,
                  selectedColor: Colors.white,
                  unselectedColor: AlternativeColors.basicColor,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 30,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Picker(
                                          confirmText: "确认",
                                          cancelText: "取消",
                                          confirmTextStyle: TextStyle(fontSize: 18),
                                          cancelTextStyle: TextStyle(fontSize:18,color: Colors.grey),
                                          adapter:DateTimePickerAdapter(
                                            months: CustomData.months,
                                            yearBegin: 2018,
                                              yearEnd: 2022,
                                              value: DateTime(currentYear, currentMonth, currentDay),
                                              type: PickerDateTimeType.kYMD
                                          ),
                                          onConfirm: (Picker picker, List value) {
                                            setState(() {
                                              currentYear = 2018 + value[0];
                                              currentMonth = value[1] + 1;
                                              currentDay = value[2] + 1;
                                            });
                                          }
                                      ).showModal(this.context);
                                    },
                                    child: Text('$currentMonth月$currentDay日',style: TextStyle(color: Colors.black54,fontSize: 14),)
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                                flex: 1,
                              ),
                              Expanded(
                                  flex: 15,
                                  child: SizedBox(
                                    height: 30,
                                    child: TextFormField(
                                      controller: amountController,
                                      keyboardType: TextInputType.number,
                                      // controller: amountController,
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
                        Container(
                            color: Colors.white,
                            height: ((currentConfig.bookKeepingButtonConfig.length) / 5) * 85,
                            child: GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(10),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 5,
                                children: List.generate(currentConfig.bookKeepingButtonConfig.length,
                                    (index) => SelectedButton(
                                      icon: currentConfig.bookKeepingButtonConfig[index].icon,
                                      iconSel: currentConfig.bookKeepingButtonConfig[index].iconSel,
                                      type: currentConfig.bookKeepingButtonConfig[index].type,
                                      isSelected: buttonSelectedIndex == index,
                                      onTap: () {
                                        selectedType = AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[index].type;
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        setState(() {
                                          buttonSelectedIndex = index;
                                        });
                                      },
                                    )))),
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
                  Container(
                    color: Colors.white,
                    height: 300,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),minimumSize: MaterialStateProperty.all(Size(160,40))),
                              onPressed: () async {
                              if(await save()){
                                amountController.clear();
                                remarkController.clear();
                              }
                            },
                            child: Text('保存再记', style: TextStyle(color: AlternativeColors.basicColor),),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AlternativeColors.basicColor),minimumSize: MaterialStateProperty.all(Size(160,40))),
                              onPressed: () async {
                                if(await save()){
                                  Get.back();
                                }
                              },
                              child:
                                  Text('保存')),
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
    );
  }
}
