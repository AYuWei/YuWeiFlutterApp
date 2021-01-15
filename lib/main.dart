
import 'package:YuWeiFlutterApp/src/common/theme_model.dart';
import 'package:YuWeiFlutterApp/src/root_app_page.dart';
import 'package:YuWeiFlutterApp/src/userbean.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';



void main() {
  // runApp( 
  //   ChangeNotifierProvider<ThemeModel> (
  //      create: (_) {
  //        return ThemeModel(ThemeType.dark);
  //      },
  //      child: RootApp(),
  //   ) );
 
    // runApp(
    //   FutureProvider<String>(
    //     create: (_){
    //       return Future.delayed(Duration(seconds:2),(){
    //         return "this is flutter FutureProvider";
    //       });
    //     },
    //     // 应为两秒后才有值，所以我们需要给个初始值
    //     initialData: "this is a initialData from FutureProvider!",
    //     child: StreamProvider<int>(
    //       create: (_){
    //         return Stream.periodic(Duration(milliseconds: 500),(v){
    //           return v + 3;
    //         }).take(100);
    //       },
    //       lazy: false,
    //       updateShouldNotify: (_, __){
    //         print("当前是updateShouldNotify || _ = $_, __= $__");
    //         return true;
    //       },
    //       child: ChangeNotifierProvider<ThemeModel> (
    //         create: (_) {
    //           return ThemeModel(ThemeType.dark);
    //         },
    //         child: RootApp(),
    //       ) ,
    //     ),
    //   )
    // );

    runApp(
      MultiProvider(
        providers: [
          // 使用FutureProvider返回一个字符串
          FutureProvider<String>(
            create: (_){
              return Future.delayed(Duration(seconds:2),(){
                return "this is flutter FutureProvider";
              });
            },
            // 应为两秒后才有值，所以我们需要给个初始值
            initialData: "this is a initialData from FutureProvider!",
          ),
          // 使用StreamProvider返回一个int类型，不只是返回int 其它也行
          StreamProvider<int>(
            create: (_){
              return Stream.periodic(Duration(milliseconds: 500),(v){
                return v + 3;
              }).take(100);
            },
            lazy: false,
            updateShouldNotify: (_, __){
              // print("当前是updateShouldNotify || _ = $_, __= $__");
              return true;
            },
          ),
          // 
          ChangeNotifierProvider<ThemeModel> (
            create: (_) {
              return ThemeModel(ThemeType.dark);
            },
          ),
          ChangeNotifierProvider<UserBean>(
            create: (_){
              print("创建？  $_");
              return UserBean(name : "Flutter ChangeNotifierProvider", address: "Chian ChangeNotifierProvider");
            },
          )
        ],
        child: RootApp(),
      ), 
    );
  
} 