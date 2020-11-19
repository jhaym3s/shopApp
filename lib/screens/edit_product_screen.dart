import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productProvider.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "editProductScreen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var editedProducts =
      Product(
          id: null,
          title: "",
          description: "",
          imageUrl: "",
          price: 0);

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(updateURL);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(updateURL);
    _imageController.dispose();// always remember you dispose the controller(if any) before the focus node
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void updateURL() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }
  void saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
      _form.currentState.save();
     Provider.of<ProductsProvider>(context,listen: false).addProduct(editedProducts);
     Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: saveForm)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0 * 2),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) {
                  editedProducts = Product(
                      id: null,
                      title: newValue,
                      description: editedProducts.description,
                      imageUrl: editedProducts.imageUrl,
                      price: editedProducts.price);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Add something";
                  }
                  return null;
                },
              ),
              TextFormField(
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onSaved: (newValue) {
                    editedProducts = Product(
                        id: null,
                        title: editedProducts.title,
                        description: editedProducts.description,
                        imageUrl: editedProducts.imageUrl,
                        price: double.parse(newValue));
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Add a price";
                    } else if (double.tryParse(value) == null) {
                      return "Please add a valid number";
                    } else if (double.parse(value) <= 0) {
                      return "Add a number greater than 0 Oga";
                    }
                    return null;
                  }),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                // textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.text,
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                onSaved: (newValue) {
                  editedProducts = Product(
                      id: null,
                      title: editedProducts.title,
                      description: newValue,
                      imageUrl: editedProducts.imageUrl,
                      price: editedProducts.price);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please add a product description";
                  } else if (value.length < 10) {
                    return "Your description is to short";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(right: 10, top: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: _imageController.text.isEmpty
                          ? Text("hey")
                          : FittedBox(
                              child: Image.network(_imageController.text),
                              fit: BoxFit.cover,
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "hey:)",
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageController,
                      onFieldSubmitted: (value) => saveForm(),
                      onSaved: (newValue) {
                        editedProducts = Product(
                            id: null,
                            title: editedProducts.title,
                            description: editedProducts.description,
                            imageUrl: newValue,
                            price: editedProducts.price);
                      },
                      validator: (value) {
                        if (!value.startsWith("http") &&
                            (!value.startsWith("https"))) {
                          return "Invalid address";
                        }else if(!value.endsWith(".jpg") && !value.endsWith(".png") && !value.endsWith(".jpeg")){
                          return "Add image format";
                        }
                        return null;
                      },
                    ),
                  )
                ],),
            ],),
        ),
      ),
    );
  }
}
