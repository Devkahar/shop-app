import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Auth with ChangeNotifier {
  String _token = "";
  DateTime? _expiryDate;
  String  _userId = "";
  Timer? authTimer;
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
      _autoLogOut();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String(),
      });
    }catch(error){
      _print('..');
      _print(error);
      throw error;
    }
  }
  Future<bool> tryAutoLogIn()async{
    final prefs = await SharedPreferences.getInstance();

    if(!prefs.containsKey('userData')) return false;

    final expectedData =json.decode(prefs.getString('userData') as String) as Map<String,dynamic>;
    final expiryDate = DateTime.parse(expectedData['expiryDate']);
    if(!expiryDate.isAfter(DateTime.now())) return false;
    _token = expectedData['token'] as String;
    _expiryDate=expiryDate;
    _userId = expectedData['userId'] as String;
    _autoLogOut();
    // notifyListeners();
    return true;
  }
  Future<void> signUp(String email, String password) async {
    return authenticate('signUp', email, password);
  }

  Future<void> logIn(String email, String password){
    return authenticate('signInWithPassword', email, password);
  }
  void logOut ()async{
    _token = "";
    // _expiryDate=null;
    _userId = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();
  }
  void _autoLogOut(){
    if(authTimer!=null){
      authTimer?.cancel();
    }
    final timeToExpire = _expiryDate?.difference(DateTime.now()).inSeconds??0;
    authTimer=Timer(Duration(seconds: timeToExpire),logOut);
  }
  void _print(Object message){
    if(kDebugMode){
      print(message);
    }
  }
}
