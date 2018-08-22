import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  Map<String, dynamic> listInfo;
  PostListItem(this.listInfo);

  String testAvatarUrl(String origin) {
    RegExp exp = new RegExp("^http");
    Iterable<Match> matches = exp.allMatches(origin);
    for (Match m in matches) {
      if (m.group(0) == 'http') {
        return origin;
      }
    }
    String url = 'http:' + origin;
    return url;
  }
  @override
  Widget build(BuildContext context) {
    var titleRow = new Row(children: <Widget>[
      new Expanded(child: new Text(listInfo["title"]))
    ]);
    var timeRow = new Row(children: <Widget>[
      new Container(
        width: 20.0,
        height: 20.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          image: new DecorationImage(
            image: new NetworkImage(testAvatarUrl(listInfo["author"]["avatar_url"])), fit: BoxFit.cover
          ),
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0
          )
        )
      )
    ]);
    var row = new Column(
      children: <Widget>[
        new Row(children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  titleRow,
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                    child: timeRow
                  )
                ]
              )
            )
          ),
        ]),
        new Divider(height: 5.0,color: Colors.grey,),
      ]
    );
    return new InkWell(
      child: row,
    );
  }
}