import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/provider.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({Key? key}) : super(key: key);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlContoller = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool _loading = false;
  String urlPattern =
      r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  bool isEditiable = false;
  Product _editProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );
  String imageUrl = "";

  @override
  void initState() {
    _imageUrlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final productId = ModalRoute.of(context)!.settings.arguments;
    if (productId != null) {
      final _product = Provider.of<Products>(context)
          .items
          .where((element) => element.id == productId)
          .toList()[0];
      _editProduct = _product as Product;
      isEditiable = true;
      _imageUrlContoller.text = _editProduct.imageUrl;
    }
  }

  void updateImageUrl() {
    if (_imageUrlContoller.text.isNotEmpty &&
        _imageUrlContoller.text != imageUrl) {
      setState(() {
        imageUrl = _imageUrlContoller.text;
      });
      _editProduct = Product(
        id: _editProduct.id,
        title: _editProduct.title,
        description: _editProduct.description,
        price: _editProduct.price,
        imageUrl: imageUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    void formSave() async {
      final bool isValid = _form.currentState!.validate();
      if (!isValid) return;
      _form.currentState?.save();
      setState((){
        _loading= true;
      });
      if (isEditiable) {
        product.updateProduct(
            _editProduct.id,
            _editProduct.title,
            _editProduct.description,
            _editProduct.price,
            _editProduct.imageUrl,);
        Navigator.of(context).pop();
        print("product Edited");
      } else {
        product
            .addProduct(
          _editProduct.title,
          _editProduct.description,
          _editProduct.price,
          _imageUrlContoller.text,
        ).then(
          (val) {
            setState((){
              _loading= false;
            });
            Navigator.of(context).pop();
          },
        );

        print("Product Added");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: formSave,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _loading? const Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _editProduct.title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  // Focus.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    title: value as String,
                    description: _editProduct.description,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                initialValue: _editProduct.price.toString(),
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  Focus.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter Valid Price';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Price Should be More then 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    title: _editProduct.title,
                    description: _editProduct.description,
                    price: double.parse(value as String),
                    imageUrl: _editProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                initialValue: _editProduct.description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    title: _editProduct.title,
                    description: value as String,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    decoration: BoxDecoration(border: Border.all(width: 1.0)),
                    child: _imageUrlContoller.text.isEmpty
                        ? const Text('Enter Image URL')
                        : FittedBox(
                            fit: BoxFit.contain,
                            child: Image.network(_imageUrlContoller.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Enter Image URL'),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlContoller,
                      focusNode: _imageUrlFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Image Url';
                        }
                        if (RegExp(urlPattern, caseSensitive: false)
                                .firstMatch(value) ==
                            null) {
                          return 'Enter Valid Url';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => formSave(),
                      onEditingComplete: () {
                        setState(() {
                          imageUrl = _imageUrlContoller.text.isEmpty
                              ? ''
                              : _imageUrlContoller.text;
                        });
                        _editProduct = Product(
                          id: _editProduct.id,
                          title: _editProduct.title,
                          description: _editProduct.description,
                          price: _editProduct.price,
                          imageUrl: imageUrl,
                        );
                        print(imageUrl);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
