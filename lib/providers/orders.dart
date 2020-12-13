
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
  final String authToken;
  Orders(this.authToken,this._orders);
  List<OrdersItem> _orders = [];
  List<OrdersItem> get orders {
    return [..._orders];
  }

   Future<void> fetchAndSetOrders()async{
     final url = "https://shopapp-f51eb.firebaseio.com/orders.json?auth=$authToken";
    final response = await http.get(url);
    print(json.decode(response.body));
    final List<OrdersItem> loadedData = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null){
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedData.add(OrdersItem(id: orderId,
          products: (orderData["products"] as List<dynamic>).map((cItem) =>
              CartItem(title: cItem["title"], id: cItem["id"], price: cItem["price"], quantity: cItem["quality"])).toList(),
          date:DateTime.parse(orderData["dateTime"]),
          amount: orderData["amount"]));
    });
    _orders = loadedData.reversed.toList();
    notifyListeners();
   }
  //this is called in the caartScreen file
  Future<void> addOrders(List<CartItem> cartProducts,double total) async{
    final url = "https://shopapp-f51eb.firebaseio.com/orders.json?auth=$authToken";
    final timeStamp = DateTime.now();
     final response = await http.post(url,
      body: json.encode({
      "amount": total,
       "dateTime": timeStamp.toIso8601String(),
       "products": cartProducts.map((cP) => {
         "id":cP.id,
         "title":cP.title,
         "price": cP.price,
         //mispelled
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