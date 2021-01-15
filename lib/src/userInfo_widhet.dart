 
import 'package:YuWeiFlutterApp/src/userbean.dart';
import 'package:flutter/widgets.dart';

class UserInfoInheritedWidget extends InheritedWidget {
  UserBean userBean;
  Function updateInfo;
  UserInfoInheritedWidget({
    this.userBean,
    Key key,
    Widget child,
    this.updateInfo,
  }):super(key: key, child: child);
  void updateUserBean({String username, String useraddress}){
    updateInfo(username,useraddress);
  }
  
  @override
  bool updateShouldNotify(UserInfoInheritedWidget oldWidget) { 
    return oldWidget.userBean != userBean;
    // if( oldWidget.userBean.name != userBean.name || oldWidget.userBean.address != userBean.address ){
    //   return true;  //  更新视图
    // } 
    // return false;  // 不更新视图
  }
}
 
 
class UserInfoWidget extends StatefulWidget {

  UserBean userBean;

  Widget child;

  UserInfoWidget({this.userBean, Key key , this.child}) : super(key: key);

  static UserInfoInheritedWidget of( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<UserInfoInheritedWidget>();
  }


  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {

  void _updata(String name , String address){ 
    widget.userBean = UserBean(name: name , address:  address);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserInfoInheritedWidget(
      userBean: widget.userBean,
      child: widget.child,
      updateInfo : _updata
    );
  }
}