
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
    //List<CupboardModel> cupBoardDetails;
    //DateTime expirationDate;

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
      idProduct: json["idProduct"],
      idMark: json["idMark"],
      nameProduct: json["nameProduct"],
      barCode: json["barCode"],
      //cupBoardDetails: List<CupboardModel>.from(json["cupBoardDetails"].map((x) => CupboardModel.fromMap(x))),
     // expirationDate: DateTime.parse(json["expirationDate"]),
      //expirationDate: json["expirationDate"] == null ? null : DateTime.parse(json["expirationDate"]),
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

class CupBoard {
    CupBoard({
      this.idCupBoard,
      this.nameCupBoard,
      this.isDefault,
      this.creationDate,
      this.cupBoardDetails,
    });

    String? idCupBoard;
    String? nameCupBoard;
    bool? isDefault;
    DateTime? creationDate;
    List<CupboardModel>? cupBoardDetails;

    factory CupBoard.fromJson(String str) => CupBoard.fromMap(json.decode(str));

    factory CupBoard.fromMap(Map<String, dynamic> json) => CupBoard(
        idCupBoard: json["idCupBoard"],
        nameCupBoard: json["nameCupBoard"],
        isDefault: json["isDefault"],
        creationDate: DateTime.parse(json["creationDate"]),
        cupBoardDetails: List<CupboardModel>.from(json["cupBoardDetails"].map((x) => CupboardModel.fromMap(x))),
    );

    Map<String, dynamic> toJson() => {
        "idCupBoard": idCupBoard,
        "nameCupBoard": nameCupBoard,
        "isDefault": isDefault,
        "creationDate": creationDate,
        "cupBoardDetails": List<dynamic>.from(cupBoardDetails!.map((x) => x.toJson())),
    };
}

class CupboardModel {
    CupboardModel({
      this.idCupboardDetail,
      this.idCupBoard,
      required this.idProduct,
      required this.amount,
      required this.entryDate,
      required this.exitDate,
      required this.expirationDate,
      this.product,
    });

    String? idCupboardDetail;
    String? idCupBoard;
    String idProduct;
    int amount;
    String entryDate;
    String exitDate;
    String expirationDate;
    Product? product;

    factory CupboardModel.fromJson(String str) => CupboardModel.fromMap(json.decode(str));

    

    factory CupboardModel.fromMap(Map<String, dynamic> json) => CupboardModel(
      idCupboardDetail: json["idCupboardDetail"],
      idCupBoard: json["idCupBoard"],
      idProduct: json["idProduct"],
      amount: json["amount"],
      entryDate: json["entryDate"],
      exitDate: json["exitDate"],
      expirationDate: json["expirationDate"],
      //cupBoard: CupBoard.fromMap(json["cupBoard"]),
      product: Product.fromMap(json["product"]),
    );

    Map<String, dynamic> toJson() => {
      "idCupboardDetail": idCupboardDetail,
      "idCupBoard": idCupBoard,
      "idProduct": idProduct,
      "amount": amount,
      "entryDate": entryDate,
      "exitDate": exitDate,
      "expirationDate": expirationDate,
      //"cupBoard": cupBoard!.toJson(),
      //"product": product!.toMap(),
    };
}
 





/* import 'dart:convert';

class Cupboard {
    Cupboard({
      this.nameCupBoard,
      this.isDefault,
      this.creationDate,
      this.cupBoardDetails,
    });

    String? nameCupBoard;
    bool? isDefault;
    String? creationDate;
    List<CupBoardDetail>? cupBoardDetails;

    factory Cupboard.fromJson(String str) => Cupboard.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cupboard.fromMap(Map<String, dynamic> json) => Cupboard(
        nameCupBoard: json["nameCupBoard"],
        isDefault: json["isDefault"],
        creationDate: json["creationDate"],
        cupBoardDetails: List<CupBoardDetail>.from(json["cupBoardDetails"].map((x) => CupBoardDetail.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "nameCupBoard": nameCupBoard,
        "isDefault": isDefault,
        "creationDate": creationDate,
        "cupBoardDetails": List<dynamic>.from(cupBoardDetails!.map((x) => x.toMap())),
    };
}

/* class CupBoard {
    CupBoard({
      required this.idCupBoard,
      required this.nameCupBoard,
      required this.isDefault,
      required this.creationDate,
      required this.cupBoardDetails,
    });

    String idCupBoard;
    String nameCupBoard;
    bool isDefault;
    DateTime creationDate;
    List<CupBoardDetail> cupBoardDetails;

    factory CupBoard.fromJson(String str) => CupBoard.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CupBoard.fromMap(Map<String, dynamic> json) => CupBoard(
        idCupBoard: json["idCupBoard"],
        nameCupBoard: json["nameCupBoard"],
        isDefault: json["isDefault"],
        creationDate: DateTime.parse(json["creationDate"]),
        cupBoardDetails: List<CupBoardDetail>.from(json["cupBoardDetails"].map((x) => CupBoardDetail.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "idCupBoard": idCupBoard,
        "nameCupBoard": nameCupBoard,
        "isDefault": isDefault,
        "creationDate": creationDate.toIso8601String(),
        "cupBoardDetails": List<dynamic>.from(cupBoardDetails.map((x) => x.toMap())),
    };
} */

class CupBoardDetail {
    CupBoardDetail({
      this.idCupboardDetail,
      this.idCupBoard,
      required this.idProduct,
      required this.amount,
      required this.entryDate,
      required this.exitDate,
      required this.expirationDate,
      //required this.cupBoard,
    });

    String? idCupboardDetail;
    String? idCupBoard;
    String idProduct;
    int amount;
    DateTime entryDate;
    DateTime exitDate;
    DateTime expirationDate;
    //CupBoard cupBoard;

    factory CupBoardDetail.fromJson(String str) => CupBoardDetail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CupBoardDetail.fromMap(Map<String, dynamic> json) => CupBoardDetail(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"],
        entryDate: DateTime.parse(json["entryDate"]),
        exitDate: DateTime.parse(json["exitDate"]),
        expirationDate: DateTime.parse(json["expirationDate"]),
        //cupBoard: CupBoard.fromMap(json["cupBoard"]),
        //cupBoard: json["cupBoard"] == null ? null : CupBoard.fromMap(json["cupBoard"]),
    );

    Map<String, dynamic> toMap() => {
        "idCupboardDetail": idCupboardDetail,
        "idCupBoard": idCupBoard,
        "idProduct": idProduct,
        "amount": amount,
        "entryDate": entryDate.toIso8601String(),
        "exitDate": exitDate.toIso8601String(),
        "expirationDate": expirationDate.toIso8601String(),
        //"cupBoard": cupBoard == null ? null : cupBoard.toMap(),
    };
}
 */