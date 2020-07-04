import 'package:flutter/material.dart';

class BottomNavBarButton extends StatelessWidget {
  BottomNavBarButton({Key key, this.props}) : super(key: key);

  final BottomNavBarButtonProps props;

  Widget build(BuildContext context) {
    return Padding(
      child: RaisedButton(
        child: Text(props.label),
        clipBehavior: Clip.antiAlias,
        autofocus: false,
        onPressed: props.callback,
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

class BottomNavBarButtonProps {
  BottomNavBarButtonProps({this.label, this.callback});

  final String label;
  final Function callback;
}
