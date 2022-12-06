import 'package:deviceshop/ui/products/products_grid.dart';
import 'package:deviceshop/ui/shared/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import 'products_manager.dart';

enum Menu {
  delFavorite,
  itemTwo,
}

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({super.key});
  static const routeName = '/product-favorite';
  @override
  State<FavoriteProduct> createState() => _FavoriteProduct();
}

class _FavoriteProduct extends State<FavoriteProduct> {
  final _showProduct = 'favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(234, 255, 255, 255),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your Favorites",
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
        actions: <Widget>[
          buildProductFilterMenu(),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(_showProduct),
      //child: ProductsGrid(_showProduct),
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (Menu selectedValue) {
        setState(() {
          if (selectedValue == Menu.delFavorite) {
            final productsManager = context.read<ProductsManager>();
            productsManager.clearFavorite();
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: Menu.delFavorite,
          child: Text('Remove all Favorites'),
        ),
      ],
    );
  }
}
