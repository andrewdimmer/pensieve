import 'package:flutter/material.dart';
import 'package:pensieve/Classes/dataObjects.dart';
import 'package:pensieve/Database/getNotes.dart';
import 'package:pensieve/Pages/noteList.dart';
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

  List<NoteObject> _currentList;
  List<NoteObject> _pastList;

  Widget _fab = _getAddNewFab("New Thought", () {});

  Function _handleReorderFactory(List list) {
    return (int index1, int index2) {
      setState(() {
        list.insert(index2, list[index1]);
        if (index2 < index1) {
          index1++;
        }
        list.removeAt(index1);
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
    return getNotesFromDatabase(false, []).then(
      (newCurrentList) {
        return getNotesFromDatabase(true, []).then(
          (newPastList) => setState(
            () {
              _currentList = newCurrentList;
              _pastList = newPastList;
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _currentList == null || _pastList == null
          ? loadingWidget("Loading...")
          : PageView(
              children: <Widget>[
                NoteList(
                  header: Text("Tags"),
                  list: _currentList,
                  handleReorder: _handleReorderFactory(_currentList),
                  refreshList: _refreshLists,
                ),
                NoteList(
                  header: Text("Current Thoughts"),
                  list: _currentList,
                  handleReorder: _handleReorderFactory(_currentList),
                  refreshList: _refreshLists,
                  onToggleComplete: _onToggleComplete,
                  onDelete: _onDelete,
                ),
                NoteList(
                  header: Text("Past Thoughts"),
                  list: _pastList,
                  handleReorder: _handleReorderFactory(_pastList),
                  refreshList: _refreshLists,
                  onToggleComplete: _onToggleComplete,
                  onDelete: _onDelete,
                )
              ],
              controller: _pageController,
              onPageChanged: _setFab,
            ),
      floatingActionButton:
          _currentList == null || _pastList == null ? null : _fab,
      bottomNavigationBar: _currentList == null || _pastList == null
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
