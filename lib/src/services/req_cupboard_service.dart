import 'dart:convert';
import 'package:cupboard_flutter/src/models/cupboard_model.dart';
import 'package:cupboard_flutter/src/models/reques_cupboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReqCupboadService extends ChangeNotifier{

  final List<CupBoardReq> cupboardDetail = [];
  late CupBoardReq selectCupboardDetail;
  final List<CupBoardDetail> cupboardDet = [];
  late CupBoardDetail selectCupboardDet;


  final List<CupboardModel> cupboardList = [];
  late CupboardModel selectCupboard;
  final storage = const FlutterSecureStorage();
  bool isSaving = false;
  bool isloading = true;

  ReqCupboadService(){
    getCupboard();
  }

  Future<List<CupboardModel>> getCupboard()async{
    notifyListeners();

    final url = Uri.parse('https://10.0.2.2:5001/api/CupboardDetails');
    final token = await storage.read(key: 'token');
      
    Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization' : 'Bearer $token'
    };
    http.Response resp = await http.get(url, headers: requestHeaders);

    final List<dynamic> cupboardMap = json.decode(resp.body);

    cupboardMap.forEach((value) {
      final response = CupboardModel.fromMap(value);
      cupboardList.add(response);
      //cupboardDetail.add(response);
    });

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
    final url = Uri.parse('https://10.0.2.2:5001/api/CupBoard/Create-cupboard-Detail');
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

    //cupboardDetail.add(cupboardModel);
    //print(data);

    notifyListeners();
    cupboardList.clear();
    getCupboard();
    return cupboardReq.idCupBoard;

  }

  Future<String?> updateCupboard(CupboardModel cupBoardDetail)async{
    final url = Uri.parse('https://10.0.2.2:5001/api/CupboardDetails/${cupBoardDetail.idCupboardDetail}');
    final token = await storage.read(key: 'token');

    /* final Map<String, dynamic> cupboardData = {
      'nameCupBoard': cupboardReq.nameCupBoard,
      'isDefault': cupboardReq.isDefault,
      'creationDate': cupboardReq.creationDate,
      'cupBoardDetails': [cupBoardDetail],
    };  */

    Map<String, String> requesHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token',
    };
    final resp = await http.put(url, headers: requesHeaders, body: jsonEncode(cupBoardDetail.toJson()));
    final index = cupboardList.indexWhere((element) => element.idCupboardDetail == cupBoardDetail.idCupboardDetail);
    cupboardList[index] = cupBoardDetail;

    //cupboardDetail.add(cupboardModel);
    //print(data);

    notifyListeners();
    cupboardList.clear();
    getCupboard();
    return cupBoardDetail.idCupboardDetail;

  }

  Future<String> deleteCupboard(String idCupboard) async {
    final url = Uri.parse('https://10.0.2.2:5001/api/CupBoard/${idCupboard}');
    final token = await storage.read(key: 'token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    final resp = await http.delete(url, headers: requestHeaders);
    notifyListeners();
    cupboardList.clear();
    getCupboard();
    return idCupboard;
  }

}
