import 'package:flutter/material.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
       body: ListView.builder(
        itemCount: 10,
        itemBuilder: ( BuildContext context, int index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'product'),
          child: ProductCard()
          ),
       ),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
       ),
    );
  }
}