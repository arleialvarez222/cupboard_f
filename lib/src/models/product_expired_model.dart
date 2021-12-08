/* 
import 'dart:convert';

class ExpiredProdModel {
    ExpiredProdModel({
      required this.idCupboardDetail,
      required this.idCupBoard,
      required this.idProduct,
      required this.amount,
      required this.entryDate,
      required this.exitDate,
      required this.expirationDate,
    });

    String idCupboardDetail;
    String idCupBoard;
    String idProduct;
    int amount;
    DateTime entryDate;
    DateTime exitDate;
    DateTime expirationDate;

    factory ExpiredProdModel.fromJson(String str) => ExpiredProdModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ExpiredProdModel.fromMap(Map<String, dynamic> json) => ExpiredProdModel(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"],
        entryDate: DateTime.parse(json["entryDate"]),
        exitDate: DateTime.parse(json["exitDate"]),
        expirationDate: DateTime.parse(json["expirationDate"]),
    );

    Map<String, dynamic> toMap() => {
        "idCupboardDetail": idCupboardDetail,
        "idCupBoard": idCupBoard,
        "idProduct": idProduct,
        "amount": amount,
        "entryDate": entryDate.toIso8601String(),
        "exitDate": exitDate.toIso8601String(),
        "expirationDate": expirationDate.toIso8601String(),
    };
}
 */


import 'dart:convert';

class Product {
  Product({
    required this.idProduct,
    required this.idMark,
    required this.nameProduct,
    required this.barCode,
    //required this.cupBoardDetails,
    //required this.expirationDate,
  });

  String idProduct;
  String idMark;
  String nameProduct;
  String barCode;
  //List<ExpiredProdModel> cupBoardDetails;
  //DateTime expirationDate;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    idProduct: json["idProduct"],
    idMark: json["idMark"],
    nameProduct: json["nameProduct"],
    barCode: json["barCode"],
    //cupBoardDetails: List<ExpiredProdModel>.from(json["cupBoardDetails"].map((x) => ExpiredProdModel.fromMap(x))),
    //expirationDate: DateTime.parse(json["expirationDate"]),
  );

  Map<String, dynamic> toMap() => {
    "idProduct": idProduct,
    "idMark": idMark,
    "nameProduct": nameProduct,
    "barCode": barCode,
    //"cupBoardDetails": List<dynamic>.from(cupBoardDetails.map((x) => x.toMap())),
    //"expirationDate": expirationDate.toIso8601String(),
  };
}

/* class CupBoard {
  CupBoard({
    required this.idCupBoard,
    //required this.nameCupBoard,
    required this.isDefault,
    required this.creationDate,
    //required this.cupBoardDetails,
  });

  String idCupBoard;
  //NameCupBoard nameCupBoard;
  bool isDefault;
  DateTime creationDate;
  //List<ExpiredProdModel> cupBoardDetails;

  factory CupBoard.fromJson(String str) => CupBoard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CupBoard.fromMap(Map<String, dynamic> json) => CupBoard(
    idCupBoard: json["idCupBoard"],
    //nameCupBoard: nameCupBoardValues.map[json["nameCupBoard"]],
    isDefault: json["isDefault"],
    creationDate: DateTime.parse(json["creationDate"]),
    //cupBoardDetails: List<ExpiredProdModel>.from(json["cupBoardDetails"].map((x) => ExpiredProdModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "idCupBoard": idCupBoard,
    //"nameCupBoard": nameCupBoardValues.reverse[nameCupBoard],
    "isDefault": isDefault,
    "creationDate": creationDate.toIso8601String(),
    //"cupBoardDetails": List<dynamic>.from(cupBoardDetails.map((x) => x.toMap())),
  };
} */

class ExpiredProdModel {
  ExpiredProdModel({
    required this.idCupboardDetail,
    required this.idCupBoard,
    required this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
    //required this.cupBoard,
    required this.product,
  });

  String idCupboardDetail;
  String idCupBoard;
  String idProduct;
  int amount;
  DateTime entryDate;
  DateTime exitDate;
  DateTime expirationDate;
  //CupBoard cupBoard;
  Product product;

  factory ExpiredProdModel.fromJson(String str) => ExpiredProdModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExpiredProdModel.fromMap(Map<String, dynamic> json) => ExpiredProdModel(
    idCupboardDetail: json["idCupboardDetail"],
    idCupBoard: json["idCupBoard"],
    idProduct: json["idProduct"],
    amount: json["amount"],
    entryDate: DateTime.parse(json["entryDate"]),
    exitDate: DateTime.parse(json["exitDate"]),
    expirationDate: DateTime.parse(json["expirationDate"]),
    //cupBoard: CupBoard.fromMap(json["cupBoard"]),
    product: Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "idCupboardDetail": idCupboardDetail,
    "idCupBoard": idCupBoard,
    "idProduct": idProduct,
    "amount": amount,
    "entryDate": entryDate.toIso8601String(),
    "exitDate": exitDate.toIso8601String(),
    "expirationDate": expirationDate.toIso8601String(),
    //"cupBoard": cupBoard.toMap(),
    "product": product.toMap(),
  };
}



