import 'package:flutter/material.dart';
import 'package:cupboard_flutter/src/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ProductsModel product;

  ProductProvider(this.product);

  /* categoriU( value){
    print(value);

    this.categoria = value;
    notifyListeners();
  } */

  bool isValidForm(){
    print('nombre: ${product.nameProduct}');
    print('code: ${product.barCode}');
    print('id mark: ${product.idMark}');
   // print('id mark: ${product.trademark}');
    return formKey.currentState?.validate() ?? false;
  } 
}