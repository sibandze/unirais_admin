import './../../model/_model.dart';

enum CartBlocEventType { CREATE, READ, UPDATE, DELETE, DELETE_ALL }

class CartBlocEvent {
  CartBlocEventType cartBlocEventType;

  CartItem cartItem;

  CartBlocEvent() : cartBlocEventType = CartBlocEventType.READ;

  CartBlocEvent.create(product)
      : cartBlocEventType = CartBlocEventType.CREATE,
        cartItem = CartItem(product: product);

  CartBlocEvent.update(this.cartItem)
      : cartBlocEventType = cartItem.quantity > 0
            ? CartBlocEventType.UPDATE
            : CartBlocEventType.DELETE;

  CartBlocEvent.delete(this.cartItem)
      : cartBlocEventType = CartBlocEventType.DELETE;

  CartBlocEvent.deleteAll() : cartBlocEventType = CartBlocEventType.DELETE_ALL;
}
