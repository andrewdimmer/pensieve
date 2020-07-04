import 'package:flutter/material.dart';
import 'package:pensieve/Pages/noteList.dart';
import 'package:pensieve/Widgets/bottomNavBar.dart';
import 'package:pensieve/Widgets/bottomNavBarButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pensieve Online',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pensieve Online'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> _list = [
    {"noteId": "Test1", "content": "This is the first note."},
    {"noteId": "Test2", "content": "This is the second note."},
    {"noteId": "Test3", "content": "This is the third note."},
    {"noteId": "Test4", "content": "This is the fourth note."},
    {"noteId": "Test5", "content": "This is the fifth note."},
    {"noteId": "Test6", "content": "This is the sixth note."},
    {"noteId": "Test7", "content": "This is the seventh note."},
    {"noteId": "Test8", "content": "This is the eighth note."},
    {"noteId": "Test9", "content": "This is the nineth note."},
    {"noteId": "Test10", "content": "This is the tenth note."},
  ];

  final _pageController = PageController(initialPage: 1);

  void _handleReorder(int index1, int index2) {
    setState(() {
      _list.insert(index2, _list[index1]);
      if (index2 < index1) {
        index1++;
      }
      _list.removeAt(index1);
    });
  }

  Function _navigationFunctionFactory(int goToPage) {
    return () {
      _pageController.animateToPage(goToPage,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        children: <Widget>[
          NoteList(
            header: Text("Tags"),
            list: _list,
            handleReorder: _handleReorder,
          ),
          NoteList(
            header: Text("Current Thoughts"),
            list: _list,
            handleReorder: _handleReorder,
          ),
          NoteList(
            header: Text("Past Thoughts"),
            list: _list,
            handleReorder: _handleReorder,
          )
        ],
        controller: _pageController,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NewGoal(
                        addGoal: addGoal,
                      ))); */
        },
        label: Text('New Thought'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavBar(
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
