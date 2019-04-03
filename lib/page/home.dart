import 'package:flutter/material.dart';
import 'package:my_app/config/AppTheme.dart';
import 'package:my_app/view/home_tab_list_view.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List<String> _mapList = [
    '头条',
    '社会',
    '国内',
    '娱乐',
    '体育',
    '军事',
    '科技',
    '财经',
    '时尚',
  ];
  List<String> _keyList = [
    'top',
    'shehui',
    'guonei',
    'yule',
    'tiyu',
    'junshi',
    'keji',
    'caijing',
    'shishang',
  ];
  int _currentIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: _mapList.length, vsync: this);
    _tabController.addListener(() {
      if (_currentIndex != _tabController.index) {
        _currentIndex = _tabController.index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
            color: Color(AppTheme.mainColor),
            child: SafeArea(
                child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 25,
                    onPressed: () {
                      print("搜索");
                    },
                  ),
                ),
                Expanded(child: this._tabBar()),
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 25,
                    // color: Colors.white,
                    onPressed: () {
                      print("添加栏目");
                    },
                  ),
                )
              ],
            )),
          ),
          preferredSize: Size.fromHeight(kTextTabBarHeight)),
      body: Column(
        children: <Widget>[this._tabView()],
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      indicatorColor: Color(AppTheme.secondColor),
      controller: _tabController,
      isScrollable: true,
      labelStyle: TextStyle(
        fontSize: 16,
      ),
      labelPadding: EdgeInsets.all(12),
      indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      indicatorWeight: 0.01,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _mapList.map((v) {
        return new Tab(
          text: v,
        );
      }).toList(),
    );
  }

  Widget _tabView() {
    return Expanded(
      child: new TabBarView(
          controller: _tabController,
          children: List.generate(_mapList.length, (index) {
            return new HomeTabListView(_mapList[index],_keyList[index]);
          })),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
