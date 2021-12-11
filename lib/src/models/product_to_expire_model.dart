import 'dart:convert';

class Product {
    Product({
      required this.idProduct,
      required this.idMark,
      required this.nameProduct,
      required this.barCode,
    });

    String idProduct;
    String idMark;
    String nameProduct;
    String barCode;

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
      idProduct: json["idProduct"],
      idMark: json["idMark"],
      nameProduct: json["nameProduct"],
      barCode: json["barCode"],
      
    );

    Map<String, dynamic> toMap() => {
      "idProduct": idProduct,
      "idMark": idMark,
      "nameProduct": nameProduct,
      "barCode": barCode,
    };
}

class ProdExpireModel {
  ProdExpireModel({
    required this.idCupboardDetail,
    required this.idCupBoard,
    required this.idProduct,
    required this.amount,
    required this.entryDate,
    required this.exitDate,
    required this.expirationDate,
    required this.product,
  });

    String idCupboardDetail;
    String idCupBoard;
    String idProduct;
    int amount;
    DateTime entryDate;
    DateTime exitDate;
    DateTime expirationDate;
    Product product;

    factory ProdExpireModel.fromJson(String str) => ProdExpireModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProdExpireModel.fromMap(Map<String, dynamic> json) => ProdExpireModel(
        idCupboardDetail: json["idCupboardDetail"],
        idCupBoard: json["idCupBoard"],
        idProduct: json["idProduct"],
        amount: json["amount"],
        entryDate: DateTime.parse(json["entryDate"]),
        exitDate: DateTime.parse(json["exitDate"]),
        expirationDate: DateTime.parse(json["expirationDate"]),
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
        "product": product.toMap(),
    };
}
