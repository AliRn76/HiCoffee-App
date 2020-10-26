import 'package:jalali_date/jalali_date.dart';

class Log{
  String text;
  String type;
  String date;
  Log(
      this.text,
      this.type,
      this.date,
      );

  /// baraye json estefade mishe --> harf avaleshon kochike
  Log.fromJson(Map<String, dynamic> json){
    text = json['text'];
    type = json['type'];
    if(json['date'] != null)
      date = PersianDate.fromDateTime(DateTime.parse(json['date']).toLocal()).toString(
          showTime: true, second: true);
//    else
//      date = json['date'];
  }

  /// baraye db estefade mishe --> harf avaleshon Bozorge
  Log.fromMap(Map<String, dynamic> map){
    text = map['Text'];
    type = map['Type'];
    date = map['Date'];
  }

  /// convert to json baraye send e request
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['text'] = text;
    map['type'] = type;
    map['date'] = date;
    return map;
  }

  /// toMap lazem nadarim chon moghe insert to db , done done mizanim
}