### 关于flutter APP 中的权限访问。 2021-1-6

**借助于第三方库**

> permission_handler

这里查找这个库与怎样添加，在这就不再说了，直接来正文。


在我们日常的app中难免会遇到访问本地权限的时候，则我们需要申请是否访问权限。

这是我们这个Permission就能帮助处理一些和手机上的权限问题。

## android权限访问的配置文件

在下面文件中设置

> android>app>src>main>AndroidManifest.mxl  

```dart
在manifest下面添加一下文件。

<!-- 英特尔 -->
<uses-permission android:name="android.permission.INTERNET" /> 
<!-- 文件存储 -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<!-- GPS定位 ACCESS_FINE_LOCATION location-->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/> 
<!-- 相机权限 -->
<uses-permission android:name="android.permission.CAMERA"/> 
```

## IOS权限访问的配置文件

在下面文件中设置

> ios>app>Runner>Info.plist



```dart

在dict添加简直对的形式

<key>NSCameraUsageDescription</key>
<string>为了您刚好的体验,App需要访问您的相机权限。</string>
```
 
**切记，当我们需要使用权限的时候，都需要去对应的配置文件中配置，才能够访问与打开权限**


## 具体使用

```dart
// 添加要访问的权限是什么
Permission permission = Permission.camera;  // 相机权限

// 获取当前权限的状态
PermissionStatus status = permission.status; 

// 判断当前状态处于什么类型
if( status.isUndetermined ){
    // 第一次申请权限
} else if( status.isDenied ){
    // 第一次申请被拒绝 再次重试
} else if( status.isPermanentlyDenied ){
    // 第二次申请被拒绝 去设置中心
} else if( status.isGranted ){
    // 同意了访问权限。
    // 处理该处理的事情
}

// 处理权限申请
PermissionStatus status = await permission.request();

// 然后处理完再次验证。

```

当去设置中心的时候，应为有个回来的过程，则我们需要借助于**观察者模式**，观察状态时候返回，返回后重新验证权限。


## 具体例子
```dart
/// 权限申请，我们这使用Widget的形式。
import 'dart:io';
import 'package:YuWeiFlutterApp/src/util/console.log.dart';
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
  State<StatefulWidget> createState(){
    return _PermissonRequestWidgetState();
  }
}

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
    Console.log("销毁观察者 ${ _isGoSetting }");
    // 销毁观察者
    if(state == AppLifecycleState.resumed && _isGoSetting){
      Console.log("进入观察者 ${ _isGoSetting }");
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
      Console.log("当前权限 ${ status }");
    if( status.isUndetermined ){
      /// 第一次 申请
      Console.log("第一次权限申请");
      showPermissonAlert(widget.permissonList[0],"同意", permission);
    } else if( status.isDenied ){
      /// 第一次申请拒绝 再 第二次申请
      Console.log("第二次申请");
      /// 
      if(Platform.isIOS){
         showPermissonAlert(widget.permissonList[2],"去设置中心", permission, isSetting: true);
      } else if(Platform.isAndroid){
         showPermissonAlert(widget.permissonList[1],"重试", permission);
      }
    } else if( status.isPermanentlyDenied ){
      /// 第二次申请拒绝     
      Console.log("去设置中心");

      showPermissonAlert(widget.permissonList[2],"去设置中心", permission, isSetting: true);
    } else {
      /// 同意申请。
      // showPermissonAlert(widget.permissonList[0],"同意", permission);
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
```