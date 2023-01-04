import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if(productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        //*ICONO EN LA IZQUIERDA
        // leading: IconButton(
        //   icon: Icon(Icons.login_outlined),
        //   onPressed: () {},
        // )
        actions: [IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: ()  {

            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');


          },
        )]
      ),
       body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ( BuildContext context, int index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: productsService.products[index])
          ),
       ),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          productsService.selectedProduct = new Product( 
            available: false,
            name: '',
            price: 0);
          Navigator.pushNamed(context, 'product');

        },
       ),
    );
  }
}