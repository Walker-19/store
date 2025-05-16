import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/category.dart';
import 'package:store/models/favoris.dart';
import 'package:store/models/product.dart';
import 'package:store/providers/category_provider.dart';
import 'package:store/services/category_api_service.dart';
import 'package:store/widgets/Product/card_product_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Product>> _favorisList;

 @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

void _loadFavoris() {
    _favorisList = Favoris().load();
  }

    Future<void> _refresh() async {
    setState(() {
      _loadFavoris();
    });
  }



  @override
  Widget build(BuildContext context) {
    // récupérer la catégorie stockée dans le provider
    Category category = context.watch<CategoryProvider>().category!;
    // inspect(context.watch<CategoryProvider>().category);




    return Container(
      //   color: Colors.amber,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            category.name!,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          // affichage des produits
          FutureBuilder(
            future: CategoryApiService().getProductsByCategoryId(category.id!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> data = snapshot.requireData;
                // inspect(data);

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                 
                    
                    return CardProductWidget(product: data[index]);
                  },
                );
              }

              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}


