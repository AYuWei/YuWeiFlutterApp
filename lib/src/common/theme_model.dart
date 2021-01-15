import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {
  ThemeData themeData;
  ThemeType currentType;
  ThemeModel(ThemeType type){
    currentType = type;
    type == ThemeType.dark ? 
      themeData = ThemeData.dark() :  
        themeData = ThemeData.light();
  }
  // 反转
  void reverse(){
    currentType == ThemeType.dark ? 
      _upDate(ThemeType.light) : 
        _upDate(ThemeType.dark);
  }  
  
  void _upDate(ThemeType type){
    currentType = type;  // 当前类型
    type == ThemeType.light ? 
      themeData = ThemeData.light() : 
        themeData = ThemeData.dark();
    notifyListeners(); // 更改状态
  }
}

/// 枚举
enum ThemeType {
  light,  // 白天模式
  dark,  // 黑暗模式
}