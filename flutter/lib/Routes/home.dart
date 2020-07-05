import 'package:flutter/material.dart';
import 'package:pensieve/Classes/dataObjects.dart';
import 'package:pensieve/Database/manageNotesDatabase.dart';
import 'package:pensieve/Database/manageTagsDatabase.dart';
import 'package:pensieve/Pages/noteList.dart';
import 'package:pensieve/Pages/tagList.dart';
import 'package:pensieve/Widgets/bottomNavBar.dart';
import 'package:pensieve/Widgets/bottomNavBarButton.dart';
import 'package:pensieve/Widgets/loading.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    getTagsFromDatabase().then((value) {
      setState(() {
        _tags = value;
      });
    });
    getNotesFromDatabase(false, []).then((value) {
      setState(() {
        _currentList = value;
      });
    });
    getNotesFromDatabase(true, []).then((value) {
      setState(() {
        _pastList = value;
      });
    });
  }

  final _pageController = PageController(initialPage: 1);

  List<TagObject> _tags;
  List<NoteObject> _currentList;
  List<NoteObject> _pastList;

  Widget _fab = _getAddNewFab("New Thought", () {});

  Function _handleReorderFactory(List<NoteObject> list) {
    return (int index1, int index2) {
      setState(() {
        NoteObject note = list[index1];
        list.insert(index2, note);
        if (index2 < index1) {
          index1++;
          index2++;
        }
        list.removeAt(index1);
        note.order = index2 - 2 >= 0
            ? index2 < list.length
                ? ((list[index2 - 2].order + list[index2].order) / 2).round()
                : list[index2 - 2].order - 100
            : DateTime.now().millisecondsSinceEpoch;
        editNoteOrderDatabase(note.noteId, note.order);
      });
    };
  }

  Function _navigationFunctionFactory(int goToPage) {
    return () {
      _pageController.animateToPage(goToPage,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    };
  }

  void _onToggleComplete(String noteId, bool completed) {
    editNoteCompletenessDatabase(noteId, !completed);
    setState(() {
      NoteObject note = (completed ? _pastList : _currentList).removeAt(
        _getIndex(noteId, completed),
      );
      note.complete = !note.complete;
      if ((completed ? _currentList : _pastList).length == 0) {
        (completed ? _currentList : _pastList).add(note);
      } else {
        (completed ? _currentList : _pastList).insert(0, note);
      }
    });
  }

  void _onDelete(String noteId, bool completed) {
    deleteNoteDatabase(noteId);
    setState(() {
      (completed ? _pastList : _currentList).removeAt(
        _getIndex(noteId, completed),
      );
    });
  }

  int _getIndex(String noteId, bool completed) {
    for (int i = 0;
        completed ? i < _pastList.length : i < _currentList.length;
        i++) {
      if ((completed ? _pastList : _currentList)[i].noteId == noteId) {
        return i;
      }
    }
    return -1;
  }

  static Widget _getAddNewFab(String label, Function onPressed) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(Icons.add),
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    );
  }

  void _setFab(int page) {
    Widget tempFab;
    if (page == 0) {
      tempFab = _getAddNewFab("New Tag", () {});
    } else if (page == 1) {
      tempFab = _getAddNewFab("New Thought", () {});
    }
    setState(() {
      _fab = tempFab;
    });
  }

  Future<void> _refreshLists() {
    return getTagsFromDatabase().then(
      (newTags) {
        return getNotesFromDatabase(false, []).then(
          (newCurrentList) {
            return getNotesFromDatabase(true, []).then(
              (newPastList) => setState(
                () {
                  _tags = newTags;
                  _currentList = newCurrentList;
                  _pastList = newPastList;
                },
              ),
            );
          },
        );
      },
    );
  }

  String _getTagName(String tagId) {
    for (TagObject tagObject in _tags) {
      if (tagObject.tagId == tagId) {
        return tagObject.tagName;
      }
    }
    return "";
  }

  List<String> _getUnusedTags(List<String> tagIds) {
    List<String> unused = [];
    for (TagObject tagObject in _tags) {
      if (!tagIds.contains(tagObject.tagId)) {
        unused.add(tagObject.tagId);
      }
    }
    return unused;
  }

  void _addTag(String noteId, String tagId, bool completed) {
    setState(() {
      (completed ? _pastList : _currentList)[_getIndex(noteId, completed)]
          .tags
          .add(tagId);
    });
  }

  void _removeTag(String noteId, String tagId, bool completed) {
    setState(() {
      (completed ? _pastList : _currentList)[_getIndex(noteId, completed)]
          .tags
          .remove(tagId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _tags == null || _currentList == null || _pastList == null
          ? loadingWidget("Loading...")
          : PageView(
              children: <Widget>[
                TagList(
                  list: _tags,
                  refreshList: _refreshLists,
                ),
                NoteList(
                  header: Text("Current Thoughts"),
                  list: _currentList,
                  handleReorder: _handleReorderFactory(_currentList),
                  refreshList: _refreshLists,
                  onToggleComplete: _onToggleComplete,
                  onDelete: _onDelete,
                  getTagName: _getTagName,
                  getUnusedTags: _getUnusedTags,
                  addTag: _addTag,
                  removeTag: _removeTag,
                ),
                NoteList(
                  header: Text("Past Thoughts"),
                  list: _pastList,
                  handleReorder: _handleReorderFactory(_pastList),
                  refreshList: _refreshLists,
                  onToggleComplete: _onToggleComplete,
                  onDelete: _onDelete,
                  getTagName: _getTagName,
                  getUnusedTags: _getUnusedTags,
                  addTag: _addTag,
                  removeTag: _removeTag,
                )
              ],
              controller: _pageController,
              onPageChanged: _setFab,
            ),
      floatingActionButton:
          _tags == null || _currentList == null || _pastList == null
              ? null
              : _fab,
      bottomNavigationBar:
          _tags == null || _currentList == null || _pastList == null
              ? null
              : BottomNavBar(
                  propsList: [
                    BottomNavBarButtonProps(
                      label: "Tags",
                      callback: _navigationFunctionFactory(0),
                    ),
                    BottomNavBarButtonProps(
                      label: "Current Thoughts",
                      callback: _navigationFunctionFactory(1),
                    ),
                    BottomNavBarButtonProps(
                      label: "Past Thoughts",
                      callback: _navigationFunctionFactory(2),
                    ),
                  ],
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
