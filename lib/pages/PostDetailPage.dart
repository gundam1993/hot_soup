import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('post detail', style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white)
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Post Detail Page.'),
            new RaisedButton(
              child: new Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ]
        )
      ),
    );
  }
}