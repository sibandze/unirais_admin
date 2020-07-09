import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  final int value;

  OrderState(this.value);

  @override
  List<Object> get props => props;
}

class PendingOrder extends OrderState {
  PendingOrder() : super(0);
}

class ConfirmedOrder extends OrderState {
  ConfirmedOrder() : super(1);
}

class DeliveredOrder extends OrderState {
  DeliveredOrder() : super(2);
}

class CancelledOrder extends OrderState {
  CancelledOrder() : super(3);
}

/*class OrderCancelledByUser extends CancelledOrder {
  OrderCancelledByUser() : super(3);
}

class OrderCancelledByAdmin extends CancelledOrder {
  OrderCancelledByAdmin() : super(4);
}*/
