import 'package:app_flutter_chat_scoket/helpers/mostrar_alerta.dart';
import 'package:app_flutter_chat_scoket/services/auth_service.dart';
import 'package:app_flutter_chat_scoket/widget/boton_azul.dart';
import 'package:app_flutter_chat_scoket/widget/custom_input.dart';
import 'package:app_flutter_chat_scoket/widget/label.dart';
import 'package:app_flutter_chat_scoket/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
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
                  Logo(
                    titulo: 'Messenger',
                  ),
                  _Form(),
                  Label(
                    subtitle: 'Crea una ahora!',
                    title: '¿No tienes cuenta?',
                    ruta: 'register',
                  ),
                  Text(
                    'Terminos y condiciones de uso.',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Contraseña',
            isPassword: true,
            // keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
          ),
          BotonAzul(
            title: 'Ingrese',
            onPress: authService.authenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      // Conectar a nuestro socket server
                      Navigator.pushReplacementNamed(context, 'usuarios');
                      // navegar a otra pantalla
                    } else {
                      mostrarAlerta(context, 'Login incorrecto',
                          'revice sus credenciales ');
                      // mostra alerta

                    }
                  },
          ),
        ],
      ),
    );
  }
}
