import 'package:flutter/material.dart';
import 'dart:convert';
import '../api/api.dart';
import '../util/net.dart';
import '../widgets/PostListItem.dart';

class PostListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PostListPageState();
  }
}

class PostListPageState extends State<PostListPage> {
  var listData;
  var currentPage = 1;
  var pageLimit = 10;
  var listTotalSize = 0;
  ScrollController _controller = new ScrollController();

  Widget renderRow(i) {
    return new PostListItem(listData[i]);
  }

  getPostList(bool isLoadMore) {
    String url = Api.TOPICS;
    Net.get(url, {
      'page': currentPage.toString(),
      'limit': pageLimit.toString(),
    }).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['success'] == true) {
          var posts = map['data'];
          setState(() {
            if (!isLoadMore) {
              listData = posts;
            } else {
              List list1 = new List();
              list1.addAll(listData);
              list1.addAll(posts);
              listData = list1;
            }
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPostList(false);
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      // 如果没有数据，显示圆形 loading
      return new Center(child: new CircularProgressIndicator());
    } else {
      // 有数据，显示 ListView
      Widget listView = new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => renderRow(i),
        controller: _controller,
      );
      return listView;
    }
  }
}