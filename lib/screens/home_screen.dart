import 'package:flutter/material.dart';
import 'package:products_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
       body: ListView.builder(
        itemCount: 10,
        itemBuilder: ( BuildContext context, int index) => ProductCard(),
       ),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
       ),
    );
  }
}