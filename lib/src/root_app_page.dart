 
import 'package:YuWeiFlutterApp/src/common/theme_model.dart';
import 'package:YuWeiFlutterApp/src/index_inheritedwidget.dart'; 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RootApp extends StatefulWidget {
  @override 
  State<StatefulWidget> createState(){
    return _RootAppState();
  }
}
class _RootAppState extends State {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: Provider.of<ThemeModel>(context).themeData ,
      home:IndexInHeritedWidget() ,
    );

  }
}

 