
/*
  Clase que tiene metodos para validar cadenas
  Valida correo
  Valida un numero
 */
class Validator{


  bool isEmail(String email){
    // Expresion regular de un correo electronico valido
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp  = RegExp(pattern); // Clase de expresiones regulares

    if( regExp.hasMatch(email)){ //Si esta bien contruido
      return true;
    }
    return false; //sino
  }

  bool isNumber(String value){
    //Expresion regular de un numero con decimales valido
    String pattern = r'^[$]+[0-9]+([.][0-9]+)?$';
    RegExp regExp  = RegExp(pattern);// Clase de expresiones regulares

    if( regExp.hasMatch(value)){ //Si esta bien construido
      return true;
    }

    return false;//Sino
  }
  
}

