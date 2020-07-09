import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocStateProductsUninitialized extends BlocStateProducts {}

class BlocStateProductsFetchingFailure extends BlocStateProducts {}

class BlocStateProductsFetchingSuccess extends BlocStateProducts {
  final List<Product> products;

  BlocStateProductsFetchingSuccess({@required this.products}) : super(props: [products]);
}

class BlocStateProductsFetching extends BlocStateProducts {}

abstract class BlocStateProducts extends Equatable {
  final _props;

  BlocStateProducts({props = const []})
      : _props = props,
        super();

  @override
  List<Object> get props => _props;
}

class BlocStateProductsCUDFailure extends BlocStateProductsCUD {}

class BlocStateProductsCUDProcessing extends BlocStateProductsCUD {}

abstract class BlocStateProductsCUD extends BlocStateProducts {
  BlocStateProductsCUD({props = const []}) : super(props: props);
}

class BlocStateProductsCUDSuccess extends BlocStateProductsCUD {}