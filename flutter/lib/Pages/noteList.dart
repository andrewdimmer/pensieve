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
      this.onDelete,
      this.getTagName,
      this.getUnusedTags,
      this.addTag,
      this.removeTag})
      : super(key: key);

  final Widget header;
  final List<NoteObject> list;
  final Function handleReorder;
  final Function refreshList;
  final Function onToggleComplete;
  final Function onDelete;
  final Function getTagName;
  final Function getUnusedTags;
  final Function addTag;
  final Function removeTag;

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
                getTagName: getTagName,
                getUnusedTags: getUnusedTags,
                addTag: addTag,
                removeTag: removeTag,
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
