import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:store/models/category.dart';
import 'package:store/models/product.dart';

class CategoryApiService {
  // récupérer toutes les catégories
  // Future : équivalent des promesses JS
  Future<List<Category>> getCategories() async {
    // url de l'API
    Uri url = Uri.parse('https://api.escuelajs.co/api/v1/categories');

    // requête/réponse HTTP
    http.Response response = await http.get(url);

    // tester le statut 200
    if (response.statusCode == 200) {
      // décoder les données en JSON
      List data = jsonDecode(response.body);

      // renvoyer les données formatées avec les modèles
      return data.map((category) {
        return Category(
          id: category['id'],
          name: category['name'],
          slug: category['slug'],
          image: category['image'],
        );
      }).toList();
    }

    // renvoyer une erreur
    throw Error();
  }

  // récupérer les produits d'une catégorie
  Future<List<Product>> getProductsByCategoryId(int categoryId) async {
    Uri url = Uri.parse(
      'https://api.escuelajs.co/api/v1/categories/$categoryId/products',
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      // inspect(data);

      return data.map((product) {
        return Product(
          id: product['id'],
          title: product['title'],
          slug: product['slug'],
          price: product['price'],
          description: product['description'],
          category: Category(
            id: product['category']['id'],
            name: product['category']['name'],
            slug: product['category']['slug'],
            image: product['category']['image'],
          ),
          images: product['images'],
        );
      }).toList();
    }

    throw Error();
  }
}
