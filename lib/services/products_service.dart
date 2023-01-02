   
import 'dart:convert';

import 'package:flutter/material.dart'; 
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-a47b6-default-rtdb.firebaseio.com'; 
  final List<Product> products = [];
  bool isLoading = true;

  //instancia
  ProductsService(){

    this.loadProducts();

  }

  //TODO: <List<Product>>
  Future loadProducts() async{

    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
 
    productsMap.forEach((key, value) {
      final tempProdcut = Product.fromMap( value );
      tempProdcut.id = key;
      this.products.add(tempProdcut);

    });

    print( this.products[0].name);
    

  }


}