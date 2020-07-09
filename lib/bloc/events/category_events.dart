import './../../model/_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class BlocEventCategories extends Equatable {
  final _props;

  BlocEventCategories({props}): this._props=props;

  @override
  List<Object> get props => _props;
}

class BlocEventCategoriesFetch extends BlocEventCategories {
  final String location; // categories relevant to location in question

  BlocEventCategoriesFetch({this.location}) : super(props: [location]);
}

abstract class BlocEventCategoriesCUD extends BlocEventCategories{
  BlocEventCategoriesCUD({props}): super(props:props);
}

class BlocEventCategoriesCreate extends BlocEventCategoriesCUD{
  final ProductCategory category;

  BlocEventCategoriesCreate({@required this.category}): super(props:[category]);
}
class BlocEventCategoriesUpdate extends BlocEventCategoriesCUD{
  final ProductCategory category;

  BlocEventCategoriesUpdate({@required this.category}): super(props:[category]);
}
class BlocEventCategoriesDelete extends BlocEventCategoriesCUD{
  final ProductCategory category;

  BlocEventCategoriesDelete({@required this.category}): super(props:[category]);
}
