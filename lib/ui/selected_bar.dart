import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onSelectedItemChange;
  final List<String> items;
  final double height;
  final Color borderColor;
  final Color selectedColor;
  final EdgeInsetsGeometry padding;
  final Color unselectedColor;

  SelectedBar({this.currentIndex,this.items,this.onSelectedItemChange,this.height, this.borderColor, this.selectedColor, this.padding, this.unselectedColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: CupertinoSegmentedControl(
        padding: padding,
        groupValue:currentIndex,
        borderColor: borderColor,
        onValueChanged: onSelectedItemChange,
        selectedColor: selectedColor,
        unselectedColor: unselectedColor,
        children: Map.fromIterable(items,key: (item) => items.indexOf(item), value: (item) => Text(item)),
      ),
    );
  }
}