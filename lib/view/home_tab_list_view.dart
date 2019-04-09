import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/components/one_image.dart';
import 'package:my_app/components/three_image.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

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

  RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = new RefreshController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshController.requestRefresh(true);
    });
    super.initState();
    loadData("up");
  }

  loadData(String mode) {
    String loadRUL =
        "https://feed.shida.sogou.com/discover_agent/getlist?newh5=1&cmd=getnewslist&b=${widget.channel}&h=mini_6557322&mode=${mode}";

    http.get(loadRUL).then((response) {
      var result = json.decode(response.body);
      List urlInfos = result['url_infos'];
      List selfList = newsList;
      if (mode == "down") {
        selfList.addAll(urlInfos);
        setState(() {
          newsList = selfList;
          _refreshController.sendBack(false, RefreshStatus.idle);
        });
      } else {
        urlInfos.addAll(selfList);
        setState(() {
          newsList = urlInfos;
          _refreshController.sendBack(true, RefreshStatus.completed);
        });
      }
    }).catchError((err) {
      setState(() {
        _refreshController.sendBack(false, RefreshStatus.failed);
      });
    });
  }

  _onRefresh(bool up) {
    if (up) {
      loadData("up");
    } else {
      loadData("down");
    }
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

  Widget _headerCreate(BuildContext context, RefreshStatus mode) {
    return new ClassicIndicator(
      mode: mode,
      releaseText: '松开刷新',
      refreshingText: '正在加载',
      completeText: '刷新成功',
      //idleIcon: const Icon(Icons.arrow_downward),
      idleText: '下拉刷新',
    );
  }

  Widget _footerCreate(BuildContext context, RefreshStatus mode) {
    return new ClassicIndicator(
      mode: mode,
      refreshingText: '正在加载',
      idleText: '加载更多',
    );
  }

  getBody() {
    if (newsList.length != 0) {
      return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _onRefresh,
          headerConfig: RefreshConfig(triggerDistance: 50),
          footerConfig: LoadConfig(autoLoad: true, triggerDistance: 100),
          headerBuilder: _headerCreate,
          footerBuilder: _footerCreate,
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
