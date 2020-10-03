import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cartItem.dart' as widget;

class CartScreen extends StatelessWidget {
  static const routename = "/cartScreen";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Chip(
                  label: Text(
                    "${cart.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 6,
                ),
                FlatButton.icon(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrders(
                        cart.items.values.toList(),
                        cart.totalAmount);
                    cart.clear();
                  },
                  icon: Icon(Icons.payment),
                  label: Text("Buy"),
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => widget.CartItem(
              title: cart.items.values.toList()[index].title,
              productId: cart.items.keys.toList()[index],
              id: cart.items.values.toList()[index].id,
              price: cart.items.values.toList()[index].price,
              quantity: cart.items.values.toList()[index].quantity),
          itemCount: cart.itemCount,
        )),
      ]),
    );
  }
}
