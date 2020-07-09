import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/shop/_shop.dart';

abstract class BlocEventProducts extends Equatable {
  final _props;

  BlocEventProducts({props}): this._props=props;

  @override
  List<Object> get props => _props;
}

class BlocEventProductsFetch extends BlocEventProducts {
  final ProductType productType;

  BlocEventProductsFetch({@required this.productType}) : super(props: [productType]);

}

abstract class BlocEventProductsCUD extends BlocEventProducts{
  BlocEventProductsCUD({props}): super(props:props);
}

class BlocEventProductsCreate extends BlocEventProductsCUD{
  final Product product;

  BlocEventProductsCreate({@required this.product}): super(props:[product]);
}
class BlocEventProductsUpdate extends BlocEventProductsCUD{
  final Product product;

  BlocEventProductsUpdate({@required this.product}): super(props:[product]);
}
class BlocEventProductsDelete extends BlocEventProductsCUD{
  final Product product;

  BlocEventProductsDelete({@required this.product}): super(props:[product]);
}