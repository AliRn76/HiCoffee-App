import 'package:hicoffee/sqlite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginProvider extends ChangeNotifier {

  LoginProvider(){
  }

  String _token;

  String get token => _token;

  set token(String value){
    _token = value;
    notifyListeners();
  }

  Future<bool> checkToken() async{
    var result = await DatabaseHelper().selectToken();
    if(result.isNotEmpty){
      token = result.first['Token'];
      return true;
    }else
      return false;
  }
}