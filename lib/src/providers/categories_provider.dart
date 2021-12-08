
import 'package:cupboard_flutter/src/models/categories_model.dart';

import 'package:flutter/material.dart';

class CategoriProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Categories categoria;

  CategoriProvider(this.categoria);

  bool isValidForm(){
    //print(categoria.name);
    //print(categoria.idcategory);
    return formKey.currentState?.validate() ?? false;
  } 
}