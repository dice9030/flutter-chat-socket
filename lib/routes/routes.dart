import 'package:app_flutter_chat_scoket/page/chat_page.dart';
import 'package:app_flutter_chat_scoket/page/loading_page.dart';
import 'package:app_flutter_chat_scoket/page/login_paget.dart';
import 'package:app_flutter_chat_scoket/page/register_page.dart';
import 'package:app_flutter_chat_scoket/page/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuarioPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
