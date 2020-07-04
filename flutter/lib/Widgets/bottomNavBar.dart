import 'package:flutter/material.dart';
import 'package:pensieve/Widgets/bottomNavBarButton.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key key, this.propsList}) : super(key: key);

  final List<BottomNavBarButtonProps> propsList;

  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        color: Colors.blue,
        child: Row(
          children: propsList
              .map(
                (buttonProps) => Container(
                  child: BottomNavBarButton(
                    props: buttonProps,
                  ),
                  alignment: Alignment.center,
                  width: 200, // TODO: Make 1/nth of the screen later
                ),
              )
              .toList(),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
