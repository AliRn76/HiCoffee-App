//import 'package:intl/intl.dart';

class User{
  String token;
  User(
      this.token,
      );

  // in bara db estefade mishe
  // chon too db column ha avaleshon harfe kochike
  User.fromJson(Map<String, dynamic> json){
    token = json['token'];
  }

  // in bara db estefade mishe
  // chon too db column ha avaleshon harfe bozorge
  // vagar na ba balaei yekie
  User.fromMap(Map<String, dynamic> map){
    token = map['Token'];
  }

  // convert to map
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['token'] = token;
    return map;
  }
}