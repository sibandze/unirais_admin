import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../util/_util.dart';
import './cart.dart';
import './order_item.dart';
import './order_state.dart';

class Order extends Equatable {
  final String orderNumber;
  final DateTime orderTime;
  final List<OrderItem> orderItems;
  final OrderState orderState;
  final String deliveryAddress;
  final String deliveryNote;

  // TODO More details on amount due, show all discounts used
  final Money total;

  // TODO payment method
  Order({
    this.orderNumber = '',
    orderTime,
    @required this.orderItems,
    @required this.orderState,
    @required this.deliveryAddress,
    @required this.deliveryNote,
    @required this.total,
  }) : this.orderTime = (orderTime == null) ? DateTime.now() : orderTime;

  Order.newOrder({
    @required Cart cart,
    @required this.deliveryAddress,
    @required this.deliveryNote,
  })  : this.orderTime = DateTime.now(),
        this.total = cart.total,
        this.orderState = PendingOrder(),
        this.orderNumber = '',
        this.orderItems = cart.cartItems
            .map(
              (cartItem) => OrderItem(
                product: cartItem.product,
                quantity: cartItem.quantity,
              ),
            )
            .toList();

  Map<String, String> toMap(int user) {
    return {
      "order_number": orderNumber,
      "order_time":
      '${orderTime.year}-${orderTime.month}-${orderTime.day} ${orderTime
          .hour}:${orderTime.minute}:${orderTime.second}',
      "user": user.toString(),
      "order_state": orderState.value.toString(),
      "delivery_address": deliveryAddress,
      "delivery_note": deliveryNote,
      "total": total.amount.toString(),
    };
  }

  int get quantity => orderItems.length;

  @override
  List<Object> get props => [orderNumber];

  factory Order.fromMap(map) {
    List _orderItems = map['order_items'];
    int __orderState = map['order_state'];
    OrderState _orderState;
    switch (__orderState) {
      case 0:
        _orderState = PendingOrder();
        break;
      case 1:
        _orderState = ConfirmedOrder();
        break;
      case 2:
        _orderState = DeliveredOrder();
        break;
      case 3:
        _orderState = CancelledOrder();
        break;
    }
    return Order(
      orderState: _orderState,
      deliveryAddress: map['delivery_address'],
      deliveryNote: map['delivery_note'],
      total: Money(double.parse(map['total'])),
      orderItems:
          _orderItems.map((orderItem) => OrderItem.fromMap(orderItem)).toList(),
      orderTime: DateTime.parse(map['order_time']),
      orderNumber: map['id'].toString(),
    );
  }
}
