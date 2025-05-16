import 'package:flutter/material.dart';

class CategoriesIcon {
  final List<Map<String, dynamic>> _list = [
    {'slug': "clothes", 'icon': Icons.checkroom},
    {'slug': "electronics", 'icon': Icons.bolt},
    {'slug': "furniture", 'icon': Icons.chair},
    {'slug': "shoes", 'icon': Icons.ice_skating},
    {'slug': "miscellaneous", 'icon': Icons.shuffle},
  ];

  // récupérer une icône à partir du slug d'une catégorie
  IconData getIcon(String categorySlug) {
    // recherche dans la liste des icônes
    Map<String, dynamic> result = _list.firstWhere((category) {
      return category['slug'] == categorySlug;
    });

    return result['icon'];
  }

  // tester si la catégorie existe dans la liste
  bool categoryIsExists(String categorySlug) {
    try {
      Map<String, dynamic> result = _list.firstWhere((category) {
        return category['slug'] == categorySlug;
      });
      return result.isNotEmpty ? true : false;
    } catch (e) {
      return false;
    }
  }
}
