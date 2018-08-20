import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './pages/postList.dart';
import './pages/LikeList.dart';

void main() => runApp(new MyApp());

int _tabIndex = 0;

var _body = new IndexedStack(
  children: <Widget>[
    new PostListPage(),
    new LikeListPage()
  ],
  index: _tabIndex,
);



class MyApp extends StatefulWidget {
  @override
  ClientState createState() => new ClientState();
}

class ClientState extends State<MyApp> {
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
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Hot Soup',style: new TextStyle(color: Colors.white))
        ),
        body: new Text('Hot Soup'),
        // bottomNavigationBar: new CupertinoTabBar(
        //   items:
        // ),
      )
    );
  }
}
