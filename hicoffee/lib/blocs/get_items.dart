import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hicoffee/model/item.dart';
import 'package:http/http.dart';


class GetItems extends ChangeNotifier{
//  List<Item> _items = [
//    Item("bye",3),              Item("کلمبیا۱۹", 33),
//    Item("اندونزی مدیوم", 30),    Item("میلانو", 0),
//    Item("کلمشسیب( شسیب یسبییی ییییییییییب بببببببببببببببببیا۱۹", 383),
//    Item("ترک لایت", 25),          Item("سالوادور", 0),
//    Item("نیکاراگوئه", 28),       Item("پرو", 5),
//    Item("ویتنام", 0),            Item("گلد اکوادور(بسته ۵ کیلویی)", 0),
//    Item("چای ماسالا (بسته)", 30), Item("اتیوپی", 30),
//    Item("پی بی", 15),            Item("چری", 15),
//    Item("برزیل", 19)];

  List<Item> _items = [];
  // Har vaght items ro khast _items ro behesh midam
  List get items => _items;

  // age chizi behem pas dad , mirizam to _items
  set items(List<Item> list){
    _items = list;
    notifyListeners();
  }


  void requestItems() async{
    try{
      //    items.clear();
      Response response = await get("http://al1.best:85/api/show-all/");
      print("response: $response");
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      print("data: $data");
      // Serialize data
      items = data.map((m) => Item.fromJson(m)).toList();
      print("items: $items");
    }on Exception{
      print("** Try Again To Send Get Request");
      Future.delayed(const Duration(seconds: 5), () {
        requestItems();
      });
    }
  }
}