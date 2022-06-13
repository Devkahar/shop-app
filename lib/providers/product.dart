import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product({required this.id, required this.title, required this.description, required this.price, required this.imageUrl,this.isFavourite = false});

  void toggleIsFavourite()async{
    bool oldFavourite = isFavourite;
    try{
      isFavourite = !isFavourite;
      notifyListeners();
      final url = Uri.parse('https://shopapp-d6ace-default-rtdb.firebaseio.com/products/$id');
      final client = http.Client();
      final body = {
        'isFavourite': isFavourite,
      };
      final res = await client.patch(url,body: json.encode(body));
      if(res.statusCode>=400){
        isFavourite= oldFavourite;
        notifyListeners();
      }
    }catch(error){
      print(error);
      isFavourite= oldFavourite;
      notifyListeners();
    }
   
  }
}