import 'package:flutter/material.dart';

class UserBean with ChangeNotifier{
  
  String name;
  String address;

  UserBean({this.address,this.name});

  String toString(){
    return "UserBean{name: $name, address : $address}";
  }

} 