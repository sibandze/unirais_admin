import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocStateProductTypesUninitialized extends BlocStateProductTypes {}

class BlocStateProductTypesFetchingFailure extends BlocStateProductTypes {}

class BlocStateProductTypesFetchingSuccess extends BlocStateProductTypes {
  final List<ProductType> productTypes;

  BlocStateProductTypesFetchingSuccess({@required this.productTypes}) : super(props: [productTypes]);
}

class BlocStateProductTypesFetching extends BlocStateProductTypes {}

abstract class BlocStateProductTypes extends Equatable {
  final _props;

  BlocStateProductTypes({props = const []})
      : _props = props,
        super();

  @override
  List<Object> get props => _props;
}

class BlocStateProductTypesCUDFailure extends BlocStateProductTypesCUD {}

class BlocStateProductTypesCUDProcessing extends BlocStateProductTypesCUD {}

abstract class BlocStateProductTypesCUD extends BlocStateProductTypes {
  BlocStateProductTypesCUD({props = const []}) : super(props: props);
}

class BlocStateProductTypesCUDSuccess extends BlocStateProductTypesCUD {}