import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './../../const/_const.dart';

class CartDatabaseHelper {
  static final CartDatabaseHelper cartDatabaseHelper = CartDatabaseHelper();
  final version = 1;
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    var database = openDatabase(
      join(await getDatabasesPath(), 'cart_database.db'),
      // When the database is first created, create a table to store data.
      onCreate: initDB,
      onUpgrade: onUpgrade,
      onDowngrade: onDowngrade,
      version: version,
    );
    return database;
  }

  void initDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $CART_TABLE(
            $ROW_NAME TEXT,
            $ROW_ID INTEGER UNIQUE,
            $ROW_IMG_URL TEXT,
            $ROW_PACKAGING TEXT,
            $ROW_PRICE DOUBLE,
            $ROW_QUANTITY INTEGER )''',
    );
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) {
    print("on upgrade");
  }

  void onDowngrade(Database db, int oldVersion, int newVersion) {
    print("on downgrade");
  }
}
