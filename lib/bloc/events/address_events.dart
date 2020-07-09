import 'package:equatable/equatable.dart';

import './../../model/_model.dart';

abstract class BlocEventAddress extends Equatable {
  final _props;

  BlocEventAddress({props}) : this._props = (props != null) ? props : [];

  @override
  List<Object> get props => _props;
}

class BlocEventAddressFetch extends BlocEventAddress {}

abstract class BlocEventAddressCUD extends BlocEventAddress {
  BlocEventAddressCUD({props}) : super(props: props);
}

class BlocEventAddressCreate extends BlocEventAddressCUD {
  final Address address;

  BlocEventAddressCreate(this.address) : super(props: [address]);
}

class BlocEventAddressUpdate extends BlocEventAddressCUD {
  final Address address;

  BlocEventAddressUpdate(this.address) : super(props: [address]);
}

class BlocEventAddressDelete extends BlocEventAddressCUD {
  final Address address;

  BlocEventAddressDelete(this.address) : super(props: [address]);
}

class BlocEventAddressDeleteAll extends BlocEventAddressCUD {}
