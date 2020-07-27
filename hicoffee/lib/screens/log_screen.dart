import 'package:flutter/material.dart';
import 'package:hicoffee/blocs/logs_provider.dart';
import 'package:hicoffee/model/log_model.dart';
import 'package:provider/provider.dart';
//import 'package:intl/intl.dart';

class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<Log> logs = [];

//  List<Log> logs = [Log("ماگ قهوه ای فروحته شد.","sell"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ قهوه ای فروحته شد","sell"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"),
//    Log("ماگ قهوه ای فروحته شد.","sell"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"), Log("ماگ قهوه ای فروحته شد","sell"), Log("ماگ زدر تعداد: ۲ حذف شد","delete"),  Log("نام: قهوه برزیل، تعداد: ۲ به نام: برزیل ۳، تعداد: ۳ ویرایش شد","edit"), Log("نام: قهوه برزیل، تعداد: ۱۵ ثبت شد.", "add"),];
  Color borderColor;
  Color backColor;

  @override
  Widget build(BuildContext context) {
    final LogsProvider logsProvider = Provider.of<LogsProvider>(context);
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Builder(
          builder: (BuildContext context){
            return ListView.builder(
                itemCount: logsProvider.logs.length,
                itemBuilder: (context, index){
                  return _showLog(logsProvider.logs[index]);
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
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
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
                padding: EdgeInsets.all(15.0),
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
          Positioned(
            bottom: -4.8,
            left: 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              color: backColor,
              child: Text(
                log.date,
                style: TextStyle(
                  fontFamily: "BNazanin",

                  fontWeight: FontWeight.bold,
                  color: borderColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
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
