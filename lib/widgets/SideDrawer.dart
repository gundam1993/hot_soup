import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  // 菜单文本前的图标大小
  static const double ICON_WIDTH = 30.0;
  // 菜单文本
  List<String> menuTitles = ['首页', '收藏', '私信', '提醒', '历史记录', '设置', '帮助', '捐赠'];

  TextStyle menuStyle = new TextStyle(
    fontSize: 15.0
  );

  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      //render cover image
      var img = new Image.asset(
        'images/cover_img.jpeg',
        width: 304.0
      );
      return new Container(
        width: 304.0,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        child: img,
      );
    }
    // 舍去之前的封面图
    index -= 1;
    var listItemContent = new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: new Row(children: <Widget>[
        new Expanded(
          child: new Text(
            menuTitles[index],
            style: menuStyle,
          ),
        )
      ],)
    );
    return new InkWell(
      child: listItemContent,
      onTap: () {
        print("click list item $index");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 304.0),
      child: new Material(
        elevation: 16.0,
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.white
          ),
          child: new ListView.builder(
            itemCount: menuTitles.length + 1,
            itemBuilder: renderRow,
          )
        )
      )
    );
  }
}