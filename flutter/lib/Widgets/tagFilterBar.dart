import 'package:flutter/material.dart';
import 'package:pensieve/Classes/dataObjects.dart';

class TagFilterBar extends StatelessWidget {
  TagFilterBar(
      {Key key,
      this.title,
      this.filterOptions,
      this.addTagToFilter,
      this.removeTagFromFilter})
      : super(key: key);

  final String title;
  final FilterOptions filterOptions;
  final Function addTagToFilter;
  final Function removeTagFromFilter;

  List<Widget> getFilterWidgets() {
    List<Widget> widgets = [
      Text(
        "Filters:",
        style: TextStyle(fontSize: 20),
      )
    ];
    widgets.addAll(filterOptions.tags.map((tagObject) {
      if (filterOptions.activeFilters.contains(tagObject.tagId)) {
        return Padding(
          child: Chip(
            label: Text(
              tagObject.tagName,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            deleteIconColor: Colors.white,
            onDeleted: () {
              removeTagFromFilter(tagObject.tagId);
            },
          ),
          padding: EdgeInsets.all(8),
        );
      } else {
        return Padding(
          child: Chip(
            label: Text(tagObject.tagName),
            deleteButtonTooltipMessage: "Add",
            deleteIcon: Icon(Icons.add_circle, size: 18),
            onDeleted: () {
              addTagToFilter(tagObject.tagId);
            },
          ),
          padding: EdgeInsets.all(8),
        );
      }
    }));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
              child: Text(
            title,
            style: TextStyle(fontSize: 32),
          )),
          Row(
            children: getFilterWidgets(),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
    );
  }
}

class FilterOptions {
  FilterOptions({this.activeFilters, this.tags});

  List<String> activeFilters;
  List<TagObject> tags;
}
