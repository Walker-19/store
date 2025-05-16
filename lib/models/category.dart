class Category {
  // propriétés
  // ? null
  int? id;
  String? name, slug, image;

  // constructeur avec paramètres promus obligatoires
  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });


   Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
  };


    factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    image: json['image'],
  );
}
