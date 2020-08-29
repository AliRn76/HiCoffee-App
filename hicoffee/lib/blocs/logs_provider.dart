import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import 'package:hicoffee/model/log_model.dart';

import 'package:hicoffee/sqlite/database_helper.dart';



class LogsProvider extends ChangeNotifier {

  /// contructor
  LogsProvider() {
    reqShowLogs();
    selectAll();
  }

  ///
  List<Log> _logs = [];

  /// getter
  List get logs => _logs;

  /// setter
  set logs(List<Log> list){
    _logs = list;
    notifyListeners();
  }

  // Select Token
  Future<String> selectToken()async{
    var result = await DatabaseHelper().selectToken();
    return result[0]['Token'];
  }


  // Select * from local db
  void selectAll() async{
    var result = await DatabaseHelper().selectLogs();
    print("Select * Logs from local db Result: $result");
    logs = result.map((m) => Log.fromMap(m)).toList();
  }

  // GET all logs
  void reqShowLogs() async{
    try{
      Map<String, String> reqHeader = {"Authorization": "Token ${await selectToken()}"};
      Response response = await get("http://al1.best:86/api/show-logs/", headers: reqHeader);
      print("show-logs response: ${response.statusCode}");
      List<dynamic> data = await jsonDecode(utf8.decode(response.bodyBytes));
      // Serialize data
      logs = data.map((m) => Log.fromJson(m)).toList();
      print("logs: $logs");
      // Add the items in local db
      if (response.statusCode == 200){
        var result = await DatabaseHelper().insertLogs(logs);
        print("*Insers Logs to db Result: $result");
      }
    }on Exception{
      print("** Trying to Send show-logs Request ");
      Future.delayed(const Duration(seconds: 7), () {
        reqShowLogs();
      });
    }
  }

}