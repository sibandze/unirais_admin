import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../const/_const.dart';
import './product.dart';

class OrderItem extends Equatable {
  final Product product;
  final int quantity;

  OrderItem({@required this.product, @required this.quantity});

  OrderItem.fromMap(Map<String, dynamic> map)
      : product = Product.fromMap(map),
        quantity = map[ROW_QUANTITY];

  Map<String, String> toMap(orderId) {
    return {
      ROW_NAME: product.name,
      REF_PRODUCT_ID: product.id.toString(),
      ROW_IMG_URL: product.img_url,
      ROW_PACKAGING: product.packaging,
      ROW_PRICE: product.price.amount.toString(),
      ROW_QUANTITY: quantity.toString(),
      REF_ORDER_ID: orderId.toString()
    };
  }

  @override
  List<Object> get props => [product];
}
