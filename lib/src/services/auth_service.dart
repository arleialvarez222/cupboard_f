import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final storage = const  FlutterSecureStorage();
  final _baseUrl = 'https://apiproductmanagmentteamint.azurewebsites.net';

  Future<String?> createUser(String nombreCompleto, String userName, String email, String password) async {

    final Map<String, dynamic> authData = {
      'nombreCompleto': nombreCompleto,
      'userName': userName,
      'email': email,
      'password': password,
      'clientURI': "register",
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    final url = Uri.parse('$_baseUrl/api/Acount/Register');

    await http.post(url, headers: requestHeaders, body: jsonEncode(authData));

    notifyListeners();
  } 

  Future<String?> login(String email, String password) async {

    final Map<dynamic, dynamic> authData = {
      'email': email,
      'password': password,
      'clientURI': "clientURI",
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    final url = Uri.parse('$_baseUrl/api/Acount/login');

    http.Response resp = await http.post(url, headers: requestHeaders, body: jsonEncode(authData));
    final Map<dynamic, dynamic> decodeResp = json.decode(resp.body);

    if(decodeResp.containsKey('token')){
      await storage.write(key: 'token', value: decodeResp['token']);
      return null;
    }else{
      return decodeResp['ERROR'];
    } 
  } 

  Future logout()async {
    await storage.delete(key: 'token');

    return;
  }

  Future<String> readToken()async {
    return await storage.read(key: 'token') ?? '';
  } 

}