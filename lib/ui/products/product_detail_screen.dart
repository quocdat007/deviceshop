import 'package:deviceshop/ui/cart/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Product Detail",
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
          actions: [
            IconButton(
              onPressed: () {
                final cart = context.read<CartManager>();
                cart.addItem(product);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: const Text(
                      "Item added to cart",
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removeSingleItem(product.id!);
                      },
                    ),
                  ));
              },
              icon: const Icon(Icons.add_shopping_cart_outlined),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 238,
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
              child: ValueListenableBuilder<bool>(
                valueListenable: product.isFavoriteListenable,
                builder: (ctx, isFavorite, child) {
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      product.isFavorite = !isFavorite;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
