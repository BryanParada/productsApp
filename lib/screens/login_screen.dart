import 'package:flutter/material.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
             children: [

                SizedBox( height: 250, ),

                CardContainer( 
                  child: Column(
                    children: [

                      SizedBox(height: 10,),
                      Text('Login', style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 30,),

                      ChangeNotifierProvider(
                        create: ( _ ) => LoginFormProvider(),
                        child: _LoginForm() 
                        ),
                      //_LoginForm(),

                    ],
                  )
                ),

                SizedBox( height: 50,),

                TextButton(
                  //*PARA NO VOLVER A LA RUTA ANTERIOR!
                  onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all( StadiumBorder())
                  ),
                  child:  Text('Create new account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  ),

                SizedBox( height: 50,),
             ],
          )
        ),
      )
    );
  }
}

class _LoginForm extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value ) => loginForm.email = value,
              validator: ( value ) {

                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Email is invalid';
                   
              },
            ),

            SizedBox(height: 30,),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                 hintText: '****',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value ) => loginForm.password = value,
              validator: ( value ) {
 
                  // if ( value != null && value.length >= 6) return null; 
                  // return 'Password must be at least 6 characters';

                  return ( value != null && value.length >= 6) 
                  ? null 
                  : 'Password must be at least 6 characters';
                   
              },
            ),

            SizedBox(height: 30,),


            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text( 
                  loginForm.isLoading
                  ? 'Wait please...'
                  : 'Enter',
                  style: TextStyle( color: Colors.white)
                )
              ),
              onPressed: loginForm.isLoading ? null : ()async{

                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

               if ( !loginForm.isValidForm()) return;

                loginForm.isLoading = true;

                //await Future.delayed(Duration(seconds: 2));
 
                //TODO: validar si es el login correcto
                final String? errorMessage = await authService.login(loginForm.email, loginForm.password);

                if (errorMessage == null){
                      Navigator.pushReplacementNamed(context, 'home');
                } else {
                  //TODO: mostar error en pantalla
                  print(errorMessage);
                loginForm.isLoading = false; 
                } 
              }
              )

          ],
        )
        ),
    );
  }
}