import 'package:flutter/material.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({Key? key}) : super(key: key);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlContoller = TextEditingController();

  // @override
  // void dispose() {
  //   _priceFocusNode.dispose();
  //   _descriptionFocusNode.dispose();
  //   _imageUrlContoller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  // Focus.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  Focus.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
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
                            fit: BoxFit.cover,
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
                      // focusNode: _imageUrlContoller,
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
