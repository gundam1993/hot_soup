import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:convert';
import '../util/image.dart';
import '../api/api.dart';
import '../util/net.dart';

class PostDetailPage extends StatefulWidget {
  String postId;

  PostDetailPage(this.postId);

  @override
  State<StatefulWidget> createState() {
    return new PostDetailPageState(postId);
  }
}

class PostDetailPageState extends State<PostDetailPage> {
  String postId;
  var postData;

  PostDetailPageState(this.postId);

  getPost(String postId) {
    String url = Api.POSTS + postId;
    Net.get(url, {
      'mdrender': 'false',
    }).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['success'] == true) {
          var post = map['data'];
          setState(() {
            postData = post;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPost(postId);
  }

  @override
  Widget build(BuildContext context) {
    Widget _body;
    if (postData == null) {
      _body = new Center(child: new CircularProgressIndicator());
    } else {
      var titleRow =new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 0.0),
        child: new Row(
          children: [new Expanded(child: new Text(postData["title"]))]
        )
      );
      var timeRow = new Row(children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child:  new Container(
            width: 50.0,
            height: 50.0,
            decoration: new BoxDecoration(
              color: Colors.grey,
              image: new DecorationImage(
                image: new NetworkImage(ImageHelper.testAvatarUrl(postData["author"]["avatar_url"])), fit: BoxFit.cover
              ),
              border: new Border.all(
                color: const Color(0xFFECECEC),
                width: 2.0
              )
            )
          ),
        ),
        new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        postData["author"]["loginname"],
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        " / " + postData["tab"],
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ),
                      ),
                    ],
                  )
                ),
                new Text(
                  new DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(postData['create_at'])),
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: 30.0,
            height: 20.0,
            alignment: Alignment.center,
            child: new Text(postData["replies"].length.toString(), style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              
            ),),
            decoration: new BoxDecoration(
              color: Colors.grey[600],
              borderRadius: new BorderRadius.all(
                const Radius.circular(20.0),
              ),
            )
          ),
      ]);
      // _body = new Column(
      //   children: <Widget>[
      //     new Flexible(
      //       flex: 1,
      //       child: new Padding(
      //         padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      //         child: new Column(
      //           children: <Widget>[
      //             timeRow,
      //             titleRow,
      //             new Flexible(child: new MarkdownBody(data: _uriParseRepair(postData["content"]))),
      //           ],
      //         ),
      //       ),
      //     ),
      //     new Divider(height: 5.0,color: Colors.grey),
      //   ]
      // );
      _body = new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          children: [
            timeRow,
            titleRow,
            new MarkdownBody(data: _uriParseRepair(postData["content"]), styleSheet: new MarkdownStyleSheet(
              p: TextStyle( fontSize: 18.0, color: Colors.black)
            ),),
          ]
        )
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white)
      ),
      body: _body
    );
  }
}

class PostDetailPageRoute extends CupertinoPageRoute {
  String postId;
  PostDetailPageRoute(this.postId)
    : super(builder: (BuildContext context) => new PostDetailPage(postId));

    // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new PostDetailPage(postId));
  }
}

String _uriParseRepair(String dataHtml){
  final string = dataHtml.replaceAllMapped(new RegExp(r'\(\/\/'), (hasil){
    return '(https://';
  });
  return string;
}