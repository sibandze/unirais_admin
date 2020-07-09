import 'package:bloc/bloc.dart';

import './../const/_const.dart' as CONSTANTS;
import './../model/_model.dart';
import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocOrder extends Bloc<OrderEvent, OrderingState> {
  final OrderRepository _orderRepository = OrderRepository.orderRepository;

  @override
  get initialState => OrderingStateUninitialised();

  @override
  Stream<OrderingState> mapEventToState(event) async* {
    if (event is PlaceOrder) {
      yield PlacingOrder();
      await Future.delayed(Duration(
        milliseconds: CONSTANTS.LOADING_DELAY_TIME,
      ));
      try {
        final success = await _orderRepository.makeOrders(order: event.order);
        //print(success);
        if (success) {
          event.cartBloc.add(CartBlocEvent.deleteAll());
          yield PlacingOrderSuccess();
        } else
          PlacingOrderFailed();
      } catch (e) {
        print('error: ' + e.toString());
        yield PlacingOrderFailed(message: e.toString());
      }
      await Future.delayed(Duration(
        milliseconds: CONSTANTS.LOADING_DELAY_TIME,
      ));
      yield OrderingStateUninitialised();
    } else if (event is FetchOrders) {
      yield FetchingOrders();
      await Future.delayed(Duration(
        milliseconds: CONSTANTS.LOADING_DELAY_TIME,
      ));
      try {
        List<Order> _orders = await _orderRepository.getOrders(
            orderState:
            (event.orderState == null) ? null : event.orderState.value);
        yield FetchingOrdersSuccessful(orders: _orders);
      } catch (e) {
        print(e);
        yield FetchingOrdersFailed();
      }
    }
  }
}
