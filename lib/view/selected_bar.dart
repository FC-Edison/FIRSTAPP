import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/view/main.dart';
class SelectedBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onSelectedItemChange;
  final List<String> items;

  SelectedBar({this.currentIndex,this.items,this.onSelectedItemChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: CupertinoSegmentedControl(
        padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
        groupValue:currentIndex,
        borderColor: XiaoYuApp.BASIC_COLOR,
        onValueChanged: onSelectedItemChange,
        selectedColor: XiaoYuApp.BASIC_COLOR,
        children: Map.fromIterable(items,key: (item) => items.indexOf(item), value: (item) => Text(item)),
      ),
    );
  }
}