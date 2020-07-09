import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../const/_const.dart' as CONSTANTS;
import './../../util/_util.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  String name;
  final int id;
  final int productTypeId;
  final String imgUrl;
  String packaging;
  Money price;

  Product({
    @required this.productTypeId,
    @required this.name,
    this.id = -1,
    this.imgUrl = "",
    @required this.packaging,
    num price = 0,
  }) : this.price = Money(price);

  factory Product.fromMap(map) => Product(
        name: map[CONSTANTS.ROW_NAME],
        id: map[CONSTANTS.ROW_ID],
        imgUrl: map[CONSTANTS.ROW_IMG_URL],
        packaging: map[CONSTANTS.ROW_PACKAGING],
        price: map[CONSTANTS.ROW_PRICE],
        productTypeId: map[CONSTANTS.REF_PRODUCT_TYPE_ID],
      );

  String get appUrlQualifiedImgUrl => CONSTANTS.API_URL + '/' + imgUrl;

  @override
  List<Object> get props => [id];

  Map<String, String> toMap() =>
      {
        CONSTANTS.ROW_NAME: name,
        CONSTANTS.ROW_ID: id.toString(),
        CONSTANTS.ROW_IMG_URL: imgUrl,
        CONSTANTS.ROW_PACKAGING: packaging,
        CONSTANTS.ROW_PRICE: price.amount.toString(),
        CONSTANTS.REF_PRODUCT_TYPE_ID: productTypeId.toString(),
      };
}
