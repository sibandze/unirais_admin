import './../database/_database.dart';

import './../model/_model.dart';

class CartRepository {
  static final CartRepository cartRepository = CartRepository();
  final CartDao _cartDao = CartDao();

  Future getAllCartItems({String query}) => _cartDao.getCartItems(query: query);

  Future addToCart(CartItem cartItem) => _cartDao.addToCart(cartItem);

  Future updateCartItem(CartItem cartItem) => _cartDao.updateCartItem(cartItem);

  Future deleteCartItemByProductId(int productId) =>
      _cartDao.deleteCartItem(productId);

  Future deleteAllCartItems() => _cartDao.deleteAllCartItems();

  Future getCartSize() => _cartDao.getCartSize();
}
