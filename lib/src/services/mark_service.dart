import 'dart:convert';
import 'package:cupboard_flutter/src/models/mark_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MarkService extends ChangeNotifier{

  final List<Mark> marks = [];
  late Mark selectMark;

  final storage = const FlutterSecureStorage();
  final _baseUrl = 'https://apiproductmanagmentteamint.azurewebsites.net';

  bool isloading = true;
  bool isSaving = false;

  MarkService(){
    getMark();
  }

  Future<List<Mark>> getMark()async{

    isloading = true;
    notifyListeners();

    //final url = Uri.parse('https://10.0.2.2:5001/api/Trademarks');
    final url = Uri.parse('$_baseUrl/api/Trademarks');
    final token = await storage.read(key: 'token');
      
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> categoriMap = json.decode(resp.body);

    for (var value in categoriMap) {
      final response = Mark.fromMap(value);
      marks.add(response);
    }

    isloading = false;
    notifyListeners();

    return marks;

  }

  Future saveOrUpdateMark(Mark mark) async {
    isSaving = true;
    notifyListeners();

    if(mark.idTrademark == null){
      await saveMark(mark);
    }else{
      updateMark(mark);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String?> saveMark(Mark mark) async {

    final url = Uri.parse('$_baseUrl/api/Trademarks');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    final resp = await http.post(url, headers: requestHeaders ,body: jsonEncode(mark.toJson()));
    final respuesta = json.decode(resp.body);
    mark.idTrademark = respuesta['name'];

    marks.add(mark);

    notifyListeners();
    return mark.idTrademark;

  }

  Future<String?> updateMark(Mark mark) async {

    final url = Uri.parse('$_baseUrl/api/Trademarks/${mark.idTrademark}');
    final token = await storage.read(key: 'token');
    
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };
    
    await http.put(url, headers: requestHeaders, body: jsonEncode(mark.toJson()),);

    final index = marks.indexWhere((element) => element.idTrademark == mark.idTrademark);
    marks[index] = mark;

    notifyListeners();
    return mark.idTrademark;

  }

  Future<String> deleteMark(String idTrademark) async {
    final url = Uri.parse('$_baseUrl/api/Trademarks/$idTrademark');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    await http.delete(url, headers: requestHeaders);
    notifyListeners();
    marks.clear();
    getMark();
    return idTrademark;
  }
  
}