import './../../model/_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class BlocEventProductType extends Equatable {
  final _props;

  BlocEventProductType({props}): this._props=props;

  @override
  List<Object> get props => _props;
}

class BlocEventProductTypeFetch extends BlocEventProductType {
  final ProductCategory category;

  BlocEventProductTypeFetch({@required this.category}) : super(props: [category]);

}

abstract class BlocEventProductTypeCUD extends BlocEventProductType{
  BlocEventProductTypeCUD({props}): super(props:props);
}

class BlocEventProductTypeCreate extends BlocEventProductTypeCUD{
  final ProductType productType;

  BlocEventProductTypeCreate({@required this.productType}): super(props:[productType]);
}
class BlocEventProductTypeUpdate extends BlocEventProductTypeCUD{
  final ProductType productType;

  BlocEventProductTypeUpdate({@required this.productType}): super(props:[productType]);
}
class BlocEventProductTypeDelete extends BlocEventProductTypeCUD{
  final ProductType productType;

  BlocEventProductTypeDelete({@required this.productType}): super(props:[productType]);
}
