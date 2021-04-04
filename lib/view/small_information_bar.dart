import 'package:flutter/material.dart';

class SmallInformationBar extends StatefulWidget {
  @override
  _SmallInformationBarState createState() => _SmallInformationBarState();
}

class _SmallInformationBarState extends State<SmallInformationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('   今天 星期日',style: TextStyle(color: Colors.black54,fontSize: 12)),
          Text('支出: 33.00   ',style: TextStyle(color: Colors.black54,fontSize: 12))
        ],
      ),
    );
  }
}
