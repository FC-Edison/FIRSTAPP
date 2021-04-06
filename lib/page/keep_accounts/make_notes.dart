import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/ui/selected_bar.dart';
import 'package:xiao_yu_ji_zhang/page/keep_accounts/selected_button.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class MakeNotes extends StatefulWidget {
  @override
  _MakeNotesState createState() => _MakeNotesState();
}

class _MakeNotesState extends State<MakeNotes> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
  ];
  int buttonSelectedIndex;

  int selectBarCurrentIndex = 0;
  List<String> selectBarItems = ["支出", "收入"];

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() => FocusScope.of(context).requestFocus(FocusNode()));
    super.initState();
  }

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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 30,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: Text("4月5日"),
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
                                    child: TextField(
                                      decoration: InputDecoration(
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
                            height: 170,
                            child: GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(10),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 5,
                                children: List.generate(10,
                                    (index) => SelectedButton(
                                      isSelected: buttonSelectedIndex == index,
                                      onTap: () {
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
                              child: TextField(
                                decoration: InputDecoration(
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
                    height: 300,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),minimumSize: MaterialStateProperty.all(Size(160,40))),
                            onPressed: () {},
                            child: Text('保存再记', style: TextStyle(color: AlternativeColors.basicColor),),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AlternativeColors.basicColor),minimumSize: MaterialStateProperty.all(Size(160,40))),
                              onPressed: () {
                                Navigator.pop(context);
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
