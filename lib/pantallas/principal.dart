import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen/modelos/segunda.dart';
import 'package:examen/modelos/principal.dart';

class MyCatalogo extends StatelessWidget {
  const MyCatalogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //se registra el cambio y se carga en la lista del carrito
    var carrito = context.select<CartModel, bool>(
      //se agregaran los item selecionados a nuestro carrito
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: carrito
          ? null
          : () {
              var carri = context.read<CartModel>();
              carri.add(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null;
        }),
      ),
      child: carrito
          ? const Icon(Icons.check, semanticLabel: 'AGREGADO')
          //texto que da opcion para agregar un articulo
          : const Text('AGREGAR'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //texto superior que aparece como titulo
      title: Text('Mercancia disponible',
          style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
          //asignamos el icono del carrito
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/segunda'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      //se obtiene el index de nuestro items selecionado
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
