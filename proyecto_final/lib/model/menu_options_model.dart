import 'package:flutter/material.dart';
//Define una nueva clase
class MenuOption {
  //Declara una variable final
  final String router;
  //Declara una variable final
  final IconData icon;
  //declara una variable final
  final String name;

  //Define un constructor 
  MenuOption({
    //Asigna el valor del parámetro
    required this.router,
    //Asigna el valor del parámetro icon
    required this.icon,
    //Asigna el valor del parámetro name
    required this.name,
  });
}
