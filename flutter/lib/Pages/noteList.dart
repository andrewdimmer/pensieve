import 'package:flutter/material.dart';
import 'package:pensieve/Widgets/note.dart';

class NoteList extends StatelessWidget {
  NoteList({Key key, this.header, this.list, this.handleReorder})
      : super(key: key);

  final Widget header;
  final List<Map<String, String>> list;
  final Function handleReorder;

  Widget build(BuildContext context) {
    return ReorderableListView(
      header: header,
      children: list
          .map(
            (item) => Note(
              noteId: item["noteId"],
              content: item["content"],
              key: UniqueKey(),
            ),
          )
          .toList(),
      onReorder: handleReorder,
    );
  }
}
