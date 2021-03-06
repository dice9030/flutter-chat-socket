import 'package:app_flutter_chat_scoket/page/login_paget.dart';
import 'package:app_flutter_chat_scoket/page/usuarios_page.dart';
import 'package:app_flutter_chat_scoket/services/auth_service.dart';
import 'package:app_flutter_chat_scoket/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: checkLoginState(context),
      builder: (context, snapshot) {
        return Center(
          child: Text('Esperar....'),
        );
      },
    ));
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      print(111);
      //socket server
      // Navigator.pushReplacementNamed(context, 'usuarios');
      socketService.connect();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuarioPage(),
            transitionDuration: Duration(milliseconds: 0)),
      );
    } else {
      print(2222);
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
