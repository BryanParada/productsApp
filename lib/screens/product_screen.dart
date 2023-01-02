import 'package:flutter/material.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);


    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct?.picture),
                Positioned(
                  top: 60,
                  left: 20,  
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white)
                    )
                  ),
                  Positioned(
                  top: 60,
                  right: 20,  
                  child: IconButton(
                    onPressed: () {
                      //TODO: Camara o galeria

                    },
                    icon: Icon(Icons.camera_alt_outlined, color: Colors.white)
                  )
                  )
              ],
            ),

            _ProductForm(),

            SizedBox(height: 100,)

          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.save_outlined),
        onPressed: () {

        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity, 
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [

              SizedBox(height: 10,),

              TextFormField(
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Name of the product',
                   labelText: 'Name: '
                   ),
              ),

              SizedBox(height: 30,),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Price: '
                   ),
              ),

              SizedBox(height: 30,),

              SwitchListTile(
                value: true,
                title: Text('Available'),
                activeColor: Colors.indigo,
                onChanged: ( value) {
                  //TODO: pendiente
                } 
              ),

              SizedBox(height: 30,)

            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}