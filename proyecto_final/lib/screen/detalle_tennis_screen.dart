import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/provider/detalle_provider.dart';

class DetalleProductoScreen extends StatefulWidget {
  final dynamic productDetails;

  const DetalleProductoScreen({Key? key, required this.productDetails}) : super(key: key);

  @override
  State<DetalleProductoScreen> createState() => _DetalleProductoState();
}

class _DetalleProductoState extends State<DetalleProductoScreen> {
  @override
  void initState() {
    super.initState();
    final productId = widget.productDetails['idProducto'];
    Provider.of<DetalleProvider>(context, listen: false).getProductById(productId: productId);
  }

  @override
  Widget build(BuildContext context) {
    final pProvider = Provider.of<DetalleProvider>(context);
    // Aquí puedes usar pProvider para acceder a los datos obtenidos del detalle del producto
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productDetails['producto']['nombre']), // Cambiar color de fondo de la AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.productDetails['producto']['image_name'], // Ajustar según la estructura de datos
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              'Nombre: ${widget.productDetails['producto']['nombre']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.productDetails['producto']['precio']} MXN',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.productDetails['producto']['descripccion']}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
