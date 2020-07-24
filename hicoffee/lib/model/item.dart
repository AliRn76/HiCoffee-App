class Item{
  String name;
  int number;
  Item(
      this.name,
      this.number,
      );

  // in bara db estefade mishe
  // chon too db column ha avaleshon harfe kochike
  Item.fromJson(Map<String, dynamic> json){
    name = json['name'];
    number = json['number'];
  }

  // in bara db estefade mishe
  // chon too db column ha avaleshon harfe bozorge
  // vagar na ba balaei yekie
  Item.fromMap(Map<String, dynamic> map){
    name = map['Name'];
    number = map['Number'];
  }

  // convert to map
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['number'] = number;
    return map;
  }
}
