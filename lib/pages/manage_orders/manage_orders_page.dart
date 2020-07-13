import 'package:UniRaisAdmin/bloc/_bloc.dart';
import 'package:UniRaisAdmin/model/_model.dart';
import 'package:UniRaisAdmin/presentation/_presentation.dart' as PRESENTATION;
import 'package:UniRaisAdmin/util/_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _PAGE_TITLE = "Manage Orders";

class ManageOrdersPage extends StatefulWidget {
  @override
  _ManageOrdersPageState createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  BlocOrder _orderBloc;
  int _show = 0;

  List<_ChipItem> chipItems = [
    _ChipItem(text: 'All', color: Colors.purple),
    _ChipItem(text: 'Pending', color: Colors.grey, orderState: PendingOrder()),
    _ChipItem(
        text: 'Confirmed', color: Colors.blue, orderState: ConfirmedOrder()),
    _ChipItem(
        text: 'Delivered', color: Colors.green, orderState: DeliveredOrder()),
    _ChipItem(
        text: 'Cancelled', color: Colors.red, orderState: CancelledOrder()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_PAGE_TITLE),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 48,
            width: double.infinity,
            child: ListView.builder(
              itemCount: chipItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                _ChipItem item = chipItems[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: (index == 0) ? 24.0 : 6.0,
                    right: (index == (chipItems.length - 1)) ? 24.0 : 6.0,
                  ),
                  child: ChoiceChip(
                    label: Text(
                      item.text,
                      style: TextStyle(
                          color: PRESENTATION.BACKGROUND_COLOR,
                          fontWeight: (_show == index) ? FontWeight.w600 : null,
                          fontSize: (_show == index) ? 15 : null),
                    ),
                    backgroundColor: item.color,
                    padding: EdgeInsets.symmetric(
                        horizontal: (_show == index) ? 16.0 : 12.0,
                        vertical: (_show == index) ? 8 : 0),
                    onSelected: (bool value) async {
                      setState(() {
                        if (value) _show = index;
                      });
                      if (value)
                        (index == 0)
                            ? _orderBloc.add(FetchOrders())
                            : _orderBloc
                                .add(FetchOrders(orderState: item.orderState));
                    },
                    selectedColor: item.color,
                    selected: _show == index,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<BlocOrder, OrderingState>(
              bloc: _orderBloc,
              builder: (BuildContext context, OrderingState state) {
                if (state is FetchingOrdersSuccessful) {
                  List<Order> _orders = state.orders;
                  return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: _orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return (index == 0)
                            ? Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 12,
                                  ),
                                  OrderWidget(
                                    order: _orders[index],
                                  )
                                ],
                              )
                            : OrderWidget(
                                order: _orders[index],
                              );
                      });
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _orderBloc = BlocProvider.of<BlocOrder>(context);
    _orderBloc.add(FetchOrders());
    super.initState();
  }
}

class OrderWidget extends StatelessWidget {
  final Order _order;

  const OrderWidget({Key key, @required order})
      : this._order = order,
        super(key: key);

  OrderState get orderState => _order.orderState;

  Color get _itemColor {
    Color value = Colors.white;

    if (orderState is PendingOrder) {
      value = Colors.grey;
    } else if (orderState is ConfirmedOrder) {
      value = Colors.blue;
    } else if (orderState is CancelledOrder) {
      value = Colors.red;
    } else if (orderState is DeliveredOrder) {
      value = Colors.green;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //push(context, OrderPage());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 24,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: kElevationToShadow[8],
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(24),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(24),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: PRESENTATION.BACKGROUND_COLOR,
                border: Border(
                  left: BorderSide(
                    width: 24.0,
                    color: _itemColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.bookmark,
                                color: _itemColor,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Order #${_order.orderNumber}', //
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Order time   :   ${formatDateTime(_order.orderTime)}',
                            maxLines: 1,
                            style: TextStyle(
                              //fontSize: 13,
                              color: PRESENTATION.TEXT_LIGHT_COLOR,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Price              :   ${_order.total}',
                            maxLines: 1,
                            style: TextStyle(
                              //fontSize: 13,
                              color: PRESENTATION.TEXT_LIGHT_COLOR,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Quantify       :   ${_order.quantity}',
                            maxLines: 1,
                            style: TextStyle(
                              //fontSize: 14,
                              color: PRESENTATION.TEXT_LIGHT_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: _itemColor,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipItem {
  final String text;
  final Color color;
  final OrderState orderState;

  _ChipItem({
    @required this.text,
    @required this.color,
    this.orderState,
  });
}
