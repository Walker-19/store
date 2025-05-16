import 'package:flutter/material.dart';
import 'package:store/models/product.dart';
import 'package:store/models/cart.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List<Product> cartItems = [];
  final Cart cart = Cart();

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final items = await cart.load() ?? [];
    setState(() {
      cartItems = items;
    });
  }

  Future<void> _removeFromCart(Product product) async {
    await cart.remove(product);
    await _loadCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produit retiré du panier'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon panier'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Votre panier est vide'),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final product = cartItems[index];

                return ListTile(
                  leading: product.images != null && product.images!.isNotEmpty
                      ? Image.network(
                          product.images![0],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        )
                      : const Icon(Icons.image_not_supported),
                  title: Text(product.title ?? ''),
                  subtitle: Text('${product.price} €'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeFromCart(product),
                  ),
                );
              },
            ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

