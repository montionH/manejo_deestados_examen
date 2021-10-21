import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen/tema/tema.dart';
import 'package:examen/modelos/segunda.dart';
import 'package:examen/modelos/principal.dart';
import 'package:examen/pantallas/segunda.dart';
import 'package:examen/pantallas/principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalogo, carri) {
            if (carri == null) throw ArgumentError.notNull('cart');
            carri.catalog = catalogo;
            return carri;
          },
        ),
      ],
      child: MaterialApp(
        //titulo de nuestra app
        title: 'examen moviles II',
        //llama a la clase de tema para asignar los valores agregados en esa misma
        theme: temapantallaprincipal,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyCatalogo(),
          '/segunda': (context) => const Micompra(),
        },
      ),
    );
  }
}
