

class Item{
  String name;
  int number;

  Item(
      this.name,
      this.number,
      );

  /// baraye json estefade mishe --> harf avaleshon kochike
  Item.fromJson(Map<String, dynamic> json){
    name = json['name'];
    number = json['number'];
  }

  /// baraye db estefade mishe --> harf avaleshon Bozorge
  Item.fromMap(Map<String, dynamic> map){
    name = map['Name'];
    number = map['Number'];
  }

  /// convert to json baraye send e request
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['number'] = number;
    return map;
  }

  /// toMap lazem nadarim chon moghe insert to db , done done mizanim
}

