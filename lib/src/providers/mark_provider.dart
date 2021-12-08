
import 'package:cupboard_flutter/src/models/mark_model.dart';
import 'package:flutter/material.dart';

class MarkProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Mark mark;

  MarkProvider(this.mark);

  /* categoriU( value){
    print(value);

    this.categoria = value;
    notifyListeners();
  } */

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  } 
}