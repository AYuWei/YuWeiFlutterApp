/// 权限申请，我们这使用Widget的形式。
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart'; 

/// [PermissonRequestWidget] 权限请求封装
class PermissonRequestWidget extends StatefulWidget {
  final Permission permission;
  final List<String> permissonList;
  final bool isCloseApp;
  final String leftButtonText;

/// [PermissonRequestWidget] 权限请求封装
/// [permission] Permission 请求的权限 是什么？ 如相机权限 Permission.camera 
/// [permissonList] 权限提示消息 ["第一次请求的数据信息","第二次请求的数据信息","第三次请求的数据信息"]
/// [isCloseApp] 是否关闭App
  PermissonRequestWidget({
    @required this.permission,
    @required this.permissonList,
    this.leftButtonText = '退出',
    this.isCloseApp = false,
  });

  @override
  // _PermissonRequestWidgetState createState() => _PermissonRequestWidgetState();
  State<StatefulWidget> createState(){
    return _PermissonRequestWidgetState();
  }
}

// class _PermissonRequestWidgetState extends State<PermissonRequestWidget> {  
  //  with WidgetsBindingObserver 使用观察者模式，看看去设置中心回来了没。
class _PermissonRequestWidgetState extends State<PermissonRequestWidget> with WidgetsBindingObserver {

  bool _isGoSetting = false;// 是否去设置中心

  @override
  void initState() {  

    checkPermisson();

    // 注册观察者
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  // 结束的生命周期。
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state); 
    // 销毁观察者
    if(state == AppLifecycleState.resumed && _isGoSetting){ 
      checkPermisson();
    }
  }

  // 权限判断。
  void checkPermisson({PermissionStatus status}) async {

    /// 获取传入的权限请求类型
    Permission permission = widget.permission;

    /// 如果没传入当前的状态，则获取一下当前权限的状态类型
    if(status ==  null){
      status = await permission.status; 
    } 
    if( status.isUndetermined ){
      /// 第一次 申请 
      showPermissonAlert(widget.permissonList[0],"同意", permission);
    } else if( status.isDenied ){
      /// 第一次申请拒绝 再 第二次申请 
      if(Platform.isIOS){
         showPermissonAlert(widget.permissonList[2],"去设置中心", permission, isSetting: true);
      } else if(Platform.isAndroid){
         showPermissonAlert(widget.permissonList[1],"重试", permission);
      }
    } else if( status.isPermanentlyDenied ){
      /// 第二次申请拒绝       
      showPermissonAlert(widget.permissonList[2],"去设置中心", permission, isSetting: true);
    } else {
      /// 同意申请。
      Navigator.of(context).pop(true);
    }
  }

  /// [message] 提示内容
  /// [rightName] 右边确认的名称
  /// [permission] 
  /// [isSetting] 去设置中心
  void showPermissonAlert( 
    String message,
    String rightName, 
    Permission permission,{ bool isSetting = false, } ) {
      
     showCupertinoDialog(
       context: context,
       builder: (BuildContext context){
         return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Container(
              padding: EdgeInsets.all(12),
              child: Text(message,  style: TextStyle(
                letterSpacing: 1.0, wordSpacing: 1.1, height: 1.5),
                textAlign: TextAlign.left,),
              ),
            actions: [
              // 左边的按钮
              CupertinoDialogAction(
                child: Text("${ widget.leftButtonText }"),
                onPressed: () async {
                  if(widget.isCloseApp){
                    /// 关闭应用  import 'package:flutter/services.dart';
                    // await SystemChannels.platform.invokeMethod("SystemNavigator.pop");
                    exit(0); // 关闭应用
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              CupertinoDialogAction(
                child: Text("${rightName}"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if(isSetting){
                    _isGoSetting = true;
                    // 去设置中心  也是使用到了权限管理的包
                    openAppSettings();
                  } else {
                    // 申请权限
                    requestPermiss(permission);
                  }
                },
              )
            ],
         );
       }
     );

  }

  // 设置权限
  void requestPermiss(Permission permission) async {
    PermissionStatus status = await permission.request(); 
    // 重新校验
    checkPermisson(status: status);
  }

  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
      // backgroundColor: Colors.transparent,
    );
  }
}