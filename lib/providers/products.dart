import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final uuid = Uuid();
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItem {
    return [...items.where((element) => element.isFavourite)];
  }

  Product findById(
    String id,
  ) {
    return _items.firstWhere((element) => element.id == id);
  }

  void updateProduct(
    String id,
    String title,
    String description,
    double price,
    String imageUrl,
    bool isFavourite,
  ) async {
    final body = {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavourite': isFavourite,
    };
    try {
      final url = Uri.parse(
          'https://shopapp-d6ace-default-rtdb.firebaseio.com/products/$id.json');
      final client = http.Client();
      await client.patch(url, body: json.encode(body));
      final index = _items.indexWhere((element) => element.id == id);
      _items[index] = Product(
        id: id,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
        isFavourite: isFavourite,
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
        'https://shopapp-d6ace-default-rtdb.firebaseio.com/products.json');
    var client = http.Client();
    try {
      final res = await client.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;
      final List<Product> loadedList = [];
      data.forEach(
        (productId, productData) {
          loadedList.add(
            Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              price: double.parse(productData['price'].toString()),
              imageUrl: productData['imageUrl'],
            ),
          );
        },
      );
      print("Caught Data");
      _items = loadedList;
      notifyListeners();
      return Future.value();
    } catch (error) {
      print("...Caught Error");
      print(error);
      return Future.value();
    }
  }

  Future<void> addProduct(
    String title,
    String description,
    double price,
    String imageUrl,
    bool isFavourite,
  ) async {
    final id = uuid.v4();

    final body = {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavourite': isFavourite,
    };
    final url = Uri.parse(
        'https://shopapp-d6ace-default-rtdb.firebaseio.com/products.json');
    final client = http.Client();
    try {
      final res = await client.post(url, body: json.encode(body));

      _items.add(
        Product(
          id: json.decode(res.body)['name'],
          title: title,
          description: description,
          price: price,
          imageUrl: imageUrl,
          isFavourite: isFavourite,
        ),
      );
      notifyListeners();
      return Future.value();
    } catch (error) {
      print(error);
      throw "SomeThing Went Wrong";
    }
  }

  void deleteProduct(String id) async {
    int deletedItemIdx = _items.indexWhere((element) => element.id == id);
    Product storeDeletedItem = _items[deletedItemIdx];
    try {
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
      final url = Uri.parse(
          'https://shopapp-d6ace-default-rtdb.firebaseio.com/products/$id.json');
      final client = http.Client();
      final res = await client.delete(url);
      if (res.statusCode >= 400) {
        // Throw Error;
        throw 'Failed To delete Item';
      }
    } catch (error) {
      print(error);
      _items.insert(deletedItemIdx, storeDeletedItem);
      notifyListeners();
    }
  }
}
