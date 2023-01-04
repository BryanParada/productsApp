import 'package:flutter/material.dart';

class NotificationsService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, String status){

    final snackBar = new SnackBar(
      content: Text( message, style: TextStyle( color: Colors.white, fontSize: 20)),
      backgroundColor: status == "error" ? Colors.red : Colors.green,
      );
  
  messengerKey.currentState!.showSnackBar(snackBar);
  
  }
  
}