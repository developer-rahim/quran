import 'dart:convert';
import 'package:api_test/local_json_quran_app/database/db_model.dart';
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

  Future<SuraDetailsModel> saveToAddressList(
      SuraDetailsModel addAddressModel) async {
    var dbClient = await db;
    addAddressModel.sura =
        await dbClient.insert(ADDRESS_TABLE, addAddressModel.toJson());
    //print(addAddressModel);
    print('Saved');
    return addAddressModel;
  }

  Future<List<SuraDetailsModel>> getAddresses() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(ADDRESS_TABLE, columns: [
      sura,
      ayat,
      sura_name,
      text,
      VerseIDAr,
    ]);

    List<SuraDetailsModel> addresses = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        addresses.add(SuraDetailsModel.fromJson(Map.from(maps[i])));
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

  static Future<SuraDetailsModel> getAddressById(int id) async {
    final db = await initDb();
    final List<Map<String, dynamic>> adrs =
        await db.query(ADDRESS_TABLE, where: '$sura = ?', whereArgs: [id]);
    // if (adrs.length > 0) {
    return SuraDetailsModel.fromJson(adrs.first);
    // }
    // return null;
  }

  Future<int> updateAddres(SuraDetailsModel addAddressModel) async {
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
