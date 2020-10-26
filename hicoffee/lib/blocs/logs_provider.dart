import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:hicoffee/model/log_model.dart';

import 'package:hicoffee/sqlite/database_helper.dart';
import 'package:jalali_date/jalali_date.dart';



class LogsProvider extends ChangeNotifier {

  LogsProvider() {
    selectAll();
  }

  List<Log> _logs = [];

  List get logs => _logs;

  set logs(List<Log> list){
    _logs = list;
    notifyListeners();
  }

  Future<String> selectToken()async{
    var result = await DatabaseHelper().selectToken();
    return result[0]['Token'];
  }

  void selectAll() async{
    var result = await DatabaseHelper().selectLogs();
    print("Select * Logs from local db Result: $result");
    logs = result.map((m) => Log.fromMap(m)).toList();
  }

  void addLog(Log log){
    _logs.insert(0, log);
    notifyListeners();
  }
}