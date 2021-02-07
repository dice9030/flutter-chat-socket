import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app_flutter_chat_scoket/global/environment.dart';
import 'package:app_flutter_chat_scoket/models/login_response.dart';
import 'package:app_flutter_chat_scoket/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _authenticando = false;

  final _storage = new FlutterSecureStorage();

  bool get authenticando => this._authenticando;
  set authenticando(bool valor) {
    this._authenticando = valor;
    notifyListeners();
  }

  //Getters del token de forma static

  static Future<String> gettToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.authenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post('${Enviaronment.apiUrl}/login',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    // print(resp.body);
    this.authenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      //  loginResponse.usuario
      this.usuario = loginResponse.usuario;
      //guardar token en lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    final data = {'nombre': name, 'email': email, 'password': password};

    final resp = await http.post('${Enviaronment.apiUrl}/login/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.authenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http.get('${Enviaronment.apiUrl}/login/renew',
        headers: {'Content-Type': 'application/json', 'x-token': token});

    print(resp.body);
    this.authenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
