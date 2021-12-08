// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromMap(jsonString);

import 'dart:convert';

class Mark {
  Mark({
      this.idTrademark,
      required this.mark,
  });

  String? idTrademark;
  String mark;

  factory Mark.fromJson(String str) => Mark.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory Mark.fromMap(Map<String, dynamic> json) => Mark(
      idTrademark: json["idTrademark"],
      mark: json["mark"],
  );

  Map<String, dynamic> toJson() => {
      "idTrademark": idTrademark,
      "mark": mark,
  };

  Mark update() => Mark(
    idTrademark: idTrademark,
    mark: mark
  );

}
