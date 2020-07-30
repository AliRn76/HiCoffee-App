import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import 'package:hicoffee/model/log_model.dart';

import 'package:hicoffee/sqlite/database_helper.dart';



class LogsProvider extends ChangeNotifier {

  /// contructor
  LogsProvider() {
    reqShowLogs();
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

  void reqShowLogs() async{
    try{
      Map<String, String> reqHeader = {"Authorization": "Token ${await selectToken()}"};
      Response response = await get("http://al1.best:85/api/show-logs/", headers: reqHeader);
      print("response: ${response.statusCode}");
      List<dynamic> data = await jsonDecode(utf8.decode(response.bodyBytes));
      // Serialize data
      _logs = data.map((m) => Log.fromJson(m)).toList();
      notifyListeners();
    }on Exception{
      print("** Try again req in Log Provider ");
      Future.delayed(const Duration(seconds: 5), () {
        reqShowLogs();
      });
    }
  }

}