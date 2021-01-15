import 'package:YuWeiFlutterApp/src/user_movie.dart';
import 'package:YuWeiFlutterApp/src/userbean.dart';
import 'package:flutter/material.dart';

// Notification

class CustomNotification extends Notification {

  UserBean userBean;

  UserMovieList userMovieList;

  CustomNotification(this.userBean, this.userMovieList);

}