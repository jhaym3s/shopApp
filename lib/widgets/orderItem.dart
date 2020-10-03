import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import '../providers/orders.dart' as order;


class OrdersItem extends StatefulWidget {
  final order.OrdersItem orderData;
  OrdersItem(this.orderData);

  @override
  _OrdersItemState createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),child: Column(
      children: [
        ListTile(
          title: Text("${widget.orderData.amount}"),
          subtitle: Text(DateFormat("dd/MM/yyyy hh:mm").format(widget.orderData.date)),
          trailing: IconButton(icon: Icon(expanded?Icons.expand_less:Icons.expand_more),
            onPressed: (){
            setState(() {
              expanded = !expanded;
            });
          },),
        ),
        if(expanded) Container(height: min(widget.orderData.products.length*20.0 + 20, 160),
          child:ListView(children: widget.orderData.products.map((e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text("${e.quantity} x ${e.price}",style: TextStyle(fontSize: 20,color: Colors.grey),)
            ],
          )).toList(),) ,),
      ],
    ),
    );
  }
}
