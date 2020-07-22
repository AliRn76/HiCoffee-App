import 'package:hicoffee/model/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';


class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tbl_item   = "Item";
  String col_id     = "ID";
  String col_name   = "Name";
  String col_number = "Number";

  DatabaseHelper._CreateInstance();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._CreateInstance();
    }
    return _databaseHelper;
  }

  // Create Database if it's null
  Future<Database> get database async{
    if (_database == null)
      _database = await initializeDatabase();

    return _database;
  }

  // Create Database
  Future<Database> initializeDatabase() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'HiCoffee.db');

    Database database = await openDatabase(path, version: 1, onCreate: _createDB);
    return database;
  }

  // Create Tables
  void _createDB(Database db, int version) async{
    await db.execute(
        'CREATE TABLE $tbl_item ('
            '$col_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$col_name TEXT,'
            '$col_number INTEGER)'
    );
  }

  // Select All Items
  Future<List<Map<String, dynamic>>> selectItems() async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Select * From $tbl_item"
    );
    return result;
  }

  // Insert All Items
  Future<List<Map<String, dynamic>>> insertItems(List<Item> items) async{
    deleteItems();
    Database db = await this.database;
    var result;
    for(int i=0 ; i<items.length ; i++){
      result = await db.rawQuery(
        "Insert Into $tbl_item"
            "($col_name, $col_number)"
            "Values ('${items[i].name}', ${items[i].number});"
      );
    }
    return result;
  }

  // Delete All Items
  Future<List<Map<String, dynamic>>> deleteItems() async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Delete From $tbl_item;"
    );
    return result;
  }


  // Delete One Item
  Future<List<Map<String, dynamic>>> deleteItem(Item item) async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Delete From $tbl_item Where $col_name == '${item.name}';"
    );
    return result;
  }

  // Insert One Item
  Future<List<Map<String, dynamic>>> insertItem(Item item) async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Insert Into $tbl_item ($col_name, $col_number)"
            "VALUES ('${item.name}', ${item.number});"
    );
    return result;
  }


  // Update One Item (Sell)
  Future<List<Map<String, dynamic>>> updateItem(Item item, int sellValue) async{
    Database db = await this.database;
    int newValue = item.number - sellValue;
    var result = await db.rawQuery(
        "UPDATE $tbl_item "
            "SET $col_number = $newValue "
            "WHERE $col_name = '${item.name}'; ");
    return result;
  }

}













