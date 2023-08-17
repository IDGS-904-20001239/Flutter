import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_final/model/tennis_model.dart';
import 'package:proyecto_final/provider/util_provider.dart';
import 'package:http/http.dart' as http;

class TennisProvider extends ChangeNotifier {
  final String _urlBase = 'https://localhost:7109/tenis/';

  TennisProvider() {
    getTennis();
  }

  List<dynamic> tennisList = [];

   Future getTennis() async{
    try {
      final String url = '${_urlBase}MostrarProductosActivos';
      final response = await UtilProvider.rtp.postHttp(urlBase: url, data: tennisList);
      if(response.statusCode==200){
        var jResponse = jsonDecode(response.body);
        tennisList = jResponse as List<dynamic>;
        notifyListeners();
      }else if(response.statusCode==408){
        print('No hay datos');
      }
    } catch (e) {
      print(e.toString());
    }
  }


Future<dynamic> getProductById({required int productId}) async {
  try {
    print('Helloo');final response = await http.get(
      Uri.parse('https://localhost:7109/tenis/MostrarDetalleProductoPorId/$productId'),
      headers: {
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
    final response = await http.delete(
    Uri.parse('https://localhost:7109/tenis/CambiarEstatusProducto/$productId'),
    headers: {
      
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

  Future postTennis(Tennis tennis) async {
    final String url = '${_urlBase}MostrarProductosActivos';
    
   final response = await UtilProvider.rtp.postHttp(urlBase:url, data: tennis);
   print(response.statusCode);
   if(response.statusCode == 200){
      getTennis();
      notifyListeners();
      return true;
   }
   return false;
  }
}
