   
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
 
  Future <List<Product>> loadProducts() async{

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
 
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap( value );
      tempProduct.id = key;
      this.products.add(tempProduct);

    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
    

  }


}