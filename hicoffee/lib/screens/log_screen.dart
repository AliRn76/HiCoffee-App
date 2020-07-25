import 'package:flutter/material.dart';
import 'package:hicoffee/model/log.dart';

class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<Log> logs = [Log("ماگ قهوه ای فروحته شد.","sell"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ قهوه ای فروحته شد","sell"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"),
    Log("ماگ قهوه ای فروحته شد.","sell"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ قهوه ای فروحته شد","sell"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"),];
  Color borderColor;
  Color backColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Builder(
          builder: (BuildContext context){
            return ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index){
                  return _showLog(logs[index]);
                }
            );
          },
        )
      ),
    );
  }

  Widget _showLog(Log log){


    if(log.type == "add") {
      borderColor = Colors.lightGreen[700];
      backColor = Colors.lightGreen[50];

    }else if(log.type == "edit"){
      borderColor = Colors.blue[700];
      backColor = Colors.lightBlue[50];

    }else if(log.type == "delete"){
      borderColor = Colors.red[700];
      backColor = Colors.pink[50];

    }else if(log.type == "sell"){
      borderColor = Colors.yellow[900];
      backColor = Colors.yellow[50];
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
//              child: TextField(
//
//                style: TextStyle(
//                  fontSize: 17.0,
//                  fontWeight: FontWeight.w400,
//                ),
//                maxLines: 1,
//                textDirection: TextDirection.rtl,
//                decoration: InputDecoration(
//
//                  alignLabelWithHint: false,
//                  labelText: "Tarikh",
//                  prefixIcon: Icon(Icons.search)
//                ),
//              ),
            child: Text(
              log.text,
              style: TextStyle(
                fontFamily: "BNazanin",
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Log",
        style: TextStyle(
          fontSize: 28.0,
          fontFamily: "Waltograph",
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}
