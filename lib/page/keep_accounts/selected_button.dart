import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class SelectedButton extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final String icon;
  final String iconSel;
  final String type;

  const SelectedButton(
      {Key key,
      this.isSelected = false,
      this.onTap,
      this.icon,
      this.iconSel,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 55,
        height: 55,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 44,
                  height: 44,
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                      color: isSelected
                          ? AlternativeColors.basicColor
                          : Colors.white,
                      border: Border.all(
                          width: 1,
                          color: isSelected
                              ? AlternativeColors.basicColor
                              : Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(22))),
                  child: Center(
                    child: Image.network(isSelected ? iconSel : icon,width: 22,),
                  )),
              Text(
                type,
                style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? AlternativeColors.basicColor
                        : Colors.black54),
              )
            ]),
      ),
    );
  }
}
