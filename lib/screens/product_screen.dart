import 'package:flutter/material.dart';
import 'package:store/models/product.dart';
import 'package:store/services/product_api_service.dart';
import 'package:store/widgets/shared/payment_button_widget.dart';
import 'package:store/models/cart.dart'; // Import du panier

class ProductScreen extends StatefulWidget {
  final int productId;

  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails du produit")),
      body: FutureBuilder<Product>(
        future: ProductApiService().getProductById(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text(
                "Erreur lors du chargement",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          final product = snapshot.data!;
          final images = product.images ?? [];

          selectedImageUrl ??= images.isNotEmpty ? images[0] : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedImageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      selectedImageUrl!,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 350,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),

                if (images.length > 1)
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final imgUrl = images[index];
                        final isSelected = imgUrl == selectedImageUrl;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageUrl = imgUrl;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: Image.network(
                                imgUrl,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 100,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 20),

                Text(
                  product.title ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),

                Text(
                  '${product.price} €',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Description',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description ?? '',
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Product>(
          future: ProductApiService().getProductById(widget.productId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();

            final product = snapshot.data!;

            return PaymentButtonWidget(
              text: "Ajouter au panier",
              onPressed: () async {
                final cart = Cart();
                final currentCart = await cart.load() ?? [];

                if (cart.containsInList(currentCart, product)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Produit déjà dans le panier"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                } else {
                  await cart.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Produit ajouté au panier"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
