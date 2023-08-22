import 'package:proyecto_final/provider/login_provider.dart';
import 'package:proyecto_final/provider/productos_provider.dart';
import 'package:proyecto_final/provider/provider.dart';
import 'package:proyecto_final/routes/app_routes.dart';
import 'package:proyecto_final/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/util/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginFormProvider()),
        ChangeNotifierProvider(create: (context) => TennisProvider())
      ],
      child: MaterialApp(
        title: 'MexaTech',
        theme: AppTheme.lightThemeData,
        initialRoute: AppRoutes.initialRouters,
        routes: AppRoutes.routes,
         scaffoldMessengerKey: NotificationsService.messengerKey,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
