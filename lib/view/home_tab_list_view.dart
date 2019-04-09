import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/components/one_image.dart';
import 'package:my_app/components/three_image.dart';
import 'package:my_app/config/color.dart' show materialColor;

// ignore: must_be_immutable
class HomeTabListView extends StatefulWidget {
  String title;
  String channel;

  HomeTabListView(this.title, this.channel);

  @override
  State<StatefulWidget> createState() => new _HomeTabListViewState();
}

class _HomeTabListViewState extends State<HomeTabListView>
    with AutomaticKeepAliveClientMixin {
  List newsList = [];

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    loadData("up");
  }

  loadData(String mode) async {
    String loadRUL =
        "https://feed.shida.sogou.com/discover_agent/getlist?newh5=1&cmd=getnewslist&b=${widget.channel}&h=mini_6557322&mode=${mode}";

    http.Response response = await http.get(loadRUL);
    var result = json.decode(response.body);

    List urlInfos = result['url_infos'];

    List selfList = newsList;

    if (mode == "down") {
      selfList.addAll(urlInfos);
      setState(() {
        newsList = selfList;
      });
    } else {
      urlInfos.addAll(selfList);
      setState(() {
        newsList = urlInfos;
      });
    }
  }

  Future<Null> _onRefresh() async {
    await loadData("up");
  }

  Future<Null> _loadMore() async {
    await loadData("down");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: getBody(),
          ),
        ],
      ),
    );
  }

  getBody() {
    if (newsList.length != 0) {
      return EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: ClassicsHeader(
            key: _headerKey,
            refreshText: "下拉刷新",
            refreshReadyText: "放开刷新",
            refreshingText: "正在刷新",
            refreshedText: "刷新成功",
            //moreInfo: "updateAt",
            bgColor: Colors.grey[100],
            textColor: Colors.black87,
            moreInfoColor: Colors.black54,
            showMore: false,
            refreshHeight: 50.0,
          ),
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            loadText: "上拉加载",
            loadReadyText: "松开加载",
            loadingText: "正在加载",
            loadedText: "加载完成",
            noMoreText: "没有更多了",
            moreInfo: "updateAt",
            bgColor: Colors.transparent,
            textColor: Colors.grey,
            moreInfoColor: Colors.grey,
            showMore: false,
            loadHeight: 50.0,
          ),
          onRefresh: _onRefresh,
          loadMore: _loadMore,
          autoLoad: true,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 1,
                  indent: 10.0,
                  color: Colors.grey[200],
                ),
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              var item = newsList[index];
              List images = item['images'];
              if (images.length >= 3) {
                return new GestureDetector(
                  onTap: () {
                    print(item);
                  },
                  child: new ThreeImage(item),
                );
              } else if (images.length == 1) {
                return new GestureDetector(
                  onTap: () {
                    print(item);
                  },
                  child: new OneImage(item),
                );
              }
            },
          ));
    } else {
      return CupertinoActivityIndicator();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
