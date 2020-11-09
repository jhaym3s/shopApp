import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  UserProductItem(this.title, this.imageURL);

  final String title;
  final String imageURL;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageURL),),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon:Icon(Icons.edit), onPressed: (){},color: Theme.of(context).primaryColor,),
            IconButton(icon:Icon(Icons.delete), onPressed: (){},color: Theme.of(context).errorColor,)
          ],
        ),
      ),
    );
  }
}
