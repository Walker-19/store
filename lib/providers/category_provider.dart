import 'package:flutter/material.dart';
import 'package:store/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  // propriétés
  Category? _category;

  // getter / setter
  Category? get category => _category;

  set category(Category? value) {
    _category = value;

    // mise à jour des écouteurs du provider (widgets reliés au provider)
    notifyListeners();
  }
}
