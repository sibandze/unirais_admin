import 'package:equatable/equatable.dart';

import './../../model/_model.dart';

class BlocStateAddress extends Equatable {
  final _props;

  BlocStateAddress({props=const[]}): this._props = props;

  @override
  List<Object> get props => _props;
}

class BlocStateAddressInitial extends BlocStateAddress {}

class BlocStateAddressFetching extends BlocStateAddress {}

class BlocStateAddressFetchingSuccess extends BlocStateAddress {
  final List<Address> addresses;

  BlocStateAddressFetchingSuccess(this.addresses) : super(props: addresses);
}

class BlocStateAddressFetchingFailure extends BlocStateAddress {}

/// crud - r = cud

abstract class BlocStateAddressCUD extends BlocStateAddress{}

class BlocStateAddressCUDProcessing extends BlocStateAddressCUD {}

class BlocStateAddressCUDSuccess extends BlocStateAddressCUD {}

class BlocStateAddressCUDFailure extends BlocStateAddressCUD {}