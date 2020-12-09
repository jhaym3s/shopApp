import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../widgets/orderItem.dart' as widget;
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orderScreen";
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading = true;
      });
   await Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body:isLoading? Center(child: CircularProgressIndicator(),):ListView.builder(itemBuilder: (context, index) =>
          widget.OrdersItem(ordersData.orders[index]),itemCount: ordersData.orders.length,),
    );
  }
}
