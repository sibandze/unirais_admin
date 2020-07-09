import 'dart:async';

import './../../const/_const.dart';
import './../../model/_model.dart';
import './../database_helper/_database_helper.dart';

class CartDao {
  final dbHelper = CartDatabaseHelper.cartDatabaseHelper;

  Future<int> addToCart(CartItem cartItem) async {
    final db = await dbHelper.database;
    var result = db.insert(CART_TABLE, cartItem.toMap());
    return result;
  }

  Future<List<CartItem>> getCartItems(
      {List<String> columns, String query}) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> result;

    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(
          CART_TABLE,
          columns: columns,
          where: 'description LIKE ?',
          whereArgs: ["%$query%"],
        );
    } else
      result = await db.query(CART_TABLE, columns: columns);

    List<CartItem> cartItems = result.isNotEmpty
        ? result.map((item) => CartItem.fromMap(item)).toList()
        : [];

    return cartItems;
  }

  Future<int> updateCartItem(CartItem cartItem) async {
    final db = await dbHelper.database;
    var result = await db.update(CART_TABLE, cartItem.toMap(),
        where: "$ROW_ID = ?", whereArgs: [cartItem.product.id]);
    return result;
  }

  Future<int> deleteCartItem(int productId) async {
    final db = await dbHelper.database;
    var result = await db
        .delete(CART_TABLE, where: '$ROW_ID = ?', whereArgs: [productId]);
    return result;
  }

  Future deleteAllCartItems() async {
    final db = await dbHelper.database;
    var result = await db.delete(CART_TABLE);
    return result;
  }

  Future<int> getCartSize() async {
    final db = await dbHelper.database;
    var result = await db.query(CART_TABLE);
    int cartSize = result.isNotEmpty ? result.length : 0;
    return cartSize;
  }
}
