import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DetalleProductoScreen extends StatelessWidget {
  final Map<String, dynamic> productoDetalle;

  const DetalleProductoScreen({required this.productoDetalle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Producto'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(productoDetalle['image_name']),
                  
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              productoDetalle['nombre'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Descripción:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              productoDetalle['descripccion'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              'Precio:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              '\$${productoDetalle['precio']}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final productId = productoDetalle['idProducto'] as int;
                  print('ID del producto a eliminar: $productId');

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.WARNING,
                    headerAnimationLoop: false,
                    animType: AnimType.SCALE,
                    title: '¡Advertencia!',
                    desc: '¿Estás seguro de que deseas eliminar este producto?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      try {
                        await updateTennis(productId: productId);
                        Navigator.pop(context, true);
                      } catch (e) {
                        print('Error al eliminar el producto: $e');
                      }
                    },
                  ).show();
                },
                child: Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, 
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> updateTennis({required int productId}) async {
  try {
    final response = await http.post(
      Uri.parse('https://localhost:7109/tenis/CambiarEstatusProducto/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"idProducto": productId}),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print('Producto actualizado exitosamente');
    } else {
      throw Exception('Fallo al actualizar el producto');
    }
  } catch (e) {
    print('Error al actualizar el producto: $e');
  }
}
