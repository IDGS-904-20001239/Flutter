import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_final/model/tennis_model.dart';
import 'package:proyecto_final/provider/util_provider.dart';
import 'package:http/http.dart' as http;

class DetalleProvider extends ChangeNotifier {
  
Future<dynamic> getProductById({required int productId}) async {
  try {
    print('Helloo');    
    final response = await http.post(
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

final String _baseUrl = 'https://localhost:7109/tenis'; // Cambiar por tu URL base

  Future<int> deleteProduct(int productId) async {
    final url = Uri.parse('$_baseUrl/CambiarEstatusProducto/$productId');

    final headers = {
      'Content-Type': 'application/json',
    };

    final resp = await http.delete(url, headers: headers);

    if (resp.statusCode == 200) {
      // Producto eliminado exitosamente
      return productId;
    } else {
      throw Exception('Error al eliminar el producto');
    }
  }
}