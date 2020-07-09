import './../../util/_util.dart';
import './cart_item.dart';
import './product.dart';

class Cart {
  List<CartItem> cartItems;
  Money total;

  Cart({List<CartItem> cartItems})
      : cartItems = cartItems != null ? cartItems : [] {
    calculateTotal();
  }

  int get length => cartItems.length;

  bool get isNotEmpty => cartItems.isNotEmpty;

  bool get isEmpty => cartItems.isEmpty;

  CartItem getCartItem(Product _product) {
    int pos = cartItems.indexOf(CartItem(product: _product));
    return (pos > -1) ? cartItems[pos] : null;
  }

  bool contains(Product _product) {
    return cartItems.contains(CartItem(product: _product));
  }

  bool updateCart(CartItem _cartItem) {
    if (contains(_cartItem.product)) {
      cartItems[cartItems.indexOf(_cartItem)].quantity = _cartItem.quantity;
      return true;
    }
    return false;
  }

  bool removeFromCart(CartItem _cartItem) {
    if (contains(_cartItem.product)) {
      cartItems.remove(_cartItem);
      return true;
    }
    return false;
  }

  bool addToCart(CartItem _cartItem) {
    if (!contains(_cartItem.product)) {
      cartItems.add(_cartItem);
      return true;
    }
    return false;
  }

  void calculateTotal() {
    total = Money(0);
    for (CartItem cartItem in cartItems) {
      total += cartItem.product.price * cartItem.quantity;
    }
  }

  void clearCart() {
    cartItems.clear();
  }
}
