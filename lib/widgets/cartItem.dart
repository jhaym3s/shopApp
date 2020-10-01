import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  CartItem({this.title,this.id,this.price,Key key,this.quantity}):super(key:key);

  final String title;
  final String id;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      child: Padding(padding: EdgeInsets.all(8),child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.purpleAccent,
          child: FittedBox(child: Text("$price",softWrap: true,
            style: TextStyle(color: Colors.black,),),
            fit: BoxFit.cover,),),
        title: Text(title,style: Theme.of(context).textTheme.headline6,),
        subtitle: Text("${price*quantity}"),
        trailing: Text("$quantity x"),
      ),),
    );
  }
}
