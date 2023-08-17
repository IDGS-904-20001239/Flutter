import 'package:flutter/material.dart';
import 'package:proyecto_final/model/menu_options_model.dart';
import 'package:proyecto_final/screen/detalle_tennis_screen.dart';
import '../screen/screen.dart';

class AppRoutes {
 static Map<String, Widget Function(BuildContext context)> routes = {
    //Esta línea define la ruta principal ("/") en el mapa de rutas.
    //Se crea una instancia de la clase y se devuelve
        '/Home':(BuildContext context) => const HomeScreen(),
        //Esta línea define la ruta "/ListView" en el mapa de rutas.
        //Se crea una instancia de la clase y se devuelve
        '/Tennis':(BuildContext context) => const TennisScreen(),
        //Esta línea define la ruta "/Jugador" en el mapa de rutas.
        //Se crea una instancia de la clase y se devuelve
        '/Login':(BuildContext context) => const LoginScreen(),
        //Esta línea define la ruta "/Equipos" en el mapa de rutas.
        //Se crea una instancia de la clase y se devuelve
      };
      static List<Map<String, dynamic>> menu = [
    
    {
      'router':'/Home',
      'name': 'Home',
      'icon': const Icon(Icons.home)
    },
    //Representa un elemento de menú con la ruta '/ListView', el nombre
    {
      'router':'/Tennis',
      'name': 'Productos',
      'icon': Icon(Icons.account_balance)
    }
    
  ];
      static String initialRouters='/Login';
    static final menuOptions = <MenuOption>[
    MenuOption(router: '/Home', icon: Icons.home, name: 'Home'),
    MenuOption(router: '/Tennis', icon: Icons.sports, name: 'Productos'),

    
  ];
  
    static onGenarteRouter(settings) {
    //devuelve una nueva instancia de MaterialPageRoute
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  }

