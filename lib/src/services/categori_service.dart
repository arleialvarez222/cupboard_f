import 'dart:convert';
import 'package:cupboard_flutter/src/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CategoriService extends ChangeNotifier{

  final List<Categories> categories = [];
  late Categories selCategorie;

  final storage = FlutterSecureStorage();

  bool isloading = true;
  bool isSaving = false;

  CategoriService(){
    loadCategories();
  }  

  Future<List<Categories>> loadCategories()async{

    isloading = true;
    notifyListeners();

    final url = Uri.parse('https://10.0.2.2:5001/api/Categories');
    final token = await storage.read(key: 'token');
      
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders, );

    final List<dynamic> categoriMap = json.decode(resp.body);

    categoriMap.forEach((value) {
      final resCategori = Categories.fromMap(value);
      //resCategori.idcategory = key;
      categories.add(resCategori);
    });

    isloading = false;
    notifyListeners();

    return categories;

  }

  Future saveOrUpdateCategory(Categories category) async {
    isSaving = true;
    notifyListeners();

    if(category.idcategory == null){
      await saveCategory(category);
    }else{
      await updateCategory(category);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String?> saveCategory(Categories category) async {

    final url = Uri.parse('https://10.0.2.2:5001/api/Categories');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    final resp = await http.post(url, headers: requestHeaders, body: jsonEncode(category.toJson()));
    final decodeData = json.decode(resp.body);
    category.idcategory = decodeData['name'];

    categories.add(category);

    notifyListeners();
    return category.idcategory;

  }

  Future<String?> updateCategory(Categories category) async {
    isSaving = true;

    final url = Uri.parse('https://10.0.2.2:5001/api/Categories/${category.idcategory}');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    
    final resp = await http.put(url, headers: requestHeaders, body: jsonEncode(category.toJson()),);
    

    final index = categories.indexWhere((element) => element.idcategory == category.idcategory);
    categories[index] = category;

    notifyListeners();
    isSaving = false;
    return category.idcategory;

  }

  Future<String> deleteCategory(String idcategory) async {
    final url = Uri.parse('https://10.0.2.2:5001/api/Categories/${idcategory}');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    final resp = await http.delete(url, headers: requestHeaders);
    
    notifyListeners();
    categories.clear();
    loadCategories();
    return idcategory;
  }

}