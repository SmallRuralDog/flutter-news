import 'package:flutter/material.dart';
import 'package:my_app/config/style.dart';
import 'package:transparent_image/transparent_image.dart';

// ignore: must_be_immutable
class ThreeImage extends StatelessWidget {
  Map item;

  ThreeImage(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0,0,0,10),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              alignment: Alignment.topLeft,
              child: Text(
                item['title'],
                style: TextStyle(
                    fontSize: Style.titleSize,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(34, 34, 34, 1)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FadeInImage.memoryNetwork(
                        key: ValueKey(item['images'][0]['name']),
                        placeholder: kTransparentImage,
                        image: item['images'][0]['name'],
                        height: Style.imagesH,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 3,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FadeInImage.memoryNetwork(
                        key: ValueKey(item['images'][1]['name']),
                        placeholder: kTransparentImage,
                        image: item['images'][1]['name'],
                        height: Style.imagesH,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 3,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FadeInImage.memoryNetwork(
                        key: ValueKey(item['images'][2]['name']),
                        placeholder: kTransparentImage,
                        image: item['images'][2]['name'],
                        height: Style.imagesH,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    item['source'],
                    style:
                    TextStyle(fontSize: Style.infoSize, color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      '评论 95',
                      style:
                      TextStyle(fontSize: Style.infoSize, color: Colors.grey),
                    ),
                  ),
                  Text(
                    '1小时前',
                    style:
                    TextStyle(fontSize: Style.infoSize, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}
