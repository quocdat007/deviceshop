import 'package:deviceshop/ui/products/banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui/cart/cart_manager.dart';
import '../../ui/cart/cart_screen.dart';
import 'top_right_badge.dart';
import '../shared/app_drawer.dart';
import 'products_grid.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showProduct = 'all';
  //var _showOnlyFavorite = false;
  bool colorOne = false;
  bool colorTwo = false;
  bool colorThree = false;
  bool colorFour = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(234, 255, 255, 255),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo.png', height: 40),
            const Text("  DEVICES SHOP",
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
          //buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.pink],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20.0))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.laptop),
                  color: colorOne
                      ? const Color.fromARGB(234, 255, 255, 255)
                      : Colors.black,
                  onPressed: () {
                    setState(() {
                      _showProduct = 'laptop';
                      colorOne = true;
                      colorTwo = false;
                      colorThree = false;
                      colorFour = false;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.phone_android),
                  color: colorTwo
                      ? const Color.fromARGB(234, 255, 255, 255)
                      : Colors.black,
                  onPressed: () {
                    setState(() {
                      _showProduct = 'phone';
                      colorOne = false;
                      colorTwo = true;
                      colorThree = false;
                      colorFour = false;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.tablet_mac),
                  color: colorThree
                      ? const Color.fromARGB(234, 255, 255, 255)
                      : Colors.black,
                  onPressed: () {
                    setState(() {
                      _showProduct = 'tablet';
                      colorOne = false;
                      colorTwo = false;
                      colorThree = true;
                      colorFour = false;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.devices_other),
                  color: colorFour
                      ? const Color.fromARGB(234, 255, 255, 255)
                      : Colors.black,
                  onPressed: () {
                    setState(() {
                      _showProduct = 'all';
                      colorOne = false;
                      colorTwo = false;
                      colorThree = false;
                      colorFour = true;
                    });
                  },
                ),
              ],
            ),
          ),
          //DiscountBanner(),
          Expanded(
            child: ProductsGrid(_showProduct),
            //child: ProductsGrid(_showProduct),
          )
        ],
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(builder: (ctx, cartManager, child) {
      return TopRightBadge(
        data: cartManager.productCount,
        child: IconButton(
          icon: const Icon(
            Icons.local_mall,
          ),
          onPressed: () {
            Navigator.of(ctx).pushNamed(CartScreen.routeName);
          },
        ),
      );
    });
  }

  /*Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorites = true;
          } else {
            _showOnlyFavorites = false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
  */
}
