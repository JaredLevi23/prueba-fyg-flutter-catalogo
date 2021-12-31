/*
  Pantalla de inicio de sesion 
*/
import 'package:flutter/material.dart';

import 'package:catalogo_productos/src/providers/users_service.dart';
import 'package:catalogo_productos/src/widgets/widgets.dart';
import 'package:catalogo_productos/src/validators/validator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // Controladores de entradas de texto 
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final validate = Validator();// Clase para validar correo  /validators/validator.dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 

        child: ListView(
          physics: const BouncingScrollPhysics(), 
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
        
            //Encabezado del widget ( reutilizado ) /widgets/custom_header.dart
            const CustomHeader( title: 'Catálogo de Productos',), 
        
            // Entrada de texto del correo 
            CustomTextField(//widget( reutilizado ) /widgets/custom_textfield.dart
              label: 'Correo Electrónico',
              controller: _emailController,
              isPassword: false,
              icon: Icons.email,
            ),
            
            CustomTextField(//widget( reutilizado ) /widgets/custom_textfield.dart
              label: 'Contraseña',
              controller: _passwordController,
              isPassword: true,
              icon: Icons.lock,
            ),
        
            CustomButton(//widget( reutilizado ) /widgets/custom_button.dart
              label: 'Iniciar Sesión',
              onPressed: () async{
                //Verificar que los campos sean validos
                if( validate.isEmail(_emailController.text.trim()) ){ // es un correo valido
                  
                  // La clase contiene el para iniciar sesion 
                  final userService =  UserService(); // clase /provider/users_service.dart
                  // Espera una respuesta del login
                  bool res = await userService.login(_emailController.text.trim(), _passwordController.text) ;

                  if( res == false){
                    // Muestra una alerta 
                    showDialog(context: context, builder: (context) => const
                     CustomDialog( //widget( reutilizado ) /widgets/custom_dialog.dart
                      error: true  ,
                      message: 'Las credenciales son incorrectas' 
                    ));
                  }else{
                    Navigator.pushReplacementNamed(context, 'home'); // Navega pantalla de inicio /screens/home_screen.dart
                  }

                }else{
                  // si no es un correo valido muestra la alerta
                  showDialog(context: context, builder: (context) => const 
                  CustomDialog( // widget ( reutilizado ) /widgets/custom_dialog.dart
                    error: true,
                    message: 'El correo electronico es invalido',
                  ));
                }
                
              },
            ),

            //Boton para iniciar sesion con google
            const GoogleButton(), // (widget) /widgets/google_button.dart
        
            const SizedBox(height: 25,),
        
            GestureDetector(
              child: const Center(
                child: Text(
                  '¿Aún no tienes cuenta?\nRegístrate aquí', 
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 15, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.black54
                  ),
                )
              ),
              onTap: ()=> Navigator.pushNamed(context, 'register'), //Navega al registro /screens/register_screen.dart
            ),
            const SizedBox(height: 25,)
          ]
        ),
      )
    );
  }
}
