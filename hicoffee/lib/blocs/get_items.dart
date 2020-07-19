import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hicoffee/model/item.dart';
import 'package:hicoffee/sqlite/database_helper.dart';
import 'package:http/http.dart';


class GetItems extends ChangeNotifier{

  // Ta tooye main GetItems() seda zade mishe , inja tooye constructor in 2 ta
  // function ro ejra mikone (faghat nmidonm chera 2 bar ejrash mikone - ziad mohem nist :D)
  GetItems() {
    // Use the local db
    selectAll();
    // Get data from server
    requestItems();
  }

  // Tarif avalie
  List<Item> _items = [];

  // Har vaght items ro khast _items ro behesh midam
  List get items => _items;

  // age chizi behem pas dad , mirizam to _items
  set items(List<Item> list){
    _items = list;
    notifyListeners();
  }

  // Select * kon va beriz too items
  void selectAll()async{
    var result = await DatabaseHelper().selectItems();
    print("* selectAll Result: $result");
    items = result.map((m) => Item.fromMap(m)).toList();
  }

  // Req bede va briz too items
  // Age req 200 bood , insert kon too db
  void requestItems() async{
    try{
      Response response = await get("http://al1.best:85/api/show-all/");
      print("response: $response");
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      print("data: $data");
      // Serialize data
      items = data.map((m) => Item.fromJson(m)).toList();
      print("items: $items");
      if (response.statusCode == 200){
        var result = await DatabaseHelper().insertItems(items);
        print("*Inser Result: $result");
      }
    }on Exception{
      print("** Try Again To Send Get Request");
      Future.delayed(const Duration(seconds: 5), () {
        requestItems();
      });
    }
  }
}