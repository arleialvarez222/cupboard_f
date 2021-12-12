
import 'package:cupboard_flutter/src/models/cupboard_model.dart';
import 'package:flutter/material.dart';

class EditCupboardProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late CupboardModel cupModel;

  EditCupboardProvider(
    this.cupModel
  );

  valueSelect(String value){
    cupModel.idProduct = value;
    notifyListeners();
  }



  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }
}