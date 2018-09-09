
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class TopTab{
  String title;
  TopTab(this.title);
}

class WooPage extends StatefulWidget{
  static const String routeName = '/material/scrollable-tabs';

  @override
  WooPageState createState() => new WooPageState();
}

class WooPageState extends State<WooPage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  final List<TopTab> topTabs = <TopTab>[
    new TopTab('推荐'),
    new TopTab('生活'),
    new TopTab('我家'),
    new TopTab('设计'),
    new TopTab('陈设'),
    new TopTab('科技'),
    new TopTab('玩具'),
    new TopTab('盆景'),
    new TopTab('DIY'),
    new TopTab('教程'),
    new TopTab('国外'),
    new TopTab('工业'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: topTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0, //不让TabBar左右有间距
        title: new TabBar(
          isScrollable: true,
          indicatorColor: Colors.transparent,
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black,
          labelStyle: new TextStyle(fontSize: 18.0),
          tabs: topTabs.map((item){
            return new Tab(text: item.title,);
          }).toList(),

        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: topTabs.map((item){
          return NewsList();
        }).toList(),
      ),
    );
  }
}

class NewsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>{

  List<Widget> widgets = [];
  List<int> items = [];
  String getUrl = "https://vod.woodsoo.tv/tvapi/get_video_info?limit=10&tab=0&limit_end=0";

  //HTTP请求的函数返回值为异步控件Future
  Future<String> get() async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(getUrl));
    var response = await request.close();
    return await response.transform(utf8.decoder).join();
  }

  Future<Null> loadData() async{
    await get();   //注意await关键字
    if (!mounted) return; //异步处理，防止报错
    setState(() {});//什么都不做，只为触发RefreshIndicator的子控件刷新
  }
  
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
          case ConnectionState.none:        //get未执行时
          case ConnectionState.waiting:     //get正在执行时
            return new Center(
              child: new Card(
                child: new Text('loading...'),    //在页面中央显示正在加载
              ),
            ) ;
          default:
            if (snapshot.hasError)    //get执行完成但出现异常
              return new Text('Error: ${snapshot.error}');
            else  //get正常执行完成
              // 创建列表，列表数据来源于snapshot的返回值，而snapshot就是get(widget.newsType)执行完毕时的快照
              // get(widget.newsType)执行完毕时的快照即函数最后的返回值。
              return createList(snapshot);
        }
      },
    );
  }

  Widget createList(AsyncSnapshot snapshot){

    List values = jsonDecode(snapshot.data);
    switch (values.length) {
      case 1: //没有获取到数据，则返回请求失败的原因
        return new Center(
          child: new Card(
            child: new Text(jsonDecode(snapshot.data)['reason']),
          ),
        );
      default:
        return new ListView.builder(
          itemCount: values == null ? 0 : values.length,
          itemBuilder: (context, i) {
            return _newsRow(values, i);
          },
        );
    }
  }

  Widget _newsRow(values, i){
    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              children: <Widget>[
                new Text(values[i]['title'], textScaleFactor: 1.2,),
              ],
            ),
          ),
          _generateOnePicItem(values[i]),
          _setDivider(i, values),
        ],
      ),
    );
  }

  //仅有一个图片时的效果
  _generateOnePicItem(Map newsInfo){
    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Expanded(
            child: new Container(
                padding: const EdgeInsets.all(3.0),
                child: new SizedBox(
                  child: new Image.network(
                    newsInfo['titlePic'],
                    fit: BoxFit.fitWidth,
                  ),
                  height: 200.0,
                )
            )
        )
      ],
    );
  }

  //设置最后一条数据不显示分割线
  _setDivider(int i, List values){
    if (i < values.length - 1)
      return new Divider(color: Colors.grey,);
    else
      return new Divider(color: Colors.transparent,);
  }

}

