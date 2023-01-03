import 'package:flutter/material.dart';

import '../models/models.dart';


//La clase ChangeNotifier es una clase abstracta que proporciona un mecanismo para informar
// a otras partes de tu aplicación que un cambio ha ocurrido. Esto es útil si tienes algún estado
// que es compartido entre diferentes widgets y necesitas informar a todos esos widgets cuando el estado ha cambiado.

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;
  //constructor            v debe ser una copia para evitar referncia
  ProductFormProvider( this.product);

  updateAvailability(bool value){
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm(){


    return formKey.currentState?.validate() ?? false;
  }

}