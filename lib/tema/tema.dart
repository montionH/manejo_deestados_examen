import 'package:flutter/material.dart';

//widget para asignar un tema a la pantalla principal
final temapantallaprincipal = ThemeData(
  //color de la pantalla superior al igual que el de las letras de agregar
  primarySwatch: Colors.cyan,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'Corben',
      //tamaño de fuente de letra
      fontSize: 24,
      //color de la letra
      color: Colors.brown,
    ),
  ),
);
