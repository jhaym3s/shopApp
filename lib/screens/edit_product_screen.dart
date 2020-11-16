
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "editProductScreen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}
class _EditProductScreenState extends State<EditProductScreen> {
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageUrlFocusNode = FocusNode();
  final imageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    imageUrlFocusNode.addListener(updateURL);
  }

  void updateURL(){
    if(!imageUrlFocusNode.hasFocus){
      setState(() {});
    }

  }


  @override
  void dispose() {
    // TODO: implement dispose
    imageUrlFocusNode.removeListener(updateURL);
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageUrlFocusNode.dispose();
    imageController.dispose();
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }
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
            TextFormField(
              decoration: InputDecoration(
                labelText: "Description",
              ),
             // textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.text,
              focusNode: descriptionFocusNode,
              maxLines: 3,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,height: 100,
                  margin: EdgeInsets.only(
                    right: 10, top: 8),
                  decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, width: 1,
                  ),
                ),
                child:imageController.text.isEmpty?Text("hey"):FittedBox(child:
                Image.network(imageController.text),
                fit: BoxFit.cover,
                )
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Image",
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
                    focusNode: imageUrlFocusNode,
                    controller: imageController,

                  ),
                )
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
