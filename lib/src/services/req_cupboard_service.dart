import 'dart:convert';
import 'package:cupboard_flutter/src/models/cupboard_model.dart';
import 'package:cupboard_flutter/src/models/reques_cupboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReqCupboadService extends ChangeNotifier{

  late CupBoardReq selectCupboardDetail;
  late CupBoardDetail selectCupboardDet;
  
  final List<CupboardModel> cupboardList = [];
  late CupboardModel selectCupboard;
  final List<CupboardAvailable> cupboardLista = [];
  late CupboardAvailable selectCupboardd;
  final storage = const FlutterSecureStorage();
  final _baseUrl = 'https://apiproductmanagmentteamint.azurewebsites.net';
  bool isSaving = false;
  bool isloading = true;
  final fech = DateTime.now();

  ReqCupboadService(){
    getCupboard();
    getAllCupboard();
  }

  Future<List<CupboardAvailable>> getCupboard()async{
    notifyListeners();

    final url = Uri.parse('$_baseUrl/api/CupboardDetails/valid-products');
    final token = await storage.read(key: 'token');
      
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> cupboardMap = json.decode(resp.body);

    for (var value in cupboardMap) {
      final response = CupboardAvailable.fromMap(value);

      cupboardLista.add(response);
    }

    isloading = false;
    notifyListeners();

    return cupboardLista;

  }

  Future<List<CupboardModel>> getAllCupboard()async{
    notifyListeners();

    final url = Uri.parse('$_baseUrl/api/CupboardDetails');
    final token = await storage.read(key: 'token');
      
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> cupboardMap = json.decode(resp.body);

    for (var value in cupboardMap) {
      final response = CupboardModel.fromMap(value);

      //if(response.expirationDate   fech)
      cupboardList.add(response);
    }

    isloading = false;
    notifyListeners();

    return cupboardList;

  }

  Future saveOrUpdateCupboard(CupBoardReq cupboardReq, CupBoardDetail cupBoardDetail) async{
    isSaving = true;
    notifyListeners();

    if(cupboardReq.idCupBoard == null){
      await saveCupboard(cupboardReq, cupBoardDetail);
    }else{
      //await updateCupboard(cupboardModel);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String?> saveCupboard(CupBoardReq cupboardReq, CupBoardDetail cupBoardDetail)async{
    final url = Uri.parse('$_baseUrl/api/CupBoard/Create-cupboard-Detail');
    final token = await storage.read(key: 'token');

    final Map<String, dynamic> cupboardData = {
      'nameCupBoard': cupboardReq.nameCupBoard,
      'isDefault': cupboardReq.isDefault,
      'creationDate': cupboardReq.creationDate,
      'cupBoardDetails': [cupBoardDetail],
    }; 

    Map<String, String> requesHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token',
    };
    final resp = await http.post(url, headers: requesHeaders, body: jsonEncode(cupboardData));
    final data = json.decode(resp.body);
    cupboardReq.idCupBoard = data['idCupBoard'];

    notifyListeners();
    cupboardList.clear();
    getAllCupboard();
    return cupboardReq.idCupBoard;

  }

  Future<String?> updateCupboard(CupboardModel cupBoardDetail)async{
    final url = Uri.parse('$_baseUrl/api/CupboardDetails/${cupBoardDetail.idCupboardDetail}');
    final token = await storage.read(key: 'token');

    Map<String, String> requesHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token',
    };
    await http.put(url, headers: requesHeaders, body: jsonEncode(cupBoardDetail.toJson()));
    final index = cupboardList.indexWhere((element) => element.idCupboardDetail == cupBoardDetail.idCupboardDetail);
    cupboardList[index] = cupBoardDetail;

    notifyListeners();
    cupboardList.clear();
    getAllCupboard();
    return cupBoardDetail.idCupboardDetail;

  }

  Future<String> deleteCupboard(String idCupboard) async {
    final url = Uri.parse('$_baseUrl/api/CupBoard/$idCupboard');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    await http.delete(url, headers: requestHeaders);
    notifyListeners();
    cupboardList.clear();
    getAllCupboard();
    return idCupboard;
  }

}
