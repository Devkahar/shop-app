import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = "";
  String _expiryDate = "";
  String _userId = "";
  final String key = "AIzaSyAY-eHIBxM2GOy2MIEKjFEycDGihsn0NuA";
  Future<void> authenticate(String action,String email,String password,String errorMessage)async{
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
      _print(json.decode(response.body));
    }catch(error){
      throw errorMessage;
      _print(error);
    }
  }
  Future<void> signUp(String email, String password) async {
    String errorMessage = 'Something went wrong';
    return authenticate('signUp', email, password,errorMessage);
  }

  Future<void> logIn(String email, String password){
    String errorMessage = 'Invalid Login Credential';
    return authenticate('signInWithPassword', email, password,errorMessage);
  }
  void _print(Object message){
    if(kDebugMode){
      print(message);
    }
  }
}
