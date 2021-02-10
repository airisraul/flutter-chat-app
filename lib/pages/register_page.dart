import 'package:chatapp/helpers/mostrar_alerta.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/widgets/boton_azul.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Logo(titulo: 'Registro'),

                    _Form(),

                    Labels(ruta: 'login', texto1: '¿Ya tienes una cuenta?',texto2: 'Ingresa ahora!'),

                    Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200)),
          
                  ]
                ),
              ),
            ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    
    return Container(
       margin: EdgeInsets.only(top: 40),
       padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column(
         children: [
           
           CustomInput(
             icon: Icons.perm_identity,
             placeholder: 'Nombre',
             keyboardType: TextInputType.text,
             textController: nameCtrl,
           ),
           CustomInput(
             icon: Icons.mail_outline,
             placeholder: 'Correo',
             keyboardType: TextInputType.emailAddress,
             textController: emailCtrl,
           ),
           CustomInput(
             icon: Icons.lock_outline,
             placeholder: 'Contraseña',
             textController: passCtrl,
             isPassword: true,
           ),
          
           BotonAzul(
             texto: 'Crear cuenta',
             onPressed: authService.autenticando ? null : () async {              
               
               // quitar el teclado
               FocusScope.of(context).unfocus();
               final registerOK = await authService.register(nameCtrl.text, emailCtrl.text, passCtrl.text);

               if ( registerOK == true ) {
                 //Navegar a otra pantalla
                 socketService.connect();
                 Navigator.pushReplacementNamed(context, 'login');
               }else{
                 // Mostrar alerta
                mostrarAlerta(context, 'Registro incorrecto', registerOK);

               }
               
             },
           )

         ],
       ),
    );
  }
}