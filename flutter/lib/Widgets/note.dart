import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  Note({Key key, this.noteId, this.content}) : super(key: key);

  final String noteId;
  final String content;

  Widget build(BuildContext context) {
    return (Dismissible(
        child: Card(
          child: Container(
            child: Row(
              children: [
                Padding(
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32)),
                Expanded(
                  child: Text(content),
                ),
                Padding(
                    child: IconButton(
                      icon: Icon(Icons.drag_handle),
                      onPressed: () {},
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32)),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            constraints: BoxConstraints.expand(
                height:
                    96), // Center the icon buttons; does not expand for the text.
          ),
          elevation: 2,
          margin: EdgeInsets.all(16),
        ),
        key: UniqueKey(),
        background: Container(
          child: Row(
            children: [
              Padding(
                child: Icon(
                  Icons.check,
                  color: Colors.green[900],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Text(
                "Mark as Complete",
                style: TextStyle(color: Colors.green[900]),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          color: Colors.green,
          margin: EdgeInsets.symmetric(vertical: 16),
        ),
        secondaryBackground: Container(
          child: Row(
            children: [
              Text(
                "Delete",
                style: TextStyle(color: Colors.red[900]),
              ),
              Padding(
                child: Icon(
                  Icons.delete,
                  color: Colors.red[900],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          color: Colors.red,
          margin: EdgeInsets.symmetric(vertical: 16),
        ),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Swipe Right'),
              duration: Duration(seconds: 1, milliseconds: 50),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ));
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Swipe Left'),
              duration: Duration(seconds: 1, milliseconds: 50),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));
          }
        }));
  }
}
