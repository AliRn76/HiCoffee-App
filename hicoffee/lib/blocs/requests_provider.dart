
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hicoffee/model/log_model.dart';
import 'package:hicoffee/model/item_model.dart';
import 'package:hicoffee/blocs/logs_provider.dart';
import 'package:hicoffee/sqlite/database_helper.dart';
import 'package:jalali_date/jalali_date.dart';


class RequestsProvider extends ChangeNotifier{

  RequestsProvider() {
    selectAll();
  }

  List<Item> _items = [];

  List get items => _items;

  set items(List<Item> list){
    _items = list;
    notifyListeners();
  }


  void selectAll()async{
    var result = await DatabaseHelper().selectItems();
    print("* selectAll Result: $result");
    items = result.map((m) => Item.fromMap(m)).toList();
  }

  Future<int> reqAddItem(Item item) async{
      var result = await DatabaseHelper().insertItem(item);
      print("Insert db Result: $result");
      _items.add(item);
      Log log = Log(
          "${item.name} ${item.countType}: ${item.number} ثبت شد.",
          "add", PersianDate.fromDateTime(DateTime.now().toLocal()).toString(
          showTime: true, second: true)
      );
      LogsProvider logsProvider = LogsProvider();
      var result2 = await DatabaseHelper().insertLog(log);
      print("Add Log db Result: $result2");
      logsProvider.addLog(log);
      notifyListeners();

      return 200;
  }

  Future<int> reqDeleteItem(Item item) async{
      var result = await DatabaseHelper().deleteItem(item);
      print("Delete db Result: $result");
      _items.remove(item);

      Log log = Log(
          "${item.name} ${item.number} ${item.countType} حذف شد.",
          "delete", PersianDate.fromDateTime(DateTime.now().toLocal()).toString(
          showTime: true, second: true)
      );
      LogsProvider logsProvider = LogsProvider();
      var result2 = await DatabaseHelper().insertLog(log);
      print("Delete Log db Result: $result2");
      logsProvider.addLog(log);
      notifyListeners();

      return 200;
  }

  Future<int> reqSellItem(Item item, int sellValue) async{
      var result = await DatabaseHelper().updateItem(item, sellValue);
      print("Sell db Result: $result");
      // Update the provider
      for(int i=0 ; i<_items.length ; i++){
        if (_items[i].name == item.name)
          _items[i].number = _items[i].number - sellValue;
      }
      Log log = Log(
          "${item.name} $sellValue ${item.countType} فروخته شد. موجودی: ${item.number}",
          "sell", PersianDate.fromDateTime(DateTime.now().toLocal()).toString(
          showTime: true, second: true)
      );
      LogsProvider logsProvider = LogsProvider();
      var result2 = await DatabaseHelper().insertLog(log);
      print("Sell Log db Result: $result2");
      logsProvider.addLog(log);
      notifyListeners();

      return 200;
  }


  Future<int> reqEditItem(String oldName, String newName, int newNumber, String countType) async{
      var result = await DatabaseHelper().editItem(oldName, newName, newNumber, countType);
      print("Edit db Result: $result");
      String lastType;
      int oldNumber;
      for(int i=0 ; i<_items.length ; i++){
        if (_items[i].name == oldName){
          _items[i].name    = newName;
          oldNumber = _items[i].number;
          _items[i].number  = newNumber;
          lastType = _items[i].countType;
          _items[i].countType  = countType;
        }
      }
      Log log = Log(
          "$oldName $lastType: $oldNumber به $newName $countType: $newNumber ویرایش شد.",
          "edit", PersianDate.fromDateTime(DateTime.now().toLocal()).toString(
          showTime: true, second: true)
      );
      LogsProvider logsProvider = LogsProvider();
      var result2 = await DatabaseHelper().insertLog(log);
      print("Edit Log db Result: $result2");
      logsProvider.addLog(log);
      notifyListeners();
    return 202;
  }
}