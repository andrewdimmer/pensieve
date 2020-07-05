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
  final _pageController = PageController(initialPage: 1);

  List<NoteObject> _list;

  Widget _fab = _getAddNewFab("New Thought", () {});

  Function _handleReorderFactory(List list) {
    return (int index1, int index2) {
      setState(() {
        list.insert(index2, _list[index1]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _list == null
          ? loadingWidget("Loading...")
          : PageView(
              children: <Widget>[
                NoteList(
                  header: Text("Tags"),
                  list: _list,
                  handleReorder: _handleReorderFactory(_list),
                ),
                NoteList(
                  header: Text("Current Thoughts"),
                  list: _list,
                  handleReorder: _handleReorderFactory(_list),
                ),
                NoteList(
                  header: Text("Past Thoughts"),
                  list: _list,
                  handleReorder: _handleReorderFactory(_list),
                )
              ],
              controller: _pageController,
              onPageChanged: _setFab,
            ),
      floatingActionButton: _list == null ? null : _fab,
      bottomNavigationBar: _list == null
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