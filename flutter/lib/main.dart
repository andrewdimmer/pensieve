import 'package:flutter/material.dart';
import 'package:pensieve/Widgets/bottomNavBar.dart';

import 'Widgets/note.dart';

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
  ];

  void handleReorder(int index1, int index2) => {
        setState(() {
          _list.insert(index2, _list[index1]);
          if (index2 < index1) {
            index1++;
          }
          _list.removeAt(index1);
        })
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ReorderableListView(
        children: _list
            .map(
              (item) => Note(
                noteId: item["noteId"],
                content: item["content"],
                key: UniqueKey(),
              ),
            )
            .toList(),
        onReorder: handleReorder,
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
        leftLabel: "Tags",
        rightLabel: "Past Thoughts",
        leftCallback: () => {},
        rightCallback: () => {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
