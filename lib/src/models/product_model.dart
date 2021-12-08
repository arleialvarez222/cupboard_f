// To parse this JSON data, do
//
//     final productsModel = productsModelFromMap(jsonString);

import 'dart:convert';

class ProductsModel {
    ProductsModel({
        this.idProduct,
        required this.idMark,
        required this.nameProduct,
        required this.barCode,
        this.trademark,
    });

    String? idProduct;
    String idMark;
    String nameProduct;
    String barCode;
    Trademark? trademark;

    factory ProductsModel.fromJson(String str) => ProductsModel.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory ProductsModel.fromMap(Map<String, dynamic> json) => ProductsModel(
        idProduct: json["idProduct"],
        idMark: json["idMark"],
        nameProduct: json["nameProduct"],
        barCode: json["barCode"],
        trademark: Trademark.fromMap(json["trademark"]),
    );

    Map<String, dynamic> toJson() => {
        //"idProduct": idProduct,
        "idMark": idMark,
        "nameProduct": nameProduct,
        "barCode": barCode,
        //"trademark": trademark!.toMap(),
    };
}

class Trademark {
    Trademark({
        required this.idTrademark,
        required this.mark,
    });

    String idTrademark;
    String mark;

    factory Trademark.fromJson(String str) => Trademark.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Trademark.fromMap(Map<String, dynamic> json) => Trademark(
        idTrademark: json["idTrademark"],
        mark: json["mark"],
    );

    Map<String, dynamic> toMap() => {
        "idTrademark": idTrademark,
        "mark": mark,
    };
}
