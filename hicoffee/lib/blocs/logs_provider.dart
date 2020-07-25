import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hicoffee/model/item.dart';
import 'package:hicoffee/model/log.dart';
import 'package:hicoffee/sqlite/database_helper.dart';
import 'package:http/http.dart';
import 'package:hicoffee/blocs/connection_provider.dart';
import 'package:intl/intl.dart';


class LogsProvider extends ChangeNotifier {
  LogsProvider() {
    // Constructor
    reqShowLogs();
  }
  List<Log> _logs = [];

  List get logs => _logs;

  set logs(List<Log> list){
    _logs = list;
    notifyListeners();
  }

  void reqShowLogs() async{
    try{
      Response response = await get("http://al1.best:85/api/show-logs/");
      print("response: ${response.statusCode}");
      List<dynamic> data = await jsonDecode(utf8.decode(response.bodyBytes));
      print("data: $data");
      // Serialize data
      logs = data.map((m) => Log.fromJson(m)).toList();
      print("logs: $logs");
      // Add the items in local db
//      if (response.statusCode == 200){
//        var result = await DatabaseHelper().insertItems(items);
//        print("*Insers db Result: $result");
//      }
    }on Exception{
      print("** Try again req in Log Provider ");
      Future.delayed(const Duration(seconds: 5), () {
        reqShowLogs();
      });
    }
  }

}