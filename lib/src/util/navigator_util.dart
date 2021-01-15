import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; 

class NavigatorUtil {

  /// 普通打开页面的方式。
  /// [context] 上下文对象 
  /// [targPage] 目标页面
  /// [isReplace] 是否替换当前页面
  /// [dismissCallBack] 回调函数
  static void pushPage({
    @required BuildContext context,
    @required Widget targPage,
    bool isReplace = false,
    Function(dynamic value) dismissCallBack,
  }){
    
    PageRoute pageRoute;

    // 不同平台的手机我们使用不同的方式跳转。
    if(Platform.isIOS){
      pageRoute = CupertinoPageRoute(builder: (BuildContext context){
        return targPage;
      } );
    } else if(Platform.isAndroid){
      pageRoute = MaterialPageRoute( builder: (BuildContext context){
        return targPage;
      });
    }

    // 替换当前页面
    if( isReplace ) {
      Navigator.of(context).pushReplacement(pageRoute).then((value){
        // 页面返回的时候需要干什么？
        if(dismissCallBack != null){
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context).push(pageRoute).then((value){
        if(dismissCallBack != null){
          dismissCallBack(value);
        }
      });
    }
  }


  /// 自定义路由 
  ///[context] 上下文对象
  ///[targPage] 目标页面
  ///[isReplace] 是否替换当前页面  A -B
  ///[startMills] 过度的毫秒数
  ///[opaque] 是否以背景透明的方式打开页面
  static void pushPageByFade({
    @required BuildContext context,
    @required Widget targPage,
    bool isReplace = false,
    int startMills=400,
    bool opaque = false,
    Function(dynamic value) dismissCallBack,
  }){

    PageRoute pageRoute = PageRouteBuilder(
      opaque : opaque, 
      pageBuilder: (BuildContext context, Animation<double> animation, 
        Animation<double> secondaryAnimation){
          return targPage;
      },
      transitionDuration: Duration(milliseconds : startMills ),
      // 动画
      transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child){
          // 透明度渐变的容器。
          return FadeTransition(
            opacity: animation,
            child: child,
            // child: Text("111"),
          );
      }
    );

        // 替换当前页面
    if( isReplace ) {
      Navigator.of(context).pushReplacement(pageRoute).then((value){
        // 页面返回的时候需要干什么？
        if(dismissCallBack != null){
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context).push(pageRoute).then((value){
        if(dismissCallBack != null){
          dismissCallBack(value);
        }
      });
    }
    

  }

  
}