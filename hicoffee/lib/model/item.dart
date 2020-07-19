class Item{
  String name;
  int number;
  Item(
      this.name,
      this.number,
      );

  Item.fromJson(Map<String, dynamic> json){
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['number'] = number;
    return map;
  }


  Item.fromMap(Map<String, dynamic> map){
    name = map['Name'];
    number = map['Number'];
  }
}
