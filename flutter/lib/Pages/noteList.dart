import 'package:flutter/material.dart';
import 'package:pensieve/Classes/dataObjects.dart';
import 'package:pensieve/Database/getNotes.dart';
import 'package:pensieve/Widgets/note.dart';

class NoteList extends StatelessWidget {
  NoteList(
      {Key key, this.header, this.list, this.handleReorder, this.refreshList})
      : super(key: key);

  final Widget header;
  final List<NoteObject> list;
  final Function handleReorder;
  final Function refreshList;

  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ReorderableListView(
        header: header,
        children: list
            .map(
              (item) => Note(
                noteId: item.noteId,
                content: item.content,
                key: UniqueKey(),
              ),
            )
            .toList(),
        onReorder: handleReorder,
        padding: EdgeInsets.only(top: 16),
      ),
      onRefresh: refreshList,
    );
  }
}
