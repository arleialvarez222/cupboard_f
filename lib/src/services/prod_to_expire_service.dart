import 'dart:convert';
import 'package:cupboard_flutter/src/models/product_to_expire_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProductToExpireService extends ChangeNotifier{

  final List<ProdExpireModel> productToExpire = [];
  final storage = const FlutterSecureStorage();
  bool isloading = true;
  final _baseUrl = 'https://apiproductmanagmentteamint.azurewebsites.net';

  ProductToExpireService(){
    getProductToExpire();
  }

  Future<List<ProdExpireModel>> getProductToExpire()async{
    notifyListeners();

    final url = Uri.parse('$_baseUrl/api/CupboardDetails/productsNextToExpire');
    final token = await storage.read(key: 'token');
      
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> productToExpMap = json.decode(resp.body);

    for (var value in productToExpMap) {
      final response = ProdExpireModel.fromMap(value);
      productToExpire.add(response);
    }

    //print(productToExpire);
    isloading = false;
    notifyListeners();

    return productToExpire;

  }
}