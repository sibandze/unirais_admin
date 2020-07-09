import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    @required this.name,
    this.id,
    @required this.categoryId,
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

  Map<String, String> toMap() => {
        CONSTANTS.ROW_NAME: name,
        CONSTANTS.ROW_ID: id.toString(),
        CONSTANTS.REF_CATEGORY_ID: categoryId.toString(),
        CONSTANTS.ROW_IMG_URL: imgUrl,
      };

  String get appUrlQualifiedImgUrl => CONSTANTS.API_URL + '/' + imgUrl;

  @override
  List<Object> get props => [id];
}
