//import 'package:intl/intl.dart';

class Log{
  String text;
  String type;
  String date;
  Log(
      this.text,
      this.type,
      this.date,
      );

  // in bara db estefade mishe
  // chon too db column ha avaleshon harfe kochike
  Log.fromJson(Map<String, dynamic> json){
    text = json['text'];
    type = json['type'];
    date = json['date'];
  }

  // in bara db estefade mishe
  // chon too db column ha avaleshon harfe bozorge
  // vagar na ba balaei yekie
  Log.fromMap(Map<String, dynamic> map){
    text = map['Text'];
    type = map['Type'];
    date = map['Date'];
  }

  // convert to map
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['text'] = text;
    map['type'] = type;
    map['date'] = date;
    return map;
  }
}