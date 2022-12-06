import 'package:flutter/material.dart';
import './cart_manager.dart';
import '../../models/cart_item.dart';
import '../shared/dialog_utils.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CartItemCard({
    required this.productId,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Do you want to remove the item from the cart?',
        );
      },
      onDismissed: (direction) {
        // ignore: avoid_print
        context.read<CartManager>().removeItem(productId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), //or 15.0
            child: Image.network(
              cartItem.imageUrl,
              fit: BoxFit.contain,
              height: 60.0,
              width: 60.0,
            ),
            // child: Padding(
            //   padding: const EdgeInsets.all(5),
            //   child: FittedBox(
            //     child: //Text('\$${cartItem.price}'),
            //         Image.network(
            //       cartItem.imageUrl,
            //       //fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ),
          title: Text(cartItem.title),
          subtitle: Text('Total: \$${(cartItem.price * cartItem.quantity)}'),
          trailing: Text('${cartItem.quantity} x'),
        ),
      ),
    );
  }
}
