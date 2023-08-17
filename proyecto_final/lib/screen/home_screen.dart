import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screen/screen.dart';
import 'package:proyecto_final/theme/app_theme.dart';
import 'package:proyecto_final/widgets/drawer_widget.dart';
import 'package:proyecto_final/routes/app_routes.dart';

import '../provider/util_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      )..show();
    }
  return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
               showWarningDialog(context);
            },
            icon: Icon(Icons.logout_sharp),
          ),
        ],
        title: Text('Bienvenido'),
        backgroundColor: AppTheme.secondaryColor,
      ),
      drawer: const DrawerWidget(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/borboleta2.jpg'),
          ),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: const DrawerWidget(),
        appBar: AppBar(
          actions: [IconButton(
            onPressed: ()async {
                    Navigator.pushNamed(context, '/Login');
                },
            icon: Icon(Icons.logout_sharp))],
          title: Text('Bienvienido'),
          backgroundColor: AppTheme.secondaryColor,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/borboleta2.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
