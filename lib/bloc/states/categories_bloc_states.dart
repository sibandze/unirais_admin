import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocStateCategoriesUninitialized extends BlocStateCategories {}

class BlocStateCategoriesFetchingFailure extends BlocStateCategories {}

class BlocStateCategoriesFetchingSuccess extends BlocStateCategories {
  final List<ProductCategory> categories;

  BlocStateCategoriesFetchingSuccess({@required this.categories}) : super(props: [categories]);
}

class BlocStateCategoriesFetching extends BlocStateCategories {}

abstract class BlocStateCategories extends Equatable {
  final _props;

  BlocStateCategories({props = const []})
      : _props = props,
        super();

  @override
  List<Object> get props => _props;
}

class BlocStateCategoriesCUDFailure extends BlocStateCategoriesCUD {}

class BlocStateCategoriesCUDProcessing extends BlocStateCategoriesCUD {}

abstract class BlocStateCategoriesCUD extends BlocStateCategories {
  BlocStateCategoriesCUD({props = const []}) : super(props: props);
}

class BlocStateCategoriesCUDSuccess extends BlocStateCategoriesCUD {}
