import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'list_page.dart';
import 'woo_page.dart';
import 'news_page.dart';
import 'reorderable_list_demo.dart';
import 'leave_behind_demo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _tabList = ['List', 'Woo', 'News', 'Swipe', 'Divdier'];
  int _tabIndex = 0;


  @override
  Widget build(BuildContext context) {

    var _body = new IndexedStack(
      children: <Widget>[
        new ListPage(),
        new WooPage(),
        new NewsPage(),
        new ReorderableListDemo(),
        new LeaveBehindDemo(),
      ],
      index: _tabIndex,
    );

    return new Scaffold(
     /* appBar: new AppBar(
        title: new Text("Sample App"),
      ),*/
      body: _body,
      bottomNavigationBar: new CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            title: new Text(_tabList[0]),
          ),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.description),
              title: new Text(_tabList[1])),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.fiber_new),
              title: new Text(_tabList[2])),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.ac_unit),
              title: new Text(_tabList[3])),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.widgets),
              title: new Text(_tabList[4])),
        ],
        currentIndex: _tabIndex,
        onTap: (index){
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
