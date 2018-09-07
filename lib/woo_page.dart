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
        title: new TabBar(
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black,
          tabs: topTabs.map((item){
            return new Tab(text: item.title,);
          }).toList(),
          isScrollable: true,
          indicatorColor: Colors.transparent,
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: topTabs.map((item){
          return new Center(
            child: new Text(item.title),
          );
        }).toList(),
      ),
    );
  }
}