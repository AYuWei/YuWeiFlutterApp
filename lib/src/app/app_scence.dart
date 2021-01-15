 
import 'package:YuWeiFlutterApp/src/pages/Diary/diary.dart';
import 'package:YuWeiFlutterApp/src/pages/Home/home.dart';
import 'package:YuWeiFlutterApp/src/pages/My/my.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

//  出事页面。
class AppScence extends StatefulWidget {
  @override
  _AppScenceState createState() => _AppScenceState();
}

class _AppScenceState extends State<AppScence> {

    List<Widget> _children = [ Home(), Diary() ];
    List<String> _childrenName = ['组件', '日记'];
    List<num> _childrenIcon = [0xe66a,0xe962];
    num _childIndex = 0;

  @override
  Widget build(BuildContext context) {

 

    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: Text(_childrenName[_childIndex], key: UniqueKey(),),
        ),
      ),
      drawer : My(),

      body: AnimatedContainer(
        duration: Duration(milliseconds:200),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds:200),
          child: _children[_childIndex],
        ),
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          ...List.generate(_childrenName.length, (index) => BottomNavigationBarItem(
            icon: Icon(IconData(
              _childrenIcon[index],
              fontFamily : 'MyFontFamily'
            )),
            title: Text(_childrenName[index])
          ))
        ],
        type : BottomNavigationBarType.fixed, // fixed 将导航条固定在底部。
        // 点击的时候触发事件
        onTap: (e){
          setState(() {
            _childIndex = e;
          });
        }, 
        // 当点击的时候获取下标
        currentIndex: _childIndex,
        backgroundColor: Color.fromRGBO(200, 200, 200, 0.6),
      ),
    );

  }
}


 