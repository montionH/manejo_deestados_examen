import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen/modelos/segunda.dart';

class Micompra extends StatelessWidget {
  const Micompra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //titulo superior de la pantalla
          title: Text('Ticket de compra',
              style: Theme.of(context).textTheme.headline1),
          //se agrega el color del fondo de nuestro titulo
          backgroundColor: Colors.grey),
      body: Container(
        color: Colors.blue, //se agina el color del fondo de esta pantalla
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    var carri = context.watch<CartModel>();

    return ListView.builder(
      itemCount: carri.items.length,
      itemBuilder: (context, index) => ListTile(
        //icono para demostrar que esta agregado
        leading: const Icon(Icons.done),
        trailing: IconButton(
          //icono para dar opcion de eliminar del ticket
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            carri.remove(carri.items[index]);
          },
        ),
        title: Text(
          carri.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          //alinea nuestro total al centro
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: hugeStyle)),
            const SizedBox(width: 24),
            //genera boton para realizar compra.
            TextButton(
              onPressed: () {
                //aparece un mensaje emergente que da un mensaje de compra hecha
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Su compra se a efectuado!!')));
              },
              //asignamos el color del texto inferior
              style: TextButton.styleFrom(primary: Colors.yellow),
              //para generar la compra
              child: const Text('Finalizar la compra'),
            ),
          ],
        ),
      ),
    );
  }
}
