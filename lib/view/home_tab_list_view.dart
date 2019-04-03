import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/components/one_image.dart';
import 'package:my_app/components/three_image.dart';

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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    String loadRUL =
        "http://v.juhe.cn/toutiao/index?type=${widget.channel}&key=de1c0487cf95773991e705b9bf5fd4bd";
    http.Response response = await http.get(loadRUL);
    var result = json.decode(response.body);
    setState(() {
      newsList = result['result']['data'];
    });
  }

  Future<Null> _onRefresh() async {
    await loadData();
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
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: 1,
                indent: 10.0,
                color: Colors.grey[200],
              ),
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            var item = newsList[index];
            if (item['thumbnail_pic_s03'] is String) {
              return new GestureDetector(
                onTap: () {
                  print(item);
                },
                child: new ThreeImage(item),
              );
            } else {
              return new GestureDetector(
                onTap: () {
                  print(item);
                },
                child: new OneImage(item),
              );
            }
          },
        ),
      );
    } else {
      return CupertinoActivityIndicator();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
