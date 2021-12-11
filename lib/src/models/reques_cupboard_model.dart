
import 'dart:convert';

class CupBoardReq {
  CupBoardReq({
    this.idCupBoard,
    required this.nameCupBoard,
    required this.isDefault,
    this.creationDate,
    this.cupBoardDetails,
  });

  String? idCupBoard;
  String nameCupBoard;
  bool isDefault;
  String? creationDate;
  List<CupBoardDetail>? cupBoardDetails;

  factory CupBoardReq.fromJson(String str) => CupBoardReq.fromMap(json.decode(str));

  factory CupBoardReq.fromMap(Map<String, dynamic> json) => CupBoardReq(
    idCupBoard: json["idCupBoard"],
    nameCupBoard: json["nameCupBoard"],
    isDefault: json["isDefault"],
    creationDate: json["creationDate"],
    cupBoardDetails: List<CupBoardDetail>.from(json["cupBoardDetails"].map((x) => CupBoardDetail.fromMap(x))),
  );

  Map<String, dynamic> toJson() => {
    "idCupBoard": idCupBoard,
    "nameCupBoard": nameCupBoard,
    "isDefault": isDefault,
    "creationDate": creationDate,
    "cupBoardDetails": List<dynamic>.from(cupBoardDetails!.map((x) => x.toJson())),
  };
}

class CupBoardDetail {
  CupBoardDetail({
    this.idCupboardDetail,
    this.idCupBoard,
    required this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
  });

  String? idCupboardDetail;
  String? idCupBoard;
  String idProduct;
  String amount;
  String entryDate;
  String exitDate;
  String expirationDate;

  factory CupBoardDetail.fromJson(String str) => CupBoardDetail.fromMap(json.decode(str));

  factory CupBoardDetail.fromMap(Map<String, dynamic> json) => CupBoardDetail(
    idCupboardDetail: json["idCupboardDetail"],
    idCupBoard: json["idCupBoard"],
    idProduct: json["idProduct"],
    amount: json["amount"],
    entryDate: json["entryDate"],
    exitDate: json["exitDate"],
    expirationDate: json["expirationDate"],
  );

  Map<String, dynamic> toJson() => {
    "idCupboardDetail": idCupboardDetail,
    "idCupBoard": idCupBoard,
    "idProduct": idProduct,
    "amount": amount,
    "entryDate": entryDate,
    "exitDate": exitDate,
    "expirationDate": expirationDate,
  };
}
