import 'package:app_flutter_chat_scoket/global/environment.dart';
import 'package:app_flutter_chat_scoket/models/usuarios_response.dart';
import 'package:app_flutter_chat_scoket/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_chat_scoket/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Enviaronment.apiUrl}/usuarios?desde=0',
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.gettToken()
          });
      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
