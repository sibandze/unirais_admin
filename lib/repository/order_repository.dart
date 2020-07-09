import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import './../const/_const.dart' as CONSTANTS;
import './../model/shop/_shop.dart';
import './user_repository.dart';
import './../services/_services.dart';

class OrderRepository {
  static final OrderRepository orderRepository = OrderRepository();
  List<Order> orderList;

  Future<List<Order>> getOrders({int orderState}) async {
    int userId = await UserRepository.userRepository.getUser();

    orderList = await WebService().get(
      Resource(
        parse: (http.Response response) {
          return (jsonDecode(response.body)['orders'] as List)
              .map((e) => Order.fromMap(e))
              .toList();
        },
        url: CONSTANTS.API_URL +
            '/app/orders/?uid=$userId' +
            ((orderState == null) ? '' : '&order_state=$orderState'),
      ),
    );
    return orderList;
  }

  Future<Order> getOrder({
    @required int orderId,
  }) async {
    int userId = await UserRepository.userRepository.getUser();
    return await WebService().get(
      Resource(
        parse: (http.Response response) =>
            Order.fromMap(jsonDecode(response.body)['order']),
        url: CONSTANTS.API_URL + '/app/orders/?uid=$userId&&oid=$orderId',
      ),
    );
  }

  Future<bool> makeOrders({
    @required Order order,
  }) async {
    int userId = await UserRepository.userRepository.getUser();
    Map<String, dynamic> orderResult = await WebService().post(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: order.toMap(userId),
        url: CONSTANTS.API_URL + '/app/orders/index.php',
      ),
    );
    if (orderResult['success'] == true) {
      var orderId = orderResult['order_id'];

      for (var e in order.orderItems) {
        await WebService().post(
          Resource(
            parse: (http.Response response) {
              return jsonDecode(response.body);
            },
            params: e.toMap(orderId),
            url: CONSTANTS.API_URL + '/app/orders/orderitem.php',
          ),
        );
      }
      return true;
    } else
      return false;
  }
}
