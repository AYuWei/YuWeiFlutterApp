
// 输出日志
class Console {
   // 是否输出日志
   static bool _isLog = true;
   static String _logFlag = "测试 - YuWei";

   static void init({bool islog = false, String logFlag = "测试 - YuWei"}){
      _isLog = islog;
      _logFlag = logFlag;
   }

   static void log(String message){
     if(_isLog){
       print("$_logFlag | $message");
     }
   }
}