import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';
import '../provider/util_provider.dart';
import '../theme/app_theme.dart';
import '../util/util.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flp = Provider.of<LoginFormProvider>(context);
    
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Form(
        key: LoginFormProvider.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 90.0,
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/Logo.png'),
                ),
                Divider(
                  height: 18.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Correo electrónico',
                    labelText: 'Ingresa tu correo electrónico',
                    labelStyle: TextStyle(color: Colors.orange),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.orange,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  onChanged: (value) {
                    flp.email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu correo electrónico';
                    }
                    if (!isValidEmail(value)) {
                       return 'Ingresa un correo electrónico válido';
              }
                 
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    labelText: 'Ingresa tu contraseña',
                    labelStyle: TextStyle(color: Colors.orange),
                    suffixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.orange,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  onChanged: (value) {
                    flp.password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }
                 
                    return null;
                  },
                ),
                Divider(
                  height: 15.0,
                ),
                ElevatedButton(
  onPressed: () async {
    FocusScope.of(context).unfocus();
    print(flp.password);

    if (!flp.isValidForm()) return;

    flp.isLoading = true;
    await Future.delayed(Duration(seconds: 2));

    if (flp.email != null && flp.password != null) {
      UtilProvider.rtp.saveStorage(
          usuario: flp.email, password: flp.password);
      final rest = await UtilProvider.rtp.saveStorage(
          usuario: flp.email, password: flp.password);
      if ( rest ==1) {
                await login(email: flp.email, password: flp.password);

        Dialogos.msgDialog(
          context: context,
          texto: 'Bienvenido',
          dgt: DialogType.success,
          onPress: () {
            NotificationsService.showSnackBar(message: 'Bienvenido');
            Navigator.pushNamed(context, '/Home');
          },
        ).show();
      }
    }
    flp.isLoading = false;
  },
  child: Text(flp.isLoading ? 'Cargando...' : 'Ingresar'),
),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}

Future<void> login({required String email, required String password}) async {
  try {
    final response = await http.post(
      Uri.parse('https://localhost:7109/tenis/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    print('Código de estado de respuesta: ${response.statusCode}');
    print('Cuerpo de la respuesta: ${response.body}');

    if (response.statusCode == 200) {
      print('Inicio de sesión exitoso');
      // Aquí podrías realizar acciones adicionales después del inicio de sesión exitoso
    } else if (response.statusCode == 401) {
      // Usuario no encontrado o credenciales inválidas
      throw Exception('Usuario no encontrado');
    } else {
      throw Exception('Fallo al iniciar sesión');
    }
  } catch (e) {
    print('Error al iniciar sesión: $e');
    throw Exception('Error al iniciar sesión: $e');
  }
}
