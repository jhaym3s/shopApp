
import 'package:flutter/widgets.dart';
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

  void addOrders(List<CartItem> cartProducts,double total){
    _orders.insert(0, OrdersItem(
        id: DateTime.now().toString(),
            products: cartProducts,
            date: DateTime.now(),
            amount: total));
    notifyListeners();
  }

}