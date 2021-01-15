
import 'package:YuWeiFlutterApp/src/common/webview_model.dart';
import 'package:YuWeiFlutterApp/src/util/console.log.dart';
import 'package:YuWeiFlutterApp/src/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

/// 用户协议的模块

class ProtocolModel {

  TapGestureRecognizer _registProtocol; // 用户协议
  TapGestureRecognizer _privacyProtocol; // 隐私协议


  
  // 用来显示用户协议  为什么要异步？因为我处理完这个弹框后关闭要处理事情，而不是直接在那个弹框哪里处理事情
  Future<bool> showProtocolFunction(BuildContext context) async {

    // 注册手势
    _registProtocol = TapGestureRecognizer();
    _privacyProtocol = TapGestureRecognizer();


    bool isShow = await showCupertinoDialog(
      context: context,
      builder: (BuildContext context){
        return cupertinoAlertDialog(context);
      }
    );

    // 销毁手势
    _registProtocol.dispose();
    _privacyProtocol.dispose();

    return Future.value(isShow);

  }

  CupertinoAlertDialog cupertinoAlertDialog(BuildContext context){
        return CupertinoAlertDialog(
          title: Text("温馨提示"),
          content: Container(
            height: 250.0,
            padding: EdgeInsets.only(top:12, left : 5.0, right : 5.0),
            child: SingleChildScrollView(
              child: buildContainer(context),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text("不同意"),
              onPressed: (){
                Navigator.of(context).pop(false);
                Console.log('不同意协议');
              },
            ),
            CupertinoDialogAction(
              child: Text("同意"),
              onPressed: (){
                Navigator.of(context).pop(true);
                Console.log('同意协议');
              },
            )
          ],
        );
      }

  String protocolText = "我们一向尊重并会严格保护用户在使用本产品时的合法权益（包括用户隐私、用户数据等）不受到任何侵犯。本协议（包括本文最后部分的隐私政策）是用户（包括通过各种合法途径获取到本产品的自然人、法人或其他组织机构，以下简称“用户”或“您”）与我们之间针对本产品相关事项最终的、完整的且排他的协议，并取代、合并之前的当事人之间关于上述事项的讨论和协议。本协议将对用户使用本产品的行为产生法律约束力，您已承诺和保证有权利和能力订立本协议。用户开始使用本产品将视为已经接受本协议，请认真阅读并理解本协议中各种条款，包括免除和限制我们的免责条款和对用户的权利限制（未成年人审阅时应由法定监护人陪同），如果您不能接受本协议中的全部条款，请勿开始使用本产品。";

  buildContainer(BuildContext context){
    // 富文本
    return RichText(
      text: TextSpan(
        text: "请您在使用本产品之前仔细阅读",
        style: TextStyle(color:Color(0xff333333)),
        children: [
          TextSpan(
            text: "《用户协议》",
            style: TextStyle(color:Colors.blue),
            recognizer: _registProtocol..onTap = (){
              openRegistProtocol(context);
            }
          ),
          TextSpan(
            text: "与",
            style: TextStyle(color:Colors.black, fontWeight: FontWeight.w500)
          ),
          TextSpan(
            text: "《隐私协议》",
            style: TextStyle(color:Colors.blue),
            recognizer: _privacyProtocol..onTap = (){
              openPrivacyProtocol(context);
            }
          ),
          TextSpan(
            text: "并同意协议，",
            style: TextStyle(color:Colors.black, fontWeight: FontWeight.w500)
          ),
           TextSpan(
            text: protocolText, 
          ),
           TextSpan(
            text: "上述内容纯属虚构请勿担心。",
            style: TextStyle(color:Colors.redAccent, fontWeight: FontWeight.w500)
          ),
          
        ]
      ),
    );
  }

  // 用户协议
  void openRegistProtocol(BuildContext context){
    Console.log("《用户协议》"); 
    NavigatorUtil.pushPage(
      context: context, 
      targPage:  WebViewModel(
        pageTitle: "用户协议",
        pageUrl: "https://blog.csdn.net/weixin_45080852/article/details/112260111",
      )
    );
  }
  // 隐私协议
  void openPrivacyProtocol(BuildContext context){
    Console.log("《隐私协议》");
     NavigatorUtil.pushPage(
      context: context, 
      targPage:  WebViewModel(
        pageTitle: "隐私协议", 
        pageUrl: "https://blog.csdn.net/weixin_45080852/article/details/112274066",
      )
    );
  }

}