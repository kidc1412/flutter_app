import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    List<int> item = [];
    for (int i = 0; i < 300; i++){
      item.add(i);
    }

    final tiles = item.map((item){
      return new ListTile(
        title: new Text(item.toString()),
        subtitle: new Text(item.toString()),
        leading: new CircleAvatar(child: new Text(item.toString()),),
      );
    });

    final divider = ListTile.divideTiles(tiles: tiles, context: context, color: Colors.red).toList();

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('ListView 分割线测试'),

      ),
      /*body: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new ListView(
        children: divider,
      )),*/
      body: new ListView.builder(
          itemCount: 11,
          itemBuilder: (BuildContext context, int i){
              return new Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*new Padding(padding: new EdgeInsets.all(20.0),
                  child: new Text('$i', textAlign: TextAlign.center,),),*/
                  new ListTile(
                    title: new Text(i.toString()),
                    subtitle: new Text(i.toString()),
                    leading: new CircleAvatar(child: new Text(i.toString()),),
                  ),

                  getDivider(i),
                ],
              );

      }),
    );


  }

  Widget getDivider(int i){
    if (i < 10)
      return new Divider(color: Colors.red,);
    else
      return new Divider(color: Colors.transparent,);
  }

  /*Widget buildListTile(int i){
    return new ListTile(
      title: new Text(i.toString()),
      leading: new CircleAvatar(child: new Text(i.toString()),),
      subtitle: new Text(i.toString()),
    );
  }*/
}
