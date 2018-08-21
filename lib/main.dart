import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './pages/postList.dart';
import './pages/LikeList.dart';
import './pages/PostDetailPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  ClientState createState() => new ClientState();
}

class ClientState extends State<MyApp> {
  int _tabIndex = 0;
  final tabTextStyleNormal = new TextStyle(color: Colors.grey[600]);
  final tabTextStyleSelected = new TextStyle(color: Colors.red);
  // 页面底部 TabItem 上的图标数组
  var tabImages;
  // 页面顶部的大标题
  var appBarTitles = ['Timeline', 'Collection'];
  var _body;
  // 全局路由
  var _routes;
  // 数据初始化
  void initData() {
    if (tabImages == null) {
      tabImages = [
        [Icon(Icons.home, color: Colors.grey[600]), Icon(Icons.home, color: Colors.red)],
        [Icon(Icons.star_border, color: Colors.grey[600]), Icon(Icons.star, color: Colors.red)]
      ];
    }
    if (_routes == null) {
      _routes = {
        'PostDetail': (BuildContext) {
          return new PostDetailPage();
        },
        'PostList': (BuildContext) {
          return new PostListPage();
        },
        'LikeList': (BuildContext) {
          return new LikeListPage();
        },
      };
    }
    _body = new IndexedStack(
      children: <Widget>[
        new PostListPage(),
        new LikeListPage()
      ],
      index: _tabIndex,
    );
  }

  // 根据索引值确定 Tab 是选中状态的样式还是非选中状态的样式
  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  // 根据索引值确定 TabItem 的 icon 是选中还是非选中
  Icon getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return new Text(
      appBarTitles[curIndex],
      style: getTabTextStyle(curIndex),
    );
  }

  List<BottomNavigationBarItem> getBottomNavItems() {
    List<BottomNavigationBarItem> list = new List();
    for (int i = 0; i < 2; i++) {
      list.add(new BottomNavigationBarItem(
        icon: getTabIcon(i),
        title: getTabTitle(i)
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      title: 'Hot Soup',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.red,
      ),
      routes: _routes,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Hot Soup',style: new TextStyle(color: Colors.white))
        ),
        body: _body,
        bottomNavigationBar: new CupertinoTabBar(
          items: getBottomNavItems(),
          currentIndex: _tabIndex,
          onTap: (index) {
            // 底部 TabItem 的点击事件处理，改变选中的 tab 的索引值
            setState(() {
              _tabIndex = index;
            });
          },
        ),
        drawer: new Drawer(
          child: new Center(
            child: new Text('this is a drawer')
          )
        ),
      )
    );
  }  
}
