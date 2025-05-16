import 'package:store/models/category.dart';

class Product {
  int? id;
  num? price;
  String? title, slug, description;
  Category category;
  List<dynamic>? images;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });
}
