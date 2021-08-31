import 'package:demo_kai_morning_210303/model/order_model.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:demo_kai_morning_210303/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDoingList extends StatefulWidget {
  @override
  _OrderDoingListState createState() => _OrderDoingListState();
}

class _OrderDoingListState extends State<OrderDoingList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<OrderModel>>.value(
      value: orderNetwork.getOrdersDoing(),
      child: Consumer<List<OrderModel>>(
        builder: (context, orders, _){
          if(orders == null){
            return MyProgressIndicator();
          }
          else if (orders.isEmpty){
            return Text('진행중인 주문이 없습니다.');
          }
          else{
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index){
                return OrderItem(
                  orderModel: orders[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
