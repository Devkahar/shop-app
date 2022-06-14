import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> products = [];
  final String token;
  final String userId;

  Products({required this.products, required this.token,required this.userId});

  List<Product> get items {
    return [...products];
  }

  List<Product> get favouriteItem {
    return [...products.where((element) => element.isFavourite)];
  }

  Product findById(
    String id,
  ) {
    return products.firstWhere((element) => element.id == id);
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
          'https://shopapp-d6ace-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
      final client = http.Client();
      await client.patch(url, body: json.encode(body));
      final index = products.indexWhere((element) => element.id == id);
      products[index] = Product(
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
        'https://shopapp-d6ace-default-rtdb.firebaseio.com/products.json?auth=$token');
    final favUrl = Uri.parse('https://shopapp-d6ace-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$token');
    var client = http.Client();
    try {
      final res = await client.get(url);
      final favRes = await client.get(favUrl);
      final data = json.decode(res.body) as Map<String, dynamic>;
      final favData= json.decode(favRes.body ) as Map<String,dynamic>;
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
              isFavourite: favData!=null?favData[productId]??false:false
            ),
          );
        },
      );
      print("Caught Data");
      products = loadedList;
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

    final body = {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
    final url = Uri.parse(
        'https://shopapp-d6ace-default-rtdb.firebaseio.com/products.json?auth=$token');
    final client = http.Client();
    try {
      final res = await client.post(url, body: json.encode(body));
      products.add(
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
    int deletedItemIdx = products.indexWhere((element) => element.id == id);
    Product storeDeletedItem = products[deletedItemIdx];
    try {
      products.removeWhere((element) => element.id == id);
      notifyListeners();
      final url = Uri.parse(
          'https://shopapp-d6ace-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
      final client = http.Client();
      final res = await client.delete(url);
      if (res.statusCode >= 400) {
        // Throw Error;
        throw 'Failed To delete Item';
      }
    } catch (error) {
      print(error);
      products.insert(deletedItemIdx, storeDeletedItem);
      notifyListeners();
    }
  }
}
