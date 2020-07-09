import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './../../const/_const.dart';

class AddressDatabaseHelper {
  static final AddressDatabaseHelper addressDatabaseHelper =
      AddressDatabaseHelper();
  final version = 1;
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    var database = openDatabase(
      join(await getDatabasesPath(), 'address_database.db'),
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
      '''CREATE TABLE $ADDRESS_TABLE(
            $ROW_ID INTEGER PRIMARY KEY,
            $ROW_SAVED_AS TEXT,
            $ROW_ADDRESS TEXT,
            $ROW_ROOM_NUMBER TEXT,
            $ROW_UNIVERSITY INTEGER,
            $ROW_RESIDENCE INTEGER,
            $ROW_LONG DOUBLE,
            $ROW_LAT DOUBLE )''',
    );
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) {
    print("on upgrade");
  }

  void onDowngrade(Database db, int oldVersion, int newVersion) {
    print("on downgrade");
  }
}
