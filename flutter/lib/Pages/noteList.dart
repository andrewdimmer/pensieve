import 'package:flutter/material.dart';
import 'package:pensieve/Classes/dataObjects.dart';
import 'package:pensieve/Widgets/note.dart';

class NoteList extends StatelessWidget {
  NoteList(
      {Key key,
      this.header,
      this.list,
      this.handleReorder,
      this.refreshList,
      this.onToggleComplete,
      this.onDelete})
      : super(key: key);

  final Widget header;
  final List<NoteObject> list;
  final Function handleReorder;
  final Function refreshList;
  final Function onToggleComplete;
  final Function onDelete;

  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ReorderableListView(
        header: header,
        children: list
            .map(
              (item) => Note(
                note: item,
                onToggleComplete: onToggleComplete,
                onDelete: onDelete,
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
