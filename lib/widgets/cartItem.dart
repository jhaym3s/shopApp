import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  CartItem({this.title, this.id, this.price, Key key, this.quantity, this.productId})
      : super(key: key);

  final String title;
  final String productId;
  final String id;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child:
            Icon(Icons.delete,color: Colors.white,size: 30,),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              child: FittedBox(
                child: Text(
                  "$price",
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text("${price * quantity}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
