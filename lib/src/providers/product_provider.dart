import 'package:flutter/material.dart';
import 'package:cupboard_flutter/src/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ProductsModel product;

  ProductProvider(this.product);

  valueSelect(String value){
    product.idMark = value;
    notifyListeners();
  }

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  } 
}