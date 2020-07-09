import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../const/_const.dart' as CONSTANTS;
import './product_type.dart';

// ignore: must_be_immutable
class ProductCategory extends Equatable {
  String name;
  final int id;
  final List<ProductType> productTypeList;

  ProductCategory({@required this.name, this.id=-1, this.productTypeList = const []});

  factory ProductCategory.fromMap(map) {
    return ProductCategory(
      name: map[CONSTANTS.ROW_NAME],
      id: map[CONSTANTS.ROW_ID],
      productTypeList: (map[CONSTANTS.ROW_PRODUCT_TYPE_LIST] as List)
          .map((productType) => ProductType.fromMap(productType))
          .toList(),
    );
  }

  @override
  List<Object> get props => [id];

  Map<String, String> toMap() {
    return {
      CONSTANTS.ROW_NAME: name,
      CONSTANTS.ROW_ID: id.toString(),
    };
  }
}