import 'package:flutter/material.dart';
import 'package:xiao_yu_ji_zhang/logic/app/config/manager.dart';
import 'package:xiao_yu_ji_zhang/logic/book_keeping/model.dart';
import 'package:xiao_yu_ji_zhang/ui/ui.dart';

class ListCell extends StatelessWidget {
  final DetailListItem item;

  const ListCell({Key key, this.item}) : super(key: key);

  List<int> get colorList => [0xccff8303,0xccc67ace,0xcc0e49b5,0xccd7385e,0xcc0e918c,0xcc6a097d,0xeeec0101,0xffff5722,0xff7fdbda,0xff1b6ca8,0xffb590ca,0xffbaf1a1,0xfff1935c,0xff916dd5];

  Color typeColor (String type){
    for(int i = 0;i < AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig.length;i++){
      if(type == AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[i].type){
        return Color(colorList[i + 9]);
      }

    }
    for(int i = 0;i < AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig.length;i++){
      if(type == AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[i].type){
        return Color(colorList[i]);
      }
    }
    return null;
  }
  
  String typeIcon (String type){
    for(int i = 0;i < AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig.length;i++){
      if(type == AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[i].type){
        return AppConfigManager.instance.incomeConfig.bookKeepingButtonConfig[i].iconSel;
      }

    }
    for(int i = 0;i < AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig.length;i++){
      if(type == AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[i].type){
        return AppConfigManager.instance.outcomeConfig.bookKeepingButtonConfig[i].iconSel;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 14),
                  Container(
                    width: 48,
                    child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            color:  typeColor(item.type),
                            borderRadius: BorderRadius.all(Radius.circular(24))),
                        child: Center(
                          child: Image.network(typeIcon(item.type) ,width: 25,),
                        )),
                  ),
                  Container(width: 12),
                  //列表文字描述
                  Container(
                    // width: 80,
                    child: RichText(
                      maxLines: 1,
                      text: TextSpan(children: [
                        TextSpan(
                            text: item.type,
                            style: TextStyle(color: Colors.black54, fontSize: 14)),
                        TextSpan(
                          text: item.remarks == "" ? "" : " - " + item.remarks,
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        )
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // width: 120,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      // width: 100,
                      alignment: Alignment.centerRight,
                      child: Text(
                        //列表价格
                        ((item.isOutcome == true ? " - " : " + ") + item.amount.toPrecision(2).toString()),
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                        maxLines: 1,
                      ),
                    )),
                Container(width: 14),
              ],
            )
          ],
        ));
  }
}
