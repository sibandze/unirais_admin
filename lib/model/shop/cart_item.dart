import 'package:equatable/equatable.dart';

import './../../const/_const.dart';
import './product.dart';

// ignore: must_be_immutable
class CartItem extends Equatable {
  final Product product;
  int quantity;

  CartItem({this.product, quantity})
      : quantity = (quantity != null) ? quantity : 1;

  CartItem.fromMap(Map<String, dynamic> map)
      : this.product = Product.fromMap(map),
        this.quantity = map[ROW_QUANTITY];

  void increment() {
    quantity++;
  }

  void decrease() {
    quantity--;
  }

  @override
  List<Object> get props => [product];

  Map<String, dynamic> toMap() {
    return {
      ROW_NAME: product.name,
      ROW_ID: product.id,
      ROW_IMG_URL: product.img_url,
      ROW_PACKAGING: product.packaging,
      ROW_PRICE: product.price.amount,
      ROW_QUANTITY: quantity,
    };
  }
}
