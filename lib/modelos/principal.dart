import 'package:flutter/material.dart';

class CatalogModel {
  //lista de items que se mostraran en la pantalla principal
  static List<String> itemNames = [
    'playera',
    'camisa',
    'camiseta',
    'corbata',
    'moño',
    'cadena',
    'pantalón',
    'short',
    'jeans',
    'pantalonera',
    'calcetines',
    'calcetas',
    'zapatos',
    'tennis',
    'sandalias',
  ];

  ///se obtiene el item por su [id].
  ///
  /// se genera una lista infinita donde se repiten los articulos [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
      //asigna un color para diferenciar cada item
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
