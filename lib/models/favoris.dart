import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/models/product.dart';
import 'package:store/services/storage_service.dart';

class Favoris extends StorageService<List<Product>>{

    Favoris() : super(key: 'favoris_list');


  @override
  Future<List<Product>?> load() async {
    final  prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);
    if(jsonData == null) return null;
    final List<dynamic> decoded = jsonDecode(jsonData);
    return decoded.map((item) => Product.fromJson(item)).toList();
  }

  @override
  Future<void> save(List<Product> data) async {
   final prefs = await SharedPreferences.getInstance();
  final jsonList = data.map((product) => product.toJson()).toList();
    inspect(jsonList);
    await prefs.setString(key, jsonEncode(jsonList));
  }

  Future<void> add(Product product) async {
    final list = await load();

    list!.add(product);   
    await save(list); 
  }

  bool containsInList(List<Product> list  ,Product product) {
    return list.any((p) => p.id == product.id); 
  }

  Future<bool>  remove(Product product) async {
    final list = await load();
    list!.removeWhere((p) => p.id == product.id);

    await save(list);

    return true;
  }
    
}