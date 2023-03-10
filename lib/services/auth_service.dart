import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final String _baseURL = dotenv.env['BASE_URL'].toString();
  final String _fireBaseToken = dotenv.env['FIREBASE_API_KEY'].toString();

  final storage = new FlutterSecureStorage();

  //Si retornamos algo es un error, sino todo bien
  Future<String?> createUser( String email, String password) async{ 
    
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseURL, '/v1/accounts:signUp', {
      'key': _fireBaseToken
    });

    final resp = await http.post(url, body: json.encode( authData ));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    //print(decodedResp);

    if ( decodedResp.containsKey('idToken')){
        //Token hay que guardarlo en un lugar seguro
        await storage.write(key: 'token', value: decodedResp['idToken']); 

        // return decodedResp['idToken'];
        return null;
    }else{
        return decodedResp['error']['message'];
    }
    

  }


  Future<String?> login( String email, String password) async{ 
    
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseURL, '/v1/accounts:signInWithPassword', {
      'key': _fireBaseToken
    });

    final resp = await http.post(url, body: json.encode( authData ));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
 
    if ( decodedResp.containsKey('idToken')){
        //Token hay que guardarlo en un lugar seguro
        await storage.write(key: 'token', value: decodedResp['idToken']); 
        // return decodedResp['idToken'];
        return null;
    }else{
        return decodedResp['error']['message'];
    }
    

  }

  Future logout() async{ 
    await storage.delete(key: 'token'); 
    return;

  }

  Future<String> readToken() async{

    return await storage.read( key: 'token') ??  '';

  }


}