import 'package:flutter/material.dart';
import 'package:my_app/config/style.dart';
import 'package:transparent_image/transparent_image.dart';

class OneImage extends StatelessWidget {
  Map item;

  OneImage(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                height: Style.imagesH,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        item['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Style.titleSize,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(34, 34, 34, 1)),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            item['author_name'],
                            style: TextStyle(
                                fontSize: Style.infoSize, color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              '评论 95',
                              style: TextStyle(
                                  fontSize: Style.infoSize, color: Colors.grey),
                            ),
                          ),
                          Text(
                            '1小时前',
                            style: TextStyle(
                                fontSize: Style.infoSize, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Container(
            width: 6,
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[100],
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item['thumbnail_pic_s'],
                height: Style.imagesH,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
