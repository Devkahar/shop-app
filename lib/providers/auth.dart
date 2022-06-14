import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = "";
  DateTime? _expiryDate;
  String  _userId = "";
  final String key = "AIzaSyAY-eHIBxM2GOy2MIEKjFEycDGihsn0NuA";
  bool get isAuth{
    return token!="";
  }
  String? get token{
    if(_expiryDate!=null && _expiryDate!.isAfter(DateTime.now()) && _token!=""){
      return _token;
    }
    return "";
  }
  String? get userId{
    return _userId;
  }
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
      );
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
  void logOut(){
    _token = "";
    // _expiryDate=null;
    _userId = "";
    notifyListeners();
  }
  void _print(Object message){
    if(kDebugMode){
      print(message);
    }
  }
}
