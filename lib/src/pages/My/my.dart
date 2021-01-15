import 'package:flutter/material.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        padding : EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("钟宇为"), // 标题
            accountEmail: Text("gmainzhongyuwei1998@gmail.com"), // 副表体
            currentAccountPicture: CircleAvatar(), // 主头像
            otherAccountsPictures: [CircleAvatar(),CircleAvatar()], // 副头像
            margin: EdgeInsets.zero,
            onDetailsPressed: (){
              print('点击事件');
            },
           decoration: BoxDecoration(
                color: Colors.yellow[400],
                image: DecorationImage(
                    image: NetworkImage('http://pic.netbian.com/uploads/allimg/190510/221228-15574975489aa1.jpg'),
                    fit: BoxFit.cover, // 一种图像的布局方式
                    colorFilter: ColorFilter.mode(
                        Colors.grey[400].withOpacity(0.6),
                        BlendMode.hardLight
                    )
                )
           )
          ),
          ListTile(
           // List标题
           title: Text('details', textAlign: TextAlign.left),
           trailing: Icon(
             Icons.favorite, // Icon种类
             color: Colors.black12, // Icon颜色
             size: 22.0, // Icon大小
           ),
           // 点按时间，这里可以做你想做的事情，如跳转、判断等等
           // 此处博主只使用了 Navigator.pop(context) 来手动关闭Drawer
           onTap: () => Navigator.pop(context),
          ),

        ],
      ),
    );
  }
}