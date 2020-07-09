import 'dart:async';

import './../../const/_const.dart';
import './../../model/_model.dart';
import './../database_helper/_database_helper.dart' show AddressDatabaseHelper;

class AddressDao {
  final dbHelper = AddressDatabaseHelper.addressDatabaseHelper;

  Future<int> addNewAddress(Address address) async {
    final db = await dbHelper.database;
    var result = db.insert(ADDRESS_TABLE, address.toMap);
    return result;
  }

  Future<List<Address>> getAddresses() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> result = await db.query(ADDRESS_TABLE);
    List<Address> addresses = result.isNotEmpty
        ? result.map((item) => Address.fromMap(item)).toList()
        : [];

    return addresses;
  }

  Future<int> updateAddress(Address address) async {
    final db = await dbHelper.database;
    var result = await db.update(
      ADDRESS_TABLE,
      address.toMap,
      where: "$ROW_ID = ?",
      whereArgs: [address.id],
    );
    return result;
  }

  Future<int> deleteAddress(Address address) async {
    final db = await dbHelper.database;
    var result = await db.delete(
      ADDRESS_TABLE,
      where: "$ROW_ID = ?",
      whereArgs: [address.id],
    );
    return result;
  }

  Future deleteAllAddresses() async {
    final db = await dbHelper.database;
    var result = await db.delete(ADDRESS_TABLE);
    return result;
  }
}