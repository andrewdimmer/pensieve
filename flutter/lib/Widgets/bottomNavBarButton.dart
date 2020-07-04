import 'package:flutter/material.dart';

class BottomNavBarButton extends StatelessWidget {
  BottomNavBarButton({Key key, this.label, this.callback}) : super(key: key);

  final String label;
  final Function callback;

  Widget build(BuildContext context) {
    return Padding(
      child: RaisedButton(
        child: Text(label),
        clipBehavior: Clip.antiAlias,
        autofocus: false,
        onPressed: callback,
        color: Colors.teal,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
