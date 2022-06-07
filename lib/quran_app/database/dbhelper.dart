// import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/material.dart';


// // import 'package:mart_up/models/product.dart';
// // import 'package:mart_up/services/user_login_service.dart';
// import 'package:api_test/quran_app/database/db_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// // import 'package:path_provider/path_provider.dart';

// class DBHelper {
//   static Database? _db;
//   static const String ID = 'id';
//   static const String PROID = 'pid';
//   //static const String NAME = 'fname';
//   static const String PNAME = 'name';
//   static const String CITY = 'city';
//   static const String FNAME = 'fname';
//   static const String LNAME = 'lname';
//   static const String ROADNO = 'roadNo';
//   static const String HOUSENO = 'houseNo';
//   static const String MOBILENO = 'mobileNo';
//   static const String IMAGE = 'image';
//   static const String PRICE = 'price';
//   static const String REGULARPRICE = 'regularprice';
//   static const String SHOTDES = 'shotdescription';
//   static const String QUANTITY = 'quantity';
//   static const String CATEGORIES = 'categories';
//   static const String ATTRIBUTES = 'attribute';
//   static const String FAVORITELIST_TABLE = 'Favoritelist';

//   static const String CARTLIST_TABLE = 'Cartlist';
//   static const String ADDRESS_TABLE = 'Addresslist';
//   static const String DB_NAME = 'martup.db';

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await initDb();
//     return _db!;
//   }

//   static initDb() async {
//     String path = join(await getDatabasesPath(), DB_NAME);
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }

//   static _onCreate(Database db, int version) async {
//     await db.execute(
//         "CREATE TABLE $ADDRESS_TABLE ($ID INTEGER PRIMARY KEY,$CITY TEXT, $FNAME TEXT, $LNAME TEXT, $ROADNO TEXT,$HOUSENO TEXT,$MOBILENO TEXT)");
//   }

//   // Future<int> insertTransaction(
//   //     FavoriteModel transactionModel, context) async {
//   //       print(transactionModel);
//   //   Database db = await this.db;
//   //   final int result = await db.insert(FAVORITELIST_TABLE, transactionModel.toJson());
//   //    print('Data added: $result');

//   //   return result;
//   // }

//   Future<AddAddressModel> saveToAddressList(
//       AddAddressModel addAddressModel) async {
//     var dbClient = await db;
//     addAddressModel.id =
//         await dbClient.insert(ADDRESS_TABLE, addAddressModel.toJson());
//     //print(addAddressModel);
//     return addAddressModel;
//     /*
//     await dbClient.transaction((txn) async {
//       var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
//       return await txn.rawInsert(query);
//     });
//     */
//   }

//   Future<List<AddAddressModel>> getAddresses() async {
//     var dbClient = await db;
//     List<Map> maps = await dbClient.query(ADDRESS_TABLE,
//         columns: [ID, CITY, FNAME, LNAME, ROADNO, HOUSENO, MOBILENO]);
//     //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
//     List<AddAddressModel> addresses = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         addresses.add(AddAddressModel.fromJson(Map.from(maps[i])));
//       }
//     }
//     // ignore: unused_local_variable
//     var val = jsonEncode(addresses);
//     //print(val);
//     return addresses;
//   }

//   Future close() async {
//     var dbClient = await db;
//     dbClient.close();
//   }

//   static Future<AddAddressModel> getAddressById(int id) async {
//     final db = await initDb();
//     final List<Map<String, dynamic>> adrs =
//         await db.query(ADDRESS_TABLE, where: '$ID = ?', whereArgs: [id]);
//     // if (adrs.length > 0) {
//     return AddAddressModel.fromJson(adrs.first);
//     // }
//     // return null;
//   }

//   Future<int> updateAddres(AddAddressModel addAddressModel) async {
//     final db = await initDb();
//     var re = await db.update(ADDRESS_TABLE, addAddressModel.toJson(),
//         where: '$ID    = ?', whereArgs: [addAddressModel.id]);
//     return re;
//   }

//   static Future<void> deleteAddress(int id) async {
//     final db = await initDb();
//     await db.delete(ADDRESS_TABLE, where: '$ID = ?', whereArgs: [id]);
//   }

//   // static List<Product> parseCompare(String data) {
//   //   var resultdata = jsonDecode(data) as dynamic;
//   //  List <Product> compare = List<Product>.from(resultdata);
//   //   return compare;
//   // }

//   // Future _onCreate(Database db, int version) async {
//   //   await db.execute('''
//   //     CREATE TABLE address(
//   //         id INTEGER PRIMARY KEY,
//   //         city TEXT,
//   //         fname TEXT,
//   //         lname TEXT,
//   //         roadNo TEXT,
//   //         houseNo TEXT,
//   //         mobileNo TEXT

//   //     )
//   //     ''');
// }



import 'dart:convert';

import 'package:api_test/quran_app/database/db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelper {
  static Database? _db;
  static const String sura = 'sura';

  static const String ayat = 'ayat';
  static const String sura_name = 'sura_name';
  static const String text = 'text';
  static const String VerseIDAr = 'VerseIDAr';

  static const String CARTLIST_TABLE = 'Cartlist';
  static const String ADDRESS_TABLE = 'Addresslist';
  static const String DB_NAME = 'martup.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  static initDb() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  static _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $ADDRESS_TABLE ($sura INTEGER PRIMARY KEY,$ayat TEXT, $sura_name TEXT, $text TEXT, $VerseIDAr INTEGER)");
  }

  Future<AddAddressModel> saveToAddressList(
      AddAddressModel addAddressModel) async {
    var dbClient = await db;
    addAddressModel.sura =
        await dbClient.insert(ADDRESS_TABLE, addAddressModel.toJson());
    //print(addAddressModel);
    print('Saved');
    return addAddressModel;

  }

  Future<List<AddAddressModel>> getAddresses() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(ADDRESS_TABLE, columns: [
      sura,
      ayat,
      sura_name,
      text,
      VerseIDAr,
    ]);

    List<AddAddressModel> addresses = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        addresses.add(AddAddressModel.fromJson(Map.from(maps[i])));
      }
    }
    // ignore: unused_local_variable
    var val = jsonEncode(addresses);
    //print(val);
    return addresses;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  static Future<AddAddressModel> getAddressById(int id) async {
    final db = await initDb();
    final List<Map<String, dynamic>> adrs =
        await db.query(ADDRESS_TABLE, where: '$sura = ?', whereArgs: [id]);
    // if (adrs.length > 0) {
    return AddAddressModel.fromJson(adrs.first);
    // }
    // return null;
  }

  Future<int> updateAddres(AddAddressModel addAddressModel) async {
    final db = await initDb();
    var re = await db.update(ADDRESS_TABLE, addAddressModel.toJson(),
        where: '$sura    = ?', whereArgs: [addAddressModel.sura]);
    return re;
  }

  static Future<void> deleteAddress(int id) async {
    final db = await initDb();
    await db.delete(ADDRESS_TABLE, where: '$sura = ?', whereArgs: [id]);
  }
}
