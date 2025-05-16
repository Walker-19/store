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


   Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'description': description,
    'category': category.toJson(),
    'image': images,
    'price': price,
  };


    factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'],
    slug: json['slug'],
    description: json['description'],
    category: Category.fromJson(json['category']),
    images: json['images'],
    price: json['price'],
  );
}
