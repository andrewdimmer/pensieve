import 'package:flutter/material.dart';
import 'package:pensieve/Widgets/bottomNavBarButton.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar(
      {Key key,
      this.leftLabel,
      this.rightLabel,
      this.leftCallback,
      this.rightCallback})
      : super(key: key);

  final String leftLabel;
  final String rightLabel;
  final Function leftCallback;
  final Function rightCallback;

  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        color: Colors.blue,
        child: Row(
          children: <Widget>[
            BottomNavBarButton(
              label: leftLabel,
              callback: leftCallback,
            ),
            BottomNavBarButton(
              label: rightLabel,
              callback: rightCallback,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
