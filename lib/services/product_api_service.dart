import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store/models/category.dart';
import 'package:store/models/product.dart';

class ProductApiService {
  Future<Product> getProductById(int id) async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/products/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Product(
        id: data['id'],
        title: data['title'],
        slug: data['slug'],
        price: data['price'],
        description: data['description'],
        category: Category(
          id: data['category']['id'],
          name: data['category']['name'],
          slug: data['category']['slug'],
          image: data['category']['image'],
        ),
        images: List<String>.from(data['images']),
      );
    } else {
      throw Exception('Erreur lors du chargement du produit');
    }
  }
}
