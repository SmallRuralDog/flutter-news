import 'package:flutter/material.dart';
import 'package:my_app/config/AppTheme.dart';
import 'package:my_app/page/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.getThemeData('black'),
      home: MyHomePage(title: 'Flutter头条'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  final List<Tab> titleTabs = <Tab>[
    Tab(
      text: '今日实时榜',
    ),
    Tab(
      text: '昨日排行榜',
    ),
    Tab(
      text: '上周积分榜',
    ),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        children: <Widget>[
          new Home(),
          Text('电脑'),
          Text('音乐'),
          Text('视频'),
          Text('我的'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabIndex,
          elevation: 2,
          onTap: (int index) {
            _pageController.jumpToPage(index);
          },
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('首页')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.computer), title: Text('电脑')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.music_video), title: Text('音乐')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.videocam), title: Text('视频')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text('我的')),
          ]),
    );
  }
}
