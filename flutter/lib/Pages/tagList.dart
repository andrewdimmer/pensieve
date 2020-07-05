import 'package:flutter/material.dart';
import 'package:pensieve/Classes/dataObjects.dart';

class TagList extends StatelessWidget {
  TagList({Key key, this.list, this.refreshList}) : super(key: key);

  final List<TagObject> list;
  final Function refreshList;

  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ReorderableListView(
        header: Text("Tags"),
        children: list
            .map(
              (item) => Text(item.tagName, key: UniqueKey()),
            )
            .toList(),
        onReorder: (index1, index2) {},
        padding: EdgeInsets.only(top: 16),
      ),
      onRefresh: refreshList,
    );
  }
}
