import 'dart:developer';

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


bool productIncart(Product product) {
  bool isOncart = Cart().containsInList(cartItems, product);
  return isOncart;
}

num getTotalProduct(Product product) {
  num nbrProduct = 0;
  cartItems.contains(product);
  for (var prod in cartItems) {
       if(prod.id == product.id) {
        nbrProduct++;
       }
  }
  return nbrProduct;
}

num getTotalPrice() {
  num price = 0;
  for (var element in cartItems) {
    price += element.price!;
  }
  return price;
}

// Regrouper les produits par ID
  Map<int, _GroupedProduct> _groupCartItems() {
    final Map<int, _GroupedProduct> grouped = {};
    // _loadCart();
    for (var product in cartItems) {
      if (grouped.containsKey(product.id)) {
        grouped[product.id]!.quantity++;
      } else {
        grouped[product.id!] = _GroupedProduct(product: product, quantity: 1);
      }
    }
    return grouped;
  }

 Future<void> _refresh() async {
     await  _loadCart();
    
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
   if (cartItems.isEmpty){
      return  const Center(child: Text('Votre panier est vide')); }
       else { 
        final groupeProduct = _groupCartItems();
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 20,
            children: [
              Text("Votre panier", style: TextTheme.of(context).headlineMedium, textAlign: TextAlign.center,
              
              ),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groupeProduct.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final entry = groupeProduct.values.elementAt(index);
                  final product = entry.product;

                  
                    return ListTile(
                      leading: _buildImage(product),
                      title: Text(product.title ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${product.price} €'),
                          Row(
                            spacing: 10,
                            children: [
                              IconButton( onPressed: () async{
                                if(entry.quantity > 1) {
                               await cart.removeOneProduct(product);
                                await _refresh(); 

                                }
                              }, icon:Icon(Icons.remove)),
                              Text('${getTotalProduct(product)}x'),
                              IconButton( onPressed: () async{
                               await cart.add(product);
                               await _refresh();
                              }, icon:Icon(Icons.add))
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeFromCart(product),
                      ),
                    );


                  // return ListTile(
                  //   leading: _buildImage(product),
                  //   title: Text(product.title ?? ''),
                  //   subtitle: Text('${product.price} €'),
                  //   trailing: IconButton(
                  //     icon: const Icon(Icons.delete, color: Colors.red),
                  //     onPressed: () => _removeFromCart(product),
                  //   ),
                  // );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total:", style: TextStyle(fontSize: 20)),
                  Text(
                    "${getTotalPrice().toStringAsFixed(2)} €",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent,
                ),
                child: const Center(
                  child: Text(
                    "Payer",
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      }
}

Widget _buildImage(Product product) {
  return product.images != null && product.images!.isNotEmpty
      ? Image.network(
          product.images![0],
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
        )
      : const Icon(Icons.image_not_supported);
}

}





class _GroupedProduct {
  final Product product;
  int quantity;
    _GroupedProduct({required this.product, required this.quantity});

}