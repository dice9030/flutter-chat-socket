import 'package:app_flutter_chat_scoket/global/environment.dart';
import 'package:app_flutter_chat_scoket/models/mensajes_response.dart';
import 'package:app_flutter_chat_scoket/models/usuario.dart';
import 'package:app_flutter_chat_scoket/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get('${Enviaronment.apiUrl}/mensajes/$usuarioID',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.gettToken()
        });

    final mensajesResponse = mensajesResponseFromJson(resp.body);

    return mensajesResponse.mensajes;
  }
}
