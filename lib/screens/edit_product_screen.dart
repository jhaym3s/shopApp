import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "editProductScreen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}
class _EditProductScreenState extends State<EditProductScreen> {
  final priceFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Edit Page")
     ),
      body: Padding(
        padding: const EdgeInsets.all(8.0*2),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value){
                FocusScope.of(context).requestFocus(priceFocusNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Price",
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: priceFocusNode,
            ),
          ],
        )),
      ),
    );
  }
}
