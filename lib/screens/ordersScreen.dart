import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../widgets/orderItem.dart' as widget;
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orderScreen";
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: ListView.builder(itemBuilder: (context, index) => widget.OrdersItem(ordersData.orders[index]),itemCount: ordersData.orders.length,),
    );
  }
}
