
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/cart.dart';

class OrdersItem{
  final String id;
  final DateTime date;
  final double amount;
  final List<CartItem> products;

  OrdersItem({
  @required this.id,
  @required this.products,
  @required this.date,
  @required this.amount});
}
class Orders with ChangeNotifier{
  List<OrdersItem> _orders = [];
  List<OrdersItem> get orders {
    return [..._orders];
  }

  //this is called in the caartScreen file
  Future<void> addOrders(List<CartItem> cartProducts,double total) async{
    const url = "https://shopapp-f51eb.firebaseio.com/orders.json";
    final timeStamp = DateTime.now();
     final response = await http.post(url,
      body: json.encode({
      "amount": total,
       "dateTime": timeStamp.toIso8601String(),
       "products": cartProducts.map((cP) => {
         "id":cP.id,
         "title":cP.title,
         "price": cP.price,
         "quality": cP.quantity,
       }).toList()
      })
    );
    _orders.insert(0, OrdersItem(
        id: json.decode(response.body)["name"],
            products: cartProducts,
            date: timeStamp,
            amount: total));
    notifyListeners();
  }

}