import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = "";
  String _expiryDate = "";
  String _userId = "";
  final String key = "AIzaSyAY-eHIBxM2GOy2MIEKjFEycDGihsn0NuA";
  Future<void> authenticate(String action,String email,String password)async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$action?key=$key');
    final client = http.Client();
    try{
      final response = await client.post(
        url,
        body: json.encode(
            {
              'email': email,
              'password': password,
              'returnSecureToken': true,
            }
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      ).toString();
      notifyListeners();
    }catch(error){
      _print('..');
      _print(error);
      throw error;
    }
  }
  Future<void> signUp(String email, String password) async {
    return authenticate('signUp', email, password);
  }

  Future<void> logIn(String email, String password){
    return authenticate('signInWithPassword', email, password);
  }
  void _print(Object message){
    if(kDebugMode){
      print(message);
    }
  }
}
