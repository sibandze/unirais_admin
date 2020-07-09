import 'package:equatable/equatable.dart';

import './../../model/_model.dart';

class FetchingOrders extends OrderingState {}

class FetchingOrdersFailed extends OrderingState {}

class FetchingOrdersSuccessful extends OrderingState {
  final List<Order> orders;

  FetchingOrdersSuccessful({this.orders}) : super(props: orders);
}

abstract class OrderingState extends Equatable {
  final List _props;

  OrderingState({props = const []}) : _props = props;

  @override
  List<Object> get props => _props;
}

class OrderingStateUninitialised extends OrderingState {}

class PlacingOrder extends OrderingState {}

class PlacingOrderFailed extends OrderingState {
  final String message;
  PlacingOrderFailed({this.message = ''}) : super(props: [message]);
}

class PlacingOrderSuccess extends OrderingState {}
