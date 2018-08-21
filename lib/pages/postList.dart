import 'package:flutter/material.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new RaisedButton(
        child: new Text('to detail page'),
        onPressed: () {
          Navigator.of(context).pushNamed('PostDetail');
        }
      ),
    );
  }
}