import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewModel extends StatefulWidget {
  String pageUrl;
  String pageTitle;
  WebViewModel({this.pageUrl, this.pageTitle= ""});
  @override
  _WebViewModelState createState() => _WebViewModelState();
}

class _WebViewModelState extends State<WebViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${ widget.pageTitle }"),
      ),
      
      backgroundColor: Colors.white,
      body:WebView(
        initialUrl: widget.pageUrl,
      ) ,
    );
  }
}