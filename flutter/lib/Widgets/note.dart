import 'package:flutter/material.dart';
import 'package:pensieve/Classes/dataObjects.dart';

class Note extends StatelessWidget {
  Note({Key key, this.note, this.onToggleComplete, this.onDelete})
      : super(key: key);

  final NoteObject note;
  final Function onToggleComplete;
  final Function onDelete;

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
                  child: Text(note.content),
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
        background: note.complete
            ? dismissBackground(Colors.red, Colors.black, Icons.delete,
                "Delete", MainAxisAlignment.start)
            : dismissBackground(Colors.green, Colors.black, Icons.check,
                "Completed", MainAxisAlignment.start),
        secondaryBackground: note.complete
            ? dismissBackground(Colors.green, Colors.black, Icons.check,
                "Current", MainAxisAlignment.end)
            : dismissBackground(Colors.red, Colors.black, Icons.delete,
                "Delete", MainAxisAlignment.end),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            note.complete
                ? onDelete(note.noteId, note.complete)
                : onToggleComplete(note.noteId, note.complete);
          } else {
            note.complete
                ? onToggleComplete(note.noteId, note.complete)
                : onDelete(note.noteId, note.complete);
          }
        }));
  }
}

Widget dismissBackground(Color backgroundColor, Color accentColor,
    IconData icon, String label, MainAxisAlignment alignment) {
  return Container(
    child: Row(
      children: alignment == MainAxisAlignment.start
          ? [
              Padding(
                child: Icon(
                  icon,
                  color: accentColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Text(
                label,
                style: TextStyle(color: accentColor),
              ),
            ]
          : [
              Text(
                label,
                style: TextStyle(color: accentColor),
              ),
              Padding(
                child: Icon(
                  icon,
                  color: accentColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ],
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
    ),
    color: backgroundColor,
    margin: EdgeInsets.symmetric(vertical: 16),
  );
}
