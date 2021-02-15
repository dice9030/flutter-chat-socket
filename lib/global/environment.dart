import 'dart:io';

class Enviaronment {
  static String apiUrl = Platform.isAndroid
      ? 'http://172.17.92.177:3000/api'
      : 'http://localhost:3000/api';
  static String socketUrl = Platform.isAndroid
      ? 'http://172.17.92.177:3000'
      : 'http://localhost:3000';
}
