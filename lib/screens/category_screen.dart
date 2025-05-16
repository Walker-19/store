import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/category.dart';
import 'package:store/models/favoris.dart';
import 'package:store/models/product.dart';
import 'package:store/providers/category_provider.dart';
import 'package:store/services/category_api_service.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
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
                    return ListTile(
                      leading: Image.network(data[index].images![0]),
                      title: Text(data[index].title!),
                      subtitle: Text('${data[index].price!}€'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 10),
                      onTap: () async {
                         Favoris favoris = Favoris();

                         await favoris.add(data[index]);

                        //  inspect(favoris.load());
                      },
                    );
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
