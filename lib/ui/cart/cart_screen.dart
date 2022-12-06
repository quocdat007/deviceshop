import 'package:flutter/material.dart';
import 'package:deviceshop/ui/orders/orders_manager.dart';
import '../shared/dialog_utils.dart';
import 'cart_manager.dart';
import 'cart_item_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your Cart                  ",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.pink],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          )),
        ),
      ),
      // body: Column(
      //   children: <Widget>[
      //     buildCartSummary(cart, context),
      //     const SizedBox(height: 10),
      //     Expanded(
      //       child: buildCartDetails(cart),
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: buildCartDetails(cart)),
            Container(
                color: Colors.white, child: buildCartSummary(cart, context)),
          ],
        ),
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cartItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      // elevation: 15,
      margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 5, left: 20),
                          child: Text(
                            'Total:',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Text(
                          '\$${cart.totalAmount.toStringAsFixed(3)}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                TextButton(
                  onPressed: cart.totalAmount <= 0
                      ? null
                      : () {
                          context
                              .read<OrdersManager>()
                              .addOrder(cart.products, cart.totalAmount);
                          showAlertDialog(context, 'Order Sucess!');
                          cart.clear();
                        },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 110.0, vertical: 10.0),
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
