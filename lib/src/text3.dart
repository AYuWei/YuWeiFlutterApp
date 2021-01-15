import 'package:YuWeiFlutterApp/src/index_inheritedwidget.dart';
import 'package:YuWeiFlutterApp/src/userbean.dart';
import 'package:YuWeiFlutterApp/src/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Text3 extends StatefulWidget {
  @override
  _Text3State createState() => _Text3State();
}

class _Text3State extends State<Text3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text#"),
      ),
      body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Consumer<UserBean>(
            builder: (context, value, child){
              return Text(value.name);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<UserBean>(
            builder: (context, value, child){
              return Text(value.address);
            },
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
             onPressed: (){ 
               NavigatorUtil.pushPageByFade(context: context, targPage: IndexInHeritedWidget() ,isReplace : true);
             },
             child: Text("返回"),
          ),
          FlatButton(
             onPressed: (){ 
               print("更改数据"); 
               Provider.of<UserBean>(context, listen: false).address = "China";
               Provider.of<UserBean>(context, listen: false).name = "Flutter ";
               setState(() {
                 
               });
             },
             child: Text("更改数据"),
          ),
        ],
      )
    ) 
    );
  }
}