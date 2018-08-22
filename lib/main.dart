import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './pages/postList.dart';
import './pages/PostDetailPage.dart';
import './widgets/SideDrawer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  ClientState createState() => new ClientState();
}

class ClientState extends State<MyApp> {
  // 页面顶部的大标题
  // var appBarTitles = ['Timeline', 'Collection'];

  @override
  Widget build(BuildContext context) {
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
      home: new DefaultTabController(
        length: 5,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('CNODE',style: new TextStyle(color: Colors.white)),
            bottom: new TabBar(
              tabs: <Widget>[
                new Tab(text: '全部',key: new Key('all')),
                new Tab(text: '精华',key: new Key('good')),
                new Tab(text: '分享',key: new Key('share')),
                new Tab(text: '问答',key: new Key('ask')),
                new Tab(text: '招聘',key: new Key('job')),
              ],
            ),
          ),
          body: new TabBarView(
            children: [
              new PostListPage('all'),
              new PostListPage('good'),
              new PostListPage('share'),
              new PostListPage('ask'),
              new PostListPage('job'),
            ]
          ),
          drawer: new SideDrawer(),
        )
      )
    );
  }  
}
