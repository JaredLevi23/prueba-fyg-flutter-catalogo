/*
  Pantalla del registro de usuario
  **Este registro es volatil, cuando se baja el servidor **
*/

import 'package:flutter/material.dart';

import 'package:catalogo_productos/src/providers/users_service.dart';
import 'package:catalogo_productos/src/validators/validator.dart';
import 'package:catalogo_productos/src/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  //Controladores de entradas de texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final validate = Validator(); // Clase para validar email

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const CustomHeader(title:'Crear una cuenta es gratis'), // widget (reutilizado ) /widgets/custom_header.dart
            CustomTextField( //widget( reutilizado ) /widgets/custom_textfield.dart
              icon: Icons.email, 
              label: 'Correo electrónico', 
              isPassword: false, 
              controller: emailController,
              textType: TextInputType.emailAddress,
            ),
            CustomTextField(//widget( reutilizado ) /widgets/custom_textfield.dart
              icon: Icons.person, 
              label: 'Nombre', 
              isPassword: false, 
              controller: nameController
            ),
            CustomTextField(//widget( reutilizado ) /widgets/custom_textfield.dart
              icon: Icons.email, 
              label: 'Contraseña', 
              isPassword: true, 
              controller: passwordController
            ),
            
            CustomButton(label: 'Registrar', onPressed: () async{ //widget( reutilizado ) /widgets/custom_button.dart
              //Registro del usuario local

              if( !validate.isEmail(emailController.text)){ // es un email valido
                return showDialog(context: context, builder: (context) =>
                  const CustomDialog( //widget( reutilizado ) /widgets/custom_dialog.dart
                    message: 'El correo electrónico no es valido', error: true
                  )
                );
              }

              // si algun campo esta vacio
              if( nameController.text.trim() == '' || passwordController.text.trim() == ''){
                return showDialog(context: context, builder: (context) =>
                  const CustomDialog( //widget( reutilizado ) /widgets/custom_dialog.dart
                    message: 'Por favor llena todos los campos', error: true
                  )
                );
                
              }

              //Paso las validaciones
              final userService = UserService(); // Clase con metodo para registrarse
              //Espera al registro que retorna un booleano
              bool res = await userService.register(emailController.text , passwordController.text, nameController.text);

              // Si es falso es por que el correo ya esta en uso
              if( res == false ){
                showDialog(context: context, builder: (context){
                  return const CustomDialog(message: 'Este correo electronico ya esta en uso', error: true) ;
                });
                
              }else{ // si es verdadero 
                
                Navigator.pushReplacementNamed(context, 'home'); // Navega a la pagina de inicio /screens/home_screen.dart
              }

            }),

            const SizedBox(height: 25,)
          ],
        ),
    );
  }
}