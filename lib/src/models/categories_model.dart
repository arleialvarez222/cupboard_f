
import 'dart:convert';

class Categories {
    Categories({
        this.idcategory,
        required this.name,
    });

    String? idcategory;
    String name;

    factory Categories.fromJson(String str) => Categories.fromMap(json.decode(str));

    factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        idcategory: json["idcategory"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        //"idcategory": idcategory,
        "name": name,
    };

    Categories update() => Categories(
      idcategory: idcategory,
      name: name
    );
}
