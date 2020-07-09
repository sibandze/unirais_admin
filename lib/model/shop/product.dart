import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../const/_const.dart' as CONSTANTS;
import './../../util/_util.dart';

class Product extends Equatable {
  final String name;
  final int id;

  // ignore: non_constant_identifier_names
  final int product_type_id;

  // ignore: non_constant_identifier_names
  final String img_url;
  final String packaging;
  final Money price;

  Product({
    // ignore: non_constant_identifier_names
    @required this.product_type_id,
    @required this.name,
    @required this.id,
    // ignore: non_constant_identifier_names
    this.img_url,
    @required this.packaging,
    @required num price,
  }) : this.price = Money(price);

  factory Product.fromMap(map) => Product(
        name: map[CONSTANTS.ROW_NAME],
        id: map[CONSTANTS.ROW_ID],
        img_url: map[CONSTANTS.ROW_IMG_URL],
        packaging: map[CONSTANTS.ROW_PACKAGING],
        price: map[CONSTANTS.ROW_PRICE],
        product_type_id: map[CONSTANTS.REF_PRODUCT_TYPE_ID],
      );

  // ignore: non_constant_identifier_names
  String get app_url_qualified_img_url => CONSTANTS.API_URL + '/' + img_url;

  @override
  List<Object> get props => [id];
}
