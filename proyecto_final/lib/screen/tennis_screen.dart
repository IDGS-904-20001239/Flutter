import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/screen/screen.dart';
import '../provider/provider.dart';
import '../theme/app_theme.dart';
import 'package:proyecto_final/widgets/widget.dart';

import 'detalle_tennis_screen.dart';

class TennisScreen extends StatefulWidget {
  const TennisScreen({Key? key}) : super(key: key);

  @override
  State<TennisScreen> createState() => _TennisScreenState();
}

class _TennisScreenState extends State<TennisScreen> {
  @override
  void initState() {
    Provider.of<TennisProvider>(context, listen: false).getTennis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tProvider = Provider.of<TennisProvider>(context);
    List<dynamic> tennisList = tProvider.tennisList;

    void showWarningDialog(BuildContext context) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: false,
        animType: AnimType.SCALE,
        title: '¡Advertencia!',
        desc: '¿Estás seguro de que deseas salir de la aplicación?',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await UtilProvider.rtp.clearSession();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
      ).show();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              showWarningDialog(context);
            },
            icon: Icon(
              Icons.logout_sharp,
              color: Colors.white,
            ),
          ),
        ],
        title: Text('Productos'),
        backgroundColor: AppTheme.secondaryColor,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tennisList.length,
              itemBuilder: (context, index) {
                var product = tennisList[index];
                var imageAssets = [
                  'assets/producto03.jpeg',
                  'assets/producto02.jpeg',
                  'assets/producto04.jpeg',
                  'assets/producto01.jpeg',
                ];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              imageAssets[index % imageAssets.length],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            product['nombre'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estatus: ${product['estatus']}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // Navegar a la pantalla de detalles
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalleProductoScreen(
                                      productoDetalle: product,
                                   
                                    )),
                                );
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.orange,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> getTennisDetalle({required int productId}) async {
  try {
    final response = await http.post(
      Uri.parse('https://localhost:7109/tenis/MostrarDetalleProductoPorId/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"idProducto": productId, "nuevoCampo": "nuevoValor"}),
    );
    
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print('Detalles del producto');
      // Aquí podrías notificar al proveedor para actualizar la lista de productos
    } else {
      throw Exception('Fallo al actualizar el producto');
    }
  } catch (e) {
    print('Error al actualizar el producto: $e');
  }
}