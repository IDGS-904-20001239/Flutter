import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class UtilProvider extends ChangeNotifier {
  static final UtilProvider rtp = UtilProvider._();
  final storage = const FlutterSecureStorage();
  UtilProvider._();

  static Future responseHTTPpost({required String urlBase}) async {
    var response = await http.post(Uri.parse(urlBase));
    return response;
  }
  static Future responseHTTPGet({required String urlBase}) async {
    var response = await http.get(Uri.parse(urlBase));
    return response;
  }

  Future postHttp({required String urlBase, required dynamic data}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var jsonData = jsonEncode(data);
    var response = await http.post(
      Uri.parse(urlBase),
      headers: headers,
      body: jsonData,
    );

    return response;
  }

  Future checkSession() async {
    Map<String, String> allValues = await storage.readAll();
    if (allValues['inSesion'] == '1') {
      return 1;
    }
    return 0;
  }
  

  Future saveStorage({
    required String usuario,
    required String password,
  }) async {
    await storage.write(key: 'Usuario', value: usuario);
    await storage.write(key: 'psw', value: password);
    await storage.write(key: 'inSesion', value: '1');
    return 1;
  }

  Future responseHttp({required String urlBase}) async {
    var response = await http.get(Uri.parse(urlBase));
    return response;
  }

  Future clearSession() async {
    await storage.deleteAll();
  }

   Future<dynamic> getProductById({required int productId}) async {
  try {
    print('Helloo');
    var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhZG1pbkBleGFtcGxlLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwiZXhwIjoxNjkyMTYyNzE4LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MDg4LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjcwODgvIn0.p_ElqemzzpOL5H569XW1fzNPWSrQnC4f6F5Y3S2wcs8';
    final response = await http.get(
      Uri.parse('https://localhost:7088/api/Product/$productId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Si la llamada al servidor fue exitosa, analiza el JSON
      return jsonDecode(response.body);
    } else {
      // Si la llamada no fue exitosa, lanza un error.
      throw Exception('Fallo en la carga');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> deleteProduct({required String productId}) async {
  try {
    var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhZG1pbkBleGFtcGxlLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwiZXhwIjoxNjkyMTYyNzE4LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MDg4LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjcwODgvIn0.p_ElqemzzpOL5H569XW1fzNPWSrQnC4f6F5Y3S2wcs8';
    final response = await http.delete(
    Uri.parse('https://localhost:7088/api/Product/$productId'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    // Producto eliminado exitosamente
    print('Producto eliminado exitosamente');
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Fallo al eliminar el producto');
  }
} catch (e) {
  print(e);
}

}

}
