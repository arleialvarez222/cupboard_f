import 'dart:convert';
import 'package:cupboard_flutter/src/models/product_expired_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ExpiredProdutService extends ChangeNotifier{

  final List<ExpiredProdModel> expiredProduct = [];
  final storage = const FlutterSecureStorage();
  bool isloading = true;

  ExpiredProdutService(){
    getExpiredProduct();
  }

  Future<List<ExpiredProdModel>> getExpiredProduct()async{
    notifyListeners();

    final url = Uri.parse('https://10.0.2.2:5001/api/CupboardDetails/expired-products');
    final token = await storage.read(key: 'token');
      
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> productToExpMap = json.decode(resp.body);

    for (var value in productToExpMap) {
      final response = ExpiredProdModel.fromMap(value);
      expiredProduct.add(response);
    }

    //print(productToExpire);
    isloading = false;
    notifyListeners();

    return expiredProduct;

  }
}