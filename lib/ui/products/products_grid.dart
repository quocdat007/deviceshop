import 'package:flutter/material.dart';
import 'product_grid_tile.dart';
import 'products_manager.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final String showItems;
  const ProductsGrid(this.showItems, {super.key});

  // final bool showFavorites;
  // const ProductsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // final products = context.select<ProductsManager, List<Product>>(
    //     (productsManager) => showFavorites
    //         ? productsManager.favoriteItems
    //         : productsManager.items);
    if (showItems == 'favorite') {
      final products = context.select<ProductsManager, List<Product>>(
          (productsManager) => productsManager.favorite);
      return GridView.builder(
        padding: const EdgeInsets.only(right: 10),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductGridTile(products[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
      );
    } else {
      final products = context.select<ProductsManager, List<Product>>(
          (productsManager) => showItems == 'all'
              ? productsManager.items
              : productsManager.typeP(showItems));
      return GridView.builder(
        padding: const EdgeInsets.only(right: 10),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductGridTile(products[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
      );
    }
  }
}
