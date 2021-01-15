 
import 'package:YuWeiFlutterApp/main.dart';
import 'package:YuWeiFlutterApp/src/userInfo_widhet.dart';
import 'package:YuWeiFlutterApp/src/userbean.dart';
import 'package:flutter/material.dart';

class IndexTextPage extends StatefulWidget {
  @override
  _IndexTextPageState createState() => _IndexTextPageState();
}

class _IndexTextPageState extends State<IndexTextPage> {

  
  @override
  void initState() { 
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    print("page2");

    return Scaffold(
      appBar: AppBar(
        title: Text("Page_2"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0x88f1f1f1),
        child: Column(
          children: [
            SizedBox(height: 200.0,),
            Text( UserInfoWidget.of(context).userBean.name),
            // Text(UserInfoWidget.of(context).userBean.name),
            SizedBox(height: 10.0,),
            Text(UserInfoWidget.of(context).userBean.address),

            SizedBox(height: 290.0,),

            FloatingActionButton(
              onPressed: (){  

                // eventBus.fire(UserBean( name:"flutter EventBus", address: "Chian EventBus"));
                
                UserInfoWidget.of(context).updateUserBean( username: "Flutter Change", useraddress: "Chian Change");

                // NavigatorUtil.pushPageByFade(context: context, isReplace: true, targPage: IndexInHeritedWidget() );
              },
              child: Icon(Icons.error),
            ),
            SizedBox(height: 20.0,),

            // FloatingActionButton(
            //   onPressed: (){
            //     // NavigatorUtil.pushPage(context: context , targPage: IndexTextPage());
            //     // Navigator.of(context).push(MaterialPageRoute(
            //     //   builder: (context) => IndexTextPage()
            //     // ));
            //   },
            //   child: Icon(Icons.chevron_right),
            // )


          ],
        ),
      ),  
    );
  }
}