   
import 'dart:convert';

import 'package:flutter/material.dart'; 
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-a47b6-default-rtdb.firebaseio.com'; 
  final List<Product> products = [];
  Product? selectedProduct; //tambien se puede usar late en vez de ?
  bool isLoading = true;
  bool isSaving = false;

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

  Future saveOrCreateProduct( Product product) async{

    isSaving = true;
    notifyListeners();

    if ( product.id == null){
      // es necesario crear

    }else{
      //actualizar
      await this.updateProduct(product);
    }



    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct( Product product) async{

    final url = Uri.https( _baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson() );
    final decodedData = resp.body;

    print(decodedData);
    
    final index = this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;



  }


}