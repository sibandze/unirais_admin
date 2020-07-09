import './../../model/_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class BlocEventProductTypes extends Equatable {
  final _props;

  BlocEventProductTypes({props}) : this._props = props;

  @override
  List<Object> get props => _props;
}

class BlocEventProductTypesFetch extends BlocEventProductTypes {
  final ProductCategory category;

  BlocEventProductTypesFetch({@required this.category})
      : super(props: [category]);

}

abstract class BlocEventProductTypesCUD extends BlocEventProductTypes {
  BlocEventProductTypesCUD({props}) : super(props: props);
}

class BlocEventProductTypesCreate extends BlocEventProductTypesCUD {
  final ProductType productType;

  BlocEventProductTypesCreate({@required this.productType})
      : super(props: [productType]);
}

class BlocEventProductTypesUpdate extends BlocEventProductTypesCUD {
  final ProductType productType;

  BlocEventProductTypesUpdate({@required this.productType})
      : super(props: [productType]);
}

class BlocEventProductTypesDelete extends BlocEventProductTypesCUD {
  final ProductType productType;

  BlocEventProductTypesDelete({@required this.productType})
      : super(props: [productType]);
}
