import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hicoffee/model/log_model.dart';
import 'package:hicoffee/model/item_model.dart';



class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

/// Table ITEM
  String tbl_item   = "Item";
  String col_id     = "ID";
  String col_name   = "Name";
  String col_number = "Number";
  String col_count_type = "CountType";
  String col_date   = "Date";

/// Table USER
  String tbl_user   = "User";
  // String col_id = "ID";
  String col_token  = "Token";

/// Table LOG
  String tbl_log    = "Log";
  // String col_id = "ID";
  String col_type   = "Type";
  String col_text   = "Text";
  // String col_date   = "Date";

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
    print(databasePath);
    String path = join(databasePath, 'HiCoffee.db');
    print(path);
    // Increase the version of db everytime update the tables
    Database database = await openDatabase(path, version: 1, onCreate: _createDB);
    return database;
  }

  // Create Tables
  void _createDB(Database db, int version) async{
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tbl_item ('
            '$col_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$col_name TEXT,'
            '$col_count_type TEXT,'
            '$col_number INTEGER,'
            '$col_date Text)'
    );
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tbl_user ('
            '$col_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$col_token TEXT)'
    );
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tbl_log ('
            '$col_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$col_type TEXT,'
            '$col_text TEXT,'
            '$col_date TEXT)'
    );
  }


/// Table ITEM

  // Select All Items
  Future<List<Map<String, dynamic>>> selectItems() async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Select * From $tbl_item"
    );
    return result;
  }

  // Insert All Items
//  Future<List<Map<String, dynamic>>> insertItems(List<Item> items) async{
////    deleteItems();
//    Database db = await this.database;
//    var result;
//    for(int i=0 ; i<items.length ; i++){
//      result = await db.rawQuery(
//        "Insert Into $tbl_item"
//            "($col_name, $col_number, $col_count_type)"
//            "Values ('${items[i].name}', ${items[i].number}, '${items[i].countType}');"
//      );
//    }
//    return result;
//  }

  // Delete All Items
//  Future<List<Map<String, dynamic>>> deleteItems() async{
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "Delete From $tbl_item;"
//    );
//    return result;
//  }


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
        "Insert Into $tbl_item "
            "($col_name, $col_number, $col_count_type)"
            "Values ('${item.name}', ${item.number}, '${item.countType}');"
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

  // Update One Item (Edit)
  Future<List<Map<String, dynamic>>> editItem(String oldName, String newName, int newNumber, String countType) async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "UPDATE $tbl_item "
            "SET $col_name = '$newName' ,"
                "$col_number = '$newNumber' ,"
                "$col_count_type = '$countType' "
            "WHERE $col_name = '$oldName'; ");
    return result;
  }

/// Table USER

  // Insert Token
  Future<List<Map<String, dynamic>>> insertToken(String token) async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Insert Into $tbl_user ($col_token)"
            "VALUES ('$token');"
    );
    return result;
  }

  // Select Token
  Future<List<Map<String, dynamic>>> selectToken() async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Select $col_token From $tbl_user"
    );
    print("Select Token from db: $result");
    return result;
  }

  // Delete Token
  Future<List<Map<String, dynamic>>> deleteToken() async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Delete From $tbl_user"
    );
    return result;
  }

/// Table LOG
  // Insert All Logs
  Future<List<Map<String, dynamic>>> insertLog(Log logs) async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Insert Into $tbl_log"
            "($col_type, $col_text, $col_date)"
            "Values ('${logs.type}', '${logs.text}', '${logs.date}');"
    );
    return result;
  }


  // Insert All Logs
  Future<List<Map<String, dynamic>>> insertLogs(List<Log> logs) async{
    deleteLogs();
    Database db = await this.database;
    var result;
    for(int i=0 ; i<logs.length ; i++){
      result = await db.rawQuery(
          "Insert Into $tbl_log"
              "($col_type, $col_text, $col_date)"
              "Values ('${logs[i].type}', '${logs[i].text}', '${logs[i].date}');"
      );
    }
    return result;
  }

  // Select All Logs
  Future<List<Map<String, dynamic>>> selectLogs() async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Select * From $tbl_log ORDER BY date desc"
    );
    return result;
  }


  // Delete All Logs
  Future<List<Map<String, dynamic>>> deleteLogs() async{
    Database db = await this.database;
    var result = await db.rawQuery(
        "Delete From $tbl_log;"
    );
    return result;
  }
}













