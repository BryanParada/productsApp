import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final String _baseURL = dotenv.env['BASE_URL'].toString();
  final String _fireBaseToken = dotenv.env['FIREBASE_API_KEY'].toString();

  Future<String?> createUser( String email, String password) async{

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.https(_baseURL, '/v1/accounts:signUp', {
      'key': _fireBaseToken
    });

    final resp = await http.post(url, body: json.encode( authData ));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);
    

  }


}