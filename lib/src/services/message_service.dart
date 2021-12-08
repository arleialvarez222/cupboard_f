
import 'package:flutter/material.dart';

class MessageService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message){
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white, fontSize: 20),),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }

}