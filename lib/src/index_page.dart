 import 'dart:io';
 
import 'package:YuWeiFlutterApp/src/app/app_scence.dart';
import 'package:YuWeiFlutterApp/src/common/permisson_request_widget.dart';
import 'package:YuWeiFlutterApp/src/common/protocol_model.dart';
import 'package:YuWeiFlutterApp/src/index_inheritedwidget.dart';
import 'package:YuWeiFlutterApp/src/userInfo_widhet.dart';
import 'package:YuWeiFlutterApp/src/userbean.dart';
import 'package:YuWeiFlutterApp/src/util/console.log.dart';
import 'package:YuWeiFlutterApp/src/util/navigator_util.dart';
import 'package:YuWeiFlutterApp/src/util/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class IndexApp extends StatefulWidget {
  @override
  _IndexAppState createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> with ProtocolModel{
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      initData();
    });
  }

  List<String> _list = [
    "为您更好的体验应用，所以需要获取您的相机权限权限。",
    "您已拒绝权限，无法访问相机权限，将无法使用APP。",
    "您已拒绝权限，请在设置中心同意APP的权限请求。", 
  ];

  // 初始化数据
  void initData() async{ 
   // 权限请求
   Console.log("权限请求");
   // 相机权限请求
   NavigatorUtil.pushPageByFade(
     context: context, 
     opaque: true,
     targPage:  PermissonRequestWidget(
      //  Permission.camera   Permission.location,
       permission: Permission.camera, // 相机权限
       permissonList: _list,
       isCloseApp: true,
     ),
     dismissCallBack: (value) {
       Console.log("申请的结果 $value");
       // 同意开启协议后下一步操作
       initNext();
     }
    );
  
  }

  void initNext() async {
    
    if(Platform.isIOS){
      Directory libDire = await getLibraryDirectory();
     Console.log("libDire ${libDire.path}");
    }
    
    
    
    // 初始化保留全局数据的东西
    await SPUtil.init();

    // 读取当前是否同意协议
    bool isAgrement = await SPUtil.getBool("isAgrement");
    
    SPUtil.saveObject("data", {
      "name" : "dog",
      "discription" : "不仅长得可爱，而且还很听话！"
    });
   
    if(isAgrement == null || !isAgrement){
      //用户协议
      isAgrement = await showProtocolFunction(context); 
    }

    if(isAgrement){

      Console.log("同意用户协议");

      // 保存一下用户协议的标示
      SPUtil.save("isAgrement", isAgrement );
      NavigatorUtil.pushPageByFade(context: context, 
      targPage: AppScence(),
      // targPage: IndexInHeritedWidget(),
      isReplace: true);

    }

     
     

  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);

    return Scaffold(
      body: Center(),
    );
  }
}
