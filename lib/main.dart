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
  List<Widget> widgets = [];
  List<int> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 10; i++) {
      widgets.add(buildTile(i));
      items.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: _details),
        ],
      ),
      body: new ListView.builder(
          padding: new EdgeInsets.all(10.0),
          itemCount: widgets.length, //规定列表显示的数量 如果不设置则为无限数量
          itemBuilder: (BuildContext context, int i){
            return buildTile(i);
          },
      ),
    );
  }

    
  Widget buildTile(int i) {
    return new GestureDetector(

      child: new Column(
        children: <Widget>[

          new ListTile(
              title: new Text("Row is $i"),
              subtitle: new Text("Row is $i"),
              trailing: new Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
              leading: new CircleAvatar(child: new Text(i.toString()))
          ),
          //增加分割线
          _setDivider(i),
        ],
      ),
      //列表item的点击事件
      onTap: () {
        setState(() {
          widgets = new List.from(widgets);
          widgets.add(buildTile(widgets.length + 1)); //点击item就增加一行数据
          print('row $i');
        });
      },
    );
  }
    
    //设置最后一条数据不显示分割线
  _setDivider(int i){
    if (i < widgets.length - 1)
      return new Divider(color: Colors.red,);
    else
      return new Divider(color: Colors.transparent,);
  }

  //跳转到详情页
  void _details(){
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context){
            final tiles = items.map((item){
              return new ListTile(
                title: new Text(item.toString()));
            });
            final divider = ListTile.divideTiles(
              color: Colors.blue,
              context: context,
              tiles: tiles,
            ).toList();

            return new Scaffold(
              appBar: new AppBar(
                title: new Text('详情页'),
              ),
              body: new ListView(children: divider),
            );
          }
      )
    );
  }

}
