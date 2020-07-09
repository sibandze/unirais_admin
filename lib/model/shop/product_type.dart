import 'package:equatable/equatable.dart';

import './../../const/_const.dart' as CONSTANTS;
import './../../util/_util.dart';
import './product.dart';

// ignore: must_be_immutable
class ProductType extends Equatable {
  final int id;
  final int categoryId;
  String name;
  final String imgUrl;
  final Money minPrice;
  final List<Product> productList;

  ProductType({
    this.name,
    this.id,
    this.categoryId,
    this.imgUrl,
    num minPrice = 0,
    this.productList = const [],
  }) : minPrice = Money(minPrice);

  factory ProductType.fromMap(map) {
    return ProductType(
      name: map[CONSTANTS.ROW_NAME],
      id: map[CONSTANTS.ROW_ID],
      categoryId: map[CONSTANTS.REF_CATEGORY_ID],
      imgUrl: map[CONSTANTS.ROW_IMG_URL],
      minPrice: map[CONSTANTS.ROW_MIN_PRICE],
      productList: (map[CONSTANTS.ROW_PRODUCT_LIST] as List)
          .map((product) => Product.fromMap(product))
          .toList(),
    );
  }

  String get appUrlQualifiedImgUrl => CONSTANTS.API_URL + '/' + imgUrl;

  @override
  List<Object> get props => [id];
}
