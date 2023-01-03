import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_app/providers/product_form_provider.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductScreenBody(productService: productService)
      );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        //esta opcion oculta el teclado al hacer scroll
        //no se recomienda puesto que usuario puede mover intencionalmente para tener mas espacio
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        
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

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

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
                initialValue: product.name,
                onChanged: ( value ) => product.name = value,
                validator:(value) {
                  if ( value == null || value.length < 1)
                  return 'Name is required';
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Name of the product',
                   labelText: 'Name: '
                   ),
              ),

              SizedBox(height: 30,),

              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: ( value ) {
                  if ( double.tryParse(value) == null){
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                }, 
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Price: '
                   ),
              ),

              SizedBox(height: 30,),

              SwitchListTile(
                value: product.available,
                title: Text('Available'),
                activeColor: Colors.indigo,
                //onChanged: ( value) => productForm.updateAvailability(value)
                // ===
                onChanged: productForm.updateAvailability
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