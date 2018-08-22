import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../util/image.dart';
import '../pages/PostDetailPage.dart';

class PostListItem extends StatelessWidget {
  String title;
  String avatarUrl;
  String createdAt;
  String tab;
  String loginName;
  int replyCount;
  String postId;
  Map<String, String> tagMap = {
    'all': '全部',
    'good': '精华',
    'share': '分享',
    'ask': '问答',
    'job': '招聘',
  };
  PostListItem(this.postId, this.title, this.avatarUrl, this.loginName, this.createdAt, this.tab, this.replyCount);

  @override
  Widget build(BuildContext context) {
    var titleRow =new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new Row(
          children: [new Expanded(child: new Text(title))]
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
                image: new NetworkImage(ImageHelper.testAvatarUrl(avatarUrl)), fit: BoxFit.cover
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
                        loginName,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text(
                        " / " + tagMap[tab],
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ),
                      ),
                    ],
                  )
                ),
                new Text(
                  new DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(createdAt)),
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
            child: new Text(replyCount.toString(), style: new TextStyle(
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
    var row = new Column(
      children: <Widget>[
        new Row(children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  timeRow,
                  titleRow,
                  // new Padding(
                  //   padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  //   child: timeRow
                  // )
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
      onTap: () {
        // Navigator.of(context).pushNamed('PostDetail', );
        Navigator.push(
          context,
          new PostDetailPageRoute(postId)
        );
      },
    );
  }
}