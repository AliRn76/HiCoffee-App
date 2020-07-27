
class User{
  String token;
  User(
      this.token,
      );

  /// baraye json estefade mishe --> harf avaleshon kochike
  User.fromJson(Map<String, dynamic> json){
    token = json['token'];
  }

  /// baraye db estefade mishe --> harf avaleshon Bozorge
  User.fromMap(Map<String, dynamic> map){
    token = map['Token'];
  }

  /// convert to json baraye send e request (inja alakie)
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['token'] = token;
    return map;
  }

  /// toMap lazem nadarim chon moghe insert to db , done done mizanim
}