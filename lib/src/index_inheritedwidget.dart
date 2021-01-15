 
import 'package:YuWeiFlutterApp/src/common/theme_model.dart';
import 'package:YuWeiFlutterApp/src/text3.dart';
import 'package:YuWeiFlutterApp/src/userbean.dart';
import 'package:YuWeiFlutterApp/src/util/navigator_util.dart';
import 'package:provider/provider.dart'; 
import 'package:flutter/material.dart';

class IndexInHeritedWidget extends StatefulWidget {
  @override
  _IndexInHeritedWidgetState createState() => _IndexInHeritedWidgetState();
}

class _IndexInHeritedWidgetState extends State<IndexInHeritedWidget> {

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
 

 
  @override
  Widget build(BuildContext context) {
    print("page1  ");
    return Scaffold(
      appBar: AppBar(
        title: Text("Page_1"),
      ),
      body:   Container(
           width: double.infinity,
           height: double.infinity,
           color: Color(0x88f1f1f1),
           child: Column(
             children: [
             
               SizedBox(height: 200.0,),

               Consumer<String>(
                 builder: (context, value , child){
                   return Text(value);
                 },
               ),
              
               Consumer<int>(
                 builder: (context, value, child){
                   return Text(value.toString());
                 },
               ),

               Consumer<UserBean>(
                 builder: (context, value, child){
                   return Text(value.name);
                 },
               ),
              Consumer<UserBean>(
                 builder: (context, value, child){
                   return Text("| Consumer 读取 |  " + value.address);
                 },
               ),

               Selector<UserBean, UserBean>(
                 builder: (context, value, child){
                   return Text("| Selector 读取 |  " + value.name);
                 },
                 selector: (context, UserBean){
                   return UserBean;
                 },
               ),

               FlatButton(
                 onPressed: (){ 

                   // 反转颜色。
                   Provider.of<ThemeModel>(context, listen: false).reverse();
                  
                 },
                 child: Consumer<ThemeModel>(
                   builder: (context, type, child){
                     String result = "切换成";
                     if(type.currentType == ThemeType.dark ){
                       result += "白天模式";
                     } else {
                       result += "黑夜模式";
                     }
                     return Text(result);
                   },
                 )
                //  child: 
                //       Selector<ThemeModel, ThemeType>(
                //         builder: (context, type, child){
                //           String result = "切换成";
                //           if(type == ThemeType.dark ){
                //             result += "白天模式";
                //           } else {
                //             result += "黑夜模式";
                //           }
                //           return Text(result);
                //         },
                //         selector: (context, themeModel){
                //           return themeModel.currentType;
                //         },
                //       )
               ),
               SizedBox(
                 height: 20,
               ),
               FlatButton(
                 onPressed: (){
                   NavigatorUtil.pushPageByFade(context: context, isReplace: true, targPage: Text3() );
                 },
                 child: Text("切换页面"),
               )
             ],
           ),
      ),
    );
  }
}