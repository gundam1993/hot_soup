import 'package:flutter/material.dart';
import 'dart:convert';
import '../api/api.dart';
import '../util/net.dart';
import '../widgets/PostListItem.dart';

class PostListPage extends StatefulWidget {
  String tab;

  PostListPage(this.tab);

  @override
  State<StatefulWidget> createState() {
    return new PostListPageState(tab);
  }
}

class PostListPageState extends State<PostListPage> {
  String tab;
  var listData;
  var currentPage = 1;
  var pageLimit = 10;
  var listTotalSize = 0;
  ScrollController _controller = new ScrollController();


  PostListPageState(this.tab) {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        // scroll to bottom, get next page data
        print('load more ...');
        currentPage++;
        getPostList(true);
      }
    });
  }

  Widget renderRow(i) {
    return new PostListItem(
      listData[i]['id'],
      listData[i]["title"], 
      listData[i]['author']['avatar_url'], 
      listData[i]['author']['loginname'], 
      listData[i]['create_at'], 
      listData[i]['tab'], 
      listData[i]['reply_count']);
  }

  getPostList(bool isLoadMore) {
    String url = Api.TOPICS;
    Net.get(url, {
      'tab': tab,
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