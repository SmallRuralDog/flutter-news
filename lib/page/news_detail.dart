import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {

  final String title;

  const NewsDetail({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new NewsDetailState();
}

class NewsDetailState extends State<NewsDetail>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text(widget.title),elevation: 0.0,),
    );
  }

}