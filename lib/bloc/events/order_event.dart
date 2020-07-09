import 'package:equatable/equatable.dart';

import './../../model/shop/_shop.dart';
import '../cart_bloc.dart';

class FetchOrders extends OrderEvent {
  final OrderState orderState;

  FetchOrders({this.orderState}) : super(props: [orderState]);
}

abstract class OrderEvent extends Equatable {
  final List _props;

  OrderEvent({props = const []}) : _props = props;

  @override
  List<Object> get props => _props;
}

class PlaceOrder extends OrderEvent {
  final Order order;
  final BlocCart cartBloc;

  PlaceOrder(this.order, this.cartBloc) : super(props: [order]);
}
