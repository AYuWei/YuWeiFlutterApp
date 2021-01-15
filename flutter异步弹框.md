## flutter 异步弹框 2021-1-6

之前我写的弹框都是卸载同一个页面上，或者把弹框抽离出来，但是弹框中的事件我是放在回调函数里面去执行的。

比如说下面这种情况。
```js
showDialogFunction(BuildContext context ,{ Function callBack }){
    showCupertinoDialog(
        context : context,
        builder : (BuildContext context){
            return CupertinoAlertDialog(
                title : Text("温馨提示"),
                content : Container(
                    hieght : 200.0
                    child : SingleChildScrollView(
                        /// 文本提示
                    )
                ),
                actions : [
                    CupertinoDialogAction(
                        child : Text("不同意");
                        onPressed:(){
                            // 分别不同的处理callBack
                        }
                    ),
                    CupertinoDialogAction(
                        child : Text("同意");
                        onPressed: (){
                            // 分别不同的处理callBack
                        }
                    )
                ]
            )
        }
    )
}
 
```

以上的方法就只用在CupertinoDialogAction按钮中处理事件，不能当你点击了返回会在处理。

则我们需要一个异步的，当我们打开这个弹框的时候，我们等待，然后点击了按钮后才执行下一步计划。

**等待返回后在执行** 下面则我们电视同意或者不同意都会返回一个值。然后我们就可以哪这个值下一步操作了。
```js
    // 等待弹框被点击后返回事件
    bool isShow = await showDialogFunction(context);

    if(isShow){
        // 放大胆的去干你想干的事情
    }

    // showDialogFunction 弹框方法
    Future<bool> showDialogFunction(BuildContext context) async {
        bool isShow = await showCupertinoDialog(
            context : context,
            builder : (BuildContext context){
                return cupertinoAlertDialog(context);
            }
        );
        return Future.value(isShow);
    }

    CupertinoAlertDialog cupertinoAlertDialog(BuildContext context){
      return CupertinoAlertDialog(
        title: Text("温馨提示"),
        content: Container(
          height: 250.0,
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Text("文案"),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("不同意"),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
          ),
          CupertinoDialogAction(
            child: Text("同意"),
            onPressed: (){
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    }
 
```